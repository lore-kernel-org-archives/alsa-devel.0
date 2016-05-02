From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH] ALSA: compress: fix some typo
Date: Mon,  2 May 2016 14:06:28 +0530
Message-ID: <1462178188-30509-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 866D126040E
 for <alsa-devel@alsa-project.org>; Mon,  2 May 2016 10:30:33 +0200 (CEST)
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
Cc: tiwai@suse.de, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

Noticed two typos in Documentation, so fix them up

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 Documentation/sound/alsa/compress_offload.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/sound/alsa/compress_offload.txt b/Documentation/sound/alsa/compress_offload.txt
index 630c492c3dc2..8ba556a131c3 100644
--- a/Documentation/sound/alsa/compress_offload.txt
+++ b/Documentation/sound/alsa/compress_offload.txt
@@ -149,7 +149,7 @@ Gapless Playback
 ================
 When playing thru an album, the decoders have the ability to skip the encoder
 delay and padding and directly move from one track content to another. The end
-user can perceive this as gapless playback as we dont have silence while
+user can perceive this as gapless playback as we don't have silence while
 switching from one track to another
 
 Also, there might be low-intensity noises due to encoding. Perfect gapless is
@@ -184,7 +184,7 @@ Sequence flow for gapless would be:
 - Fill data of the first track
 - Trigger start
 - User-space finished sending all,
-- Indicaite next track data by sending set_next_track
+- Indicate next track data by sending set_next_track
 - Set metadata of the next track
 - then call partial_drain to flush most of buffer in DSP
 - Fill data of the next track
-- 
1.9.1
