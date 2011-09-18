From: Julia Lawall <julia@diku.dk>
Subject: [PATCH 4/4] src/pcm/pcm_multi.c: add missing free
Date: Sun, 18 Sep 2011 22:04:37 +0200
Message-ID: <1316376277-1224-4-git-send-email-julia@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw2.diku.dk (mgw2.diku.dk [130.225.96.92])
	by alsa0.perex.cz (Postfix) with ESMTP id C7AC4247D6
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

 src/pcm/pcm_multi.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/pcm/pcm_multi.c b/src/pcm/pcm_multi.c
index 68f2d68..6b39c7a 100644
--- a/src/pcm/pcm_multi.c
+++ b/src/pcm/pcm_multi.c
@@ -886,6 +886,8 @@ int snd_pcm_multi_open(snd_pcm_t **pcmp, const char *name,
 	err = snd_pcm_new(&pcm, SND_PCM_TYPE_MULTI, name, stream,
 			  multi->slaves[0].pcm->mode);
 	if (err < 0) {
+		free(multi->slaves);
+		free(multi->channels);
 		free(multi);
 		return err;
 	}
