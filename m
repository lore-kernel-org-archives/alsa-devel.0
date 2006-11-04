From: Giuliano Pochini <pochini@shiny.it>
Subject: [PATCH] echoaudio, rawmidi race fix
Date: Sat, 4 Nov 2006 21:45:03 +0100
Message-ID: <20061104214503.0776410f.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


There is a very unlikely possibility that snd_echo_midi_output_write()
dereferences a NULL pointer or it accesses a substream that doesn't exists
anymore when the .close callback is executed while the timer handler is
running on another cpu. The following patch replaces del_timer() with
del_timer_sync() in the .trigger callback and it deletes a useless check in
the timer handler.

Short description for the changelog:

This patch fixes a race condition between the timer handler and the close callback.


Signed-off-by: Giuliano Pochini <pochini@shiny.it>

--- alsa-kernel/pci/echoaudio/midi.c__orig	2006-11-02 20:39:45.000000000 +0100
+++ alsa-kernel/pci/echoaudio/midi.c	2006-11-02 20:44:22.000000000 +0100
@@ -213,7 +213,7 @@ static void snd_echo_midi_output_write(u
 	sent = bytes = 0;
 	spin_lock_irqsave(&chip->lock, flags);
 	chip->midi_full = 0;
-	if (chip->midi_out && !snd_rawmidi_transmit_empty(chip->midi_out)) {
+	if (!snd_rawmidi_transmit_empty(chip->midi_out)) {
 		bytes = snd_rawmidi_transmit_peek(chip->midi_out, buf,
 						  MIDI_OUT_BUFFER_SIZE - 1);
 		DE_MID(("Try to send %d bytes...\n", bytes));
@@ -264,9 +264,11 @@ static void snd_echo_midi_output_trigger
 		}
 	} else {
 		if (chip->tinuse) {
-			del_timer(&chip->timer);
 			chip->tinuse = 0;
+			spin_unlock_irq(&chip->lock);
+			del_timer_sync(&chip->timer);
 			DE_MID(("Timer removed\n"));
+			return;
 		}
 	}
 	spin_unlock_irq(&chip->lock);



--
Giuliano.

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
