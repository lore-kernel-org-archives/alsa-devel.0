From: Peter Rosin <peda@axentia.se>
Subject: [PATCH] ASoC: atmel_ssc_dai: Match the CMR divider
	only in full duplex.
Date: Fri, 24 Oct 2014 21:25:59 +0200
Message-ID: <1414178759-7252-2-git-send-email-peda@axentia.se>
References: <544A1121.6080900@atmel.com>
 <1414178759-7252-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from peda-pc.axentia.se (unknown [87.96.186.165])
 by alsa0.perex.cz (Postfix) with ESMTP id D2A5926057B
 for <alsa-devel@alsa-project.org>; Fri, 24 Oct 2014 21:26:15 +0200 (CEST)
In-Reply-To: <1414178759-7252-1-git-send-email-peda@axentia.se>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bo Shen <voice.shen@atmel.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Peter Rosin <peda@axentia.se>
List-Id: alsa-devel@alsa-project.org

The CMR divider register is shared by playback and capture. The SSC driver
therefore tries to enforce rules so that the needed register content do
not conflict during simultaneous playback/capture. However, the
implementation also prevents changing the register content in
half-duplex scenarios, which is needed when using the OSS API.

Thus, only lock the divider if there is a stream in the other direction.

Fixes the below program to not fail with the atmel ssc dai in master mode.

#include <sys/ioctl.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/soundcard.h>

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
	speed = 22025;
	if (ioctl(fd, SNDCTL_DSP_SPEED, &speed) == -1) {
		perror("SNDCTL_DSP_SPEED");
		return 1;
	}
	return 0;
}

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 sound/soc/atmel/atmel_ssc_dai.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
index f403f39..b1cc2a4 100644
--- a/sound/soc/atmel/atmel_ssc_dai.c
+++ b/sound/soc/atmel/atmel_ssc_dai.c
@@ -310,7 +310,10 @@ static int atmel_ssc_set_dai_clkdiv(struct snd_soc_dai *cpu_dai,
 		 * transmit and receive, so if a value has already
 		 * been set, it must match this value.
 		 */
-		if (ssc_p->cmr_div == 0)
+		if (ssc_p->dir_mask !=
+			(SSC_DIR_MASK_PLAYBACK | SSC_DIR_MASK_CAPTURE))
+			ssc_p->cmr_div = div;
+		else if (ssc_p->cmr_div == 0)
 			ssc_p->cmr_div = div;
 		else
 			if (div != ssc_p->cmr_div)
-- 
2.1.1
