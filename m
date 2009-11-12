From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH]  OSS: fix error return in dma_ioctl()
Date: Thu, 12 Nov 2009 17:43:11 +0100
Message-ID: <4AFC3B1F.1050901@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.146])
	by alsa0.perex.cz (Postfix) with ESMTP id 6761D103800
	for <alsa-devel@alsa-project.org>; Thu, 12 Nov 2009 17:31:09 +0100 (CET)
Received: by ey-out-1920.google.com with SMTP id 3so630296eyh.16
	for <alsa-devel@alsa-project.org>; Thu, 12 Nov 2009 08:31:08 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

The returned error should stay negative

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
 sound/oss/audio.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/oss/audio.c b/sound/oss/audio.c
index b69c05b..7df48a2 100644
--- a/sound/oss/audio.c
+++ b/sound/oss/audio.c
@@ -838,7 +838,7 @@ static int dma_ioctl(int dev, unsigned int cmd, void __user *arg)
 					if ((err = audio_devs[dev]->d->prepare_for_input(dev,
 						     dmap_in->fragment_size, dmap_in->nbufs)) < 0) {
 						spin_unlock_irqrestore(&dmap_in->lock,flags);
-						return -err;
+						return err;
 					}
 					dmap_in->dma_mode = DMODE_INPUT;
 					audio_devs[dev]->enable_bits |= PCM_ENABLE_INPUT;
