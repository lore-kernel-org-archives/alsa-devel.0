From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001914]: playing 2-channel sound on surround device uses rear speakers
Date: Thu, 16 Mar 2006 02:06:14 +0100
Message-ID: <46161921c6a11de51182263475507980@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D609E20C
	for <alsa-devel@alsa-project.org>; Thu, 16 Mar 2006 02:06:14 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1914> 
======================================================================
Reported By:                mru
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1914
Category:                   PCI - cmipci
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo
Kernel Version:             2.6.15-gentoo-r1
======================================================================
Date Submitted:             03-11-2006 21:25 CET
Last Modified:              03-16-2006 02:06 CET
======================================================================
Summary:                    playing 2-channel sound on surround device uses rear
speakers
Description: 
If I play regular 2-channel stereo sound specifying device "surround51" or
"surround40" (or either of those with a "plug:" prefix) the sound is
output on the rear speakers.  6-channel playback is correct.
======================================================================

----------------------------------------------------------------------
 tiwai - 03-15-06 13:04 
----------------------------------------------------------------------
The attached patch should fix this problem.

This doesn't change the default behavior of plug plugin, i.e. the
2-channel sampless are copied only to front and rest speakers are silent.
For a more clever channel expansion, it'd better to create a new plugin.

----------------------------------------------------------------------
 mru - 03-16-06 02:06 
----------------------------------------------------------------------
That patch makes plug:surround51 work as expected with two channels. 
However, it is now failing with 6-channel sound.  Front and surround/lfe
are fine, but right rear is about half volume, and left rear is barely
audible.  Playing 2-channel sound on the "rear" device works, so I'm sure
the speakers are connected properly.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-11-06 21:25 mru            New Issue                                    
03-11-06 21:25 mru            Distribution              => Gentoo          
03-11-06 21:25 mru            Kernel Version            => 2.6.15-gentoo-r1
03-14-06 15:04 tiwai          Note Added: 0008477                          
03-14-06 15:15 mru            Note Added: 0008478                          
03-14-06 15:22 tiwai          Note Added: 0008481                          
03-14-06 23:53 mru            Note Added: 0008524                          
03-15-06 11:59 tiwai          Note Added: 0008536                          
03-15-06 12:27 mru            Note Added: 0008541                          
03-15-06 13:04 tiwai          Note Added: 0008545                          
03-15-06 13:05 tiwai          File Added: pcm-hw-restrict.diff                  
 
03-16-06 02:06 mru            Note Added: 0008580                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
