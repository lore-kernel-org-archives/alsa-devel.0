From: Giuliano Pochini <pochini@shiny.it>
Subject: [PATCH] echoaudio, about changeset 5389
Date: Sun, 16 Sep 2007 23:04:06 +0200
Message-ID: <20070916230406.13a3754e.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out112.alice.it (smtp-out112.alice.it [85.37.17.112])
	by alsa0.perex.cz (Postfix) with ESMTP id 9347E103826
	for <alsa-devel@alsa-project.org>;
	Sun, 16 Sep 2007 23:08:18 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

About changeset 5389: Remove superfluous volatile prefix. It's fine, except
for the struct comm_page.handshake which is polled by
echoaudio_dsp.c::wait_handshake(). Without volatile we need another way to
prevent the compiler from moving the read outside of the loop. If I
overlooked something, please let me know.


Short descr.: This patch adds a barrier() to prevent the compiler from
moving the read outside of the loop. It also fixes a comment.

Signed-off-by: Giuliano Pochini <pochini@shiny.it>

--- alsa-kernel/pci/echoaudio/echoaudio_dsp.c__orig	2007-09-16 22:33:37.000000000 +0200
+++ alsa-kernel/pci/echoaudio/echoaudio_dsp.c	2007-09-16 22:39:58.000000000 +0200
@@ -43,11 +43,11 @@ static int wait_handshake(struct echoaud
 {
 	int i;
 
-	/* Wait up to 10ms for the handshake from the DSP */
+	/* Wait up to 20ms for the handshake from the DSP */
 	for (i = 0; i < HANDSHAKE_TIMEOUT; i++) {
 		/* Look for the handshake value */
+		barrier();
 		if (chip->comm_page->handshake) {
-			/*if (i)  DE_ACT(("Handshake time: %d\n", i));*/
 			return 0;
 		}
 		udelay(1);


--
Giuliano.
