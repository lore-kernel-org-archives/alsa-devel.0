From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: Re: [PATCH 2/2] ASoC: sgtl5000: clean up
 sgtl5000_enable_regulators()
Date: Mon, 16 Dec 2013 03:31:29 +0000
Message-ID: <892cbb07bd064f44b2af45f106aeb479@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1386916983-27832-1-git-send-email-shawn.guo@linaro.org>
 <1386916983-27832-2-git-send-email-shawn.guo@linaro.org>
 <00a7a941be434caf829f9fd246879c6d@BY2PR03MB505.namprd03.prod.outlook.com>
 <20131213125129.GV18380@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0235.outbound.protection.outlook.com [207.46.163.235])
 by alsa0.perex.cz (Postfix) with ESMTP id 1096F261B2B
 for <alsa-devel@alsa-project.org>; Mon, 16 Dec 2013 04:31:33 +0100 (CET)
In-Reply-To: <20131213125129.GV18380@S2101-09.ap.freescale.net>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


> > > -	ret = regulator_bulk_get(codec->dev, ARRAY_SIZE(sgtl5000->supplies),
> > > -				sgtl5000->supplies);
> > > -	if (!ret)
> > > -		external_vddd = 1;
> > > -	else {
> > > +	/* External VDDD only works before revision 0x11 */
> > > +	if (sgtl5000->revision < 0x11) {
> > > +		vddd = regulator_get_optional(codec->dev, "VDDD");
> > > +		if (IS_ERR(vddd)) {
> > > +			/* See if it's just not registered yet */
> > > +			if (PTR_ERR(vddd) == -EPROBE_DEFER)
> > > +				return -EPROBE_DEFER;
> > > +		} else {
> > > +			external_vddd = 1;
> > > +			regulator_put(vddd);
> > > +		}
> >
> > Shouldn't we handle other errors ?
> 
> We do not really care other errors.  In case that an external VDDD is present
> on hardware design but regulator_get_optional("VDDD") still fails for some
> other reason, we should turn to use the internal LDO anyway rather than simply
> failing out.
> 
> > We can see that from the regulator_get_optional()-->_regulator_get(),
> > there are many other errors maybe returned. Not considering other
> > error cases, If the dt is used here, only ERR_PTR(-ENODEV) will be
> > returned if the external VDDD is absent, and only this case the
> > ERR_PTR(_ENODEV) error will be returned, Or if dt is not used and
> > there has no external VDDD was found, the
> > ERR_PTR(-EPROBE_DEFER) will be returned.
> >
> > So, if the external VDDD is not used, only ERR_PTR(-ENODEV) and
> > ERR_PTR(-EPROBE_DEFER) maybe returned ignoring other errors.
> >
> > How about the following ?
> > -----------------
> > +	if (IS_ERR(vddd)) {
> > +		/* See if it's just not registered yet */
> > +		if (PTR_ERR(vddd) != -ENODEV)
> > +			return PTR_ERR(vddd);
> 
> Just for example, if PTR_ERR(vddd) is -EBUSY here, instead of failing out, why
> do not we switch to internal LDO for continuing the probe?
> 

Yes, sounds perfect.

Well, the regulator_get_optional() is still needed to improve.
For instance, if dts is not used for one platform and the external VDDD supply is
absent. The regulator_get_optional() will return -EPROBE_DEFER, so the SGTL5000's
probe, and then the SGTL5000 will do the deferral probe, and this time the same
-EPROBE_DEFER error will return again. 
Where should this special handling be dealt with ? Is here or regulator_get_optional()
will be better ?


Thanks,

--
Xiubo
