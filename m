From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: [PATCH 10/11] ucm: fix handling of cset with spaces in
	the control name
Date: Tue, 21 Dec 2010 22:11:59 +0000
Message-ID: <1292969520-18047-11-git-send-email-lrg@slimlogic.co.uk>
References: <1292969520-18047-1-git-send-email-lrg@slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 68E9A103A5A
	for <alsa-devel@alsa-project.org>; Tue, 21 Dec 2010 23:12:27 +0100 (CET)
Received: by mail-ww0-f51.google.com with SMTP id 15so4322500wwe.20
	for <alsa-devel@alsa-project.org>; Tue, 21 Dec 2010 14:12:27 -0800 (PST)
In-Reply-To: <1292969520-18047-1-git-send-email-lrg@slimlogic.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Always terminate the cset command based on the last space found within the
cset command since the control name may contain spaces.
---
 src/ucm/main.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/ucm/main.c b/src/ucm/main.c
index 5f44461..7305042 100644
--- a/src/ucm/main.c
+++ b/src/ucm/main.c
@@ -168,7 +168,7 @@ static int execute_cset(snd_ctl_t *ctl, char *cset)
 	snd_ctl_elem_value_malloc(&value);
 	snd_ctl_elem_info_malloc(&info);
 
-	pos = strchr(cset, ' ');
+	pos = strrchr(cset, ' ');
 	if (pos == NULL) {
 		uc_error("undefined value for cset >%s<", cset);
 		return -EINVAL;
-- 
1.7.1
