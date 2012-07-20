From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 3/3] hda-emu: Fix extra IDT verbs for 92hd93bxx
Date: Fri, 20 Jul 2012 14:59:52 +0200
Message-ID: <1342789192-11191-3-git-send-email-david.henningsson@canonical.com>
References: <1342789192-11191-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 063DB26534B
 for <alsa-devel@alsa-project.org>; Fri, 20 Jul 2012 15:00:08 +0200 (CEST)
In-Reply-To: <1342789192-11191-1-git-send-email-david.henningsson@canonical.com>
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

Fixes a false alarm on this codec:
92hd93bxx-dell-latitude-e6230-ccert-201202-10551

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 hda-spec.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/hda-spec.c b/hda-spec.c
index 3e14394..f1b03b4 100644
--- a/hda-spec.c
+++ b/hda-spec.c
@@ -265,6 +265,7 @@ static struct verb_ext_list extensions[] = {
 	{ .id = 0x111d76d4, .verbs = idt_92hd8xx_verbs },
 	{ .id = 0x111d76d5, .verbs = idt_92hd8xx_verbs },
 	{ .id = 0x111d76d9, .verbs = idt_92hd8xx_verbs },
+	{ .id = 0x111d76df, .verbs = idt_92hd8xx_verbs },
 	{ .id = 0x111d76e0, .verbs = idt_92hd8xx_verbs },
 	{ .id = 0x111d76e3, .verbs = idt_92hd8xx_verbs },
 	{ .id = 0x111d76e5, .verbs = idt_92hd8xx_verbs },
-- 
1.7.9.5
