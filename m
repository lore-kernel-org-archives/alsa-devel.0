From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000660]: No sound output  despite unmuting and maximizing all volume settings
Date: Sun, 21 Nov 2004 02:55:32 +0100
Message-ID: <fa2a98fda7bddcde51a6def34ab1f611@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 2E24F262
	for <alsa-devel@alsa-project.org>; Sun, 21 Nov 2004 02:55:33 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=660> 
======================================================================
Reported By:                bji
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   660
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Fedora Core 3
Kernel Version:             2.6.9
======================================================================
Date Submitted:             11-21-2004 02:53 CET
Last Modified:              11-21-2004 02:55 CET
======================================================================
Summary:                    No sound output  despite unmuting and maximizing all
volume settings
Description: 
I get no sound output from any program I have tried (xmms, play, aplay, cat
> /dev/audio) with no error messages or any other indication that there is
a problem which would cause sound to not occur.

I have already run alsamixer many times and tried every combination of
muted and unmuted settings with all volumes maximized.  With no volume
settings muted, and all volume settings at maximum level, I still get no
sound.

Everything *looks* like it's working - output in the kernel log, xmms's
display, everything.  But I get no sound out of the built-in speaker or
the headphone jack.

I have tried the following:

* Default install of Fedora Core 3; it recognized the sound card and
installed module settings in /etc/modprobe.conf to load snd-intel8x0.  But
I never got any sound out of this default install no matter what I tried.

* Custom compiled the 2.6.9 kernel with no patches except the software
suspend 2 patch.  This built the version of the ALSA drivers that come
with 2.6.9.  Still no sound.

* Downloaded and compiled version 1.0.7 of the ALSA drivers and installed
them.  Still no sound.

======================================================================

----------------------------------------------------------------------
 bji - 11-21-04 02:55 
----------------------------------------------------------------------
Oh, I should mention that previously I had been using Debian unstable and
the sound worked perfectly.  I believe that the kernel version was 2.6.8
or 2.6.9 (unfortunately I have blown away that installation and can't get
any information from it).

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-21-04 02:53 bji            New Issue                                    
11-21-04 02:53 bji            Distribution              => Fedora Core 3   
11-21-04 02:53 bji            Kernel Version            => 2.6.9           
11-21-04 02:55 bji            Note Added: 0002481                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
