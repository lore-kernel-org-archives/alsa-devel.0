From: Edgar Berdahl <eberdahl@ccrma.Stanford.EDU>
Subject: Re: TWL4030 low-latency
Date: Mon, 24 Oct 2011 17:21:08 -0700
Message-ID: <DC00A584-F0E0-4895-93AC-4D7313A7E307@ccrma.Stanford.EDU>
References: <B4E3E481-AEFC-4E2E-A5FA-A63908D8DE12@ccrma.Stanford.EDU>
	<CAPo=G1yzBxH3FL=Y5yqmR+REVawPV7eAdO5jmrxEJ6RRkndgxg@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-roam.stanford.edu (smtp-roam1.Stanford.EDU [171.67.219.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 73AC9243A9
	for <alsa-devel@alsa-project.org>;
	Tue, 25 Oct 2011 02:21:15 +0200 (CEST)
In-Reply-To: <CAPo=G1yzBxH3FL=Y5yqmR+REVawPV7eAdO5jmrxEJ6RRkndgxg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Ujfalusi, Peter" <peter.ujfalusi@ti.com>
Cc: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>, alsa-devel@alsa-project.org, Wendy Ju <wendyju@gmail.com>
List-Id: alsa-devel@alsa-project.org

Dear Peter,

Sorry for the delay in getting back to you. I just wanted to follow up now that I got the Angstrom SDHC card and booted it to check the kernel version.

> Edgar, are you guys running a vanilla kernel or an -rt kernel?

We are running vanilla kernels:
In Ubuntu:
ccrma@satellite:~$ uname -a
Linux omap 2.6.38.4-x3 #1 SMP Wed Apr 27 00:42:20 UTC 2011 armv7l GNU/Linux

In Angstrom:
root@beagleboard:~# uname -a                                                    
Linux beagleboard 2.6.32 #3 PREEMPT Wed Aug 18 15:53:03 UTC 2010 armv7l unknown 

>>> I think I can explain this:
>>> McBSP2 has 1280 word long buffer.
>> Wow, that is a long buffer! There is no way to reduce the buffer size?
> I have some ideas, but it is a long shot.
> Basically by design it is not possible, but I might can get around of it by
> misusing/configuring the McBSP, and sDMA.
I would imagine that you could, in order to decrease the latency, initialize the buffer with all zeros and then only change part of the buffer with each interrupt. Or is there some hardware restriction?

> I try to hack something up for kernel 3.3.
I'm looking forward to testing it!

Best regards,
Edgar

Ujfalusi, Peter wrote:
> I think I can explain this:
> McBSP2 has 1280 word long buffer.
> We place constraint that the ALSA buffer must not be smaller than this, because
> if it is smaller we can end up spinning on the buffer at stream start:
> sDMA will fill up the FIFO, and if the buffer is smaller than the
> FIFO, it will copy
> the buffer several times, or partially. Depending on the size you
> would have chosen.
> 
> You are requesting 128 frames long period size, which occupy 256 words (I assume
> stereo samples)
> With that period size you will need at least 5 periods to cover the McBSP2 FIFO:
> 1280 / 256 = 5
> It is another question, why jack selects 8 periods, while it could use
> 6, if it likes to
> have even number of periods...
