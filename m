From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: hw_ptr_interrupt removal broke interrupt pointer
 updates
Date: Wed, 27 Jan 2010 18:21:10 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1001271541380.6542@eeebox2.perex-int.cz>
References: <4B5EF09B.3040900@ladisch.de>
	<alpine.LNX.2.00.1001261713430.6542@eeebox2.perex-int.cz>
	<4B600C3E.6090208@ladisch.de>
	<alpine.LNX.2.00.1001271057160.6542@eeebox2.perex-int.cz>
	<4B6049E8.5000401@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 1AD62103811
	for <alsa-devel@alsa-project.org>; Wed, 27 Jan 2010 18:21:11 +0100 (CET)
In-Reply-To: <4B6049E8.5000401@ladisch.de>
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

On Wed, 27 Jan 2010, Clemens Ladisch wrote:

> Jaroslav Kysela wrote:
>> On Wed, 27 Jan 2010, Clemens Ladisch wrote:
>>> A somewhat unrelated issue:  Both old and new code assume that
>>> hw_ptr==0 is a period boundary, but that is not true if the boundary
>>> is not an integer multiple of the period size, and the pointer wraps.
>>> I'm not sure what happens then.
>>
>> I'm not exactly sure what you're talking about. Where is the
>> hw_ptr==0 assumption?
>
> This code, which tries to align hw_ptr_interrupt to a period boundary:
>
> 	runtime->hw_ptr_interrupt = new_hw_ptr -
> 			(new_hw_ptr % runtime->period_size);

I see. It is really problem, because if hw_ptr_interrupt shifts, then the 
condition
 		delta = runtime->hw_ptr_interrupt + runtime->period_size;
                 if (delta > new_hw_ptr) {

is not accurate and might cause unwanted issues.

The simple fix for 64-bit archs is to use "boundary = buffer_size * 
period_size" expression to setup the boundary variable properly.

I added code to find the lowest common multiple for 32-bit archs.

The patch is:

http://git.alsa-project.org/?p=alsa-kernel.git;a=commitdiff;h=7910b4a1db63fefc3d291853d33c34c5b6352e8e

 					Thanks,
 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
