From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Driver code with mpc5200 pointer problem.
Date: Sun, 26 Apr 2009 18:43:17 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0904261838010.25064@eeebox2.perex-int.cz>
References: <9e4733910904260825o68d5b9dndbf92cdbc4a4e48e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 7434224356
	for <alsa-devel@alsa-project.org>;
	Sun, 26 Apr 2009 18:43:18 +0200 (CEST)
In-Reply-To: <9e4733910904260825o68d5b9dndbf92cdbc4a4e48e@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sun, 26 Apr 2009, Jon Smirl wrote:

> Here's the code computing the mpc5200 dma pointer. Could you please
> take a look at it and let me know what it is doing wrong.

I think that the culprit of your problems is that your code expects that 
buffer_size / period_size is an integer value (whole period is placed 
inside ring buffer). But if you do not instruct the high level code of 
ALSA in open() callback by calling snd_pcm_hw_constraint_integer(runtime, 
SNDRV_PCM_HW_PARAM_PERIODS) to do so - see other drivers - then period 
might be also placed across the buffer_size boundary - which appearently 
makes your current problems.

I think that bcom_submit_next_buffer() expects continuous memory (thus 
whole period), right?

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
