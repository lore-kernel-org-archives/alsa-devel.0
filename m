From: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Subject: [PATCH 1/2] cplay: fix size and nmemb of mp3 header of
	fread
Date: Tue, 23 Jan 2018 11:33:11 +0900
Message-ID: <20180123023312.13029-1-suzuki.katsuhiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
 by alsa0.perex.cz (Postfix) with ESMTP id 543B0266E3A
 for <alsa-devel@alsa-project.org>; Tue, 23 Jan 2018 03:33:10 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>
Cc: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>, Jassi Brar <jaswinder.singh@linaro.org>, Takashi Iwai <tiwai@suse.com>, Masami Hiramatsu <masami.hiramatsu@linaro.org>
List-Id: alsa-devel@alsa-project.org

This patch swaps 'size' and 'nmemb' arguments of fread.
The fread returns always 1 (because 'nmemb' is 1) so checking
the return value is always failure.

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
---
 src/utils/cplay.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/utils/cplay.c b/src/utils/cplay.c
index e0603fd..bc95f0d 100644
--- a/src/utils/cplay.c
+++ b/src/utils/cplay.c
@@ -220,7 +220,7 @@ void play_samples(char *name, unsigned int card, unsigned int device,
 		exit(EXIT_FAILURE);
 	}
 
-	read = fread(&header, sizeof(header), 1, file);
+	read = fread(&header, 1, sizeof(header), file);
 	if (read != sizeof(header)) {
 		fprintf(stderr, "Unable to read header \n");
 		fclose(file);
-- 
2.15.0
