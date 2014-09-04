From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 3/4] hda-emu: Allow some more codec IDs to use
	ATI HDMI special verbs
Date: Thu,  4 Sep 2014 16:21:25 +0200
Message-ID: <1409840486-14961-4-git-send-email-david.henningsson@canonical.com>
References: <1409840486-14961-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 197F9265644
 for <alsa-devel@alsa-project.org>; Thu,  4 Sep 2014 16:21:25 +0200 (CEST)
In-Reply-To: <1409840486-14961-1-git-send-email-david.henningsson@canonical.com>
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
 hda-spec.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hda-spec.c b/hda-spec.c
index b03d06a..58dd87a 100644
--- a/hda-spec.c
+++ b/hda-spec.c
@@ -434,6 +434,9 @@ static struct verb_ext_list extensions[] = {
 	{ .id = 0x11060446, .verbs = vt2002p_verbs },
 	{ .id = 0x11068446, .verbs = vt2002p_verbs },
 
+	{ .id = 0x1002793c, .verbs = amdhdmi_verbs },
+	{ .id = 0x10027919, .verbs = amdhdmi_verbs },
+	{ .id = 0x1002791a, .verbs = amdhdmi_verbs },
 	{ .id = 0x1002aa01, .verbs = amdhdmi_verbs },
 
 	{ .id = 0x10de0002, .verbs = nvhdmi_8ch_7x_verbs },
-- 
1.9.1
