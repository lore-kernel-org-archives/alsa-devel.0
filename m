From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] disable period wakeups
Date: Mon, 15 Nov 2010 11:26:10 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1011151123380.29422@eeebox2.perex-int.cz>
References: <AANLkTimLAuzn+rSEGTv2oV_yPErbBHdRdij-61Ya2JcE@mail.gmail.com>
	<4CE1043A.6010607@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 8E21F1037F9
	for <alsa-devel@alsa-project.org>; Mon, 15 Nov 2010 11:26:10 +0100 (CET)
In-Reply-To: <4CE1043A.6010607@ladisch.de>
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
Cc: pl bossart <bossart.nospam@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 15 Nov 2010, Clemens Ladisch wrote:

> pl bossart wrote:
>> Here's the second set of patches based on feedback from Takashi,
>> Jaroslav and Clemens. Hope this is fine now.
>
> Committed, with fixed whitespace (your mailer or editor replaced tabs
> with spaces in all new lines), added back
> snd_pcm_hw_params_can_disable_period_wakeup(), and small changes.

The problem in the kernel side is that there is no ring buffer boundary 
check using system jiffies. Without this check, the actual implementation 
does not guarantee the consistency of hw_ptr.

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
