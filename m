From: Joe Perches <joe@perches.com>
Subject: [PATCH 9/8] printk: Only look for prefix levels in
	kernel messages
Date: Tue, 05 Jun 2012 20:04:02 -0700
Message-ID: <1338951842.11962.41.camel@joe2Laptop>
References: <cover.1338889066.git.joe@perches.com>
	<20120605142826.d92316a0.akpm@linux-foundation.org>
	<1338934303.5780.8.camel@joe2Laptop>
	<20120605151754.a794ac7c.akpm@linux-foundation.org>
	<1338936572.5780.29.camel@joe2Laptop>
	<20120605162910.caccb0d4.akpm@linux-foundation.org>
	<1338939316.11962.3.camel@joe2Laptop>
	<CAPXgP13J+8-dPpZkSfh9sM3xXujC2Rb9tJaOvGoEPghgdr8jiw@mail.gmail.com>
	<1338939792.11962.4.camel@joe2Laptop>
	<CAPXgP10DEsqtz9xbPUQ3xCwdFGTTYyTGSd7yEcU2vUr3SJ83Sw@mail.gmail.com>
	<1338940345.11962.9.camel@joe2Laptop>
	<20120605165808.cd255b93.akpm@linux-foundation.org>
	<1338941247.11962.16.camel@joe2Laptop>
	<CAPXgP12OFnh6FZO4zFGCw=Ea4U6Ne5OoCg_9BPxRX62x0EVnng@mail.gmail.com>
	<1338941971.11962.20.camel@joe2Laptop>
	<CAPXgP10VE2huY4gGpeFPe=YKYM+nDBfoMgpHnGmQwn0jdPxhbw@mail.gmail.com>
	<20120605173751.65a2e1ee.akpm@linux-foundation.org>
	<1338943205.11962.28.camel@joe2Laptop>
	<20120605174638.69bcfa31.akpm@linux-foundation.org>
	<CAPXgP11DA2z2y4kR8C+AGtrd_-8=2Cy0jj3GX7T5JqczNke4GQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from labridge.com (perches-mx.perches.com [206.117.179.246])
	by alsa0.perex.cz (Postfix) with ESMTP id CCDE81044B1
	for <alsa-devel@alsa-project.org>;
	Wed,  6 Jun 2012 05:04:06 +0200 (CEST)
In-Reply-To: <CAPXgP11DA2z2y4kR8C+AGtrd_-8=2Cy0jj3GX7T5JqczNke4GQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kay Sievers <kay@vrfy.org>
Cc: devel@driverdev.osuosl.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-btrfs@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

vprintk_emit prefix parsing should only be done for internal
kernel messages.  This allows existing behavior to be kept
in all cases.

Signed-off-by: Joe Perches <joe@perches.com>
---
 kernel/printk.c |   32 +++++++++++++++++---------------
 1 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/kernel/printk.c b/kernel/printk.c
index 5cd73f7..4e72c07 100644
--- a/kernel/printk.c
+++ b/kernel/printk.c
@@ -1267,7 +1267,6 @@ asmlinkage int vprintk_emit(int facility, int level,
 	static char cont_buf[LOG_LINE_MAX];
 	static size_t cont_len;
 	static int cont_level;
-	int kern_level;
 	static struct task_struct *cont_task;
 	static char textbuf[LOG_LINE_MAX];
 	char *text = textbuf;
@@ -1329,21 +1328,24 @@ asmlinkage int vprintk_emit(int facility, int level,
 		newline = true;
 	}
 
-	/* strip syslog prefix and extract log level or control flags */
-	kern_level = printk_get_level(text);
-	if (kern_level) {
-		const char *end_of_header = printk_skip_level(text);
-		switch (kern_level) {
-		case '0' ... '7':
-			if (level == -1)
-				level = kern_level - '0';
-		case 'd':	/* KERN_DEFAULT */
-			prefix = true;
-		case 'c':	/* KERN_CONT */
-			break;
+	/* strip kernel syslog prefix and extract log level or control flags */
+	if (facility == 0) {
+		int kern_level = printk_get_level(text);
+
+		if (kern_level) {
+			const char *end_of_header = printk_skip_level(text);
+			switch (kern_level) {
+			case '0' ... '7':
+				if (level == -1)
+					level = kern_level - '0';
+			case 'd':	/* KERN_DEFAULT */
+				prefix = true;
+			case 'c':	/* KERN_CONT */
+				break;
+			}
+			text_len -= end_of_header - text;
+			text = (char *)end_of_header;
 		}
-		text_len -=  end_of_header - text;
-		text = (char *)end_of_header;
 	}
 
 	if (level == -1)
