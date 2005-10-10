From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001471]: Digital output sometimes doesn't work
Date: Mon, 10 Oct 2005 22:44:27 +0200
Message-ID: <af3cd7c1d4ee5a9b7dd54a3f99cc5769@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6A21B189
	for <alsa-devel@alsa-project.org>; Mon, 10 Oct 2005 22:44:27 +0200 (MEST)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1471> 
======================================================================
Reported By:                andrei_badea
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1471
Category:                   PCI - cs46xx
Reproducibility:            random
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Debian GNU/Linux
Kernel Version:             2.6.13.2
======================================================================
Date Submitted:             10-10-2005 22:44 CEST
Last Modified:              10-10-2005 22:44 CEST
======================================================================
Summary:                    Digital output sometimes doesn't work
Description: 
I have a Hercules Fortissimo II sound card whose digital out line is
connected to a digital receiver. Sometimes (about once in ten reboots) the
digital output doesn't work (there's no sound). There aren't any errors in
the kernel log, and sound-playing application work with no error messages
too (except there's no sound). The receiver shows there's a signal at its
digital input connector. The digital output line in alsamixer is not
muted, and moreover, the analog output works.

If I rmmod the snd-cs46xx module and modprobe it again, this message it
logged to the kernel log:

cs46xx: failure waiting for FIFO command to complete

and the receiver shows no presence of a digital signal anymore.

Usually if I reboot it all starts working again. It once happened that one
reboot wasn't enough and I had to reboot once more.

I will happily provide more information if needed or test fixes.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-10-05 22:44 andrei_badea   New Issue                                    
10-10-05 22:44 andrei_badea   Distribution              => Debian GNU/Linux
10-10-05 22:44 andrei_badea   Kernel Version            => 2.6.13.2        
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
