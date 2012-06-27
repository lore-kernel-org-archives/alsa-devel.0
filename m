From: Thomas Richter <thor@math.tu-berlin.de>
Subject: Re: emu10k1 driver can't allocate memory
Date: Wed, 27 Jun 2012 15:07:11 +0000 (UTC)
Message-ID: <loom.20120627T170549-645@post.gmane.org>
References: <CAHYJk3R0aS84KYLXFtWmxaHWQG+vdy3xSmXpVO+vN8w7ov2XSQ@mail.gmail.com>
	<s5h396j9umz.wl%tiwai@suse.de>
	<loom.20120627T153803-845@post.gmane.org>
	<s5h7gusrh1f.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
	by alsa0.perex.cz (Postfix) with ESMTP id 6856724157
	for <alsa-devel@alsa-project.org>;
	Wed, 27 Jun 2012 17:07:28 +0200 (CEST)
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1Sjtq1-0006vt-Ea
	for alsa-devel@alsa-project.org; Wed, 27 Jun 2012 17:07:25 +0200
Received: from rusime04.rus.uni-stuttgart.de ([129.69.58.55])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 27 Jun 2012 17:07:25 +0200
Received: from thor by rusime04.rus.uni-stuttgart.de with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 27 Jun 2012 17:07:25 +0200
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai <tiwai <at> suse.de> writes:


> > There is a kernel patch for this:
> > 
> > https://bugs.launchpad.net/ubuntu/+source/awesfx/+bug/183456
> 
> Did you see the address value in the above original report?  It's the
> address returned from dma_alloc_coherent().  Certainly the same
> problem won't happen on 2GB memory system without IOMMU.  It's a
> completely different thing.

Thanks, I guess you are right - especially in so far as the mentioned 
patch seem to have been applied by the OP already.

So long,
Thomas
