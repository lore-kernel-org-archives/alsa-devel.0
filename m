From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001855]: no sound with openal
Date: Tue, 18 Jul 2006 14:39:39 +0200
Message-ID: <f4604b54f4ed3ed261b130a31df4b320@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7D2A4176
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Jul 2006 14:39:39 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been ASSIGNED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1855> 
======================================================================
Reported By:                eiz
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   1855
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Debian
Kernel Version:             2.6.15.3
======================================================================
Date Submitted:             02-18-2006 20:24 CET
Last Modified:              07-18-2006 14:39 CEST
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
 rlrevell - 02-18-06 20:30 
----------------------------------------------------------------------
should be fixed in 2.6.15.4

----------------------------------------------------------------------
 eiz - 02-19-06 12:25 
----------------------------------------------------------------------
Tested with kernel 2.6.15.4 : this is not fixed yet.

tested with :
 openal 0.2005080600-2.1
 openal 0.0.8

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

----------------------------------------------------------------------
 Raymond - 03-04-06 10:06 
----------------------------------------------------------------------
Does vol_ctl really work without set device ? (Only set
Interface,name,index)

snd_ctl_elem_value_set_device(src->vol_ctl,
snd_pcm_info_get_device(info));

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
03-04-06 10:06 Raymond        Note Added: 0008346                          
07-18-06 14:39 jcdutton       Status                   new => assigned     
07-18-06 14:39 jcdutton       Assigned To               => jcdutton        
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
