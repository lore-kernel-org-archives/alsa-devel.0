From: Ian Minett <ian_minett@creativelabs.com>
Subject: [PATCHv2 - CA0132 HDA Codec 2/2] Change
	spin_lock()/unlock() to spin_lock_irqsave()/restore()
Date: Wed, 25 Jul 2012 11:01:20 -0700
Message-ID: <1343239280-3503-2-git-send-email-ian_minett@creativelabs.com>
References: <s5hipdoggbb.wl%tiwai@suse.de>
 <1343239280-3503-1-git-send-email-ian_minett@creativelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1343239280-3503-1-git-send-email-ian_minett@creativelabs.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, Ian Minett <ian_minett@creativelabs.com>
List-Id: alsa-devel@alsa-project.org

From: Ian Minett <ian_minett@creativelabs.com>

 in azx_pcm_trigger(). 
 This change is to prevent deadlock when an interrupt occurs,
 caused by chip->reg_lock contention.


Signed-off-by: Ian Minett <ian_minett@creativelabs.com>

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 796472d..0ccffde 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -551,6 +551,7 @@ enum {
 	(AZX_DCAPS_NVIDIA_SNOOP | AZX_DCAPS_RIRB_DELAY | AZX_DCAPS_NO_MSI |\
 	 AZX_DCAPS_ALIGN_BUFSIZE)
 
+/* quirks for Creative CTHDA */
 #define AZX_DCAPS_PRESET_CTHDA \
 	(AZX_DCAPS_NO_MSI | AZX_DCAPS_POSFIX_LPIB | AZX_DCAPS_4K_BDLE_BOUNDARY)
 
@@ -1930,6 +1931,7 @@ static int azx_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 	struct snd_pcm_substream *s;
 	int rstart = 0, start, nsync = 0, sbits = 0;
 	int nwait, timeout;
+	unsigned long flags;
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
@@ -1956,7 +1958,7 @@ static int azx_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 		snd_pcm_trigger_done(s, substream);
 	}
 
-	spin_lock(&chip->reg_lock);
+	spin_lock_irqsave(&chip->reg_lock, flags);
 	if (nsync > 1) {
 		/* first, set SYNC bits of corresponding streams */
 		if (chip->driver_caps & AZX_DCAPS_OLD_SSYNC)
@@ -1980,7 +1982,7 @@ static int azx_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 		}
 		azx_dev->running = start;
 	}
-	spin_unlock(&chip->reg_lock);
+	spin_unlock_irqrestore(&chip->reg_lock, flags);
 	if (start) {
 		if (nsync == 1)
 			return 0;
-- 
1.7.4.1
