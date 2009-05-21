From: Jon Smirl <jonsmirl@gmail.com>
Subject: more on appl_ptr and DMA overrun at end of stream
Date: Thu, 21 May 2009 14:44:27 -0400
Message-ID: <9e4733910905211144mfdc2947mbeb8872affb201cf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.145])
	by alsa0.perex.cz (Postfix) with ESMTP id A499B244EA
	for <alsa-devel@alsa-project.org>;
	Thu, 21 May 2009 20:44:30 +0200 (CEST)
Received: by qw-out-1920.google.com with SMTP id 4so765078qwk.56
	for <alsa-devel@alsa-project.org>; Thu, 21 May 2009 11:44:29 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I've been reading Lennart's article on glitch free audio....

On my scatter/gather DMA hardware I generate an interrupt at the end
of each period. On the last period this causes ALSA to issue a
trigger(STOP). However, there is a latency from when that interrupt is
generated and when ALSA does the trigger(STOP). During that latency my
hardware starts playing the next buffer (which contains stale data).
Playing stale data causes a noise burst. I fixed this by programming
my DMA hardware to not overrun appl_ptr.

There's another solution. ALSA already knows the stream ends
mid-period and pads out the partial period with silence. If it simply
padded out the next period with silence too the overrun problem would
become non-audible and there would time to process trigger(STOP).

If padding out two periods at end of stream is possible, it then
becomes possible for me to turn off interrupts in my audio driver.

-- 
Jon Smirl
jonsmirl@gmail.com
