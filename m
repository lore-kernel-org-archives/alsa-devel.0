From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: What recommended performance for ALSA(ASoC)?
Date: Fri, 7 Mar 2008 08:49:09 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0803070838120.7942@tm8103.perex-int.cz>
References: <280b69ac0803061801o4ef80585mdd8b7753ab40be8a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 5DEAC245D4
	for <alsa-devel@alsa-project.org>; Fri,  7 Mar 2008 08:49:10 +0100 (CET)
In-Reply-To: <280b69ac0803061801o4ef80585mdd8b7753ab40be8a@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jinyoung Park <mcjin02@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 7 Mar 2008, Jinyoung Park wrote:

> Hello, I tred developing new ALSA(ASoC) driver for our company's
> embedded processor.
> Our processor supported I2S and DMA. So, my ALSA drvier implementation
> using DMA.
> I was tested my ALSA driver. When I play wav file(sample rate 44100)
> using aplay( aplay -M -D hw:0,0 test.wav), sometimes occured breaks.
> Also, play mp3 file(sample rate 44100Hz) using madplay and mpg123,
> sometimes occured noises.
> So, I was tested wav file and mp3 file that down sampling 44100 ->
> 22050. They was not occurring break and decreasing noises.
> I tried improving my ALSA driver, optimize souce code and change
> variety buffer size and period size. But It doesn't improve much.
> In my guess, my target system is not enough performance because ALSA is heavy.
> Target system' processor(ARM9) clock is 200MHz and BogoMIPS is
> 99.6(cat /proc/cpuinfo). Linux kernel version is 2.6.24.1.
> 
> What recommended performance for ALSA(ASoC)?
> If my target system is enough performance, shall I do that solve problem?

It looks like that your driver has trouble with highter rates. Also, try 
to measure where the problem occurs. Maybe your system is not able to 
deliver data from source in time to sound DMA buffer for continuous 
playback. Note that whole system must be tuned not only ALSA driver to get 
satisfiable results. DMA+mmap transfers are pretty lightweight in ALSA, 
but if disc read operation eats too much CPU time, you cannot expect good 
results.

Regarding noises - I would check if DMA ring buffer position reported from 
driver is correct in application. It looks like a handshake or 
maybe cache problem.

						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
