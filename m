From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001895]: nvidia 6150 --- desparate attempt fails at  snd_verbose_printk
Date: Tue, 7 Mar 2006 19:21:56 +0100
Message-ID: <f2961b7cc6c529c7b196e82f665d7b4d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D93E61A3
	for <alsa-devel@alsa-project.org>; Tue,  7 Mar 2006 19:21:56 +0100 (MET)
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
Last Modified:              03-07-2006 19:21 CET
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
 iaw4 - 03-07-06 19:03 
----------------------------------------------------------------------
Dear Steve:

your info (use snd_hda_intel), possibly with some options, helps a lot.  I
am running gentoo-linux.  alas, not yet there:

* the position_fix= part of the option creates a
  FATAL: Error inserting snd_hda_intel ... Invalid argument
if I remove it, modprobe snd_hda_intel inserts fine.  [is there a way
to reload all sound modules?  at the moment, I hand-rmmod them, and
then reload them.]

* there is a high-pitched tone (about 16 KHz) while sound is playing.
It disappears when the player stops.

* when I use the alsamixer to change volume after I am playing, I get
full and unreversible mute.  (noted elsewhere, too, e.g., at
http://quaggaspace.org/a8nvm/).

if the chipset can't be made to work, just tell me and I will buy
something else.  I still have an envy (ice) card lying around,
although it has always refused to work nice with realplayer.  it has
worked fine with other software.  [PS: what is the best soundcard for
compatibility and decent sound under ALSA these days?]

regards,

----------------------------------------------------------------------
 rlrevell - 03-07-06 19:21 
----------------------------------------------------------------------
Um, you can't just literally pass "position_fix=", you have to set it to
something, like "position_fix=1" or 0 or 2 or 3 or whatever.

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
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
