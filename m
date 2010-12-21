From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: [PATCH 06/11] ucm: remove unused code.
Date: Tue, 21 Dec 2010 22:11:55 +0000
Message-ID: <1292969520-18047-7-git-send-email-lrg@slimlogic.co.uk>
References: <1292969520-18047-1-git-send-email-lrg@slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 567F3103A48
	for <alsa-devel@alsa-project.org>; Tue, 21 Dec 2010 23:12:21 +0100 (CET)
Received: by mail-wy0-f179.google.com with SMTP id 11so4299235wyi.38
	for <alsa-devel@alsa-project.org>; Tue, 21 Dec 2010 14:12:21 -0800 (PST)
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
 src/ucm/main.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/src/ucm/main.c b/src/ucm/main.c
index fae89a2..403f5c5 100644
--- a/src/ucm/main.c
+++ b/src/ucm/main.c
@@ -744,7 +744,6 @@ static int get_device_list(snd_use_case_mgr_t *uc_mgr, const char **list[],
         return get_list2(&verb->device_list, list,
                          struct use_case_device, list,
                          name, comment);
-        return 0;
 }
 
 /**
@@ -768,7 +767,6 @@ static int get_modifier_list(snd_use_case_mgr_t *uc_mgr, const char **list[],
         return get_list2(&verb->modifier_list, list,
                          struct use_case_modifier, list,
                          name, comment);
-        return 0;
 }
 
 struct myvalue {
-- 
1.7.1
