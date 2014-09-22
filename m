From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 5/5] hda-spec: Add IDT 92HD95 to IDT verb codec
	list
Date: Mon, 22 Sep 2014 13:09:06 +0200
Message-ID: <1411384146-23286-6-git-send-email-david.henningsson@canonical.com>
References: <1411384146-23286-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id BA1042652D1
 for <alsa-devel@alsa-project.org>; Mon, 22 Sep 2014 13:09:13 +0200 (CEST)
In-Reply-To: <1411384146-23286-1-git-send-email-david.henningsson@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 hda-spec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hda-spec.c b/hda-spec.c
index 0f42a2d..5f1ac42 100644
--- a/hda-spec.c
+++ b/hda-spec.c
@@ -308,6 +308,7 @@ static struct verb_ext_list extensions[] = {
 	{ .id = 0x111d7674, .verbs = idt_92hd7xx_verbs },
 	{ .id = 0x111d7675, .verbs = idt_92hd7xx_verbs },
 	{ .id = 0x111d7676, .verbs = idt_92hd7xx_verbs },
+	{ .id = 0x111d7695, .verbs = idt_92hd7xx_verbs },
 	{ .id = 0x111d76b0, .verbs = idt_92hd7xx_verbs },
 	{ .id = 0x111d76b1, .verbs = idt_92hd7xx_verbs },
 	{ .id = 0x111d76b2, .verbs = idt_92hd7xx_verbs },
-- 
1.9.1
