From: Adam Williamson <awilliam@redhat.com>
Subject: Re: Unsupported Valley View 'LPE' adapter?
Date: Mon, 17 Feb 2014 16:48:32 -0800
Message-ID: <1392684512.2924.12.camel@adam.happyassassin.net>
References: <1385840039.2566.12.camel@adam.happyassassin.net>
 <529A5C6A.70604@ladisch.de>
 <1385865517.2566.36.camel@adam.happyassassin.net>
 <20131202063216.GJ8834@intel.com>
 <1386035807.2566.145.camel@adam.happyassassin.net>
 <1388369981.15622.7.camel@adam.happyassassin.net>
 <1388370192.15622.8.camel@adam.happyassassin.net>
 <s5hwqiebsuo.wl%tiwai@suse.de> <loom.20140217T104754-228@post.gmane.org>
 <1392684057.2527.3.camel@xps13.happyassassin.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by alsa0.perex.cz (Postfix) with ESMTP id 361BD265086
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2014 01:48:36 +0100 (CET)
In-Reply-To: <1392684057.2527.3.camel@xps13.happyassassin.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: bobby <bseventynine@yahoo.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2014-02-17 at 16:40 -0800, Adam Williamson wrote:
> On Mon, 2014-02-17 at 09:54 +0000, bobby wrote:
> > 
> > This is a pci device for which the driver is not yet available.
> > I went through the intel atom processor manual and found that it has 3 I2S 
> > ports, has its 
> > own DMA. The Soc is interfaced with LPE audio core via internal PCI bus. 
> > Did you guys hear anything from intel about the driver support. Any inputs 
> > would be of great help please
> 
> Jan Michael Brummer at Intel pointed this out to me recently:
> 
> https://kernel.googlesource.com/pub/scm/linux/kernel/git/lrg/asoc/+/intel/haswell-audio-dsp%5E
> 
> looks like it's being worked on.

Heh, that's actually just a mirror of the git ASoC branch. All those
patches went through this very list last week. I don't know precisely
how the upstreaming process goes for this stuff, but I'm guessing it'll
wind up in 3.14 or 3.15.

(I may try building the patches into my Fedlet kernel builds and see if
that gets anywhere...)
-- 
Adam Williamson
Fedora QA Community Monkey
IRC: adamw | Twitter: AdamW_Fedora | XMPP: adamw AT happyassassin . net
http://www.happyassassin.net
