From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] MPU-401 fixes
Date: Mon, 05 May 2003 08:33:25 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0305050831420.4924-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


- fix deadlock: when snd_mpu401_uart_input_trigger() is interrupted
  immediately after the call to spin_unlock_irqrestore(), the interrupt
  handler won't clear the interrupt condition because the RX_LOOP bit is
  still set
- abort the tx loop when the FIFO is full; otherwise, the inner loop would
  be executed 25600 times
- clear the output trigger bit when output buffer is exhausted


Index: alsa-kernel/drivers/mpu401/mpu401_uart.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/drivers/mpu401/mpu401_uart.c,v
retrieving revision 1.23
diff -u -r1.23 mpu401_uart.c
--- alsa-kernel/drivers/mpu401/mpu401_uart.c	23 Apr 2003 10:01:28 -0000	1.23
+++ alsa-kernel/drivers/mpu401/mpu401_uart.c	5 May 2003 06:28:02 -0000
@@ -93,12 +93,9 @@
 static void _snd_mpu401_uart_interrupt(mpu401_t *mpu)
 {
 	if (test_bit(MPU401_MODE_BIT_INPUT, &mpu->mode)) {
-		if (! test_and_set_bit(MPU401_MODE_BIT_RX_LOOP, &mpu->mode)) {
-			spin_lock(&mpu->input_lock);
-			snd_mpu401_uart_input_read(mpu);
-			spin_unlock(&mpu->input_lock);
-			clear_bit(MPU401_MODE_BIT_RX_LOOP, &mpu->mode);
-		}
+		spin_lock(&mpu->input_lock);
+		snd_mpu401_uart_input_read(mpu);
+		spin_unlock(&mpu->input_lock);
 	} else
 		snd_mpu401_uart_clear_rx(mpu);
  	/* ok. for better Tx performance try do some output when input is done */
@@ -369,9 +366,12 @@
 					break;
 				}
 			}
+			if (timeout == 0)
+				break; /* Tx FIFO full - try again later */
 		} else {
 			snd_mpu401_uart_remove_timer (mpu, 0);
-			max = 1; /* no other data - leave the tx loop */
+			clear_bit(MPU401_MODE_BIT_OUTPUT_TRIGGER, &mpu->mode);
+			break; /* no other data - leave the tx loop */
 		}
 	} while (--max > 0);
 }




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
