From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 1/1] ASoC: TWL4030: Headset VMID ramp fix
Date: Mon, 11 May 2009 09:22:41 +0300
Message-ID: <200905110922.41837.peter.ujfalusi@nokia.com>
References: <1241763077-6851-1-git-send-email-peter.ujfalusi@nokia.com>
	<20090508165501.954a61e7.jhnikula@gmail.com>
	<20090508172322.53be8d2c.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 5AC0124670
	for <alsa-devel@alsa-project.org>;
	Mon, 11 May 2009 08:22:50 +0200 (CEST)
In-Reply-To: <20090508172322.53be8d2c.jhnikula@gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: "sakoman@gmail.com" <sakoman@gmail.com>, "getarunks@gmail.com" <getarunks@gmail.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "anuj.aggarwal@ti.com" <anuj.aggarwal@ti.com>
List-Id: alsa-devel@alsa-project.org

On Friday 08 May 2009 17:23:22 ext Jarkko Nikula wrote:
> On Fri, 8 May 2009 16:55:01 +0300
>
> Jarkko Nikula <jhnikula@gmail.com> wrote:
> > Would it be possible that pop is not caused by the HS output but
> > inside the chip, like from DAC?
>
> Seems to be not the case. Pops are there even if I put msleep(250)
> before and after playing with the HS.
>
> A digital scope would definitely help here to see are there ramp and is
> the coupling configuration correct.

OK I got the scope hooked up.
Startup sequence on HS looks fine:
TWL4030_VMID_EN
TWL4030_RAMP_EN
HS gain restore.

On the shutdown sequence part I have the following:
~TWL4030_RAMP_EN
msleep(30)
~TWL4030_VMID_EN
HS gain mute

When the RAMP_DELAY =3D 0 (27/20/14 ms) the voltage on the HSOL line gradua=
lly =

ramps down.
If I set the RAMP_DELAY =3D 1 (55/40/27 ms) the voltage on HSOL line starts=
 to =

gradually ramp down, but close to the end there is a clear cut (voltage jum=
ps =

to 0, after around 30ms from the start of the ramp down). If I further =

increase the RAMP_DELAY, the cut happens at the same time, but it falls fro=
m =

even higher voltage to 0.

I think the solution for now is to fix the RAMP_DELAY to 0 (27/20/14 ms), a=
nd =

add the delay for the shutdown case.

Also I have tried gradually decrease the volume on the HS output. It does n=
ot =

seams to be working on the twl4030 codec: when the HSL_GAIN, HSR_GAIN is se=
t =

to 0 it effectively cuts the output (HSOL line drops to zero -> 'tuck' can =
be =

heard)

Mark: what do you think, is it acceptable to add a maximum of 27ms delay to =

the hsol_event:SND_SOC_DAPM_POST_PMD event?

-- =

P=E9ter
