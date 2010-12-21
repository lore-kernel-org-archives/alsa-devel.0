From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: [PATCH 04/11] ucm: implement basic script exec
	functionality
Date: Tue, 21 Dec 2010 22:11:53 +0000
Message-ID: <1292969520-18047-5-git-send-email-lrg@slimlogic.co.uk>
References: <1292969520-18047-1-git-send-email-lrg@slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 8FC66103A43
	for <alsa-devel@alsa-project.org>; Tue, 21 Dec 2010 23:12:19 +0100 (CET)
Received: by mail-ww0-f51.google.com with SMTP id 15so4322500wwe.20
	for <alsa-devel@alsa-project.org>; Tue, 21 Dec 2010 14:12:19 -0800 (PST)
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

Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>
---
 src/ucm/main.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/src/ucm/main.c b/src/ucm/main.c
index ecf07f9..64e4279 100644
--- a/src/ucm/main.c
+++ b/src/ucm/main.c
@@ -265,7 +265,9 @@ static int execute_sequence(snd_use_case_mgr_t *uc_mgr,
 			usleep(s->data.sleep);
 			break;
 		case SEQUENCE_ELEMENT_TYPE_EXEC:
-			uc_error("exec not yet implemented: '%s'", s->data.exec);
+			err = system(s->data.exec);
+			if (err < 0)
+				goto __fail;
 			break;
 		default:
 			uc_error("unknown sequence command %i", s->type);
-- 
1.7.1
