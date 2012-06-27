From: Thomas Richter <thor@math.tu-berlin.de>
Subject: Re: emu10k1 driver can't allocate memory
Date: Wed, 27 Jun 2012 13:41:03 +0000 (UTC)
Message-ID: <loom.20120627T153803-845@post.gmane.org>
References: <CAHYJk3R0aS84KYLXFtWmxaHWQG+vdy3xSmXpVO+vN8w7ov2XSQ@mail.gmail.com>
	<s5h396j9umz.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
	by alsa0.perex.cz (Postfix) with ESMTP id ABC7524501
	for <alsa-devel@alsa-project.org>;
	Wed, 27 Jun 2012 15:45:10 +0200 (CEST)
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1SjsYL-0005YL-8u
	for alsa-devel@alsa-project.org; Wed, 27 Jun 2012 15:45:05 +0200
Received: from edur-m-8d3a310c.campus.uni-stuttgart.de ([141.58.43.12])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 27 Jun 2012 15:45:05 +0200
Received: from thor by edur-m-8d3a310c.campus.uni-stuttgart.de with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 27 Jun 2012 15:45:05 +0200
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

T
> > Hi, (please CC me on replies, not subscribed)
> > 
> > I recently upgraded to 3.3.6 from 2.6.33.15 (yeah, I know). Since then
> > I noticed sometimes sounds were sometimes missing, then I noticed
> > thousands of these in dmesg,
> > [37280.283484] max memory size is 0x7fffffff (addr = 0x1d5d70071038000)!!
> 
> I guess you are enabling IOMMU?  I guess it translates the address
> somehow in a way emu10k1 doesn't like.
> There are really little changes in emu10k1 driver itself, so if the
> kernel upgrade changes the behavior, it must be in the core part such
> like IOMMU handling.
> 
> Try to boot without iommu and see whether it changes the behavior
> again.

This is *not* a IOMMU configuration issue. It is an issue of where the
emu10k1 allows DMA, and what the kernel does about it. If you have more
than 2GB of memory, and the system runs out of 16MB ISA space, you see
exactly this happening.

There is a kernel patch for this:

https://bugs.launchpad.net/ubuntu/+source/awesfx/+bug/183456

Greetings,

Thomas
