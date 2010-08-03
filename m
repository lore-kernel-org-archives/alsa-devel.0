From: Bill Pemberton <wfp5p@virginia.edu>
Subject: [PATCH 1/5] sound: serial-u16550: fix uninitialized
	variable warning
Date: Tue,  3 Aug 2010 15:20:22 -0400
Message-ID: <1280863226-6824-1-git-send-email-wfp5p@virginia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from viridian.itc.virginia.edu (viridian.itc.Virginia.EDU
	[128.143.12.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 294F9243EC
	for <alsa-devel@alsa-project.org>;
	Tue,  3 Aug 2010 21:20:28 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: trivial@kernel.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Fix sound/drivers/serial-u16550.c:905: warning: 'uart' may be used
uninitialized in this function

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
---
 sound/drivers/serial-u16550.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/drivers/serial-u16550.c b/sound/drivers/serial-u16550.c
index a25fb7b..5f8ae28 100644
--- a/sound/drivers/serial-u16550.c
+++ b/sound/drivers/serial-u16550.c
@@ -902,7 +902,7 @@ static int __devinit snd_uart16550_rmidi(struct snd_uart16550 *uart, int device,
 static int __devinit snd_serial_probe(struct platform_device *devptr)
 {
 	struct snd_card *card;
-	struct snd_uart16550 *uart;
+	struct snd_uart16550 *uninitialized_var(uart);
 	int err;
 	int dev = devptr->id;
 
-- 
1.7.2
