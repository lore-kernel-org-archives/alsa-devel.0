From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: [PATCH] pcm: Fix channel map query when there are lots
	of maps
Date: Sun,  8 Jun 2014 12:58:56 +0300
Message-ID: <1402221536-26473-1-git-send-email-anssi.hannula@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail3.ippnet.fi (mail3.ippnet.fi [62.197.168.3])
 by alsa0.perex.cz (Postfix) with ESMTP id A85212617B5
 for <alsa-devel@alsa-project.org>; Sun,  8 Jun 2014 11:59:06 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On most HDA Intel HDMI devices, the channel map list is approx. 500 ints
in size, making the 256-sized buffer used by
snd_pcm_query_chmaps_from_hw() too small and causing the query to fail
(NULL result to caller, ENOMEM).

Bump the buffer size to 2048 ints.

Signed-off-by: Anssi Hannula <anssi.hannula@iki.fi>
---

Found while writing XBMC support.

I don't like just bumping the buffer size, so I hope you have some idea
of a better solution?
I guess one way would be just to retry with a dynamically allocated
bigger buffer on ENOMEM, if there is nothing better...

 src/pcm/pcm_hw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/pcm/pcm_hw.c b/src/pcm/pcm_hw.c
index 9ff83a9..ed83197 100644
--- a/src/pcm/pcm_hw.c
+++ b/src/pcm/pcm_hw.c
@@ -1051,7 +1051,7 @@ snd_pcm_query_chmaps_from_hw(int card, int dev, int subdev,
 {
 	snd_ctl_t *ctl;
 	snd_ctl_elem_id_t *id;
-	unsigned int tlv[256], *start;
+	unsigned int tlv[2048], *start;
 	snd_pcm_chmap_query_t **map;
 	int i, ret, nums;
 
-- 
1.8.4.5
