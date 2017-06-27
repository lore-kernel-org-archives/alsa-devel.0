From: b_lkasam@codeaurora.org
Subject: ALSA core info race condition
Date: Wed, 28 Jun 2017 00:42:18 +0530
Message-ID: <70ff31e5f7fb35774cc0a9f3764ed144@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
 by alsa0.perex.cz (Postfix) with ESMTP id 1EBD2266838
 for <alsa-devel@alsa-project.org>; Tue, 27 Jun 2017 21:12:20 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: lkasam@qti.qualcomm.com, b_lkasam@codeaurora.org
List-Id: alsa-devel@alsa-project.org

hi ALSA team,
there is a race condition in below API when accessing list API.

In file sound/core/info.c:

Added below patch to avoid list access of same parent node
by two threads at same time causing list_debug crash.

diff --git a/sound/core/info.c b/sound/core/info.c
index b5158b5..c1fd671 100644
--- a/sound/core/info.c
+++ b/sound/core/info.c
@@ -747,8 +747,11 @@ snd_info_create_entry(const char *name, struct 
snd_info_entry *parent)
  	INIT_LIST_HEAD(&entry->children);
  	INIT_LIST_HEAD(&entry->list);
  	entry->parent = parent;
-	if (parent)
+	if (parent) {
+		mutex_lock(&parent->access);
  		list_add_tail(&entry->list, &parent->children);
+		mutex_unlock(&parent->access);
+	}
  	return entry;
  }

Please check above logic looks fine, and help comment accordingly.


Thanks
Kasam
