From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ALSA: mixart: Mark expected switch fall-through
Date: Sat, 4 Aug 2018 15:11:03 -0500
Message-ID: <20180804201103.GA26669@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: alsa-devel@alsa-project.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 sound/pci/mixart/mixart.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/mixart/mixart.c b/sound/pci/mixart/mixart.c
index a74f1ad..9cd297a 100644
--- a/sound/pci/mixart/mixart.c
+++ b/sound/pci/mixart/mixart.c
@@ -182,6 +182,7 @@ static int mixart_set_clock(struct mixart_mgr *mgr,
 	case PIPE_RUNNING:
 		if(rate != 0)
 			break;
+		/* fall through */
 	default:
 		if(rate == 0)
 			return 0; /* nothing to do */
-- 
2.7.4
