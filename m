From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 2/2] ASoC: DaVinci: Change default output volume
Date: Mon,  6 Jul 2009 15:02:03 -0700
Message-ID: <1246917723-27071-3-git-send-email-khilman@deeprootsystems.com>
References: <1246917723-27071-1-git-send-email-khilman@deeprootsystems.com>
	<1246917723-27071-2-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f188.google.com (mail-pz0-f188.google.com
	[209.85.222.188])
	by alsa0.perex.cz (Postfix) with ESMTP id 2ED07103867
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Jul 2009 00:02:11 +0200 (CEST)
Received: by pzk26 with SMTP id 26so1613909pzk.16
	for <alsa-devel@alsa-project.org>; Mon, 06 Jul 2009 15:02:10 -0700 (PDT)
In-Reply-To: <1246917723-27071-2-git-send-email-khilman@deeprootsystems.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: davinci-linux-open-source@linux.davincidsp.com, broonie@sirena.org.uk, Naresh Medisetty <naresh@ti.com>
List-Id: alsa-devel@alsa-project.org

From: Naresh Medisetty <naresh@ti.com>

Changes default output volume of alsa driver since it is very low

Signed-off-by: Naresh Medisetty <naresh@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 sound/soc/codecs/tlv320aic3x.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.h b/sound/soc/codecs/tlv320aic3x.h
index ac827e5..76dbff4 100644
--- a/sound/soc/codecs/tlv320aic3x.h
+++ b/sound/soc/codecs/tlv320aic3x.h
@@ -195,7 +195,7 @@
 #define INVERT_VOL(val)   (0x7f - val)
 
 /* Default output volume (inverted) */
-#define DEFAULT_VOL     INVERT_VOL(0x50)
+#define DEFAULT_VOL     INVERT_VOL(0x60)
 /* Default input volume */
 #define DEFAULT_GAIN    0x20
 
-- 
1.6.3.3
