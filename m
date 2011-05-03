From: baeksan@ccrma.stanford.edu
Subject: [PATCH] [ALSA][UCM] fix memory leak when executing
	cset commands. snd_ctl_elem's are allocated, but never free'ed
Date: Tue,  3 May 2011 10:52:34 -0700
Message-ID: <4dc040e4.2423440a.597c.12c5@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, Baek Chang <breakchange@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Baek Chang <breakchange@gmail.com>

---
 src/ucm/main.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/src/ucm/main.c b/src/ucm/main.c
index 86f29e3..f8ceeeb 100644
--- a/src/ucm/main.c
+++ b/src/ucm/main.c
@@ -173,7 +173,8 @@ static int execute_cset(snd_ctl_t *ctl, char *cset)
 	pos = strrchr(cset, ' ');
 	if (pos == NULL) {
 		uc_error("undefined value for cset >%s<", cset);
-		return -EINVAL;
+		err =  -EINVAL;
+		goto __fail;
 	}
 	*pos = '\0';
 	err = snd_ctl_ascii_elem_id_parse(id, cset);
@@ -196,6 +197,14 @@ static int execute_cset(snd_ctl_t *ctl, char *cset)
 	err = 0;
       __fail:
 	*pos = ' ';
+
+	if (id != NULL)
+		free(id);
+	if (value != NULL)
+		free(value);
+	if (info != NULL)
+		free(info);
+
 	return err;
 }
 
-- 
1.6.0.4
