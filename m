From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 02/10] ASoC: twl6040: Combine the custom
	volsw get, and put functions
Date: Tue, 27 Sep 2011 14:21:37 +0300
Message-ID: <15316585.mj9RxehzRH@barack>
References: <1317043593-27202-1-git-send-email-peter.ujfalusi@ti.com>
	<2435781.WrNUf02Inv@barack>
	<20110927105625.GF2910@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog115.obsmtp.com (na3sys009aog115.obsmtp.com
	[74.125.149.238])
	by alsa0.perex.cz (Postfix) with ESMTP id C307D10395E
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Sep 2011 13:21:30 +0200 (CEST)
Received: by mail-bw0-f45.google.com with SMTP id zv15so7004760bkb.4
	for <alsa-devel@alsa-project.org>; Tue, 27 Sep 2011 04:21:28 -0700 (PDT)
In-Reply-To: <20110927105625.GF2910@opensource.wolfsonmicro.com>
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

On Tuesday 27 September 2011 11:56:26 Mark Brown wrote:
> On Tue, Sep 27, 2011 at 09:16:16AM +0300, P=E9ter Ujfalusi wrote:
> > On Monday 26 September 2011 22:21:42 Mark Brown wrote:
> > > Traditionally this would be done by comparing reg and rreg - if
> > > they're
> > > the same they're a mono control.
> > =

> > I'm not looking for the mono/stereo, but looking for the gain value(s)
> > are in the same register, but in different offset VS gain values are at
> > the same offset, but in two different registers.
> =

> That's not what you're actually checking :)  This would generally be
> checked by comparing the shift registers - the basic reason we have the
> two functions at all is that we used to mash everything into a 32 bit
> int rather than using a pointer to struct.

I see what you mean, but..
The thing I'm after here is to select between the snd_soc_put_volsw, and =

snd_soc_put_volsw_2r to make the change in the HW.

In case of SOC_SINGLE_TLV I (will) need to call snd_soc_put_volsw
In case of SOC_DOUBLE_TLV I need to call  snd_soc_put_volsw
In case of SOC_DOUBLE_R_TLV I need to call  snd_soc_put_volsw_2r.

SOC_SINGLE_TLV:
reg =3D		xreg,
rreg =3D	0,
shift =3D	xshift,
rshift =3D 	xshift,

SOC_DOUBLE_TLV:
reg =3D		xreg,
rreg =3D	0,
shift =3D	left_shift,
rshift =3D 	right_shift,

SOC_DOUBLE_R_TLV:
reg =3D		left_reg,
rreg =3D	right_reg,
shift =3D	xshift,
rshift =3D 	xshift,

To pick the correct snd_soc_put_* call it is easier to check if the rreg is=
 0, =

since in that case I need to use the snd_soc_put_volsw (and =

snd_soc_put_volsw_2r, when we have two registers to configure).

--
P=E9ter
