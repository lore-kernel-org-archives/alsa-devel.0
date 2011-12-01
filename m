From: Tomoya MORINAGA <tomoya.rohm@gmail.com>
Subject: Re: [PATCH v3] sound/soc/codecs: add LAPIS Semiconductor ML26124
Date: Thu, 1 Dec 2011 16:46:55 +0900
Message-ID: <CANKRQniP=UUAPbbyoZNvxs16H7QZzS=O9zwt6kJu69u8s8qGTQ@mail.gmail.com>
References: <1322474755-18785-1-git-send-email-tomoya.rohm@gmail.com>
	<4ED37CE3.6040008@metafoo.de>
	<CANKRQnh7MnSQdKXvPJvSPzf-7afXmHip9LqR1cKCgB6HXqcnBg@mail.gmail.com>
	<4ED4EE48.8070100@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4ED4EE48.8070100@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, Mike Frysinger <vapier@gentoo.org>, Daniel Mack <zonque@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, qi.wang@intel.com, yong.y.wang@intel.com, joel.clark@intel.com, kok.howg.ewe@intel.com
List-Id: alsa-devel@alsa-project.org

2011/11/29 Lars-Peter Clausen <lars@metafoo.de>:
>
> Also this doesn't make much sense:
> + =A0 =A0 =A0 {"Input Mux", "Analog MIC in", "MICBIAS"},
> + =A0 =A0 =A0 {"Input Mux", "Digital MIC in", "MICBIAS"},
>
> You have mux, but both possible settings of the mux connect to the sa=
me
> source, which pretty much makes the mux useless.
>

Yes, you are right.
This setting was miss-settings.
This MICBIAS supplies to external MIC as reference voltage.
So, I think MICBIAS shouldn't appear at this setting.
I show modified settings.
       /* input */
       {"Input Mux", "Analog MIC SingleEnded in", "MIN"},
       {"Input Mux", "Analog MIC Differential in", "MIN"},
       {"Input Mux", "Digital MIC in", "MDIN"},
       {"ADC", "PGA", "Input Mux"},

Thanks,
------
ROHM Co., Ltd.
Tomoya MORINAGA
