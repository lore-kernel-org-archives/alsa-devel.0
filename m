From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] disable period wakeups
Date: Tue, 16 Nov 2010 10:19:40 +0100
Message-ID: <4CE24CAC.2070909@ladisch.de>
References: <AANLkTimLAuzn+rSEGTv2oV_yPErbBHdRdij-61Ya2JcE@mail.gmail.com>
	<4CE1043A.6010607@ladisch.de>
	<alpine.LNX.2.00.1011151123380.29422@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id C5FEE2434C
	for <alsa-devel@alsa-project.org>; Tue, 16 Nov 2010 10:17:54 +0100 (CET)
In-Reply-To: <alpine.LNX.2.00.1011151123380.29422@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: pl bossart <bossart.nospam@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
>> pl bossart wrote:
>>> Here's the second set of patches based on feedback from Takashi,
>>> Jaroslav and Clemens. Hope this is fine now.
> 
> The problem in the kernel side is that there is no ring buffer boundary 
> check using system jiffies. Without this check, the actual implementation 
> does not guarantee the consistency of hw_ptr.

How about this?

--8<---------------------------------------------------------------->8--
ALSA: pcm: detect xruns in no-period-wakeup mode

When period wakeups are disabled, successive calls to the pointer update
function do not have a maximum allowed distance, so xruns cannot be
detected with the pointer value only.

To detect xruns, compare the actually elapsed time with the time that
should have theoretically elapsed since the last update.  When the
hardware pointer has wrapped around due to an xrun, the actually elapsed
time will be too big by about hw_ptr_buffer_jiffies.

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
---
 sound/core/pcm_lib.c |   18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

--- alsa-kernel/sound/core/pcm_lib.c
+++ alsa-kernel/sound/core/pcm_lib.c
@@ -374,9 +374,23 @@ static int snd_pcm_update_hw_ptr0(struct
 			   (unsigned long)runtime->hw_ptr_base);
 	}
 
-	/* without period interrupts, there are no regular pointer updates */
-	if (runtime->no_period_wakeup)
+	if (runtime->no_period_wakeup) {
+		/*
+		 * Without regular period interrupts, we have to check
+		 * the elapsed time to detect xruns.
+		 */
+		jdelta = jiffies - runtime->hw_ptr_jiffies;
+		hdelta = jdelta - delta * HZ / runtime->rate;
+		while (hdelta > runtime->hw_ptr_buffer_jiffies / 2 + 1) {
+			delta += runtime->buffer_size;
+			hw_base += runtime->buffer_size;
+			if (hw_base >= runtime->boundary)
+				hw_base = 0;
+			new_hw_ptr = hw_base + pos;
+			hdelta -= runtime->hw_ptr_buffer_jiffies;
+		}
 		goto no_delta_check;
+	}
 
 	/* something must be really wrong */
 	if (delta >= runtime->buffer_size + runtime->period_size) {
