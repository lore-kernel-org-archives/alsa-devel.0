From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002108]: snd-hda-intel: Can only play 48000Hz via digital out.  44100 is garbled.
Date: Tue, 9 May 2006 00:31:45 +0200
Message-ID: <70db2f755897211fa96a1f7fff398c9f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2DD8B184
	for <alsa-devel@alsa-project.org>; Tue,  9 May 2006 00:31:46 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2108> 
======================================================================
Reported By:                WhereIsTheCloud
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2108
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Debian
Kernel Version:             2.6.15-1-686-smp
======================================================================
Date Submitted:             05-09-2006 00:28 CEST
Last Modified:              05-09-2006 00:31 CEST
======================================================================
Summary:                    snd-hda-intel: Can only play 48000Hz via digital
out.  44100 is garbled.
Description: 
Hi all.  I am having trouble getting my computer to play 44100Hz with my 
digital AV reciever.  I have an ECS 945P-A (1.1) motherboard 
(ICH7), with an onboard Realtek ALC880 8-channel audio CODEC, five 
miniport(?) jacks, and one fiber optical connector.  I use the fiber
optical 
connector to connect the motherboard to my reciever.

I cannot get clean 44100 Hz PCM sound outputted.  48000 Hz plays fine. 
Dmix converts everything to 48000. This is acceptable, but 44100->48000Hz
upsampling degrades sound quality.

If I dual boot to MS windows, I can select between 44100, 48000, and 96000
Hz output, using the realtek drivers.  All work fine and my reciever
reports getting the correct format, so it is NOT a hardware problem.

I'm not sure if this is a driver issue or a libasound issue.


Thank you in advance for your help!

Peter
======================================================================

----------------------------------------------------------------------
 WhereIsTheCloud - 05-09-06 00:31 
----------------------------------------------------------------------
HOWEVER, if I run:
aplay -D plug:dmix test-48000.wav
Playing WAVE 'test-48000.wav' : Signed 16 bit Little Endian, Rate 48000
Hz, Stereo

should read:

HOWEVER, if I run:
aplay -D hw:0,1 test-48000.wav
Playing WAVE 'test-48000.wav' : Signed 16 bit Little Endian, Rate 48000
Hz, Stereo

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-09-06 00:28 WhereIsTheCloudNew Issue                                    
05-09-06 00:28 WhereIsTheCloudDistribution              => Debian          
05-09-06 00:28 WhereIsTheCloudKernel Version            => 2.6.15-1-686-smp
05-09-06 00:31 WhereIsTheCloudNote Added: 0009649                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
