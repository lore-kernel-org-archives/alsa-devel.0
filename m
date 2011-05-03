From: Belisko Marek <marek.belisko@gmail.com>
Subject: Re: [PATCH] SOC: UDA134x: Enable POWER_OFF_ON_STANDBY define.
Date: Tue, 3 May 2011 13:56:29 +0200
Message-ID: <BANLkTi=yu5YGn5crrsToVLjr3oJ-YWUxQg@mail.gmail.com>
References: <1304415149-19725-1-git-send-email-marek.belisko@open-nandra.com>
	<20110503100042.GA1762@opensource.wolfsonmicro.com>
	<BANLkTimE_TEzManZb2McLnohqbc27hRZ=w@mail.gmail.com>
	<20110503112350.GG1762@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110503112350.GG1762@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: tiwai@suse.de, perex@perex.cz, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Tue, May 3, 2011 at 1:23 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Tue, May 03, 2011 at 01:09:27PM +0200, Belisko Marek wrote:
>> On Tue, May 3, 2011 at 12:00 PM, Mark Brown
>
>> > If this is essential why is it optional in the first place?
>
>> Not sure about background. Maybe whole define should be removed
>
> That's exactly what I'm suggesting.
>
>> This change was introduced in commit:f0fba2ad
>
> *Always* include a plain text description of the commit for those of =
us
> who haven't memorised the entire git history. =C2=A0In this case I su=
spect
> you need to do a bit more digging, that commit will just have done so=
me
> code motion here.

OK after more digging in file history find commit where define was remo=
ved:
commit cc3202f5da3c81a99c5f3a605df527da7a77eed3
Author: Vladimir Zapolskiy <vzapolskiy@gmail.com>
Date:   Thu Jun 24 17:38:50 2010 +0400

    ASoC: uda134x: replace a macro with a value in platform struct.

    This change wipes out a hardcoded macro, which enables codec bias
    level control. Now is_powered_on_standby value shall be used instea=
d.

    Signed-off-by: Vladimir Zapolskiy <vzapolskiy@gmail.com>
    Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
    Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

diff --git a/sound/soc/codecs/uda134x.c b/sound/soc/codecs/uda134x.c
index 28aac53..30cf2f9 100644
--- a/sound/soc/codecs/uda134x.c
+++ b/sound/soc/codecs/uda134x.c
@@ -28,19 +28,6 @@
 #include "uda134x.h"


-#define POWER_OFF_ON_STANDBY 1
-/*
-  ALSA SOC usually puts the device in standby mode when it's not used
-  for sometime. If you define POWER_OFF_ON_STANDBY the driver will
-  turn off the ADC/DAC when this callback is invoked and turn it back
-  on when needed. Unfortunately this will result in a very light bump
-  (it can be audible only with good earphones). If this bothers you
-  just comment this line, you will have slightly higher power
-  consumption . Please note that sending the L3 command for ADC is
-  enough to make the bump, so it doesn't make difference if you
-  completely take off power from the codec.
- */
-
#define UDA134X_RATES SNDRV_PCM_RATE_8000_48000
 #define UDA134X_FORMATS (SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16_LE=
 | \
                SNDRV_PCM_FMTBIT_S18_3LE | SNDRV_PCM_FMTBIT_S20_3LE)
@@ -531,9 +518,11 @@ static int uda134x_soc_probe(struct platform_devic=
e *pdev)
        codec->num_dai =3D 1;
        codec->read =3D uda134x_read_reg_cache;
        codec->write =3D uda134x_write;
-#ifdef POWER_OFF_ON_STANDBY
-       codec->set_bias_level =3D uda134x_set_bias_level;
-#endif

So not sure why in never commit appeared again :
commit f0fba2ad1b6b53d5360125c41953b7afcd6deff0
Author: Liam Girdwood <lrg@slimlogic.co.uk>
Date:   Wed Mar 17 20:15:21 2010 +0000

    ASoC: multi-component - ASoC Multi-Component Support

    This patch extends the ASoC API to allow sound cards to have more t=
han one
    CODEC and more than one platform DMA controller. This is achieved
by dividing
    some current ASoC structures that contain both driver data and
device data into
    structures that only either contain device data or driver data. i.e=
=2E
=2E...
+#ifdef POWER_OFF_ON_STANDBY
+       .set_bias_level =3D uda134x_set_bias_level,
+#endif
=2E....


Maybe merge problem? So the correct solution would be remove define com=
pletely
as you suggested.
>

regards,

marek

--=20
as simple and primitive as possible
-------------------------------------------------
Marek Belisko - OPEN-NANDRA
=46reelance Developer

Ruska Nova Ves 219 | Presov, 08005 Slovak Republic
Tel: +421 915 052 184
skype: marekwhite
icq: 290551086
web: http://open-nandra.com
