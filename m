From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [RFC: 2.6.19 patch] snd-hda-intel: default MSI to
	off
Date: Tue, 17 Oct 2006 14:40:53 -0700
Message-ID: <20061017144053.29b6b29c@freekitty>
References: <200610050938.10997.prakash@punnoor.de>
	<5aa69f860610051030l7323ec2el545873570052f077@mail.gmail.com>
	<200610052309.01155.prakash@punnoor.de>
	<20061017211301.GE3502@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C719316F
	for <alsa-devel@alsa-project.org>;
	Tue, 17 Oct 2006 23:40:57 +0200 (MEST)
In-Reply-To: <20061017211301.GE3502@stusta.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Adrian Bunk <bunk@stusta.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, mingo@redhat.com, hnguyen@de.ibm.com, Prakash Punnoor <prakash@punnoor.de>, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

On Tue, 17 Oct 2006 23:13:01 +0200
Adrian Bunk <bunk@stusta.de> wrote:

> On Thu, Oct 05, 2006 at 11:08:57PM +0200, Prakash Punnoor wrote:
> > Am Donnerstag 05 Oktober 2006 19:30 schrieb Fatih A????c??:
> > > 2006/10/5, Prakash Punnoor <prakash@punnoor.de>:
> > > > Hi,
> > > >
> > > > subjects say it all. Without irqpoll my nic doesn't work anymore. I added
> > > > Ingo
> > > > to cc, as my IRQs look different, so it may be a prob of APIC routing or
> > > > the
> > > > like.
> > 
> > > > Can you try booting with pci=nomsi ? I have a similar problem with my
> > 
> > I used snd-hda-intel.disable_msi=1 and this actually helped! Now the nforce 
> > nic works w/o problems. So it was the audio driver causing havoc on the nic. 
> >...
> 
> Unless someone finds and fixes what causes such problems, I'd therefore 
> suggest the patch below to let MSI support to be turned off by default.
> 
> cu
> Adrian
> 

It shouldn't be that hard to write a small bit of code to force an interrupt
and catch it, that's what other drivers do to workaround the BIOS braindamage
that seems to be rampant (until M$ Vista comes out and supports MSI).

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
