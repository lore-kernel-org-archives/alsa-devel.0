From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000670]: soundmax integrated digital not working in slack 10
Date: Mon, 24 Jan 2005 05:48:50 +0100
Message-ID: <1b0b70d4801b9e23c1515180ebef6e21@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id A06D0200
	for <alsa-devel@alsa-project.org>; Mon, 24 Jan 2005 05:48:50 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=670> 
======================================================================
Reported By:                michaelhoy
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   670
Category:                   PCI - atiixp
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               slackware
Kernel Version:             2.4.26
======================================================================
Date Submitted:             11-24-2004 00:55 CET
Last Modified:              01-24-2005 05:48 CET
======================================================================
Summary:                    soundmax integrated digital not working in slack 10
Description: 
basically the sound card won't work with alsa. below is an email to lee a
developer he recommended i submit this as a bug fix. please read the
'additional information section' if this is not the correct way of
submitting a bug fix i apologize as this is my first.
======================================================================

----------------------------------------------------------------------
 tiwai - 11-24-04 17:54 
----------------------------------------------------------------------
The kernel should have shown any error/warning messages when you load
snd-atiixp module.  If so, it's either a BIOS problem or a well-known ACPI
problem.

I'd recommend you to play with different boot options related with ACPI. 
(Check other bug entries about atiixp.)

----------------------------------------------------------------------
 alt-os - 01-24-05 05:48 
----------------------------------------------------------------------
I had similar problems.
I actually resolved much of them by removing the snd-atiixp-modem module
(I read somewhere that it breacked the snd-atiixp module) and building
snd-atiixp statically into the 2.6.10 kernel. Now (unmuted the device) I
can hear sounds. But that have a strange behaviour...

If I play quickly some sounds (for examples, opening and closing quickly a
Gnome-panel drawer applet), I just heard the first one. Then, afther a few
seconds, I can hear it again, if click again. But again, just the first.

Instead, mixed sounds work perfectly (if I play two wavs, I year them
both) and video's audio is fine.

Sorry for the strange manner to report that bug, but I actually still
don't know how to describe that strange behaviour, and I could not find
any errors in log files :/

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-24-04 00:55 michaelhoy     New Issue                                    
11-24-04 00:55 michaelhoy     Distribution              => slackware       
11-24-04 00:55 michaelhoy     Kernel Version            => 2.4.26          
11-24-04 12:18 tiwai          Note Added: 0002547                          
11-24-04 17:48 michaelhoy     Note Added: 0002573                          
11-24-04 17:54 tiwai          Note Added: 0002574                          
01-24-05 05:48 alt-os         Note Added: 0003390                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
