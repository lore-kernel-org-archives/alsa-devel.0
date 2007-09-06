From: Krzysztof Helt <krzysztof.h1@gmail.com>
Subject: Re: [PATCH] Gallant SC-6000 driver (4th version)
Date: Thu, 6 Sep 2007 23:12:06 +0200
Message-ID: <20070906231206.2ba8f939.krzysztof.h1@gmail.com>
References: <46dfa2e7d6be4@wp.pl>
	<46DFD29A.6020601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.187])
	by alsa0.perex.cz (Postfix) with ESMTP id 0081C103822
	for <alsa-devel@alsa-project.org>;
	Thu,  6 Sep 2007 23:05:39 +0200 (CEST)
Received: by nf-out-0910.google.com with SMTP id d21so320126nfb
	for <alsa-devel@alsa-project.org>; Thu, 06 Sep 2007 14:05:39 -0700 (PDT)
In-Reply-To: <46DFD29A.6020601@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rene Herman <rene.herman@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 06 Sep 2007 12:12:42 +0200
Rene Herman <rene.herman@gmail.com> wrote:

> On 09/06/2007 08:49 AM, Krzysztof Helt wrote:
> 
> > Actually, the parport_pc driver is loaded by the udev by default, so the
> > IRQ7 cannot be requested (I tested - IRQ7 request failed even if I had 
> > not used the printer).
> 
> Not everybody uses udev. But more importantly, only if the hardware in 
> question is discoverable. [...]
> 
> And _then_ there's the bit about the ISA probing being a huge gaping race by 
> design. There's really no defending that massive junk. All ISA autoprobing 
> is bad engineering and should be ripped out and shot, period. It's broken 
> both by design and implementation. The solution to making things nicer is 
> not autoprobing but not using legacy ISA -- and basically noone is other 
> than for entertainment purposes.
> 

I am quite sure we won't agree on this one. My reason (to keep autodection)
is sheer laziness of giving two numbers. Even giving them does not make
user free of problems how to avoid irqs and dmas with installed devices 
but not visible in the /proc/interrupts file).

I would like to ask Takashi to decide on this issue. I will done as he says.

Will this driver be included? I found a bug in probing - if something is wrong
after the SB region is requested it won't be released. So the next version is
needed to be done anyway (or a small patch later).

Regards,
Krzysztof
