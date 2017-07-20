From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [alsa-devel] [PATCH v3] ASoC: sgtl5000: add avc support
Date: Thu, 20 Jul 2017 14:27:11 -0300
Message-ID: <CAOMZO5Cp7keQSEcR+wV_Z6PTxYgr_xYxdcG_TDd+UUJne0R7xg@mail.gmail.com>
References: <1497337054-4911-1-git-send-email-richard.leitner@skidata.com>
 <CAOMZO5Cx6OrYSKYcbj6DWhn=hzS51sENadWHLSYdTkjRk9qJXw@mail.gmail.com> <3b154ab9-6bbd-eb53-05e6-6d08cf3cc5c0@g0hl1n.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3b154ab9-6bbd-eb53-05e6-6d08cf3cc5c0@g0hl1n.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Leitner <dev@g0hl1n.net>
Cc: Richard Leitner <richard.leitner@skidata.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Clemens Gruber <clemens.gruber@pqgruber.com>, kalle.kankare@vincit.fi, Eric Nelson <eric@nelint.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, linux-kernel <linux-kernel@vger.kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>
List-Id: alsa-devel@alsa-project.org

Hi Richard,

On Thu, Jul 20, 2017 at 2:25 PM, Richard Leitner <dev@g0hl1n.net> wrote:

> Does this occur only on reboot or everytime the driver tries to read the AVC
> threshold (avc_get_threshold)?
> Are you able to set the AVC threshold (using amixer)?

I am not even using the codec. I just run 'reboot' and the problem happens.

The following change fixes the 'reboot' issue for me. Could you please try it?

--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -409,7 +409,7 @@ static int dac_put_volsw(struct snd_kcontrol *kcontrol,
 static int avc_get_threshold(struct snd_kcontrol *kcontrol,
                             struct snd_ctl_elem_value *ucontrol)
 {
-       struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+       struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
        int db, i;
        u16 reg = snd_soc_read(codec, SGTL5000_DAP_AVC_THRESHOLD);

@@ -442,7 +442,7 @@ static int avc_get_threshold(struct snd_kcontrol *kcontrol,
 static int avc_put_threshold(struct snd_kcontrol *kcontrol,
                             struct snd_ctl_elem_value *ucontrol)
 {
-       struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+       struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
        int db;
        u16 reg;
