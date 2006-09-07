From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re:
	=?iso-8859-1?q?2=2E6=2E18-rc5-mm1=3A_BUG_in_pci=5Fdi?=
	=?iso-8859-1?q?sable=5Fmsi_on_attempts_to=09rmmod_snd=5Fhda=5Finte?=
	=?iso-8859-1?q?l_=2864-bit_kernel=29?=
Date: Thu, 7 Sep 2006 23:14:41 +0200
Message-ID: <200609072314.42581.rjw@sisk.pl>
References: <200609062259.53465.rjw@sisk.pl> <200609071229.55655.rjw@sisk.pl>
	<s5hy7svke86.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from ogre.sisk.pl (ogre.sisk.pl [217.79.144.158])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4C0D2156
	for <alsa-devel@alsa-project.org>;
	Thu,  7 Sep 2006 23:12:44 +0200 (MEST)
In-Reply-To: <s5hy7svke86.wl%tiwai@suse.de>
Content-Disposition: inline
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
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>, alsa-devel@alsa-project.org, Andi Kleen <ak@suse.de>
List-Id: alsa-devel@alsa-project.org

On Thursday, 7 September 2006 15:17, Takashi Iwai wrote:
> At Thu, 7 Sep 2006 12:29:54 +0200,
> Rafael J. Wysocki wrote:
> > 
> > On Thursday, 7 September 2006 11:20, Takashi Iwai wrote:
> > > At Wed, 6 Sep 2006 22:59:53 +0200,
> > > Rafael J. Wysocki wrote:
> > > > 
> > > > Hi,
> > > > 
> > > > I get the appended BUG when I try to rmmod snd_hda_intel on 2.6.18-rc5-mm1
> > > > (the box is an HPC nx6325).
> > > > 
> > > > The driver also breaks the suspend to disk (causes an oops to appear during
> > > > the suspend phase, but I haven't been able to catch it yet).
> > > 
> > > Could you try the patch below?  It's pending on my local tree for
> > > testing...  Also, you can use disable_msi=1 option to avoid MSI.
> > 
> > The patch fixes the rmmod issue.
> > 
> > Also setting disable_msi=1 fixes the suspend issue.
> > 
> > If the MSI is not disabled, the suspend fails with an oops (on an attempt to
> > access disk after the resume-during-suspend), but this will hopefully get
> > fixed with the new MSI code.
> 
> The PM problem might be fixed by the patch below.  Give it a try.

Yes, the patch fixes the problem.

Thanks,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
