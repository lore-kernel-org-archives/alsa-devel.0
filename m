From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: hw_ptr_interrupt removal broke interrupt pointer
	updates
Date: Tue, 26 Jan 2010 17:16:19 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1001261713430.6542@eeebox2.perex-int.cz>
References: <4B5EF09B.3040900@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 8A60C103844
	for <alsa-devel@alsa-project.org>; Tue, 26 Jan 2010 17:16:20 +0100 (CET)
In-Reply-To: <4B5EF09B.3040900@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 26 Jan 2010, Clemens Ladisch wrote:

> Commit "cleanup & merge hw_ptr update functions" says:
>> The main change is hw_ptr_interrupt variable removal to simplify code
>> logic. This variable can be computed directly from hw_ptr.
>
> The hw_ptr_interrupt variable was needed to differentiate between the
> position at the last normal pointer update and the position of the last
> signaled period boundary.
>
> 	if (in_interrupt) {
> 		/* we know that one period was processed */
> 		/* delta = "expected next hw_ptr" for in_interrupt != 0 */
> 		delta = old_hw_ptr - (old_hw_ptr % runtime->period_size)
> 			+ runtime->period_size;
> 		if (delta > new_hw_ptr) {
> 			hw_base += runtime->buffer_size;
>
> It is possible for the status/delay ioctls to be called when the sound
> card's pointer register alreay shows a position at the beginning of the
> new period, but immediately before the interrupt is actually executed.
> (This happens regularly on a SMP machine with mplayer.)  When that
> happens, the code thinks that the position must be at least one period
> ahead of the current position and drops an entire buffer of data.

Clements, thank you for nice explanation how I was wrong. I returned 
hw_ptr_interrupt variable back. I am testing this patch now:

http://git.alsa-project.org/?p=alsa-kernel.git;a=commitdiff;h=04d64a69fcb9fd182d73d6f1a8de55b2f527a1de

A review is always welcome. Thanks.


 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
