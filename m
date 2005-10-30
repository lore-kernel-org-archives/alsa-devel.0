From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001439]: OSS emulation fails for usb-audio
Date: Sun, 30 Oct 2005 17:54:23 +0100
Message-ID: <88468d18000ed07c8db398233d2f79b8@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4645B175
	for <alsa-devel@alsa-project.org>; Sun, 30 Oct 2005 17:54:24 +0100 (MET)
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
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   1439
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     confirmed
Distribution:               Gentoo
Kernel Version:             2.6.14-rc2
======================================================================
Date Submitted:             09-21-2005 21:31 CEST
Last Modified:              10-30-2005 17:54 CET
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
 Clemens Ladisch - 10-26-05 14:38 
----------------------------------------------------------------------
I could reproduce some strange behaviour with these settings.

It seems that this particular period size (1114) results in an immediate
underrun whenever some data is written to the device.  This is a bug in
the driver.

----------------------------------------------------------------------
 dagb - 10-30-05 17:54 
----------------------------------------------------------------------
Retested with 2.6.14-gentoo. The bug is still present. Time counter runs
approximately 5.5x too fast with 44.1k contents.

dagb@dagb-home ~ $ (17:43) cat /proc/asound/card1/pcm0p/sub0/hw_params
access: RW_INTERLEAVED
format: S16_LE
subformat: STD
channels: 2
rate: 44100 (44100/1)
period_size: 1024
buffer_size: 32768
tick_time: 4000
OSS format: S16_LE
OSS channels: 2
OSS rate: 44100
OSS period bytes: 4096
OSS periods: 32
OSS period frames: 1024

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
10-24-05 15:20 Alphix         Issue Monitored: Alphix                      
10-24-05 17:28 Clemens LadischAssigned To               => Clemens Ladisch 
10-24-05 17:28 Clemens LadischStatus                   new => assigned     
10-24-05 17:28 Clemens LadischCategory                 CORE OSS - pcm => USB -
usb-audio
10-25-05 13:44 Clemens LadischNote Added: 0006538                          
10-26-05 00:08 Alphix         Note Added: 0006552                          
10-26-05 14:38 Clemens LadischNote Added: 0006558                          
10-26-05 14:38 Clemens LadischStatus                   assigned => confirmed
10-30-05 17:54 dagb           Note Added: 0006574                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
