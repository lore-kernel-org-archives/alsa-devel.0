From: Chris M <cmanougian@yahoo.com>
Subject: Re: Update patch for codecs alias name for Dell
Date: Sun, 2 Feb 2014 00:20:45 +0000 (UTC)
Message-ID: <loom.20140202T011505-437@post.gmane.org>
References: <8837DB3485424EB4ADE016301C6D7DF6@realtek.com.tw>
 <s5hhaay6rsk.wl%tiwai@suse.de>
 <13CB35BE00B34161858F09AF4314495C@realtek.com.tw>
 <s5heh604wws.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 106A8264F1E
 for <alsa-devel@alsa-project.org>; Sun,  2 Feb 2014 03:10:04 +0100 (CET)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1W9mVX-0005vd-SK
 for alsa-devel@alsa-project.org; Sun, 02 Feb 2014 03:10:04 +0100
Received: from pool-72-66-69-101.washdc.fios.verizon.net ([72.66.69.101])
 by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Sun, 02 Feb 2014 03:10:03 +0100
Received: from cmanougian by pool-72-66-69-101.washdc.fios.verizon.net with
 local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Sun, 02 Feb 2014 03:10:03 +0100
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai <tiwai <at> suse.de> writes:

> 
> At Thu, 28 Nov 2013 15:30:56 +0800,
> Kailang wrote:
> > 
> > Hi Takashi,
> > 
> > I remodified the code as belowing.
> > 
> > >From 888b51395ebab411660401f856e3af7988d9240b Mon Sep 17 00:00:00 2001
> > From: Kailang Yang <kailang <at> realtek.com>
> > Date: Thu, 28 Nov 2013 15:23:20 +0800
> > Subject: [PATCH] ALSA: hda/realtek - Add more codecs alias name for Dell
> > 
> > Dell assigned alias name for more codecs.
> > ALC3220 ALC3221 ALC3223 ALC3226 ALC3234 ALC3661.
> > 
> > Signed-off-by: Kailang Yang <kailang <at> realtek.com>
> 
> Thanks, applied now, but it's targeted for 3.14 kernel, as this is no
> urgent fixes.  You can find it in for-next branch of sound git tree.
> 
> Takashi
> 

Sorry for asking this on a developer forum, but I'm pretty sure I finally
found the answer here. I had considered the need to wait it out for a kernel
upgrade (beyond 3.12 in Debian Testing/Jessie). I have no sound right now.
How do I apply this patch? When I installed Debian Testing, I installed a
targeted initrd, and I was considering retrying with a generic initrd -
although I think this thread just saved me from that. Will an established
initrd come into play? Will I have to recompile the 3.12 kernel?

The Dell codec alias name is ALC3223.

Thanks
