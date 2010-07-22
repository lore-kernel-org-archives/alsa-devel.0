From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: ASoC: multi-component updates from RFC
Date: Thu, 22 Jul 2010 09:27:16 +0300
Message-ID: <201007220927.16738.peter.ujfalusi@nokia.com>
References: <1279715490.3072.51.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 8C14424506
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Jul 2010 08:27:26 +0200 (CEST)
In-Reply-To: <1279715490.3072.51.camel@odin>
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, ext Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Hello Liam,

On Wednesday 21 July 2010 15:31:30 ext Liam Girdwood wrote:

...

> The only other change I've made is fixing the twl4030 and DAC33 codec
> probe and remove (as spotted by Peter).

I'm in the process of checking the changes.
For the twl4030 I have spotted the following:
1. twl-core registers "twl4030_codec" platform device.
2. The driver for this is the drivers/mfd/twl4030-codec.c
3. this MFD driver registers the following platform devices:
   twl4030_codec_audio
   twl4030_codec_vibra
4. the sound/soc/codecs/twl4030.c is the twl4030_codec_audio driver
5. the drivers/input/misc/twl4030-vibra.c is the twl4030_codec_vibra driver
Note: the platform data is propagated from board files to mfd/twl4030-codec=
.c, =

than this mfd driver passes the appropriate platform data to the soc codec,=
 and =

vibra driver.

The codec part of twl40x0, twl50x0 has vibra and audio functionality, and t=
hey =

have interoperability problems (sharing the same resources).

The name for the drivers/mfd/twl4030-codec.c is chosen, because the TRM ref=
ers =

to this block as codec (audio + vibra).
We could go, and rename however this mfd driver to twl4030-audio (since the=
 TRM =

randomly refers to audio block instead of codec).
Than we can have twl4030-codec as device name for the soc codec, and twl403=
0-
vibra for the vibra.

I'll continue on checking the changes...

-- =

P=E9ter
