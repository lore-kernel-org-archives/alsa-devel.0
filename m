From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002204]: Roland UA-20 "advanced
	driver" mode doesn't work
Date: Wed, 14 Jun 2006 11:33:18 +0200
Message-ID: <a6730c0dc58b99141ef3ea83a9bc6214@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id DB91E193
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Jun 2006 11:33:18 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2204> 
======================================================================
Reported By:                ldk_linux
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   2204
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Ubuntu Dapper
Kernel Version:             2.6.16 patched with alsa drivers version 1.0.11
======================================================================
Date Submitted:             06-12-2006 18:47 CEST
Last Modified:              06-14-2006 11:33 CEST
======================================================================
Summary:                    Roland UA-20 "advanced driver" mode doesn't work
Description: 
With the module sound-usb-audio in 1.0.11 my Roland UA-20 doesn't work in
"advanced driver" mode. I think the cause is the fix inserted in
1.0.11rc1, because once restored the old quirk code in usbquirks.h (see
the attached patch, applies to 1.0.11) the unit works again.

I wonder if there's a way to make all versions of the UA-20 work with a
single driver.
======================================================================

----------------------------------------------------------------------
 Clemens Ladisch - 06-13-06 16:43 
----------------------------------------------------------------------
The fix in 1.0.11rc1 hardcodes the sample format because that version of
the device doesn't have some descriptors required to autodetect it. 
Apparently, it uses a sample format slightly different from yours.

Please post the output of "lsusb -v" for your device.

----------------------------------------------------------------------
 ldk_linux - 06-14-06 11:33 
----------------------------------------------------------------------
Ok. The attached file lsusb.txt contains the output of lsusb -v on my
machine with the unit connected and in advanced driver mode.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-12-06 18:47 ldk_linux      New Issue                                    
06-12-06 18:47 ldk_linux      File Added: UA-20_with_Alsa_1.0.11.diff           
        
06-12-06 18:47 ldk_linux      Distribution              => Ubuntu Dapper   
06-12-06 18:47 ldk_linux      Kernel Version            => 2.6.16 patched with
alsa drivers version 1.0.11
06-13-06 16:14 ldk_linux      Issue Monitored: ldk_linux                    
06-13-06 16:43 Clemens LadischNote Added: 0010195                          
06-14-06 11:32 ldk_linux      File Added: lsusb.txt                        
06-14-06 11:33 ldk_linux      Note Added: 0010209                          
======================================================================
