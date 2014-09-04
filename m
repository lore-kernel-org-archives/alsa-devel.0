From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 2/4] hda-emu: Add verbs for old Nvidia HDMI 8ch
	7x
Date: Thu,  4 Sep 2014 16:21:24 +0200
Message-ID: <1409840486-14961-3-git-send-email-david.henningsson@canonical.com>
References: <1409840486-14961-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 6F9C8265640
 for <alsa-devel@alsa-project.org>; Thu,  4 Sep 2014 16:21:24 +0200 (CEST)
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

The driver sends these verbs on purpose. I can't verify that it
is correct to do so, but I hope the driver is doing the right thing here.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 hda-spec.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/hda-spec.c b/hda-spec.c
index fe2ff36..b03d06a 100644
--- a/hda-spec.c
+++ b/hda-spec.c
@@ -263,6 +263,14 @@ static struct xhda_verb_table amdhdmi_verbs[] = {
 	{ } /* terminator */
 };
 
+static struct xhda_verb_table nvhdmi_8ch_7x_verbs[] = {
+	{ 0xf79, set_cached_verb, "nvhdmi_set_channel_allocation" },
+	{ 0xf7a, set_cached_verb, "nvhdmi_set_info_frame_checksum" },
+	{ 0xf98, set_cached_verb, "nvhdmi_set_audio_protection_on" },
+	{ 0xf99, set_cached_verb, "nvhdmi_set_audio_protection_off" },
+	{ } /* terminator */
+};
+
 /*
  */
 
@@ -428,6 +436,12 @@ static struct verb_ext_list extensions[] = {
 
 	{ .id = 0x1002aa01, .verbs = amdhdmi_verbs },
 
+	{ .id = 0x10de0002, .verbs = nvhdmi_8ch_7x_verbs },
+	{ .id = 0x10de0003, .verbs = nvhdmi_8ch_7x_verbs },
+	{ .id = 0x10de0005, .verbs = nvhdmi_8ch_7x_verbs },
+	{ .id = 0x10de0006, .verbs = nvhdmi_8ch_7x_verbs },
+	{ .id = 0x10de0007, .verbs = nvhdmi_8ch_7x_verbs },
+
 	{ }
 };
 
-- 
1.9.1
