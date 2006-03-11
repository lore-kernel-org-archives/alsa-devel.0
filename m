From: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [Alsa-devel] Re: 2.6.15-rt20, "bad page state", jackd
Date: Sat, 11 Mar 2006 11:01:21 +1100
Message-ID: <44121351.2050703@yahoo.com.au>
References: <1141846564.5262.20.camel@cmn3.stanford.edu>	 <20060309084746.GB9408@osiris.boeblingen.de.ibm.com>	 <1141938488.22708.28.camel@cmn3.stanford.edu>	 <4410B2D7.4090806@yahoo.com.au>	 <1141958866.22708.69.camel@cmn3.stanford.edu>	 <441109BC.9070705@yahoo.com.au> <1142016627.6124.33.camel@cmn3.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752256AbWCKABb@vger.kernel.org>
In-Reply-To: <1142016627.6124.33.camel@cmn3.stanford.edu>
Sender: linux-kernel-owner@vger.kernel.org
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: alsa-devel@lists.sourceforge.net, Ingo Molnar <mingo@elte.hu>, Heiko Carstens <heiko.carstens@de.ibm.com>, Steven Rostedt <rostedt@goodmis.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Fernando Lopez-Lezcano wrote:

> Takashi and other gurus in alsa-devel, any comments on this? The
> original problem - not quoted in this email - is that when I stop jackd
> in the affected configurations I get errors similar to this one:
> 
> 
>>Bad page state at __free_pages_ok (in process 'jackd', page c1013ce0)
>>flags:0x00000414 mapping:00000000 mapcount:0 count:0
>>Backtrace:
>> [<c015947d>] bad_page+0x7d/0xc0 (8)
>> [<c01598fd>] __free_pages_ok+0x9d/0x180 (36)
>> [<c015a5ac>] __pagevec_free+0x3c/0x50 (40)
>> [<c015db47>] release_pages+0x127/0x1a0 (16)
>> [<c016c93d>] free_pages_and_swap_cache+0x7d/0xc0 (80)
>> [<c01681ae>] unmap_region+0x13e/0x160 (28)
>> [<c0168461>] do_munmap+0xe1/0x120 (48)
>> [<c01684df>] sys_munmap+0x3f/0x60 (32)
>> [<c01034a1>] syscall_call+0x7/0xb (16)
>>Trying to fix it up, but a reboot is needed
> 

FWIW, this is a PageReserved page being freed. PageReserved does
anything, and you instead need to ensure the page count is incremented
in your ->nopage handler (ie. via get_page()).

> 
> One other thing occurred to me (not tested yet)
> 
> - userspace regression in the module load code (so that in the end
> modules from the in kernel tree get mixed with modules coming from the
> externally compiled alsa tree). Very unlikely, I think, I could test for
> this by removing the in kernel modules temporarily. 
> 
> I have problems in both:
>   snd-ice1712 (midiman delta 66)
>   snd-hdsp (rme hdsp)
> but this seems to work fine:
>   snd-echo3g (gina3g)
> 
> The interesting thing is that the one that works (snd-echo3g) has no
> counterpat in the in kernel alsa tree - that is, only exists in the
> add-on modules compiled externally. Coincidence?
> 
> -- Fernando
> 
> 
> 


-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
