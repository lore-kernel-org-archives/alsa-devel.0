From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.18-rc5-mm1: BUG in pci_disable_msi on attempts
	to rmmod snd_hda_intel (64-bit kernel)
Date: Thu, 7 Sep 2006 08:57:38 +0200
Message-ID: <200609070857.39219.rjw@sisk.pl>
References: <200609062259.53465.rjw@sisk.pl>
	<20060906202429.6c4256fa.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from ogre.sisk.pl (ogre.sisk.pl [217.79.144.158])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 268C8241
	for <alsa-devel@alsa-project.org>;
	Thu,  7 Sep 2006 08:54:55 +0200 (MEST)
In-Reply-To: <20060906202429.6c4256fa.akpm@osdl.org>
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
To: Andrew Morton <akpm@osdl.org>
Cc: Greg KH <greg@kroah.com>, alsa-devel@alsa-project.org, Andi Kleen <ak@suse.de>
List-Id: alsa-devel@alsa-project.org

On Thursday, 7 September 2006 05:24, Andrew Morton wrote:
> On Wed, 6 Sep 2006 22:59:53 +0200
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> 
> > Hi,
> > 
> > I get the appended BUG when I try to rmmod snd_hda_intel on 2.6.18-rc5-mm1
> > (the box is an HPC nx6325).
> > 
> > The driver also breaks the suspend to disk (causes an oops to appear during
> > the suspend phase, but I haven't been able to catch it yet).
> > 
> 
> I'm told that the MSI patehs in rc5-mm1 are no good and have been redone
> and replaced.  So could you please remember to retest next -mm?  Fingers
> crossed, it'll be fixed then.

I will.

> (Where did the taint come from?)

No idea.  The system is an out-of-the-box SUSE 10.1 + current updates + the
kernel.

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
