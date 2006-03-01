From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001855]: no sound with openal
Date: Wed, 1 Mar 2006 08:00:24 +0100
Message-ID: <d0a2560997f187ca493b848fb0ea5f6e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 333C21CA
	for <alsa-devel@alsa-project.org>; Wed,  1 Mar 2006 08:00:25 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1855> 
======================================================================
Reported By:                eiz
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1855
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian
Kernel Version:             2.6.15.3
======================================================================
Date Submitted:             02-18-2006 20:24 CET
Last Modified:              03-01-2006 08:00 CET
======================================================================
Summary:                    no sound with openal
Description: 
when forcing ( define devices '(alsa native) ) in .openalrc
no sound at all and no error 
tested with openal own demo and ut2004

openal 0.2005080600-2.1 or openal-alsa-emu10k1-1.2
kernel 2.6.15.3

cat ~/.asoundrc
pcm.emu10k1 {
           type hw
           card 0
}
ctl.emu10k1 {
           type hw
           card 0
}

NOTES : 
- maybe useful tip : I noticed mmap call seems broken on amd64
- my surround51 device through spdiff is working very well with 
  aplay -c 6 -D surround51

======================================================================

----------------------------------------------------------------------
 pzad - 02-19-06 12:34 
----------------------------------------------------------------------
Don't use .asoundrc. Your card doesn't need it and it can cause problems.
I think openal-alsa-emu10k1-1.2 will not work with newer alsa (needs one
simple change).

----------------------------------------------------------------------
 Raymond - 03-01-06 08:00 
----------------------------------------------------------------------
The iface of the kcontrols had been changed from MIXER to PCM

http://sourceforge.net/mailarchive/forum.php?thread_id=7849852&forum_id=33141

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-18-06 20:24 eiz            New Issue                                    
02-18-06 20:24 eiz            File Added: openal-demo-strace.txt.gz             
      
02-18-06 20:24 eiz            Distribution              => Debian          
02-18-06 20:24 eiz            Kernel Version            => 2.6.15.3        
02-18-06 20:30 rlrevell       Note Added: 0008123                          
02-19-06 12:25 eiz            Note Added: 0008132                          
02-19-06 12:34 pzad           Note Added: 0008133                          
03-01-06 08:00 Raymond        Note Added: 0008275                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
