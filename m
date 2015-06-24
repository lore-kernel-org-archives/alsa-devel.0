From: Manish Sogi <manish.sogi@samsung.com>
Subject: [PATCH] cplay: check return value of fread() function
 and compare it with "number of blocks to read" rather than "size of each
 block".
Date: Wed, 24 Jun 2015 13:13:40 +0530
Message-ID: <1435131820-3944-1-git-send-email-manish.sogi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
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
Cc: alsa-devel@alsa-project.org, sachin.dev@samsung.com, Manish Sogi <manish.sogi@samsung.com>
List-Id: alsa-devel@alsa-project.org

fread() function on success returns the number
of blocks which it reads, so return value should
be compared with "1" because only 1 block having
size equal to sizeof(header) needs to be read.
On success fread will return 1 else error case.

Signed-off-by: Manish Sogi <manish.sogi@samsung.com>
---
 src/utils/cplay.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/utils/cplay.c b/src/utils/cplay.c
index 2d1a176..aeea5bb 100644
--- a/src/utils/cplay.c
+++ b/src/utils/cplay.c
@@ -218,7 +218,7 @@ void play_samples(char *name, unsigned int card, unsigned int device,
 	}
 
 	read = fread(&header, sizeof(header), 1, file);
-	if (read != sizeof(header)) {
+	if (read != 1) {
 		fprintf(stderr, "Unable to read header \n");
 		fclose(file);
 		exit(EXIT_FAILURE);
-- 
1.7.9.5
