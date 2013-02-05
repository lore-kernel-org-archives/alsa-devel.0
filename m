From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: How exactly snd_pcm_hw_rule_add() should to be used?
Date: Tue, 5 Feb 2013 11:24:45 +0100
Message-ID: <5110DDED.8030305@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id D85E2264F1C
 for <alsa-devel@alsa-project.org>; Tue,  5 Feb 2013 11:24:48 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

I got confused (again) regarding to how to use correctly the
snd_pcm_hw_rule_add(). Looking at the documentation [1] and to the code in
kernel seams to be suggesting the opposite.

[A]
using the 5.6. example from [1]:
snd_pcm_hw_rule_add(substream->runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
		    hw_rule_channels_by_format, 0, SNDRV_PCM_HW_PARAM_FORMAT,
		    -1);

The [1] tells me that the SNDRV_PCM_HW_PARAM_FORMAT will be refined based on
the SNDRV_PCM_HW_PARAM_CHANNELS.

In 5.7. of [1] the reverse rule is placed:
snd_pcm_hw_rule_add(substream->runtime, 0, SNDRV_PCM_HW_PARAM_FORMAT,
		    hw_rule_channels_by_format, 0,
		    SNDRV_PCM_HW_PARAM_CHANNELS, -1);

Which according to the example will refine the SNDRV_PCM_HW_PARAM_CHANNELS
based on the SNDRV_PCM_HW_PARAM_FORMAT.

However when looking at the code in the kernel the opposite seams to be what
is actually happening.

[B]
using the same 5.6. example from [1]:
snd_pcm_hw_rule_add(substream->runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
		    hw_rule_channels_by_format, 0, SNDRV_PCM_HW_PARAM_FORMAT,
		    -1);

It looks like the SNDRV_PCM_HW_PARAM_CHANNELS should be refined based on the
SNDRV_PCM_HW_PARAM_FORMAT.

Which one is the correct interpretation?

The reason I'm asking is that I need to have a rule which would place
constraint (step) on the BUFFER_SIZE based on the used RATE, but I can not =
use
a single snd_pcm_hw_constraint_step(,,BUFFER_TIME,) because of HW limitatio=
n.

Thank you,
P=E9ter

[1] http://www.alsa-project.org/~tiwai/writing-an-alsa-driver/ch05s09.html
