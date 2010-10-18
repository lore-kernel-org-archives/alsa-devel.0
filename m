From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Subject: [PATCH] ALSA: emu10k1: Fix warning: "CCR" redefined
Date: Mon, 18 Oct 2010 12:20:39 +0900
Message-ID: <1287372039-12097-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
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
Cc: tiwai@suse.de, Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>, lethal@linux-sh.org
List-Id: alsa-devel@alsa-project.org

CCR is defined in emu10k1, but SuperH is defined too.
If user use this driver with SuperH, it becomes a double definition.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
CC: Takashi iwai <tiwai@suse.de>
CC: Paul Mundt <lethal@linux-sh.org>
---
 include/sound/emu10k1.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/sound/emu10k1.h b/include/sound/emu10k1.h
index 7dc97d1..d1fcc31 100644
--- a/include/sound/emu10k1.h
+++ b/include/sound/emu10k1.h
@@ -438,6 +438,7 @@
 #define CCCA_CURRADDR_MASK	0x00ffffff	/* Current address of the selected channel		*/
 #define CCCA_CURRADDR		0x18000008
 
+#undef CCR
 #define CCR			0x09		/* Cache control register				*/
 #define CCR_CACHEINVALIDSIZE	0x07190009
 #define CCR_CACHEINVALIDSIZE_MASK	0xfe000000	/* Number of invalid samples cache for this channel    	*/
-- 
1.7.1

