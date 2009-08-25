From: Jiri Slaby <jirislaby@gmail.com>
Subject: [PATCH 2/4] SOUND: serial-u16550,
	use unitialized_var(uart)
Date: Tue, 25 Aug 2009 22:59:35 +0200
Message-ID: <1251233977-5819-2-git-send-email-jirislaby@gmail.com>
References: <1251233977-5819-1-git-send-email-jirislaby@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server1.wserver.cz (server1.wserver.cz [82.113.45.157])
	by alsa0.perex.cz (Postfix) with ESMTP id 523FF24445
	for <alsa-devel@alsa-project.org>;
	Tue, 25 Aug 2009 22:59:39 +0200 (CEST)
In-Reply-To: <1251233977-5819-1-git-send-email-jirislaby@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: Isaku Yamahata <yamahata@private.email.ne.jp>, alsa-devel@alsa-project.org, Jiri Slaby <jirislaby@gmail.com>, linux-kernel@vger.kernel.org, George Hansper <ghansper@apana.org.au>
List-Id: alsa-devel@alsa-project.org

To avoid a wrong compiler warning, use unitialized_var(uart) in
snd_uart16550_rmidi.

If uart is unitialized, we return before its use.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Isaku Yamahata <yamahata@private.email.ne.jp>
Cc: George Hansper <ghansper@apana.org.au>
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
1.6.3.3
