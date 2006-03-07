From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001895]: nvidia 6150 --- desparate attempt fails at  snd_verbose_printk
Date: Wed, 8 Mar 2006 00:12:44 +0100
Message-ID: <21d542619506224bca22c0a45d5cd83c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C544E1B8
	for <alsa-devel@alsa-project.org>; Wed,  8 Mar 2006 00:12:44 +0100 (MET)
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
Last Modified:              03-08-2006 00:12 CET
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
 rlrevell - 03-07-06 21:53 
----------------------------------------------------------------------
It's best to search for codec + driver because most bugs only apply to a
specific combination.

Make sure that the module is seeing the parameters:

cat /sys/module/snd_hda_intel/parameters/position_fix

etc

----------------------------------------------------------------------
 stevenellis - 03-08-06 00:12 
----------------------------------------------------------------------
Sorry about the bad copy/paste with the position_fix option. I did mean to
say "position_fix=1"

I have the same issues with alsa 1.0.11rc3 and a 2.6.15.6 kernel. Unless I
apply the patch to disable analog surround I get a high pitch squeal and
any volume change results in mute on both analog and digital outputs.

With the patch from http://quaggaspace.org/a8nvm/a8nvmsound.patch, I can
change the volume, no issues with digital, and analog stereo works.

I haven't tried all of the combinations of postion_fix and model at this
stage as the hardware is supposed to be the family media center, and I can
only get so much time a week for debugging.

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
03-07-06 21:45 iaw4           Note Added: 0008377                          
03-07-06 21:53 rlrevell       Note Added: 0008378                          
03-08-06 00:12 stevenellis    Note Added: 0008379                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
