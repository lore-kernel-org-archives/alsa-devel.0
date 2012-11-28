From: Eldad Zack <eldad@fogrefinery.com>
Subject: Re: [PATCH] ALSA: snd-usb: properly initialize the
 sync endpoint
Date: Wed, 28 Nov 2012 22:17:17 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1211282212500.5153@xoschi>
References: <1353612479-8460-1-git-send-email-zonque@gmail.com>
 <s5hhaohcrp3.wl%tiwai@suse.de> <alpine.LNX.2.00.1211281646530.1397@xoschi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 8EE86264F0A
 for <alsa-devel@alsa-project.org>; Wed, 28 Nov 2012 22:17:26 +0100 (CET)
Received: by mail-bk0-f51.google.com with SMTP id ik5so5621266bkc.38
 for <alsa-devel@alsa-project.org>; Wed, 28 Nov 2012 13:17:26 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1211281646530.1397@xoschi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


On Wed, 28 Nov 2012, Eldad Zack wrote:
> On Thu, 22 Nov 2012, Takashi Iwai wrote:
> > At Thu, 22 Nov 2012 20:27:59 +0100,
> > Daniel Mack wrote:
> > > 
> > > Jeffrey Barish reported an obvious bug in the pcm part of the usb-audio
> > > driver which causes the code to not initialize the sync endpoint from
> > > configure_endpoint().
> > > 
> > > Reported-by: Jeffrey Barish <jeff_barish at earthlink.net>
> > > Signed-off-by: Daniel Mack <zonque at gmail.com>
> > > Cc: stable at kernel.org [3.5+]
> > 
> > Thanks, applied.
> 
> This breaks the pcm init for the FT C400 - the reason is once 
> again the mismatch between sync and data in terms of channels and period
> bytes.
> I didn't notice it, since I was always opening capture and playback at 
> the same time.
> 
> After reverting it works as expected (for capture + playback) - however, 
> the revert is not a fix:
> If I open only the playback stream from userspace (using jack with -P),
> it will error out and then it will refuse to open pcm even for capture.
> But if I first open the device for capture (using jackd with -C), stop 
> it, then open just the playback, it works. Not surprising, since the sync
> ep was already set up.
> 
> Any suggestions on how to initialize the sync ep with its specific
> channel and period bytes paramaters?

Update: I found a solution for this - I'll post it with the C400 v4 
(today or tomorrow).

Cheers,
Eldad
