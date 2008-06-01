From: "Benjamin van den Hout" <bvdhout@gmail.com>
Subject: Re: Problem with aloop
Date: Sun, 1 Jun 2008 18:15:35 +0200
Message-ID: <d5eabee70806010915m528a33b3h26ae77c959f5946b@mail.gmail.com>
References: <20080220141906.GA15096@mathematik.uni-freiburg.de>
	<20080221000601.GA4829@mathematik.uni-freiburg.de>
	<s5hmypusssj.wl%tiwai@suse.de>
	<20080222180528.GD6860@mathematik.uni-freiburg.de>
	<s5h7igps3nv.wl%tiwai@suse.de>
	<20080301115506.GA7175@mathematik.uni-freiburg.de>
	<s5hve468o55.wl%tiwai@suse.de>
	<20080301233503.GA6175@mathematik.uni-freiburg.de>
	<s5h7igf3l71.wl%tiwai@suse.de>
	<20080531200059.GA11302@mathematik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.241])
	by alsa0.perex.cz (Postfix) with ESMTP id E58F424470
	for <alsa-devel@alsa-project.org>;
	Sun,  1 Jun 2008 18:15:36 +0200 (CEST)
Received: by rv-out-0708.google.com with SMTP id f25so521013rvb.32
	for <alsa-devel@alsa-project.org>; Sun, 01 Jun 2008 09:15:35 -0700 (PDT)
In-Reply-To: <20080531200059.GA11302@mathematik.uni-freiburg.de>
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
To: =?ISO-8859-9?Q?Ahmet_=DDnan?= <ainan@mathematik.uni-freiburg.de>
Cc: alsa-devel@alsa-project.org, Gustavo da Silva Serra <gustavo.serra@tet.com.br>
List-Id: alsa-devel@alsa-project.org

Hi Ahmet,

ive just read about aloop problems by chance, so excuse the late answer,
> for ive disabled recieving mails from this list. so also cc me when
> replying :)
>

No problem, I'm delighted somebody is answering my e-mails at all :)

> repeating stuttering
> try tickless kernel, as it improves the quality of timer interrupts
> dramatically.
> dont forget to enable high resolution timer support, hpet and so on.
>

OK, excellent tip. Thanks! High resolution timer support is already enabled
and I've got the kernel configured for "realtime" performance (CONFIG_HZ or
whatever it was called set to 1000 etc.). I'll try to see if the tickless
kernel makes any difference.


> > synchronization issue at the beginning
> this is still not resolved and its a pain in the ass to get this done
> right.
> ive implemented 4 different ways to solve it and im still not happy with
> what ive got.
>

The funny thing is, after I reverted to the 10.0.16 release tarball these
stuttering problems went away. So the fixes that were committed in
february/march under the 'fixes realtime behaviour' label actually made
things much worse..


> > kernel crash when closing
> do you really have to put at this manny places this del_timer?
> try to find the right place and resubmit. :)
>

I already presumed it was a bit much, I'll be the last one to deny that! ;-)

But then again, I'm not too familiar with ALSA kernel stuff anyway and the
existing documentation seems a bit sparse. Also, this patch was made as part
of a time-limited project at my company so I sadly couldn't spend more time
on it after I (crudely) fixed the bug. However, I'd love to refine my patch
(in my own spare time). Can you give me any pointers perhaps? They would be
greatly appreciated.

Thanks for taking the time to reply!

Kind regards,
Benjamin
