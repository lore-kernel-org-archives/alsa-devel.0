From: noreply@alsa-project.org
Subject: [ALSA - driver 0000337]: "alsactl restore" always fails
Date: Fri, 16 Jul 2004 12:02:40 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040716100240.9C01426008@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id CAE481AC
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 12:02:55 +0200 (MEST)
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


The following bug has been RESOLVED.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000337
======================================================================
Reported By:                kuulasma
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     337
Category:                   PCI - nm256
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               Debian sarge
Kernel Version:             Linux 2.6.6-1-686
Resolution:                 fixed
======================================================================
Date Submitted:             06-16-2004 22:04 CEST
Last Modified:              07-16-2004 12:02 CEST
======================================================================
Summary:                    "alsactl restore" always fails
Description: 
Dell Latitude CPt with an NM256ZX fails always to restore previously saved
state. Command "alsactl store" succesfully stores current state but
"alsactl restore" always fails to restore previous state. The OSS driver
works fine.

Example:
----------------------------------------------------------
# alsactl restore
alsactl: set_control:966: Cannot write control '2:0:0:CD Playback
Switch:0' : Invalid argument
----------------------------------------------------------
======================================================================

----------------------------------------------------------------------
 tiwai - 06-22-2004 18:51 CEST 
----------------------------------------------------------------------
Can you toggle CD mute on alsamixer, or like 'amixer set CD mute'?

----------------------------------------------------------------------
 kuulasma - 06-22-2004 21:35 CEST 
----------------------------------------------------------------------
I tried to toggle CD mute but new setting are not stored. If I try to mute
CD or change volyme, new settings are ignored. alsamixer doesn't save CD
volyme and mute state. Other controls work just like I expect them to
work. Once I open alsamixer CD settings are as follows: volyme 100 and
unmuted.

If I edit /var/lib/alsa/asound.state file manually and remove sections
control.14 and control.15, I can issue command 'alsactl restore'
succesfully (without error message). But once I store settings ('alsactl
store'), illegal control.14 and control.15 are stored in asound.state
file. 

Just in case you need following information:

# lsmod | grep snd
snd_nm256              69188  1 
snd_ac97_codec         65188  1 snd_nm256
snd_pcm_oss            54436  0 
snd_mixer_oss          20096  2 snd_pcm_oss
snd_pcm                98148  2 snd_nm256,snd_pcm_oss
snd_page_alloc         11460  1 snd_pcm
snd_timer              25380  1 snd_pcm
snd                    54692  6
snd_nm256,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer
soundcore              10336  2 snd

----------------------------------------------------------------------
 tiwai - 06-30-2004 16:29 CEST 
----------------------------------------------------------------------
The attached patch will allow the access to the CD mute/volume.
Please give a try.

----------------------------------------------------------------------
 kuulasma - 07-02-2004 07:12 CEST 
----------------------------------------------------------------------
YES!

I patched the kernel (2.6.6) and compiled. After boot new kernel with
nm256-cd.diff worked. Thank you!

When will the patch land in official kernel source repository?

Regards

Teemu

----------------------------------------------------------------------
 tiwai - 07-16-2004 12:02 CEST 
----------------------------------------------------------------------
fixed on cvs now.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
06-16-04 22:04 kuulasma       New Bug                                      
06-16-04 22:04 kuulasma       Distribution              => Debian sarge    
06-16-04 22:04 kuulasma       Kernel Version            => Linux 2.6.6-1-686
06-17-04 14:12 kuulasma       Bug Monitored: kuulasma                      
06-22-04 18:51 tiwai          Bugnote Added: 0001333                       
06-22-04 21:35 kuulasma       Bugnote Added: 0001334                       
06-30-04 16:29 tiwai          Bugnote Added: 0001355                       
06-30-04 16:30 tiwai          File Added: nm256-cd.dif                     
07-02-04 07:12 kuulasma       Bugnote Added: 0001373                       
07-16-04 12:02 tiwai          Bugnote Added: 0001444                       
07-16-04 12:02 tiwai          Resolution               open => fixed       
07-16-04 12:02 tiwai          Status                   assigned => resolved
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
