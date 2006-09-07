From: Dave Jones <davej@redhat.com>
Subject: Re: 2.6.18-rc5-mm1: BUG in pci_disable_msi on attempts
	to rmmod snd_hda_intel (64-bit kernel)
Date: Thu, 7 Sep 2006 10:52:56 -0400
Message-ID: <20060907145256.GC10792@redhat.com>
References: <200609062259.53465.rjw@sisk.pl>
	<20060906202429.6c4256fa.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 00D26223
	for <alsa-devel@alsa-project.org>;
	Thu,  7 Sep 2006 16:45:57 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <20060906202429.6c4256fa.akpm@osdl.org>
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
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Greg KH <greg@kroah.com>, alsa-devel@alsa-project.org, Andi Kleen <ak@suse.de>
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 06, 2006 at 08:24:29PM -0700, Andrew Morton wrote:
 
 > I'm told that the MSI patehs in rc5-mm1 are no good and have been redone
 > and replaced.  So could you please remember to retest next -mm?  Fingers
 > crossed, it'll be fixed then.
 > 
 > > Pid: 3684, comm: rmmod Tainted: G   M  2.6.18-rc5-mm1 #14
 > (Where did the taint come from?)

M = machine check exception happened.

(G=nonsense)

	Dave

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
