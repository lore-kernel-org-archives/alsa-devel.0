From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: [PATCH 05/11] ucm: make sure active modifier and
	device lists are initialised
Date: Tue, 21 Dec 2010 22:11:54 +0000
Message-ID: <1292969520-18047-6-git-send-email-lrg@slimlogic.co.uk>
References: <1292969520-18047-1-git-send-email-lrg@slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 13924103A46
	for <alsa-devel@alsa-project.org>; Tue, 21 Dec 2010 23:12:20 +0100 (CET)
Received: by mail-wy0-f179.google.com with SMTP id 11so4299235wyi.38
	for <alsa-devel@alsa-project.org>; Tue, 21 Dec 2010 14:12:20 -0800 (PST)
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
 src/ucm/main.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/src/ucm/main.c b/src/ucm/main.c
index 64e4279..fae89a2 100644
--- a/src/ucm/main.c
+++ b/src/ucm/main.c
@@ -587,6 +587,8 @@ int snd_use_case_mgr_open(snd_use_case_mgr_t **mgr,
 	INIT_LIST_HEAD(&uc_mgr->verb_list);
 	INIT_LIST_HEAD(&uc_mgr->default_list);
 	INIT_LIST_HEAD(&uc_mgr->value_list);
+	INIT_LIST_HEAD(&uc_mgr->active_modifiers);
+	INIT_LIST_HEAD(&uc_mgr->active_devices);
 	pthread_mutex_init(&uc_mgr->mutex, NULL);
 
 	uc_mgr->card_name = strdup(card_name);
-- 
1.7.1
