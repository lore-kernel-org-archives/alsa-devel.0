From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002298]: "Invalid argument" error with
	USB audio device
Date: Sat, 22 Jul 2006 13:34:02 +0200
Message-ID: <ab194565e4b609921e2f06daf3ede06b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B7C89152
	for <alsa-devel@alsa-project.org>;
	Sat, 22 Jul 2006 13:34:02 +0200 (MEST)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2298> 
======================================================================
Reported By:                lukeross
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   2298
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Fedora Core Linux 4
Kernel Version:             2.6.14-1.1653_FC4
======================================================================
Date Submitted:             07-22-2006 13:34 CEST
Last Modified:              07-22-2006 13:34 CEST
======================================================================
Summary:                    "Invalid argument" error with USB audio device
Description: 
Plugged in a USB audio device which is recognised as follows:

T:  Bus=02 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  3 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0e6a ProdID=0310 Rev= 1.11
S:  Product=USB Audio Device
C:* #Ifs= 3 Cfg#= 1 Atr=80 MxPwr=500mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=00 Prot=00 Driver=usbhid
E:  Ad=81(I) Atr=03(Int.) MxPS=   1 Ivl=16ms
I:  If#= 1 Alt= 0 #EPs= 0 Cls=01(audio) Sub=01 Prot=00
Driver=snd-usb-audio
I:  If#= 2 Alt= 0 #EPs= 0 Cls=01(audio) Sub=02 Prot=00
Driver=snd-usb-audio
I:  If#= 2 Alt= 1 #EPs= 1 Cls=01(audio) Sub=02 Prot=00
Driver=snd-usb-audio
E:  Ad=02(O) Atr=09(Isoc) MxPS= 192 Ivl=1ms

Whenever I try to play on this device I get the following error:

Setting of hwparams failed: Invalid argument
Broken configuration for playback: no configurations available: Invalid
argument
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-22-06 13:34 lukeross       New Issue                                    
07-22-06 13:34 lukeross       Distribution              => Fedora Core Linux 4
07-22-06 13:34 lukeross       Kernel Version            => 2.6.14-1.1653_FC4
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
