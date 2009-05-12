From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 0/1] ASoC: TWL4030: Headset ramp down fix
Date: Tue, 12 May 2009 09:44:19 +0300
Message-ID: <200905120944.19197.peter.ujfalusi@nokia.com>
References: <1242040465-10835-1-git-send-email-peter.ujfalusi@nokia.com>
	<dfeb90390905110557m79ce9a51n5b8b73e5a736d05b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id A178C10382B
	for <alsa-devel@alsa-project.org>;
	Tue, 12 May 2009 08:44:49 +0200 (CEST)
In-Reply-To: <dfeb90390905110557m79ce9a51n5b8b73e5a736d05b@mail.gmail.com>
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
Cc: "sakoman@gmail.com" <sakoman@gmail.com>, "anuj.aggarwal@ti.com" <anuj.aggarwal@ti.com>, ext Arun KS <getarunks@gmail.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Monday 11 May 2009 15:57:28 ext Arun KS wrote:
>
> 'Tuck' still present on omap3evm board.

I'm really puzzled over this...

On my scope I can see 10s of the HSOL line.
I can see when the playback (/dev/urandom) is terminated, than after 5s the =

HSOL line is ramping down (from 1.4V to 12mV) after that the HSOL line stay=
s =

low.
The signal looks really fine, no glitches on the way at all (I have not see=
n a =

single glitch in any of my measurements).
Looking at the scope picture, I can not see anything which can cause the =

'tuck' anymore. Before the patch the HSOL jumped from 1.4V to 12mV, while n=
ow =

it gradually goes down...

Arun: can you try to increase the 'HS ramp delay' to for example =

'1748/1291/874'? Does it makes any difference?

Are you hearing the 'tuck' on the right, left or in both headset speaker?
Have you configured the Headset left routing correctly? For some reason (wh=
ich =

I can not recall why I did it) the headsetl_event is only triggered when th=
e =

HSOL routing is correctly configured.

For reference, this is what happens here after the playback is stopped:

twl4030_set_bias_level: SND_SOC_BIAS_PREPARE active: 0
twl4030_codec_mute: MUTE
headsetl_event: PRE_PMD /* Not used, just printout */
headsetl_event: POST_PMD
   delay: 27
twl4030_set_bias_level: SND_SOC_BIAS_STANDBY active: 0


-- =

P=E9ter
