From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002108]: snd-hda-intel: Can only play
	48000Hz via digital out. 44100 is garbled.
Date: Thu, 6 Jul 2006 20:22:01 +0200
Message-ID: <e9b467b3f66f94adf7fa7f5d4898f7b9@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 71C0725F
	for <alsa-devel@alsa-project.org>;
	Thu,  6 Jul 2006 20:22:01 +0200 (MEST)
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
Last Modified:              07-06-2006 20:22 CEST
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
 WhereIsTheCloud - 07-02-06 01:35 
----------------------------------------------------------------------
aplay -Dspdif 44khz.wav is the same as the other -D 's.  Output is:
Playing WAVE '44khz.wav' : Signed 16 bit Little Endian, Rate 44100 Hz,
Stereo
but a 48000 PCM signal is sent to the reciever and sound is messed up.

iecset with nothing playing:
Mode: consumer
Data: audio
Rate: 44100 Hz
Copyright: permitted
Emphasis: none
Category: general
Original: 1st generation
Clock: 1000 ppm

While playing 44khz _OR_ 48khz it shows:
Mode: consumer
Data: audio
Rate: 48000 Hz
Copyright: permitted
Emphasis: none
Category: PCM coder
Original: original
Clock: 1000 ppm

Trying "iecset rate 44100", while either wav is playing:
snd_ctl_elem_write: Operation not permitted

----------------------------------------------------------------------
 tiwai - 07-06-06 20:22 
----------------------------------------------------------------------
The rate iecset reports is anyway bogus on hda-intel.  HD-audio codec has
no specific register for SPDIF rate bits.  The corresponding SPDIF bits
should be automatically updated from the actual rate.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-09-06 00:28 WhereIsTheCloudNew Issue                                    
05-09-06 00:28 WhereIsTheCloudDistribution              => Debian          
05-09-06 00:28 WhereIsTheCloudKernel Version            => 2.6.15-1-686-smp
05-09-06 00:31 WhereIsTheCloudNote Added: 0009649                          
06-08-06 05:33 legoguy        Note Added: 0010108                          
06-16-06 19:03 tiwai          Note Added: 0010258                          
06-29-06 18:28 tiwai          Note Added: 0010686                          
07-02-06 01:35 WhereIsTheCloudNote Added: 0010766                          
07-06-06 20:22 tiwai          Note Added: 0010877                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
