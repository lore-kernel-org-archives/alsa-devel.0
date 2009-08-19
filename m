From: Shine Liu <shinel@foxmail.com>
Subject: [PATCH] pcm_lib.c: Fixed inaccurate calculation of
 hw_ptr_interrupt in snd_pcm_update_hw_ptr_interrupt function
Date: Wed, 19 Aug 2009 18:22:19 +0800
Message-ID: <1250677339.3516.17.camel@shinel>
Reply-To: shinel@foxmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpbg64.qq.com (smtpbg64.qq.com [119.147.10.223])
	by alsa0.perex.cz (Postfix) with SMTP id 39DF024502
	for <alsa-devel@alsa-project.org>;
	Wed, 19 Aug 2009 12:22:39 +0200 (CEST)
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
Cc: tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

There's no restriction on that the runtime->period_size should be the
multiplicator of the runtime->buffer_size in current kernel code.

So "hw_ptr_interrupt = runtime->hw_ptr_interrupt +
runtime->period_size;" is not always the trueth.

I've encounter the problem of this bug, the kernel told me "PCM:
Unexpected hw_pointer value (stream=0, pos=8, intr_ptr=16384)".

The period_size and buffer_size I used was 0x800 and 0x3e80 when the bug
occured.

Following patch will fix the bug.



Signed-off-by: Shine Liu <shinel@foxmail.com>
-----------------------------------------------------------------------

--- a/sound/core/pcm_lib.c	2009-08-14 06:43:34.000000000 +0800
+++ b/sound/core/pcm_lib.c	2009-08-19 17:59:00.000000000 +0800
@@ -248,6 +248,12 @@
 	hw_base = runtime->hw_ptr_base;
 	new_hw_ptr = hw_base + pos;
 	hw_ptr_interrupt = runtime->hw_ptr_interrupt + runtime->period_size;
+	/* if the period_size is not the multiplicator of the 
+ 	 * buffer_size, the hw_ptr_interrupt calculated above 
+ 	 * may not be correct, should be fixed. 
+ 	 */
+	if(hw_ptr_interrupt > hw_base + runtime->buffer_size)
+		hw_ptr_interrupt = hw_base + runtime->buffer_size;
 	delta = new_hw_ptr - hw_ptr_interrupt;
 	if (hw_ptr_interrupt >= runtime->boundary) {
 		hw_ptr_interrupt -= runtime->boundary;
