From: Serge Nikolaenko <mypal_hh@utl.ru>
Subject: [PATCH] MPU401 lockups
Date: Mon, 25 Jun 2007 13:44:49 +1100
Message-ID: <200706251344.50051.mypal_hh@utl.ru>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_iwyfGsTZtO/kM76"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.utl.ru (mail.utl.ru [83.234.236.10])
	by alsa0.perex.cz (Postfix) with ESMTP id CBB9024417
	for <alsa-devel@alsa-project.org>;
	Mon, 25 Jun 2007 04:50:20 +0200 (CEST)
Received: from [83.234.237.204] (helo=[172.16.23.29])
	by mail.utl.ru with esmtp  (SMTP Server) id 1I2eeh-0001Ay-IO
	for alsa-devel@alsa-project.org; Mon, 25 Jun 2007 13:50:19 +1100
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
List-Id: alsa-devel@alsa-project.org

--Boundary-00=_iwyfGsTZtO/kM76
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

The attachement is the fix for mpu to prevent lockups/freezes. Added mutexes 
with down_trylock() calls, to prevent blocking.
Midi in/out not tested - I don't have no midi devices at the moment.

My soundcard is ESI Juli@. MB integrated midi is disabled in bios.

Last system messages after system freeze when running wine/jackd:

kernel: cmd: 0xff failed at 0xac0c (status = 0xb, data = 0x0)
...
kernel: BUG: soft lockup detected on CPU#0!
kernel:
kernel: Call Trace:
kernel:  <IRQ>  [<ffffffff802b0bdb>] softlockup_tick+0xdb/0xf6
kernel:  [<ffffffff8028f5d0>] update_process_times+0x42/0x68
kernel:  [<ffffffff80271f0c>] smp_local_timer_interrupt+0x34/0x55
kernel:  [<ffffffff802725e8>] smp_apic_timer_interrupt+0x51/0x69
kernel:  [<ffffffff8025ace6>] apic_timer_interrupt+0x66/0x70
kernel:  [<ffffffff889c600d>] :snd_mpu401_uart:mpu401_read_port+0x4/0x8
kernel:  
[<ffffffff889c62f0>] :snd_mpu401_uart:_snd_mpu401_uart_interrupt+0x4c/0x70
kernel:  
[<ffffffff889c6391>] :snd_mpu401_uart:snd_mpu401_uart_interrupt+0x13/0x1a
kernel:  [<ffffffff88a1f34b>] :snd_ice1724:snd_vt1724_interrupt+0x4e/0x13a
kernel:  [<ffffffff80210b93>] handle_IRQ_event+0x25/0x53
kernel:  [<ffffffff802b202a>] handle_fasteoi_irq+0x92/0xd1
kernel:  [<ffffffff8026862a>] do_IRQ+0xff/0x16d
kernel:  [<ffffffff8025a631>] ret_from_intr+0x0/0xa
kernel:  <EOI>  [<ffffffff802f5df7>] proc_info_read+0x0/0xb9
kernel:  [<ffffffff802f5df9>] proc_info_read+0x2/0xb9
kernel:  [<ffffffff8020b14e>] vfs_read+0xcb/0x173
kernel:  [<ffffffff80211847>] sys_read+0x45/0x6e
kernel:  [<ffffffff8025a11e>] system_call+0x7e/0x83	

--Boundary-00=_iwyfGsTZtO/kM76
Content-Type: text/x-diff;
  charset="us-ascii";
  name="mpu401_mutex.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="mpu401_mutex.diff"

diff -urN a/sound/drivers/mpu401/mpu401_uart.c b/sound/drivers/mpu401/mpu401_uart.c
--- a/sound/drivers/mpu401/mpu401_uart.c	2006-12-06 01:58:01.000000000 +1000
+++ b/sound/drivers/mpu401/mpu401_uart.c	2007-06-22 18:21:57.000000000 +1100
@@ -46,6 +46,9 @@
 static void snd_mpu401_uart_input_read(struct snd_mpu401 * mpu);
 static void snd_mpu401_uart_output_write(struct snd_mpu401 * mpu);
 
+DECLARE_MUTEX(mpu_tx_mutex);
+DECLARE_MUTEX(mpu_interrupt_mutex);
+
 /*
 
  */
@@ -103,6 +106,8 @@
 		snd_mpu401_uart_output_write(mpu);
 		spin_unlock(&mpu->output_lock);
 	}
+	
+	up(&mpu_tx_mutex);
 }
 
 static void _snd_mpu401_uart_interrupt(struct snd_mpu401 *mpu)
@@ -116,9 +121,16 @@
 		spin_unlock(&mpu->input_lock);
 	}
 	if (! (mpu->info_flags & MPU401_INFO_TX_IRQ))
+	{
 		/* ok. for better Tx performance try do some output
 		   when input is done */
+	    if (!down_trylock(&mpu_tx_mutex))
+	    {
 		uart_interrupt_tx(mpu);
+	    }
+	}
+	
+	up(&mpu_interrupt_mutex);
 }
 
 /**
@@ -134,7 +146,10 @@
 	
 	if (mpu == NULL)
 		return IRQ_NONE;
-	_snd_mpu401_uart_interrupt(mpu);
+	if (!down_trylock(&mpu_interrupt_mutex))
+	{
+	    _snd_mpu401_uart_interrupt(mpu);
+	}
 	return IRQ_HANDLED;
 }
 
@@ -153,7 +168,10 @@
 	
 	if (mpu == NULL)
 		return IRQ_NONE;
-	uart_interrupt_tx(mpu);
+	if (!down_trylock(&mpu_tx_mutex))
+	{
+	    uart_interrupt_tx(mpu);
+	}
 	return IRQ_HANDLED;
 }
 

--Boundary-00=_iwyfGsTZtO/kM76
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Boundary-00=_iwyfGsTZtO/kM76--
