From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: Unsupported Valley View 'LPE' adapter?
Date: Wed, 19 Feb 2014 07:41:22 +0000
Message-ID: <1392795682.2351.10.camel@loki>
References: <1385840039.2566.12.camel@adam.happyassassin.net>
 <529A5C6A.70604@ladisch.de>
 <1385865517.2566.36.camel@adam.happyassassin.net>
 <20131202063216.GJ8834@intel.com>
 <1386035807.2566.145.camel@adam.happyassassin.net>
 <1388369981.15622.7.camel@adam.happyassassin.net>
 <1388370192.15622.8.camel@adam.happyassassin.net>
 <s5hwqiebsuo.wl%tiwai@suse.de> <loom.20140217T104754-228@post.gmane.org>
 <1392684057.2527.3.camel@xps13.happyassassin.net>
 <1392684512.2924.12.camel@adam.happyassassin.net>
 <1392785968.30443.1.camel@adam.happyassassin.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id CEED02610D7
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2014 08:41:32 +0100 (CET)
In-Reply-To: <1392785968.30443.1.camel@adam.happyassassin.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Adam Williamson <awilliam@redhat.com>
Cc: alsa-devel@alsa-project.org, bobby <bseventynine@yahoo.com>, "Nikula,
 Jarkko" <jarkko.nikula@intel.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2014-02-18 at 20:59 -0800, Adam Williamson wrote:
> On Mon, 2014-02-17 at 16:48 -0800, Adam Williamson wrote:
> > On Mon, 2014-02-17 at 16:40 -0800, Adam Williamson wrote:
> > > On Mon, 2014-02-17 at 09:54 +0000, bobby wrote:
> > > > 
> > > > This is a pci device for which the driver is not yet available.
> > > > I went through the intel atom processor manual and found that it has 3 I2S 
> > > > ports, has its 
> > > > own DMA. The Soc is interfaced with LPE audio core via internal PCI bus. 
> > > > Did you guys hear anything from intel about the driver support. Any inputs 
> > > > would be of great help please
> > > 
> > > Jan Michael Brummer at Intel pointed this out to me recently:
> > > 
> > > https://kernel.googlesource.com/pub/scm/linux/kernel/git/lrg/asoc/+/intel/haswell-audio-dsp%5E
> > > 
> > > looks like it's being worked on.
> > 
> > Heh, that's actually just a mirror of the git ASoC branch. All those
> > patches went through this very list last week. I don't know precisely
> > how the upstreaming process goes for this stuff, but I'm guessing it'll
> > wind up in 3.14 or 3.15.
> > 
> > (I may try building the patches into my Fedlet kernel builds and see if
> > that gets anywhere...)
> 
> FWIW, I tried building a 3.14rc3 kernel with these patches applied and
> the drivers enabled as modules. On boot on a Dell Venue 8 Pro, all the
> relevant modules are loaded, but there's no ALSA device, and no
> obviously useful errors in any logs, or useful output from alsa-info.sh.
> Is it expected that the driver doesn't actually work yet? Per the recent
> commits, do I need some kind of firmware? Any debugging that would be
> useful?

Sorry, we're not finished with the upstreaming yet. The current patches
upstream are for the low level parts of the Intel DSP drivers. Jarkko
and I still have to upstream the upper layers of the drivers (probably
today) and you will also need firmware.

Once upstream the drivers will support Valley View, Baytrail, Haswell
and Broadwell. The firmware for Baytrail and Valleyview will be
available shortly too.

Liam 
