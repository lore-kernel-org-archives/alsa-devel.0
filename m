From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001895]: nvidia 6150 --- desparate attempt fails at  snd_verbose_printk
Date: Tue, 7 Mar 2006 20:39:59 +0100
Message-ID: <0a6ff0d90fa6db7c0bd6cd399bb08007@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 32D461B9
	for <alsa-devel@alsa-project.org>; Tue,  7 Mar 2006 20:39:59 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1895> 
======================================================================
Reported By:                iaw4
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1895
Category:                   1_OTHERS
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     new
Distribution:               gentoo
Kernel Version:             2.6.15.5
======================================================================
Date Submitted:             03-07-2006 03:24 CET
Last Modified:              03-07-2006 20:39 CET
======================================================================
Summary:                    nvidia 6150 --- desparate attempt fails at 
snd_verbose_printk
Description: 

I am trying to make the built-in sound on the ASUS A8N CSM VM (nvidia
6150) to work.  apparently, a realtek 880 might also work.  I was told
that the NFORCE drivers do not support it.  it seems to be some variant of
intel high-definition audio.  I was hoping the latest ALSA would support
it.  (Right wrong?)

So, I downloaded the most recent ALSA distribution.  My linux kernel is
linux-2.6.15.5.  I read the ALSA docs.  [by the way, most docs talk about
having to have the soundcore enabled.  this is unclear, because I do not
believe this is how the kernel 2.6.15.5 calls this anymore.  I think all
that is meant here is that the very top selection of sound in the kernel
must be on, which would be CONFIG_SOUND=y in this kernel.  not sure.]

The new ALSA compilation and installation works great.  Alas, now I want
to try the intel driver next, which depends on snd_ac97_codec.  alas,
despite a completely fresh installation, upon a "modprobe snd_ac97_codec",
it fails to find snd_verbose_printk.  I thought modprobe could insert
dependencies automatically.  either I am wrong here, or there is a
dependency that is not marked appropriately.

======================================================================

----------------------------------------------------------------------
 Arnaud Patard - 03-07-06 20:38 
----------------------------------------------------------------------
your mobo (a8n csm vm) has a ad1986a codec from analog and not realtek
alc880. This one is on some nforce 430 mobo from Gigabyte. Look at
alsa-devel archive and also at this bugzilla, you'll find at least a
workaround for the noise. 

As regards the position_fix= module parameter, you don't need it for
recent versions of alsa iirc.

(if you want to be sure of what codec you have, look at the
/proc/asound/codec/card0/codec#0 file)



----------------------------------------------------------------------
 er-ku - 03-07-06 20:39 
----------------------------------------------------------------------
try model=asus instead of model=3stack-digout

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-07-06 03:24 iaw4           New Issue                                    
03-07-06 03:24 iaw4           Distribution              => gentoo          
03-07-06 03:24 iaw4           Kernel Version            => 2.6.15.5        
03-07-06 06:27 stevenellis    Issue Monitored: stevenellis                    
03-07-06 06:30 stevenellis    Note Added: 0008361                          
03-07-06 19:03 iaw4           Note Added: 0008371                          
03-07-06 19:21 rlrevell       Note Added: 0008372                          
03-07-06 20:24 iaw4           Note Added: 0008374                          
03-07-06 20:37 Arnaud Patard  Note Added: 0008375                          
03-07-06 20:38 Arnaud Patard  Note Edited: 0008375                         
03-07-06 20:39 er-ku          Note Added: 0008376                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
