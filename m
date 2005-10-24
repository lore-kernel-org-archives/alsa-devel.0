From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001439]: OSS emulation fails for usb-audio
Date: Mon, 24 Oct 2005 15:18:45 +0200
Message-ID: <de909bf197a0779db461757216a81690@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 24A52120
	for <alsa-devel@alsa-project.org>; Mon, 24 Oct 2005 15:18:45 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1439> 
======================================================================
Reported By:                dagb
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1439
Category:                   CORE OSS - pcm
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Gentoo
Kernel Version:             2.6.14-rc2
======================================================================
Date Submitted:             09-21-2005 21:31 CEST
Last Modified:              10-24-2005 15:18 CEST
======================================================================
Summary:                    OSS emulation fails for usb-audio
Description: 
With ALSA as found in 2.6.14-rc{12} 
(which reports as as ALSA version 1.0.10-rc1?):
When playing audio using the OSS emulation with beep-media-player through
my USB headset adapter, there is no audio, and the time elapsed in BMP
runs way too fast.

It works if I use the native ALSA support in BMP.
But, I cannot get any audio with skype with this kernel. This is my main
beef.
skype does not do ALSA. I have to use the OSS emulation.

The exact same setup with 2.6.13-gentoo-r1 (using the vanilla kernel ALSA)
works perfectly for me.

======================================================================

----------------------------------------------------------------------
 dagb - 09-27-05 07:40 
----------------------------------------------------------------------
dagb-home src # uname -sr 
Linux 2.6.13-gentoo-r1

dagb-home src # zcat /proc/config.gz | grep CONFIG_USB_BANDWIDTH
# CONFIG_USB_BANDWIDTH is not set

dagb-home src # grep CONFIG_USB_BANDWIDTH
/usr/src/linux-2.6.14-rc1/.config
# CONFIG_USB_BANDWIDTH is not set

Yes. CONFIG_USB_BANDWIDTH disabled in both setups.

----------------------------------------------------------------------
 Alphix - 10-24-05 15:18 
----------------------------------------------------------------------
I see exactly the same issue with a TerraTec external usb audio card. I've
reported it LKML
(http://marc.theaimsgroup.com/?l=linux-kernel&m=113001840929175&w=2) and
the ALSA mailing list
(http://article.gmane.org/gmane.linux.alsa.devel/27690).


I've included the email below for the records
=============================================

After updating the kernel on one of my computers today I discovered that 
usb-audio via snd-pcm-oss over the snd-usb-audio ALSA drivers stopped 
working (worked with 2.6.13, doesn't with 2.6.14-rc[12345]).

The weird part is that it only stopped working when using the driver 
through the oss emulation and only for some programs. I've tried it with 
all apps with native alsa support that I had installed, and all of them 
worked. I also tried it with a few different apps with oss support, and 
most of them worked (xine and mplayer) while one failed (mythmusic).

The symptoms is that no sound is heard while the app seems to believe 
that everything is just fine. It also progresses through the song at 
about 20x normal speed (i.e. it thinks its done playing a 4 minute song 
after 12 seconds). The only difference I can come up with is that xine 
and mplayer probably up-sample the audio to 48.000Hz while MythMusic 
tries to play at 44.100Hz (the device is a TerraTec external USB <-> 
SPDIF interface).

I've used git's bisect command to try to find the exact problem, and it 
seems to have been introduced by this commit:	
7efd8bc800324a967a37e8a425433468b7f06adb
see also:
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=7efd8bc800324a967a37e8a425433468b7f06adb

patch name: [ALSA] usb-audio: double-buffer all playback data

I'm not sure on how to fix it since the commit is quite big and cannot 
be simply reversed with the current tree as there have been other 
patches applied to the file afterwards. Comments/suggestions welcome...

Regards,
David Härdeman

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-21-05 21:31 dagb           New Issue                                    
09-21-05 21:31 dagb           Distribution              => Gentoo          
09-21-05 21:31 dagb           Kernel Version            => 2.6.14-rc2      
09-21-05 21:31 dagb           Issue Monitored: dagb                        
09-26-05 22:07 dagb           Note Added: 0006400                          
09-26-05 22:32 rlrevell       Note Added: 0006401                          
09-27-05 07:40 dagb           Note Added: 0006404                          
10-24-05 15:18 Alphix         Note Added: 0006519                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
