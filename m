From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 1/4] hda-emu: Enable CONFIG_SND_DYNAMIC_MINORS
Date: Thu,  4 Sep 2014 16:21:23 +0200
Message-ID: <1409840486-14961-2-git-send-email-david.henningsson@canonical.com>
References: <1409840486-14961-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id BDC49265638
 for <alsa-devel@alsa-project.org>; Thu,  4 Sep 2014 16:21:23 +0200 (CEST)
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

This is enabled on any modern distro and necessary for modern HDMI
stuff (with more than two outputs) to function correctly.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 include/codec_config.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/codec_config.h b/include/codec_config.h
index 78bb04d..a5b4919 100644
--- a/include/codec_config.h
+++ b/include/codec_config.h
@@ -12,3 +12,5 @@
 #define CONFIG_SND_HDA_INPUT_BEEP
 
 #define CONFIG_SND_HDA_ENABLE_REALTEK_QUIRKS
+
+#define CONFIG_SND_DYNAMIC_MINORS
-- 
1.9.1
