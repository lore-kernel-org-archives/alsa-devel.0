From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH] ASoC: pxa: remove duplicated
	snd_soc_component_driver ops
Date: Tue, 11 Sep 2018 22:57:27 +0200
Message-ID: <877ejr69c8.fsf@belgarion.home>
References: <5110d62c9a1d266da0675cd11f196adad4b12cec.1536006242.git.petrcvekcz@gmail.com>
 <87bm955gj9.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.smtpout.orange.fr (smtp11.smtpout.orange.fr
 [80.12.242.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 95EC12676B0
 for <alsa-devel@alsa-project.org>; Tue, 11 Sep 2018 22:57:31 +0200 (CEST)
In-Reply-To: <87bm955gj9.fsf@belgarion.home> (Robert Jarzmik's message of
 "Mon, 10 Sep 2018 20:55:06 +0200")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: petrcvekcz@gmail.com
Cc: alsa-devel@alsa-project.org, dbaryshkov@gmail.com, lgirdwood@gmail.com, haojian.zhuang@gmail.com, dirk@opfer-online.de, marek.vasut@gmail.com, zhouqiao@marvell.com, broonie@kernel.org, philipp.zabel@gmail.com, lost.distance@yahoo.com, daniel@zonque.org
List-Id: alsa-devel@alsa-project.org

Robert Jarzmik <robert.jarzmik@free.fr> writes:

> Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>
> Tested-by: Robert Jarzmik <robert.jarzmik@free.fr>

Mmh actually no, there is still a potential issue :
 - the ac97 aplay works in my platform_data mioa701 board
 - but it doesn't work anymore with the devicetree version ... until I revert
   this patch where it works again.

The error I get is :
	root@mioa701:~# aplay mp3/Avril\ Lavigne\ Joie.wav 
	aplay: main:722: audio open error: Invalid argument

The relevant devicetree extract is :
	sound {
		compatible = "simple-audio-card";
		simple-audio-card,name = "MioA701";
		simple-audio-card,widgets =
		"Speaker", "Front Speaker",
		"Speaker", "Rear Speaker",
		"Microphone", "Headset",
		"Microphone", "GSM Line Out",
		"Line", "GSM Line In",
		"Microphone", "Headset Mic",
		"Microphone", "Front Mic";
		simple-audio-card,routing =
			/* Call Mic */
			"Mic Bias", "Front Mic",
			"MIC1", "Mic Bias",
			/* Headset Mic */
			"LINEL", "Headset Mic",
			"LINER", "Headset Mic",
			/* GSM Module */
			"MONOIN", "GSM Line Out",
			"PCBEEP", "GSM Line Out",
			"GSM Line In", "MONO",
			/* headphone connected to HPL, HPR */
			"Headset", "HPL",
			"Headset", "HPR",
			/* front speaker connected to HPL, OUT3 */
			"Front Speaker", "HPL",
			"Front Speaker", "OUT3",
			/* rear speaker connected to SPKL, SPKR */
			"Rear Speaker", "SPKL",
			"Rear Speaker", "SPKR";

		simple-audio-card,cpu {
			sound-dai = <&ac97>;
		};
		simple-audio-card,codec {
			sound-dai = <&wm9713>;
		};
		simple-audio-card,plat {
			sound-dai = <&pxa_pcm_audio>;
		};
	};

Cheers.

-- 
Robert
