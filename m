From: Arun Raghavan <arun.raghavan@collabora.co.uk>
Subject: [alsa-lib] [PATCH 1/4] control: Use strcpy() instead
	of stpcpy()
Date: Tue, 17 Jul 2012 15:30:14 +0530
Message-ID: <1342519217-3668-2-git-send-email-arun.raghavan@collabora.co.uk>
References: <1342519217-3668-1-git-send-email-arun.raghavan@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [93.93.135.160])
 by alsa0.perex.cz (Postfix) with ESMTP id 5467C264F91
 for <alsa-devel@alsa-project.org>; Tue, 17 Jul 2012 12:01:58 +0200 (CEST)
In-Reply-To: <1342519217-3668-1-git-send-email-arun.raghavan@collabora.co.uk>
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
Cc: Arun Raghavan <arun.raghavan@collabora.co.uk>
List-Id: alsa-devel@alsa-project.org

This allows us to build in environments that don't provide stpcpy().
This makes it necessary to traverse the string twice, but should not be
noticeable in clients since this function is very unlikely to be part of
a performance-critical path.

Signed-off-by: Arun Raghavan <arun.raghavan@collabora.co.uk>
---
 src/control/control.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/control/control.c b/src/control/control.c
index a0965c6..7ff59e6 100644
--- a/src/control/control.c
+++ b/src/control/control.c
@@ -417,8 +417,10 @@ int snd_ctl_elem_add_enumerated(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
 	info->value.enumerated.names_ptr = (uintptr_t)buf;
 	info->value.enumerated.names_length = bytes;
 	p = buf;
-	for (i = 0; i < items; ++i)
-		p = stpcpy(p, names[i]) + 1;
+	for (i = 0; i < items; ++i) {
+		strcpy(p, names[i]);
+		p += strlen(names[i]) + 1;
+        }
 
 	err = ctl->ops->element_add(ctl, info);
 
-- 
1.7.8.6
