From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000615]: AC'97 broken on SB Live 24 bit
Date: Sun, 31 Oct 2004 00:30:02 +0200
Message-ID: <b8ae7a910f58a44e02d2e1e1d452231a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 036C822F
	for <alsa-devel@alsa-project.org>; Sun, 31 Oct 2004 00:30:02 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=615> 
======================================================================
Reported By:                MRB
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   615
Category:                   PCI - audigyls
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo Linux
Kernel Version:             2.6.7-gentoo-r1
======================================================================
Date Submitted:             10-29-2004 12:34 CEST
Last Modified:              10-31-2004 00:30 CEST
======================================================================
Summary:                    AC'97 broken on SB Live 24 bit
Description: 
The Creative Sound Blaster 24bit is using an Audigy chip according to its
PCI ID. The driver audigyls doesn't work because AC'97 does not respond
and AC'97 0 access is not valid. When you remove the error checking the
audigyls module can be loaded but there's no sound output. See attached
file for details. 
======================================================================

----------------------------------------------------------------------
 jcdutton - 10-30-04 18:08 
----------------------------------------------------------------------
Try the audigyls driver from
http://www.alsa-project.org/~james/alsa-driver/
Use the file audigyls.0.0.18.tar.bz2, and place the contents in
./alsa-driver/pci/emu10k1

In the alsa-driver directory:
./configure --with-cards=audigyls

Then build it as normal.

If it fails to compile, you might have to use the alsa-driver cvs instead.

----------------------------------------------------------------------
 MRB - 10-31-04 00:30 
----------------------------------------------------------------------
Tested it, compiled with latest release. Driver loads without any errors,
no more ac97 errors in syslog. In alsamixer volume or mute of AC97, SPDIF,
Unknown and What U Hear cannot be changed, everthing else set to max. I
get no sound whatever on all 3 output plugs, neither with Creative 7.1
speakers nor a headphone. Over the input plug I get sound that with a lot
of creativity sounds like it's supposed to ( a lot of noise and extremely
unclean, hard to notice it's not random noise ) and only over the left
speaker of my headphones. 

Output in syslog loading module and attempting to play sound attached (
uncommented snd_printk calls ). 

If the soundcard it not available to the developers I'm willing to donate
the price of the card if that helps.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-29-04 12:34 MRB            New Issue                                    
10-29-04 12:34 MRB            File Added: details.txt                      
10-29-04 12:34 MRB            Distribution              => Gentoo Linux    
10-29-04 12:34 MRB            Kernel Version            => 2.6.7-gentoo-r1 
10-30-04 18:08 jcdutton       Note Added: 0002289                          
10-31-04 00:30 MRB            Note Added: 0002290                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
