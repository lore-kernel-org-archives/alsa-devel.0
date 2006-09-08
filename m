From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: 2.6.18-rc5-mm1: BUG in pci_disable_msi on attempts
 to rmmod snd_hda_intel (64-bit kernel)
Date: Fri, 8 Sep 2006 14:17:58 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0609081417360.9407@tm8103.perex-int.cz>
References: <200609062259.53465.rjw@sisk.pl> <200609071229.55655.rjw@sisk.pl>
	<s5hy7svke86.wl%tiwai@suse.de> <200609072314.42581.rjw@sisk.pl>
	<s5hslj2d548.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 61CE118D
	for <alsa-devel@alsa-project.org>;
	Fri,  8 Sep 2006 14:17:59 +0200 (MEST)
In-Reply-To: <s5hslj2d548.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>, ALSA development <alsa-devel@alsa-project.org>, Andi Kleen <ak@suse.de>, Greg KH <greg@kroah.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 8 Sep 2006, Takashi Iwai wrote:

> At Thu, 7 Sep 2006 23:14:41 +0200,
> Rafael J. Wysocki wrote:
> > 
> > On Thursday, 7 September 2006 15:17, Takashi Iwai wrote:
> > > At Thu, 7 Sep 2006 12:29:54 +0200,
> > > Rafael J. Wysocki wrote:
> > > > 
> > > > On Thursday, 7 September 2006 11:20, Takashi Iwai wrote:
> > > > > At Wed, 6 Sep 2006 22:59:53 +0200,
> > > > > Rafael J. Wysocki wrote:
> > > > > > 
> > > > > > Hi,
> > > > > > 
> > > > > > I get the appended BUG when I try to rmmod snd_hda_intel on 2.6.18-rc5-mm1
> > > > > > (the box is an HPC nx6325).
> > > > > > 
> > > > > > The driver also breaks the suspend to disk (causes an oops to appear during
> > > > > > the suspend phase, but I haven't been able to catch it yet).
> > > > > 
> > > > > Could you try the patch below?  It's pending on my local tree for
> > > > > testing...  Also, you can use disable_msi=1 option to avoid MSI.
> > > > 
> > > > The patch fixes the rmmod issue.
> > > > 
> > > > Also setting disable_msi=1 fixes the suspend issue.
> > > > 
> > > > If the MSI is not disabled, the suspend fails with an oops (on an attempt to
> > > > access disk after the resume-during-suspend), but this will hopefully get
> > > > fixed with the new MSI code.
> > > 
> > > The PM problem might be fixed by the patch below.  Give it a try.
> > 
> > Yes, the patch fixes the problem.
> 
> Glad to hear!
> 
> Jaroslav, could you update alsa-current.git again?
> I already committed the patches to HG tree.

Done.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
