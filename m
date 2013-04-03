From: Eldad Zack <eldad@fogrefinery.com>
Subject: Re: [PATCH v5] ALSA: usb: Work around CM6631 sample
 rate change bug
Date: Wed, 3 Apr 2013 23:22:51 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1304032320480.1453@xoschi>
References: <20130326211004.GD18838@pvv.ntnu.no>
 <s5hr4is54jp.wl%tiwai@suse.de> <515C0155.4090009@ladisch.de>
 <s5hy5czedgm.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f48.google.com (mail-bk0-f48.google.com
 [209.85.214.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 1E2EA265EAF
 for <alsa-devel@alsa-project.org>; Wed,  3 Apr 2013 23:22:57 +0200 (CEST)
Received: by mail-bk0-f48.google.com with SMTP id jf3so1108865bkc.21
 for <alsa-devel@alsa-project.org>; Wed, 03 Apr 2013 14:22:56 -0700 (PDT)
In-Reply-To: <s5hy5czedgm.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Torstein Hegge <hegge@resisty.net>, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org


On Wed, 3 Apr 2013, Takashi Iwai wrote:

> At Wed, 03 Apr 2013 12:15:49 +0200,
> Clemens Ladisch wrote:
> > 
> > Takashi Iwai wrote:
> > > Torstein Hegge wrote:
> > >>
> > > What about the latest status of the patch?
> > >
> > > If both Clemens and Daniel are happy with it, I can apply it for the
> > > next 3.9-rc.
> > 
> > Acked-by: Clemens Ladisch <clemens@ladisch.de>
> > with or without this change:
> 
> OK, I applied the patch now without modification for for-linus
> branch.  Then back-merged to for-next branch with the additional
> clean-up patch below.
> 
> Eldad, please rebase your patches to for-next branch of sound git
> tree.

Thanks for the heads up, Takashi!
I've sent it out with all the changes moments ago.

Cheers,
Eldad
