From: noreply@alsa-project.org
Subject: [ALSA - driver 0000198]: only one pcm active on alsa>=1.0.3
Date: Fri, 16 Jul 2004 12:55:46 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040716105546.C48B926008@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 10ECD244
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 12:55:47 +0200 (MEST)
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


The following bug has been CLOSED
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000198
======================================================================
Reported By:                prymitive
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     198
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               PLD 2.0
Kernel Version:             
======================================================================
Date Submitted:             04-09-2004 15:55 CEST
Last Modified:              07-16-2004 12:55 CEST
======================================================================
Summary:                    only one pcm active on alsa>=1.0.3
Description: 
bug(?) in ALSA 1.0.3 and higher and via82xx driver. there should be (by
default, when using DXS channels) 4 subdevices active on first pcm and one
on second, and it works great on alsa up to 1.0.2c, but on higher versions
there is only one subdevice active on first pcm, the second isn't active.
/proc/asound shows that all pcm's and theire subdevices are active but
when I try to play some mp3's with xmms and artsd is blocking one device,
it returns an error opening device, when artsd goes idle and free that
device xmms starts playing but when some apps tries to use artsd it
crashes. I've tried kernels: 2.6.5-rc2 (with and without -mm pathces),
plain 2.6.5 and 2.6.5-mm1. I've tried also alsa-lib: 1.0.1, 1.0.3 and
1.0.4. It does not change anything. My mobo is K7VT4-4X (via kt333cf and
via 8235). With 2.6.4 kernel erverything is ok. I've tried all dxs_support
options, alsa compiled in and as modules.
======================================================================

----------------------------------------------------------------------
 tiwai - 04-16-2004 12:06 CEST 
----------------------------------------------------------------------
does it happen if you run 2 aplay simultaneously?

----------------------------------------------------------------------
 prymitive - 04-16-2004 14:24 CEST 
----------------------------------------------------------------------
With aplay I can use all 4 subdevices on vanilla 2.6.5 and alsa-lib-1.0.1,
I've downgraded alsa-lib becouse 1.0.4 and kernel 2.6.4 skips few seconds
of playback when switching from X11 to console with ctr+fxx and sometimes
when mini/maximizing windows or fast scrolling in mozilla. In xmms(1.2.10)
when I use alsa output I've got error:

>ALSA lib pcm_hw.c:466:(snd_pcm_hw_prepare) SNDRV_PCM_IOCTL_PREPARE
failed: Z³y argument
>
>** WARNING **: alsa_setup(): Unable to install hw params

but when I use oss output I've got 100% cpu usage and no sound or errors
on console, same thing with mplayer -ao oss, audio device is open
(/proc/asound confirms that) and that cpu usage goes ~33% to mplayer and
~66% to kdeinit (?). When I terminate artsd mplayer and xmms plays withs
alsa without problems. And mplayer -ao alsa9 gives me this:

>Opening audio decoder: [pcm] Uncompressed PCM audio decoder
>AUDIO: 44100 Hz, 2 ch, 16 bit (0x10), ratio: 176400->176400 (1411,2
kbit)
>Selected audio codec: [pcm] afm:pcm (Uncompressed PCM)
>==========================================================================
>Checking audio filter chain for 44100Hz/2ch/16bit ->
44100Hz/2ch/16bit...
>AF_pre: af format: 2 bps, 2 ch, 44100 hz, little endian signed int
>AF_pre: 44100Hz 2ch Signed 16-bit (Little-Endian)
>alsa-init: requested format: 44100 Hz, 2 channels, Signed 16-bit
(Little-Endian)
>alsa-init: 1 soundcard found, using: hw:0,0
>ALSA lib pcm_hw.c:466:(snd_pcm_hw_prepare) SNDRV_PCM_IOCTL_PREPARE
failed: Z³y argument
>alsa-init: unable to set hw-parameters: Bad argument
>Could not open/initialize audio device -> no sound.

----------------------------------------------------------------------
 prymitive - 06-18-2004 22:42 CEST 
----------------------------------------------------------------------
It seems to be gone in current (2.6.7-rc3-mm1) kernel.

Thanks for Your work
prymitive

Bug History
Date Modified  Username       Field                    Change              
======================================================================
04-09-04 15:55 prymitive      New Bug                                      
04-09-04 15:55 prymitive      Distribution              => PLD 2.0         
04-16-04 12:06 tiwai          Bugnote Added: 0000836                       
04-16-04 14:24 prymitive      Bugnote Added: 0000837                       
06-18-04 22:42 prymitive      Bugnote Added: 0001321                       
06-22-04 18:43 tiwai          Assigned To               => tiwai           
06-22-04 18:43 tiwai          Resolution               open => fixed       
06-22-04 18:43 tiwai          Status                   new => resolved     
07-16-04 12:55 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
