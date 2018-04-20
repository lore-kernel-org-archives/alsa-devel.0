From: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
Subject: [PATCH 2/4] ALSA: usb-audio: ADC3: Fix channel mapping
	conversion for ADC3.
Date: Fri, 20 Apr 2018 18:03:25 +0100
Message-ID: <20180420170327.31569-3-jorge.sanjuan@codethink.co.uk>
References: <20180420170327.31569-1-jorge.sanjuan@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from imap1.codethink.co.uk (imap1.codethink.co.uk [176.9.8.82])
 by alsa0.perex.cz (Postfix) with ESMTP id 58D6B26760A
 for <alsa-devel@alsa-project.org>; Fri, 20 Apr 2018 19:03:39 +0200 (CEST)
In-Reply-To: <20180420170327.31569-1-jorge.sanjuan@codethink.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.com
Cc: gregkh@linuxfoundation.org, alsa-devel@alsa-project.org, Michael Drake <michael.drake@codethink.co.uk>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Michael Drake <michael.drake@codethink.co.uk>

The channel mapping is defined by bChRelationship, not bChPurpose.

Signed-off-by: Michael Drake <michael.drake@codethink.co.uk>
---
 sound/usb/stream.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/stream.c b/sound/usb/stream.c
index 6a8f5843334e..956be9f7c72a 100644
--- a/sound/usb/stream.c
+++ b/sound/usb/stream.c
@@ -349,7 +349,7 @@ snd_pcm_chmap_elem *convert_chmap_v3(struct uac3_cluster_header_descriptor
 			 * TODO: this conversion is not complete, update it
 			 * after adding UAC3 values to asound.h
 			 */
-			switch (is->bChPurpose) {
+			switch (is->bChRelationship) {
 			case UAC3_CH_MONO:
 				map = SNDRV_CHMAP_MONO;
 				break;
-- 
2.11.0
