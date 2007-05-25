From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: [ALSA] ALSA Power Management,
	Drivers behaving	unexpectedly after suspend/resume cycle
Date: Fri, 25 May 2007 14:19:09 +0100
Message-ID: <1180099149.13652.77.camel@localhost.localdomain>
References: <8d6898730705242257k6da2088fi80f0d4034ed78986@mail.gmail.com>
	<s5h3b1lp75g.wl%tiwai@suse.de>
	<8d6898730705250504p442190e6u5bf71fbcd947df38@mail.gmail.com>
	<1180096780.13652.57.camel@localhost.localdomain>
	<8d6898730705250554w31d4a3abr80b8b531f8398642@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (unknown [80.75.67.54])
	by alsa0.perex.cz (Postfix) with ESMTP id 4BA1024431
	for <alsa-devel@alsa-project.org>;
	Fri, 25 May 2007 15:19:11 +0200 (CEST)
In-Reply-To: <8d6898730705250554w31d4a3abr80b8b531f8398642@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Nobin Mathew <nobin.mathew@gmail.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2007-05-25 at 18:24 +0530, Nobin Mathew wrote:
> after resume when i do playback i am getting same number of DMA
> interrupt  as in the working case (after reboot).
> 

So, does aplay keeps playing until the end of your file or does it stop
after a short time due to no periods being transmitted to the codec (io
error) ? If it keeps playing then check the codec driver, it's possible
it hasn't resumed fully. 

> I am using aplay (/usr/share/sounds/alsa/Side_Right.wav)
> 
> But i am not getting any sound (3 underruns), my codec register
> contents and controller register contents are same.
> 

Codec drivers cache registers for faster IO, best make sure the cache is
refreshed at resume.

Also, what happens when you kill aplay and restart it after resume ?
Does audio play or does it still underrun with no audio ? If audio
works, then this suggests something in your resume path is missing.

Fwiw, I would expect to sometimes see an underrun at resume due to
resume being a busy period for most systems. 

Liam
