From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001279]: Audigy2 NX produces crackles on USB2, fine on USB1
Date: Wed, 22 Mar 2006 03:30:44 +0100
Message-ID: <f9042405d5ba95d857630b8a9931d0ec@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 86A0419F
	for <alsa-devel@alsa-project.org>; Wed, 22 Mar 2006 03:30:44 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1279> 
======================================================================
Reported By:                bluebottle
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   1279
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Distribution:               Ubuntu
Kernel Version:             2.6.12.2
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             07-24-2005 07:03 CEST
Last Modified:              03-22-2006 03:30 CET
======================================================================
Summary:                    Audigy2 NX produces crackles on USB2, fine on USB1
Description: 
I recently upgraded to a 2.6.12.2 kernel (from 2.6.12) and now the Audigy2
NX is detected as a fully-fledged USB2 device. :)

But... it produces crackles in the sound that fade in and out over about a
two second period, continuously, upon trying to play any sound. The sound
does play, but has all those crackles in it. :(

If I go into BIOS and disable USB2, making my Audigy a USB1 device again,
it works very well indeed. :)
======================================================================

----------------------------------------------------------------------
 jdthood - 09-22-05 15:12 
----------------------------------------------------------------------
Has this bug been fixed in the latest ALSA release?

----------------------------------------------------------------------
 rlrevell - 03-22-06 03:30 
----------------------------------------------------------------------
No response

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-24-05 07:03 bluebottle     New Issue                                    
07-24-05 07:03 bluebottle     Distribution              => Ubuntu          
07-24-05 07:03 bluebottle     Kernel Version            => 2.6.12.2        
07-24-05 09:58 bluebottle     Note Added: 0005557                          
07-25-05 11:03 Clemens LadischNote Added: 0005561                          
07-26-05 09:52 bluebottle     Note Added: 0005569                          
07-26-05 10:16 Clemens LadischFile Added: itd.patch                        
07-26-05 10:19 Clemens LadischNote Added: 0005570                          
07-27-05 10:09 bluebottle     File Added: libs-compile-error.txt                
   
07-27-05 10:53 bluebottle     Note Added: 0005572                          
07-27-05 16:42 Clemens LadischNote Added: 0005573                          
09-22-05 15:12 jdthood        Note Added: 0006344                          
03-22-06 03:30 rlrevell       Status                   assigned => closed  
03-22-06 03:30 rlrevell       Note Added: 0008822                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
