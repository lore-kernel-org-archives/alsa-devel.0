From: Peter Rosin <peda@axentia.se>
Subject: [PATCH] ASoC: pcm: allow changing the playback/capture
	rates for symmetric links
Date: Wed, 27 Apr 2016 10:49:19 +0200
Message-ID: <1461746959-11443-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0103.outbound.protection.outlook.com [104.47.1.103])
 by alsa0.perex.cz (Postfix) with ESMTP id 0F8BC265A72
 for <alsa-devel@alsa-project.org>; Wed, 27 Apr 2016 10:49:32 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Peter Rosin <peda@axentia.se>
List-Id: alsa-devel@alsa-project.org

The below program fails on a dai link with symmetric rates without this
patch. The patch makes it work.

#include <sys/soundcard.h>
#include <unistd.h>
#include <fcntl.h>
#include <stropts.h>
#include <stdio.h>

int
main(void)
{
    int fd;
    int format;
    int channels;
    int speed;

    if ((fd = open("/dev/dsp", O_WRONLY, 0)) == -1) {
            perror("open");
            return 1;
    }
    format = AFMT_S16_LE;
    if (ioctl(fd, SNDCTL_DSP_SETFMT, &format) == -1) {
            perror("SNDCTL_DSP_SETFMT");
            return 1;
    }
    channels = 2;
    if (ioctl(fd, SNDCTL_DSP_CHANNELS, &channels) == -1) {
            perror("SNDCTL_DSP_CHANNELS");
            return 1;
    }
    speed = 22050;
    if (ioctl(fd, SNDCTL_DSP_SPEED, &speed) == -1) {
            perror("SNDCTL_DSP_SPEED");
            return 1;
    }
    return 0;
}

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 sound/soc/soc-pcm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 35fe58f4fa86..1e876ff23524 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -237,6 +237,14 @@ static int soc_pcm_params_symmetry(struct snd_pcm_substream *substream,
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	unsigned int rate, channels, sample_bits, symmetry, i;
 
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		if (!cpu_dai->capture_active)
+			return 0;
+	} else if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
+		if (!cpu_dai->playback_active)
+			return 0;
+	}
+
 	rate = params_rate(params);
 	channels = params_channels(params);
 	sample_bits = snd_pcm_format_physical_width(params_format(params));
-- 
2.1.4
