From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002242]: Aureon 7.1 Universe does not
	show a soundcard name
Date: Thu, 29 Jun 2006 01:26:40 +0200
Message-ID: <b0837b425406d3d073f92f41e8859f80@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id EA27F28B
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Jun 2006 01:26:40 +0200 (MEST)
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2242> 
======================================================================
Reported By:                calestyo
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   2242
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Debian GNU/Linux
Kernel Version:             2.6.17
======================================================================
Date Submitted:             06-29-2006 00:43 CEST
Last Modified:              06-29-2006 01:26 CEST
======================================================================
Summary:                    Aureon 7.1 Universe does not show a soundcard name
Description: 
See also my post news://news.gmane.org:119/e7tr7q$4g9$1@sea.gmane.org .

/proc/asound/cards shows me the following:
 0 [default        ]: Aureon71Universe -
                       at 0x3880, irq 74
 1 [CK804          ]: NFORCE - NVidia CK804
                      NVidia CK804 with AD1981B at 0xb0002000, irq 217
 2 [U0x46d0x8b2    ]: USB-Audio - USB Device 0x46d:0x8b2
                      USB Device 0x46d:0x8b2 at usb-0000:00:02.0-3, full
speed

I do not use any snd-ice1724.model=universal option but even if I set it
(as far as I could see universal is for the Aureon 7.1 Universal?!) I
get the same output with the difference that dmesg shows me a line a la
"ice-1724: Aureon7.1 Universe used as model".
Does this now mean that the card is not correctly identified? As no
names are found (see ***) and the string is set to "default":
 0 [default        ]: Aureon71Universe - ***
                      *** at 0x3880, irq 74

I also don't get a name in mixers like alsamixer or gnome-volume-control
which seem to depend on this problem (II).

This perhaps leads to some other problems to (as I've described in my post
in alsa-users list).
======================================================================

----------------------------------------------------------------------
 calestyo - 06-29-06 01:26 
----------------------------------------------------------------------
Sorry this is not a compilation related problem :D...

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-29-06 00:43 calestyo       New Issue                                    
06-29-06 00:43 calestyo       Distribution              => Debian GNU/Linux
06-29-06 00:43 calestyo       Kernel Version            => 2.6.17          
06-29-06 01:26 calestyo       Issue Monitored: calestyo                    
06-29-06 01:26 calestyo       Note Added: 0010631                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
