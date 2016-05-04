From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ALSA: isa/wavefront: prevent some out of bound
	writes
Date: Wed, 4 May 2016 09:27:37 +0300
Message-ID: <20160504062737.GI22064@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 by alsa0.perex.cz (Postfix) with ESMTP id D0E36260515
 for <alsa-devel@alsa-project.org>; Wed,  4 May 2016 08:27:57 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

"header->number" can be up to USHRT_MAX and it comes from the ioctl so
it needs to be capped.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/isa/wavefront/wavefront_synth.c b/sound/isa/wavefront/wavefront_synth.c
index 69f76ff..718d5e3 100644
--- a/sound/isa/wavefront/wavefront_synth.c
+++ b/sound/isa/wavefront/wavefront_synth.c
@@ -785,6 +785,9 @@ wavefront_send_patch (snd_wavefront_t *dev, wavefront_patch_info *header)
 	DPRINT (WF_DEBUG_LOAD_PATCH, "downloading patch %d\n",
 				      header->number);
 
+	if (header->number >= ARRAY_SIZE(dev->patch_status))
+		return -EINVAL;
+
 	dev->patch_status[header->number] |= WF_SLOT_FILLED;
 
 	bptr = buf;
@@ -809,6 +812,9 @@ wavefront_send_program (snd_wavefront_t *dev, wavefront_patch_info *header)
 	DPRINT (WF_DEBUG_LOAD_PATCH, "downloading program %d\n",
 		header->number);
 
+	if (header->number >= ARRAY_SIZE(dev->prog_status))
+		return -EINVAL;
+
 	dev->prog_status[header->number] = WF_SLOT_USED;
 
 	/* XXX need to zero existing SLOT_USED bit for program_status[i]
@@ -898,6 +904,9 @@ wavefront_send_sample (snd_wavefront_t *dev,
 		header->number = x;
 	}
 
+	if (header->number >= WF_MAX_SAMPLE)
+		return -EINVAL;
+
 	if (header->size) {
 
 		/* XXX it's a debatable point whether or not RDONLY semantics
