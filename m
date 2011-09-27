From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 02/10] ASoC: twl6040: Combine the custom
	volsw get, and put functions
Date: Tue, 27 Sep 2011 09:16:16 +0300
Message-ID: <2435781.WrNUf02Inv@barack>
References: <1317043593-27202-1-git-send-email-peter.ujfalusi@ti.com>
	<1317043593-27202-3-git-send-email-peter.ujfalusi@ti.com>
	<20110926212141.GB2872@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog122.obsmtp.com (na3sys009aog122.obsmtp.com
	[74.125.149.147])
	by alsa0.perex.cz (Postfix) with ESMTP id B2B372434B
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Sep 2011 08:16:10 +0200 (CEST)
Received: by bkbzu5 with SMTP id zu5so6314298bkb.7
	for <alsa-devel@alsa-project.org>; Mon, 26 Sep 2011 23:16:07 -0700 (PDT)
In-Reply-To: <20110926212141.GB2872@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

On Monday 26 September 2011 22:21:42 Mark Brown wrote:
> On Mon, Sep 26, 2011 at 04:26:25PM +0300, Peter Ujfalusi wrote:
> =

> Applied, thanks.
> =

> > -	ret =3D snd_soc_put_volsw(kcontrol, ucontrol);
> > +	/* call the appropriate handler depending on the rreg */
> > +	if (mc->rreg)
> > +		ret =3D snd_soc_put_volsw_2r(kcontrol, ucontrol);
> > +	else
> > +		ret =3D snd_soc_put_volsw(kcontrol, ucontrol);
> > +
> =

> Traditionally this would be done by comparing reg and rreg - if they're
> the same they're a mono control.

I'm not looking for the mono/stereo, but looking for the gain value(s) are =
in =

the same register, but in different offset VS gain values are at the same =

offset, but in two different registers.
The mono/stereo handling within snd_soc_put_volsw sufficient, and at the =

moment the twl6040 has only stereo controls handled this way, but if we hav=
e =

stereo, it is not a big job to implement.

The macros for SOC_DOUBLE, SOC_DOUBLE_TLV only assignes the .reg, leaving t=
he =

.rreg to be zero.
SOC_DOUBLE_R, SOC_DOUBLE_R_TLV on the other hand assigning the .reg, and th=
e =

.rreg.

--
P=E9ter
