From: Tomoya MORINAGA <tomoya.rohm@gmail.com>
Subject: Re: [PATCH v2] sound/soc/codecs: add LAPIS Semiconductor ML26124
Date: Mon, 28 Nov 2011 18:44:04 +0900
Message-ID: <CANKRQnjf6x6GJhFoE+VYRG-=T=vtWDhNgjuED0zGcEEGDA7y0A@mail.gmail.com>
References: <1322224743-15671-1-git-send-email-tomoya.rohm@gmail.com>
	<20111125142858.GE5315@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20111125142858.GE5315@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@ti.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Lars-Peter Clausen <lars@metafoo.de>, Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, Mike Frysinger <vapier@gentoo.org>, Daniel Mack <zonque@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, qi.wang@intel.com, yong.y.wang@intel.com, joel.clark@intel.com, kok.howg.ewe@intel.com
List-Id: alsa-devel@alsa-project.org

2011/11/25 Mark Brown <broonie@opensource.wolfsonmicro.com>: wrote
>
>> +static const struct snd_kcontrol_new ml26124_snd_controls[] =3D {
>> + =A0 =A0 SOC_SINGLE_TLV("Capture Digital Volume", ML26124_RECORD_DI=
G_VOL, 0, 0xff, 1, rec_play_digi_vol),
>> + =A0 =A0 SOC_SINGLE_TLV("Playback Digital Volume", ML26124_PLBAK_DI=
G_VOL, 0, 0xff, 1, rec_play_digi_vol),
>
>> + =A0 =A0 SOC_SINGLE("Digital Volume Switch", ML26124_FILTER_EN, 4, =
1, 0),
>
> This needs either a Playback or Capture in there to match up with the
> above unless it genuinely does mute both which would be really weird.
>

Digital Volume Switch is used for both Playback and Capture.

Regards,
tomoya
