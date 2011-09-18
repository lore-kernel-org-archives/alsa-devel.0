From: Julia Lawall <julia@diku.dk>
Subject: [PATCH 2/4] src/pcm/pcm_mmap.c: add missing free
Date: Sun, 18 Sep 2011 22:04:35 +0200
Message-ID: <1316376277-1224-2-git-send-email-julia@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw2.diku.dk (mgw2.diku.dk [130.225.96.92])
	by alsa0.perex.cz (Postfix) with ESMTP id C5335247D4
	for <alsa-devel@alsa-project.org>;
	Sun, 18 Sep 2011 22:04:45 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, sumsaha@gmail.com
List-Id: alsa-devel@alsa-project.org

From: Julia Lawall <julia@diku.dk>

Something that is allocated using calloc is not freed on an error path.

Signed-off-by: Julia Lawall <julia@diku.dk>
Signed-off-by: Suman Saha <sumsaha@gmail.com>

---
Compile-tested only.

 src/pcm/pcm_mmap.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/pcm/pcm_mmap.c b/src/pcm/pcm_mmap.c
index 4621fe6..2a009c8 100644
--- a/src/pcm/pcm_mmap.c
+++ b/src/pcm/pcm_mmap.c
@@ -320,8 +320,11 @@ int snd_pcm_mmap(snd_pcm_t *pcm)
 		snd_pcm_channel_info_t *i = &pcm->mmap_channels[c];
 		i->channel = c;
 		err = snd_pcm_channel_info(pcm, i);
-		if (err < 0)
+		if (err < 0) {
+			free(pcm->mmap_channels);
+			pcm->mmap_channels = NULL;
 			return err;
+		}
 	}
 	for (c = 0; c < pcm->channels; ++c) {
 		snd_pcm_channel_info_t *i = &pcm->mmap_channels[c];
