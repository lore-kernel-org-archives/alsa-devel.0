From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000807]: No sound w/ ASRock K7S41GX
Date: Tue, 11 Jan 2005 16:13:19 +0100
Message-ID: <437682c88484b24b3f220002a6b3c0b9@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 856F72D7
	for <alsa-devel@alsa-project.org>; Tue, 11 Jan 2005 16:13:19 +0100 (MET)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=807> 
======================================================================
Reported By:                ndarlow
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   807
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               Gentoo GNU/Linux
Kernel Version:             2.6.10
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             01-11-2005 14:33 CET
Last Modified:              01-11-2005 16:13 CET
======================================================================
Summary:                    No sound w/ ASRock K7S41GX
Description: 
I was able to get sound with alsa-driver upto 1.0.6a on
gentoo-sources-2.4.26 and gentoo-dev-sources-2.6.9 (kernel-bundled ALSA).

With gentoo-dev-sources-2.6.10 (kernel-bundled ALSA) and alsa-driver 1.0.7
I don't get any sound output.

For alsa-driver 1.0.6a, and below, sndstat identified the mixer device as
a C-Media Electronics device id=0x83. For the kernel-bundled ALSA in
gentoo-dev-sources-2.6.10 and alsa-driver 1.0.7 the mixer device is
identified as a CMI9761.

For the working configurations I only had to unmute, and set volume, for
Master and PCM to get sound.

I have tried enabling all outputs, sources and switches on the non-working
configurations with no result. I have also tried ac97_quirk between 0 and
4 without result.

I cannot revert to alsa-driver 1.0.6a as it now fails to compile under
gentoo-dev-sources-2.6.10 so I am willing to undertake any diagnostic work
to make the latest stable build function.
======================================================================

----------------------------------------------------------------------
 ndarlow - 01-11-05 15:50 
----------------------------------------------------------------------
Gentoo has 1.0.8rc1 in masked status but it does work.

You are correct. Master and PCM volume adjustments have no effect and PCM
mute does work.

Interestingly, the Master, PCM, Surround, Center and LFE volumes adopt a
value of 77 after unmuting Master and PCM and restarting alsamixer.

I guess we can mark this one as fixed and close. Master volume must be
adjusted at the speakers, I suppose :-)

----------------------------------------------------------------------
 tiwai - 01-11-05 16:13 
----------------------------------------------------------------------
With ALSA 1.0.8rc2, you can use softvol plugin (and enabled as default).

When you access to "default" PCM, the volume is attenuated in software.
Unfortunately, no proper way to do this in kernel OSS emulation.

Anyway, move this to FIXED.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-11-05 14:33 ndarlow        New Issue                                    
01-11-05 14:33 ndarlow        File Added: asound.state                     
01-11-05 14:33 ndarlow        Distribution              => Gentoo GNU/Linux
01-11-05 14:33 ndarlow        Kernel Version            => 2.6.10          
01-11-05 15:03 tiwai          Note Added: 0003146                          
01-11-05 15:32 tiwai          Note Added: 0003148                          
01-11-05 15:50 ndarlow        Note Added: 0003149                          
01-11-05 16:13 tiwai          Status                   new => resolved     
01-11-05 16:13 tiwai          Resolution               open => fixed       
01-11-05 16:13 tiwai          Assigned To               => tiwai           
01-11-05 16:13 tiwai          Note Added: 0003151                          
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
