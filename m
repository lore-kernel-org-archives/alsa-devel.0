From: Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Subject: [PATCH 1/3] sound: (cosmetic) remove a superfluous
	function declaration
Date: Wed, 30 Jan 2019 17:22:39 +0100
Message-ID: <1548865361-12816-2-git-send-email-guennadi.liakhovetski@intel.com>
References: <1548865361-12816-1-git-send-email-guennadi.liakhovetski@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout-xforward.gmx.net (mout-xforward.gmx.net [82.165.159.14])
 by alsa0.perex.cz (Postfix) with ESMTP id 5CEE1267909
 for <alsa-devel@alsa-project.org>; Wed, 30 Jan 2019 17:22:43 +0100 (CET)
Received: from axis700.grange ([87.78.226.14]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lb4vZ-1hYgqw2By5-00kctq for
 <alsa-devel@alsa-project.org>; Wed, 30 Jan 2019 17:22:43 +0100
Received: from 200r.grange (200r.grange [192.168.1.16])
 by axis700.grange (Postfix) with ESMTP id 49C3061CC9
 for <alsa-devel@alsa-project.org>; Wed, 30 Jan 2019 17:22:42 +0100 (CET)
In-Reply-To: <1548865361-12816-1-git-send-email-guennadi.liakhovetski@intel.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>

Declaration of snd_pcm_drop() in sound/core/pcm_native.c is superfluous
since the function isn't called before being defined. Remove the
declaration.

Signed-off-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
---
 sound/core/pcm_native.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 0bc4aa0ac9cf..672babd20cb1 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -1806,8 +1806,6 @@ static const struct action_ops snd_pcm_action_drain_init = {
 	.post_action = snd_pcm_post_drain_init
 };
 
-static int snd_pcm_drop(struct snd_pcm_substream *substream);
-
 /*
  * Drain the stream(s).
  * When the substream is linked, sync until the draining of all playback streams
-- 
2.17.1
