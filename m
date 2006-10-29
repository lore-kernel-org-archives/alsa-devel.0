From: Daniel Barkalow <barkalow@iabervon.org>
Subject: 1.0.13 doesn't work with my laptop
Date: Sun, 29 Oct 2006 11:00:31 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0610291038450.9789@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from iabervon.org (iabervon.org [66.92.72.58])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id CECAA28C
	for <alsa-devel@alsa-project.org>; Sun, 29 Oct 2006 17:00:39 +0100 (MET)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I've got a Lenovo 3000 N100 (sorry, don't know the model number), and the 
sound works with 1.0.12, but not with 1.0.13. I get the message:

ALSA /var/tmp/portage/alsa-driver-1.0.13/work/alsa-driver-1.0.13/pci/hda/../../a
lsa-kernel/pci/hda/patch_si3054.c:245: si3054: cannot initialize. EXT MID = 0000
HDA Intel: probe of 0000:00:1b.0 failed with error -13

It looks to me like 1.0.12 doesn't detect the problematic device (11c1 ID 
1040, codec#1), while 1.0.13 identifies it and can't initialize it 
correctly. I think it's probably the modem, which I don't particularly 
have a need for.

Three things:

 Is there an easy way to tell 1.0.13 not to bother with the second codec?

 It would probably be worth having the driver do what it can with the 
  device if it succeeds in setting up anything, even if it fails to 
  initialize some portions.

 Should I help debug the issue? It's pretty convenient for me to test, at 
  least as far as whether it initializes; I don't actually have a handy 
  phone line or anyone to call with it.

(Please cc me even if that's not standard list practice; I'm not 
subscribed)

	-Daniel
*This .sig left intentionally blank*

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
