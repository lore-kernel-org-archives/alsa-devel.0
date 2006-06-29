From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002245]: Master volume is controlled
	via the "Headphone" mixer element and not via "Master
Date: Thu, 29 Jun 2006 17:08:26 +0200
Message-ID: <acfdfd8c166c5be9e5552e0d4578556f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3B6FD29C
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Jun 2006 17:08:26 +0200 (MEST)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2245> 
======================================================================
Reported By:                calestyo
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2245
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Distribution:               Debian GNU/Linux
Kernel Version:             2.6.17
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             06-29-2006 01:43 CEST
Last Modified:              06-29-2006 17:08 CEST
======================================================================
Summary:                    Master volume is controlled via the "Headphone"
mixer element and not via "Master
Description: 
I have the following ALSA devices:
$ cat /proc/asound/cards
 0 [default        ]: Aureon71Universe -
                       at 0x3880, irq 74
 1 [CK804          ]: NFORCE - NVidia CK804
                      NVidia CK804 with AD1981B at 0xb0002000, irq 217
 2 [U0x46d0x8b2    ]: USB-Audio - USB Device 0x46d:0x8b2
                      USB Device 0x46d:0x8b2 at usb-0000:00:02.0-3, full

The problem is with #1 which uses snd-intel8x0.

When I play any sounds and change the values for "Master" or "Master Mono"
nothing happens at all. But what one would expect from "Master" is done by
the "Headphone" mixer element.
======================================================================

----------------------------------------------------------------------
 calestyo - 06-29-06 16:57 
----------------------------------------------------------------------
>The headphone/line jack sense switches turn on the auto-mute function of
ac97
>codec chip. It works (and is mandatory) on some laptops/boards but on
some it's
>harmful, too.
Does that mean that I would be able to controll wheter the rear-output
still plays sound even when I plugged in a headphone in the front output
of my board/chassis?


>What is the product of your board or box? This name will be displayed as
a kernel
>message when the workaround is detected and enabled by the driver.
The board is a Tyan Thunder K8WE (S2895). Is this enough information or do
you require additional information? =)

----------------------------------------------------------------------
 tiwai - 06-29-06 17:08 
----------------------------------------------------------------------
Thanks, I fixed it on HG repo.

The simultaneous output of front and rear is usually a different issue. 
It totally depends on the ac97 codec chip.  You may have "Spread Front To
Surround" mixer swtich that enables such a feature.

Anyway, I close this bug since it's offtopic.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-29-06 01:43 calestyo       New Issue                                    
06-29-06 01:43 calestyo       Distribution              => Debian GNU/Linux
06-29-06 01:43 calestyo       Kernel Version            => 2.6.17          
06-29-06 16:33 tiwai          Note Added: 0010661                          
06-29-06 16:46 calestyo       Note Added: 0010663                          
06-29-06 16:53 tiwai          Note Added: 0010664                          
06-29-06 16:57 calestyo       Note Added: 0010665                          
06-29-06 17:08 tiwai          Status                   new => resolved     
06-29-06 17:08 tiwai          Resolution               open => fixed       
06-29-06 17:08 tiwai          Assigned To               => tiwai           
06-29-06 17:08 tiwai          Note Added: 0010667                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
