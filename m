From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: Re: [PATCH 2/2] ASoC: sgtl5000: clean up
 sgtl5000_enable_regulators()
Date: Wed, 18 Dec 2013 01:42:05 +0000
Message-ID: <76dae1a423b24118b7c1eb51007d6f25@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1386916983-27832-1-git-send-email-shawn.guo@linaro.org>
 <1386916983-27832-2-git-send-email-shawn.guo@linaro.org>
 <20131217134342.GP6691@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0185.outbound.protection.outlook.com [207.46.163.185])
 by alsa0.perex.cz (Postfix) with ESMTP id F38D42610C1
 for <alsa-devel@alsa-project.org>; Wed, 18 Dec 2013 02:42:09 +0100 (CET)
In-Reply-To: <20131217134342.GP6691@S2101-09.ap.freescale.net>
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
To: Shawn Guo <shawn.guo@linaro.org>, Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


> On Fri, Dec 13, 2013 at 02:43:03PM +0800, Shawn Guo wrote:
> > Function sgtl5000_enable_regulators() is somehow odd in handling the
> > optional external VDDD supply.  The driver can only enable this supply
> > on SGTL5000 chip before revision 0x11, and of course when this
> > external VDDD is present.  It currently does something like below.
> >
> > 1. Check if regulator_bulk_get() on VDDA, VDDIO and VDDD will fail.  If
> >    it fails, VDDD must be absent and it falls on internal LDO by calling
> >    sgtl5000_replace_vddd_with_ldo().  Otherwise, VDDD is used.  And in
> >    either case, regulator_bulk_enable() will be called to enable
> >    3 supplies.
> >
> > 2. In case that SGTL5000 revision is later than 0x11, even if external
> >    VDDD is present, it has to roll back the 'enable' and 'get' calls
> >    with regulator_bulk_disable() and regulator_bulk_free(), and starts
> >    over again by calling sgtl5000_replace_vddd_with_ldo() and
> >    regulator_bulk_enable().
> >
> > Such back and forth calls sequence is complicated and unnecessary.
> > Also, since commit 4ddfebd (regulator: core: Provide a dummy regulator
> > with full constraints), regulator_bulk_get() will always succeeds
> > because of the dummy regulator.  Thus the VDDD detection is broken.
> >
> > The patch changes the flow to something like the following, which
> > should be more reasonable and clear, and also fix the VDDD detection
> breakage.
> >
> > 1. Check if we're running a chip before revision 0x11, on which an
> >    external VDDD can possibly be an option.
> >
> > 2. If it is an early revision, call regulator_get_optional() to detect
> >    whether an external VDDD supply is available.
> >
> > 3. If external VDDD is present, call sgtl5000_replace_vddd_with_ldo() to
> >    update sgtl5000->supplies info.
> >
> > 4. Drop regulator_bulk_get() call in sgtl5000_replace_vddd_with_ldo(),
> >    and call it in sgtl5000_enable_regulators() no matter it's an
> >    external VDDD or internal LDO.
> >
> > 5. Call regulator_bulk_enable() to enable these 3 regulators.
> >
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> 
> Apart from that separate issue we're discussing, do you have any comment on
> this patch itself?

Hi Shawn,

Sorry for late.

It's looks good to me.

--
Xiubo
