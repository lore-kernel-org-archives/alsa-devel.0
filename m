From: Daniel Mack <zonque@gmail.com>
Subject: Re: Asynchronous audio USB chips: choppy playback
	since 3.8-rc7
Date: Wed, 03 Apr 2013 12:23:14 +0200
Message-ID: <515C0312.1090507@gmail.com>
References: <515C013D.8090909@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f48.google.com (mail-bk0-f48.google.com
 [209.85.214.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 74E2726535C
 for <alsa-devel@alsa-project.org>; Wed,  3 Apr 2013 12:23:17 +0200 (CEST)
Received: by mail-bk0-f48.google.com with SMTP id jf3so702878bkc.7
 for <alsa-devel@alsa-project.org>; Wed, 03 Apr 2013 03:23:17 -0700 (PDT)
In-Reply-To: <515C013D.8090909@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Alan Stern <stern@rowland.harvard.edu>, 1136110@bugs.launchpad.net
List-Id: alsa-devel@alsa-project.org

Hi David,

On 03.04.2013 12:15, David Henningsson wrote:
> Just to get your attention here on what seems to be an USB audio 
> regression.
> 
> The bug is described in detail here:
> 
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1136110?comments=all
> 
> Quoting the bug:
> 
> "
> This bug seems to affect only a certain kind of hardware, which is 
> called "Asynchronous USB Digital Audio Codec (DAC)". It's said that such 
> a DAC hosts the clock itself (USB Device Host). An ordinary DAC, so 
> called "Synchronous USB DAC", uses the clock hosted by the mother board, 
> which is not affected by this bug.
> 
> When this bug affects an asynchronous USB DAC, the audio played by the 
> DAC is constantly interrupted. The playback itself does not stop, but 
> the output becomes discontinous, filling with constant crackling noises, 
> destroying everything the DAC plays.
> "
> 
> According to the bug reporter, which seems to have done quite a bit of 
> research, this started between 3.8-rc6 and 3.8-rc7 as well as stable 
> kernels and the bug also lists a few commits which could be the cause, 
> none under sound/usb though.

There were no relevant changes for snd-usb between the two versions
mentioned. The only patches that come in mind in this time window are:

 3e619d041 "USB: EHCI: fix bug in scheduling periodic split transfers"
 b09a61cc0 "USB: EHCI: fix for leaking isochronous data"

And they have both been back-ported to stable. Copied Alan for reference.

Any chance some of the bug reporters could try and revert exactly those
for testing?


Thanks,
Daniel
