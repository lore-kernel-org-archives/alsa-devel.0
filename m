From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000232]: atiixp based sound card hardly functions correctly
Date: Tue, 18 Jan 2005 07:58:46 +0100
Message-ID: <199c531bea77a4378a90dcccceca2c3d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 94A38268
	for <alsa-devel@alsa-project.org>; Tue, 18 Jan 2005 07:58:46 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=232> 
======================================================================
Reported By:                fuoco
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   232
Category:                   PCI - atiixp
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo
Kernel Version:             2.6.6-rc1 (with cvs alsa-driver)
======================================================================
Date Submitted:             04-25-2004 21:21 CEST
Last Modified:              01-18-2005 07:58 CET
======================================================================
Summary:                    atiixp based sound card hardly functions correctly
Description: 
There was a bug 2 days ago in this driver that caused atiixp: codec read
timeout errors. The errors are still partly there in some cases even
though the card is now detected. The card indeed works but only in xmms.
Tried with many other programs without success: timidity++, xine, mplayer,
gstreamer, rhythmbox. Even sounds from programs like gaim cause problems.
The problems are either one of these (or a combination):
1. program plays but no sound from speakers.
2. speakers make lot of noise instead of playing the sound.
3. when stopping the audio the program hungs for some time, and might even
crash. 
4. e.g. gaim makes a short sound and the sound doesn't stop repeating
itself until i unload the modules.

Errors that I got in dmesg, with some of the problems mentioned:
codec read timeout (reg 0)
ALSA /home/gad/downloads/alsa/alsa-driver/alsa-kernel/pci/atiixp.c:468:
atiixp: codec read timeout (reg 3c)
ALSA /home/gad/downloads/alsa/alsa-driver/alsa-kernel/pci/atiixp.c:468:
atiixp: codec read timeout (reg 1c)
ALSA
/home/gad/downloads/alsa/alsa-driver/alsa-kernel/pci/ac97/ac97_codec.c:1791:
AC'97 2 does not respond - RESET
ALSA
/home/gad/downloads/alsa/alsa-driver/alsa-kernel/pci/ac97/ac97_codec.c:1799:
AC'97 2 access is not valid [0xffffffff], removing mixer.

For more info please ask me.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
duplicate of        0000202 atiixp works under 2.4.25, fails under ...
======================================================================

----------------------------------------------------------------------
 tiwai - 05-26-04 14:39 
----------------------------------------------------------------------
i guess the secondary codec is for modem.  so the message from
ac97_codec.c should be harmless and not related with ACPI.

----------------------------------------------------------------------
 rounin - 01-18-05 07:58 
----------------------------------------------------------------------
The card doesn't work anywhere in Fedora Core 3 with the 2.6.10-1.737
kernel. This is now the third thread about this same issue.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-25-04 21:21 fuoco          New Issue                                    
04-25-04 21:21 fuoco          Distribution              => Gentoo          
04-25-04 21:21 fuoco          Kernel Version            => 2.6.6-rc1 (with cvs
alsa-driver)
04-25-04 23:11 fuoco          Note Added: 0000944                          
04-26-04 11:41 tiwai          Status                   assigned => resolved
04-26-04 11:41 tiwai          Resolution               open => duplicate   
04-26-04 11:41 tiwai          Relationship added       duplicate of 0000202
04-26-04 14:13 perex          Status                   resolved => feedback
04-26-04 14:13 perex          Resolution               duplicate => reopened
04-26-04 14:13 perex          Note Added: 0000947                          
04-26-04 14:13 perex          Status                   feedback => assigned
04-26-04 14:14 perex          Note Deleted: 0000947                        
04-27-04 12:25 tiwai          Note Added: 0000959                          
04-27-04 17:41 fuoco          Note Added: 0000963                          
04-27-04 17:46 fuoco          Note Added: 0000964                          
04-27-04 19:06 fuoco          Note Added: 0000965                          
04-30-04 11:05 tiwai          Note Added: 0000976                          
04-30-04 11:17 fuoco          Note Added: 0000977                          
05-01-04 10:44 tiwai          Note Added: 0000997                          
05-18-04 21:22 fuoco          Note Added: 0001147                          
05-19-04 20:00 fuoco          Note Added: 0001155                          
05-22-04 13:29 fuoco          Note Added: 0001168                          
05-22-04 14:42 fuoco          Note Added: 0001171                          
05-22-04 21:08 Dezi           Issue Monitored: Dezi                        
05-25-04 12:49 tiwai          Note Added: 0001204                          
05-25-04 15:44 fuoco          Note Added: 0001216                          
05-25-04 16:07 tiwai          Note Added: 0001219                          
05-26-04 00:38 fuoco          Note Added: 0001242                          
05-26-04 14:39 tiwai          Note Added: 0001257                          
01-18-05 07:58 rounin         Note Added: 0003243                          
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
