From: noreply@alsa-project.org
Subject: [ALSA - driver 0000147]: Lost channel separation, left <--> right. Is now mono all the way.
Date: Fri, 16 Jul 2004 14:31:27 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040716123127.D2E7F2C005@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 1797B25A
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 14:31:28 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000147
======================================================================
Reported By:                Voluspa
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Bug ID:                     147
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               homebrew
Kernel Version:             2.6.5-rc2
======================================================================
Date Submitted:             03-21-2004 01:14 CET
Last Modified:              07-16-2004 14:31 CEST
======================================================================
Summary:                    Lost channel separation, left <--> right. Is now mono all the way.
Description: 
>From kernel 2.6.4 to 2.6.5-rc2 I've lost the ability to listen on separate
channels (left - right). Sliding either way only "muffles" the sound
somewhat, but it still comes from both speakers. And it is mono.
======================================================================

----------------------------------------------------------------------
 Voluspa - 03-21-2004 04:47 CET 
----------------------------------------------------------------------
Booting back in 2.6.4 I notice why I began fiddling with the channels in
the first place. Here (alsamixer) Master is in green (ca 2/3 of max) and
PCM slightly into red. Sound strength is they way I like it. In 2.6.5-rc2
I had to turn Master and PCM all the way to max to get enough strength -
plus crank up the volume knob on the active speakers. Strange I thought,
and slid the slider from channel to channel...

----------------------------------------------------------------------
 perex - 03-23-2004 16:08 CET 
----------------------------------------------------------------------
Could you do 'alsactl -f settings.txt store' on working kernel and
'alsactl -f settings.txt restore' on non-working kernel?

Capture also contents of /proc/asound/card0/codec97#0/ac97#0-0+regs
with both kernels (immediately after the alsactl command).

----------------------------------------------------------------------
 Voluspa - 03-25-2004 01:18 CET 
----------------------------------------------------------------------
The restore command gives 1 cosmetic error:

alsactl: set_control:805: warning: name mismatch
(External Amplifier Power Down/External Amplifier)
 for control https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000033

Caused by the name change you've done:

$ diff settings-2.6.5-rc2.txt settings-2.6.4.txt
267c267
<               name 'External Amplifier'
---
>               name 'External Amplifier Power Down'

But the /proc/asound/card0/codec97#0/ac97#0-0+regs
differ in two places:

$ diff regs-2.6.5-rc2.txt regs-2.6.4.txt
20c20
< 0:26 = 800f
---
> 0:26 = 000f
23c23
< 0:2c = bb80
---
> 0:2c = ac44

Uploading the full listings in voluspa-regs-settings.txt

----------------------------------------------------------------------
 Voluspa - 04-04-2004 21:15 CEST 
----------------------------------------------------------------------
Installed alsa-lib-1.0.4 and compiled the final 2.6.5 kernel. No change.
_But_ unmuting what alsamixer calls "External Amplifier" gave back channel
separation, stereo and signal strength! Same values as in kernel 2.6.4 and
prior, where unmuting that "register(?)" had no effect.

Loading the driver without a "alsactl restore" I see that the register is
unmuted by default, so unless this behaviour is totally whacked, you can
mark the bug as resolved.

One thing that turned up with the 1.0.4 libs, even when using kernel 2.6.4
(which hasn't been there before) is this message on loading:

kernel: ALSA sound/pci/intel8x0.c:596: codec_semaphore: semaphore is not
ready [0x1][0x300100]
kernel: ALSA sound/pci/intel8x0.c:627: codec_read 0: semaphore is not
ready for register 0x56

A couple of those, then the loading continues and all is well.

----------------------------------------------------------------------
 perex - 04-19-2004 15:06 CEST 
----------------------------------------------------------------------
Register 0x2c is rate register and it changes according the used playback
rate.

The problem seems solved. EAPD bit might change the amplifier behaviour
with some hardware.

Ignore the semaphore is not ready messages if they don't affect playback
or capture.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
03-21-04 01:14 Voluspa        New Bug                                      
03-21-04 01:14 Voluspa        Distribution              => homebrew        
03-21-04 01:14 Voluspa        Kernel Version            => 2.6.5-rc2       
03-21-04 04:47 Voluspa        Bugnote Added: 0000650                       
03-23-04 16:08 perex          Bugnote Added: 0000663                       
03-23-04 16:09 perex          Assigned To               => perex           
03-23-04 16:09 perex          Status                   new => assigned     
03-25-04 01:18 Voluspa        Bugnote Added: 0000703                       
03-25-04 01:20 Voluspa        File Added: voluspa-regs-settings.txt                    
04-04-04 21:15 Voluspa        Bugnote Added: 0000745                       
04-19-04 15:06 perex          Bugnote Added: 0000855                       
04-19-04 15:06 perex          Resolution               open => not a bug   
04-19-04 15:06 perex          Status                   assigned => resolved
07-16-04 14:31 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
