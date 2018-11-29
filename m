From: Jonathan Reeve <jon.reeve@gmail.com>
Subject: Re: Subwoofers aren't working on ALC298 (Lenovo Yoga
	C930 Laptop)
Date: Wed, 28 Nov 2018 22:58:10 -0500
Message-ID: <8736rkbkml.fsf@gmail.com>
References: <871s77zw23.fsf@gmail.com>
 <32e2283a-8a5e-25a6-de95-bfb568341269@64studio.com>
 <871s75tdr9.fsf@gmail.com>
 <CALbf9MznCgTE8rTm-6WLEeYAQE5iHbVAn9_SNfHEOuRTpYNNgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com
 [209.85.222.176])
 by alsa0.perex.cz (Postfix) with ESMTP id C6EBF267B11
 for <alsa-devel@alsa-project.org>; Thu, 29 Nov 2018 04:58:16 +0100 (CET)
Received: by mail-qk1-f176.google.com with SMTP id y78so299774qka.12
 for <alsa-devel@alsa-project.org>; Wed, 28 Nov 2018 19:58:16 -0800 (PST)
In-reply-to: <CALbf9MznCgTE8rTm-6WLEeYAQE5iHbVAn9_SNfHEOuRTpYNNgA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Ulricht <david.ulricht434@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Hi David,

Thanks very much for helping me look into this.

> Have you tried any other distribution, something more normal 
> like latest
> Fedora or Ubuntu ? Does the subwoofers work there ?

I just tried an Ubuntu live USB disk. I can't get subwoofers to 
work
there, either. 

> If you run Ubuntu/Fedora you can check the sound settings and 
> pavucontrol
> there is selection of speakers usually 2.1 5.1... try those ?

I don't see any option for that in pavucontrol on Ubuntu.

> And you have to make sure those [pincfgs] match with your 
> Windows10
> registry of the driver's PinConfigOverride.

Awesome. How can I find these settings? I checked in regedit and 
searched
for `pinconfigoverride` and `pincfg`, but nothing's coming up. I 
also
grepped all the driver files for those expressions, but nothing's 
coming
up there, either. Do you know if these settings are called 
something
else?

> You happen to have Windows running on that machine and can 
> extract the
> pinconfigoverride or have .ini of the driver? I can help you 
> compare
> those.

Yep, I have the Windows 10 driver files, but there is no .ini 
file, as far as
I can tell. There are lots of text files that look like they could 
be
configuration files of some sort. Which one(s) should I be looking 
for? 

Best,

Jonathan
