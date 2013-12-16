From: anish singh <anish198519851985@gmail.com>
Subject: Re: [PATCH]ASOC:DAPM: update DPCM runtime when
	mixer/mux changes
Date: Mon, 16 Dec 2013 00:03:01 -0800
Message-ID: <CAK7N6vq5RQV8JwDz7SS1K_fpXOHSmM2qOWrk8oibJZVNHcNE_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f169.google.com (mail-we0-f169.google.com
 [74.125.82.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 9DA122625F3
 for <alsa-devel@alsa-project.org>; Mon, 16 Dec 2013 09:03:01 +0100 (CET)
Received: by mail-we0-f169.google.com with SMTP id w61so4274758wes.0
 for <alsa-devel@alsa-project.org>; Mon, 16 Dec 2013 00:03:01 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@kernel.org, nhcao@marvell.com, lgirdwood@gmail.com, gabrbedd@gmail.com, Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

<This patch is dependent on the $subject
so i have used $subject instead of different
one>
I can see only one usage of:
snd_soc_dapm_mixer_update_power
and zero user of:
snd_soc_dapm_mux_update_power()

And after this $subject patch I think
both of these functions becomes redundant.

It will help in reducing the code size if we
can get rid of this dead code.We can
also remove code from tlv320aic3x.c and
just let it use the core implementation.

grep -rniI "snd_soc_dapm_mixer_update_power" sound/

sound/soc/soc-dapm.c:2149:
int snd_soc_dapm_mixer_update_power
sound/soc/codecs/tlv320aic3x.c:174:
snd_soc_dapm_mixer_update_power

grep -rniI "snd_soc_dapm_mux_update_power" sound/
no users.

I would send a patch if experts agree.
