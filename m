From: Frederick V Heitkamp <heitkamp@ameritech.net>
Subject: Re: Crash 2.6.32.x, Echo 3G, Alsa, SCSI
Date: Tue, 2 Feb 2010 18:51:13 -0800 (PST)
Message-ID: <695009.5976.qm@web180709.mail.sp1.yahoo.com>
References: <73211.74714.qm@web180714.mail.sp1.yahoo.com>
	<4B684513.8090201@ladisch.de> <20100202230911.71e8b600@Jay>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from n67.bullet.mail.sp1.yahoo.com (n67.bullet.mail.sp1.yahoo.com
	[98.136.44.47]) by alsa0.perex.cz (Postfix) with SMTP id 4A17F10386E
	for <alsa-devel@alsa-project.org>; Wed,  3 Feb 2010 03:51:15 +0100 (CET)
In-Reply-To: <20100202230911.71e8b600@Jay>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Giuliano Pochini <pochini@shiny.it>, Clemens Ladisch <clemens@ladisch.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

There is another possible fix. I tested it briefly. It looks ok wrt race

conditions because pipe->state is set only in the trigger callback. I hope
I didn't overlook anything again...


Signed-off-by: Giuliano Pochini <pochini@shiny.it>

--- alsa-driver-1.0.22.1/alsa-kernel/pci/echoaudio/echoaudio.c__orig    2010-02-02 22:37:33.000000000 +0100
+++ alsa-driver-1.0.22.1/alsa-kernel/pci/echoaudio/echoaudio.c    2010-02-02 22:44:03.000000000 +0100
@@ -1821,7 +1821,9 @@ static irqreturn_t snd_echo_interrupt(in
    /* The hardware doesn't tell us which substream caused the irq,
    thus we have to check all running substreams. */
    for (ss = 0; ss < DSP_MAXPIPES; ss++) {
-        if ((substream = chip->substream[ss])) {
+        substream = chip->substream[ss];
+        if (substream && ((struct audiopipe *)substream->runtime->
+                private_data)->state == PIPE_STATE_STARTED) {
            period = pcm_pointer(substream) /
                substream->runtime->period_size;
            if (period != chip->last_period[ss]) {


-- 
Giuliano.

I am using this patch.  So far, no crash.


Fred
