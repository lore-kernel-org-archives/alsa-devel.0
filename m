From: Nicolas Kaiser <nikai@nikai.net>
Subject: [PATCH] sound/usb/usx2y: simplify conditional
Date: Tue, 5 Oct 2010 17:38:12 +0200
Message-ID: <20101005173812.5190495d@absol.kitzblitz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Simplify conditional: (a || (!a && b)) => (a || b)

Signed-off-by: Nicolas Kaiser <nikai@nikai.net>
---
 sound/usb/usx2y/usx2yhwdeppcm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/usb/usx2y/usx2yhwdeppcm.c b/sound/usb/usx2y/usx2yhwdeppcm.c
index 2a528e5..3146a81 100644
--- a/sound/usb/usx2y/usx2yhwdeppcm.c
+++ b/sound/usb/usx2y/usx2yhwdeppcm.c
@@ -54,7 +54,7 @@
 #include <linux/gfp.h>
 #include "usbusx2yaudio.c"
 
-#if defined(USX2Y_NRPACKS_VARIABLE) || (!defined(USX2Y_NRPACKS_VARIABLE) &&  USX2Y_NRPACKS == 1)
+#if defined(USX2Y_NRPACKS_VARIABLE) || USX2Y_NRPACKS == 1
 
 #include <sound/hwdep.h>
 
-- 
1.7.2.2
