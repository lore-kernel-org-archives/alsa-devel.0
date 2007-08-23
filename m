From: "Pharaoh ." <pharaoh137@gmail.com>
Subject: Re: Audio quality issue - regular clicks are observed
Date: Thu, 23 Aug 2007 15:10:29 +0530
Message-ID: <61445c750708230240r3b3501f6la7b1ef91d28e4e70@mail.gmail.com>
References: <61445c750708220943k1c410147pa0dddf4d950eb08c@mail.gmail.com>
	<1187813792.16454.39.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.191])
	by alsa0.perex.cz (Postfix) with ESMTP id 37BF2103804
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Aug 2007 11:40:31 +0200 (CEST)
Received: by rv-out-0910.google.com with SMTP id k20so352505rvb
	for <alsa-devel@alsa-project.org>; Thu, 23 Aug 2007 02:40:30 -0700 (PDT)
In-Reply-To: <1187813792.16454.39.camel@localhost.localdomain>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 8/23/07, Liam Girdwood <lg@opensource.wolfsonmicro.com> wrote:
>
> On Wed, 2007-08-22 at 22:13 +0530, Pharaoh . wrote:
> > Hi
> > While testing the audio driver using aplay in blocking mode, a periodic
> > murmur is observed, this increases with
> > the audio volume and occurs even when there are no issues like xrun etc.
>
> > Aplay was used in normal read/write mode
> > i.e. no mmap. The song can be heard properly i.e. with no noticable gaps
> aur
> > hisses but the clicks are audible.
>
> Clock domain mismatch issues cause periodic ticks that increase in
> frequency with increasing sample rate. It's possible your clocking the
> codec and controller in two different clock domains. i.e. I2S controller
> (bitclk and frame) clocked from CPU and codec clocked from separate
> crystal.
>
> It's best to make sure that only one clock is clocking both the codec
> and digital audio interface.
>
> Liam
>
>
I tried playing /dev/zero at the same sampling rate as a wav file, but
/dev/zero played without any clicks i.e absolutely no sound heard, but while
playing a wav file using same parameters clicks occur. I am thinking it is
not about clocks mis-match, since I have checked it several times. I was
thinking whether junk data is being processed at end of buffer size, but
since /dev/zero plays well, I am ruling out that possibility also.

What else could explain the latencies at buffer ending as shown in the log
in previous mail.

-Pharaoh.
