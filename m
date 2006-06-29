From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002108]: snd-hda-intel: Can only play
	48000Hz via digital out. 44100 is garbled.
Date: Thu, 29 Jun 2006 18:28:34 +0200
Message-ID: <3a9ccb6eee5587740075caa613489d6c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E58D42A0
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Jun 2006 18:28:34 +0200 (MEST)
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
Last Modified:              06-29-2006 18:28 CEST
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
 tiwai - 06-16-06 19:03 
----------------------------------------------------------------------
Don't mix up this with audigy.  It's a totally different problem.  Emu10k1
seems to have a hardware problem for non-48k samples.

The driver *does* support other rates.  The fact that the rate is fixed to
48k is due to the default configuration of alsa-lib.  If you want to use
another rate, you can change the configuration.

----------------------------------------------------------------------
 tiwai - 06-29-06 18:28 
----------------------------------------------------------------------
What happens if you run "aplay -Dspdif 44khz.wav" ?

We may need to change SPDIF status bits appropriately.  Try iecset program
to change the rate to 44100, too.

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
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
