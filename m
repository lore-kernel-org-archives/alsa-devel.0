From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: [PATCH 01/11] ucm: removed unused 'active' member in
	struct use_case_device
Date: Tue, 21 Dec 2010 22:11:50 +0000
Message-ID: <1292969520-18047-2-git-send-email-lrg@slimlogic.co.uk>
References: <1292969520-18047-1-git-send-email-lrg@slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 8B3BE103A2E
	for <alsa-devel@alsa-project.org>; Tue, 21 Dec 2010 23:12:14 +0100 (CET)
Received: by wyi11 with SMTP id 11so4299235wyi.38
	for <alsa-devel@alsa-project.org>; Tue, 21 Dec 2010 14:12:14 -0800 (PST)
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
 src/ucm/ucm_local.h |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/src/ucm/ucm_local.h b/src/ucm/ucm_local.h
index 9f71d42..13e82da 100644
--- a/src/ucm/ucm_local.h
+++ b/src/ucm/ucm_local.h
@@ -115,8 +115,6 @@ struct use_case_device {
 	struct list_head list;
 	struct list_head active_list;
 
-	unsigned int active: 1;
-
 	char *name;
 	char *comment;
 
-- 
1.7.1
