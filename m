From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001914]: playing 2-channel sound on surround device uses rear speakers
Date: Mon, 20 Mar 2006 13:04:30 +0100
Message-ID: <635669307efef6cbd351c99e9bc0b969@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 56550206
	for <alsa-devel@alsa-project.org>; Mon, 20 Mar 2006 13:04:30 +0100 (MET)
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


The following issue has been RESOLVED.
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
Status:                     resolved
Distribution:               Gentoo
Kernel Version:             2.6.15-gentoo-r1
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             03-11-2006 21:25 CET
Last Modified:              03-20-2006 13:04 CET
======================================================================
Summary:                    playing 2-channel sound on surround device uses rear
speakers
Description: 
If I play regular 2-channel stereo sound specifying device "surround51" or
"surround40" (or either of those with a "plug:" prefix) the sound is
output on the rear speakers.  6-channel playback is correct.
======================================================================

----------------------------------------------------------------------
 mru - 03-16-06 02:38 
----------------------------------------------------------------------
Sorry, that last bit must have been caused by something else.  Muting and
unmuting the "PCM" control somehow fixed it, even though the PCM mute
otherwise only affects the front speakers.

With the patch, 2-channel samples are padded to 6 by the plug: wrapper so
the sound is correctly played on the front speakers.  6-channel playback
is unchanged, as it should.

----------------------------------------------------------------------
 tiwai - 03-20-06 13:04 
----------------------------------------------------------------------
OK, closing this bug now.  The better upmixing is a different thing (which
will be improved in near future).

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
03-16-06 02:38 mru            Note Added: 0008582                          
03-20-06 13:04 tiwai          Status                   assigned => resolved
03-20-06 13:04 tiwai          Resolution               open => fixed       
03-20-06 13:04 tiwai          Note Added: 0008719                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
