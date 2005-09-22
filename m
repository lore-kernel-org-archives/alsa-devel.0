From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001279]: Audigy2 NX produces crackles on USB2, fine on USB1
Date: Thu, 22 Sep 2005 15:12:43 +0200
Message-ID: <634ee748272c5a13c39ec87afa4e0bd7@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A618E152
	for <alsa-devel@alsa-project.org>; Thu, 22 Sep 2005 15:12:43 +0200 (MEST)
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


A NOTE has been added to this issue.
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
Status:                     assigned
Distribution:               Ubuntu
Kernel Version:             2.6.12.2
======================================================================
Date Submitted:             07-24-2005 07:03 CEST
Last Modified:              09-22-2005 15:12 CEST
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
 Clemens Ladisch - 07-27-05 16:42 
----------------------------------------------------------------------
automake 1.4 is from 1999, please try something newer.

----------------------------------------------------------------------
 jdthood - 09-22-05 15:12 
----------------------------------------------------------------------
Has this bug been fixed in the latest ALSA release?

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
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
