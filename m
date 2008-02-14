From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: a7839e96 (PNP: increase max resources) breaks my
 ALSA intel8x0 sound card
Date: Thu, 14 Feb 2008 12:26:59 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0802141226010.6110@woody.linux-foundation.org>
References: <fa.Kmpf0B4W44W1VefIME7+BnfUouY@ifi.uio.no>
	<200802141151.40396.bjorn.helgaas@hp.com>
	<alpine.LFD.1.00.0802141141470.6110@woody.linux-foundation.org>
	<200802141307.59120.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp2.linux-foundation.org (smtp2.linux-foundation.org
	[207.189.120.14])
	by alsa0.perex.cz (Postfix) with ESMTP id 7260624663
	for <alsa-devel@alsa-project.org>; Thu, 14 Feb 2008 21:27:02 +0100 (CET)
In-Reply-To: <200802141307.59120.bjorn.helgaas@hp.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Robert Hancock <hancockr@shaw.ca>, alsa-devel@alsa-project.org, avuton@gmail.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, yakui.zhao@intel.com, shaohua.li@intel.com, Andrew Morton <akpm@linux-foundation.org>, trenn@suse.de
List-Id: alsa-devel@alsa-project.org



On Thu, 14 Feb 2008, Bjorn Helgaas wrote:

> On Thursday 14 February 2008 12:42:52 pm Linus Torvalds wrote:
> > 
> > It *shouldn't* fail.
> > 
> > Things should fail only when two different drivers have requested the same 
> > region. NOT when something tells the system that a region _exists_.
> 
> The sound driver doesn't fail because two different drivers have
> requested the same region; it fails because PNP told us a region
> exists, and the sound region crosses the edge of the PNP region.

Right, and that was a bug.

It *shouldn't* fail. The PnP resource should be inserted _after_ the 
PCI region has been inserted, and _that_ should fail, since the PnP region 
is crap and cannot be inserted "half-way".

		Linus
