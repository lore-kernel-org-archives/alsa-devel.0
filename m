From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001226]: Ego Sys NEON
Date: Thu, 4 Aug 2005 18:09:59 +0200
Message-ID: <1570eb510814dd5a7dfb5831687e6248@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 69F201FF
	for <alsa-devel@alsa-project.org>; Thu,  4 Aug 2005 18:09:59 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1226> 
======================================================================
Reported By:                nictuku
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   1226
Category:                   USB - usb-audio
Reproducibility:            N/A
Severity:                   feature
Priority:                   normal
Status:                     assigned
Distribution:               Slackware Current
Kernel Version:             2.4
======================================================================
Date Submitted:             07-01-2005 21:21 CEST
Last Modified:              08-04-2005 18:09 CEST
======================================================================
Summary:                    Ego Sys NEON
Description: 
hi, i have a ESI NeON (
http://www.esi-pro.com/viewProduct.php?pid=42&page=1 ) i've tryed to make
it work with alsa with no success, but strangely on the oss the 24-bit
audio interface works. I just send this bug report to know if there's a
way to make it work or if it's planned to put support on this hardware. if
you need to test it feel free to contactme (nictuku@gmail.com)
thanx
======================================================================

----------------------------------------------------------------------
 Clemens Ladisch - 07-25-05 11:05 
----------------------------------------------------------------------
This device should work with the ALSA driver.

Please make sure that the snd-usb-audio module is loaded, and that the
audio module is _not_ loaded.  All supported sample format should be
listed in /proc/asound/cardX/stream0.

----------------------------------------------------------------------
 nictuku - 08-04-05 18:09 
----------------------------------------------------------------------
it worked perfectly. you could add it to the list of supported harware.
Both sound and midi worked just fine :). thanks!!

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-01-05 21:21 nictuku        New Issue                                    
07-01-05 21:21 nictuku        Distribution              => Slackware Current
07-01-05 21:21 nictuku        Kernel Version            => 2.4             
07-04-05 09:23 Clemens LadischNote Added: 0005382                          
07-06-05 23:04 nictuku        Issue Monitored: nictuku                     
07-06-05 23:06 nictuku        Note Added: 0005395                          
07-06-05 23:09 nictuku        Issue End Monitor: nictuku                    
07-23-05 00:32 nictuku        Note Added: 0005551                          
07-25-05 11:05 Clemens LadischNote Added: 0005562                          
08-04-05 18:09 nictuku        Note Added: 0005651                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
