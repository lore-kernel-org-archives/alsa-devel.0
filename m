From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000457]: No AC3 via SPDIF possible
Date: Sat, 21 Aug 2004 00:54:57 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040820225457.A77B71102F@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 065BF23E
	for <alsa-devel@alsa-project.org>; Sat, 21 Aug 2004 00:54:57 +0200 (MEST)
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


A BUGNOTE has been added to this bug.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000457
======================================================================
Reported By:                nospam2000
Assigned To:                
======================================================================
Project:                    ALSA - driver
Bug ID:                     457
Category:                   PCI - ens1371
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               Debian SID
Kernel Version:             2.6.6
======================================================================
Date Submitted:             08-20-2004 17:42 CEST
Last Modified:              08-21-2004 00:54 CEST
======================================================================
Summary:                    No AC3 via SPDIF possible
Description: 
I have a onboard ES1371 soundcard with SPDIF output. It works fine with the
ALSA driver for analog and PCM output, even over SPDIF, but it is
impossible to play AC3 sound over the SPDIF output. Only a clicking noise
comes out of my speakers when I try this.

The problem is, that the raw data is modified by the sound chip and not
passed 1:1 to the SPDIF output. To get correct AC3 playback, the mixer and
the sample rate converter have to be bypassed. This means that
additionally to the bit ES_1373_SPDIF_THRU the bits ES_1373_RECEN_B and
ES_1373_BYPASS_P1/ES_1373_BYPASS_P2 have to be set to make AC3 playback
work.

======================================================================

----------------------------------------------------------------------
 tiwai - 08-20-2004 18:13 CEST 
----------------------------------------------------------------------
It's better to check the non-audio bit in the IEC958 status controls.
Does the attached patch work?

----------------------------------------------------------------------
 nospam2000 - 08-21-2004 00:54 CEST 
----------------------------------------------------------------------
Your original patch didn't work. The only problem was the "!" in
"!(ensoniq->ctrl & ES_1373_SPDIF_THRU)" (actually the flag is named wrong,
its name should be ES_1373_SPDIF_THRU_DISABLE).

I modified it to get it working and uploaded ens1371-ac3-fix_002.dif which
has some more mostly cosmetic changes. The flag ES_1373_RECEN_B is not
needed, but I noticed this too late, just after uploading the new patch.

In my opinion it is totally correct to disable the sample rate converter
when the bit IEC958_AES0_NONAUDIO is set in the channel status, but this
is not the only reason. It also makes sense to disable it for correct 1:1
playback of PCM data (e.g. directly from a audio CD).

Actually I don't see the reason why it should not always be set when SPDIF
is enabled and when the samplerate is 48 kHz. For me the mixer doesn't
work in any case for the SPDIF output and analog inputs, that means I
don't get the signal from "line in" at the SPDIF output regardless of the
settings.

Another point: Non audio data should not be output via the analog output.
When I play AC3, I have to mute "PCM" in the mixer to avoid noise on my TV
speakers. This could be done automatically.

I know it's hard to keep compatibility and not to break existing use cases
:-)

Bug History
Date Modified  Username       Field                    Change              
======================================================================
08-20-04 17:42 nospam2000     New Bug                                      
08-20-04 17:42 nospam2000     File Added: alsa_ens1371_ac3_003.diff                    
08-20-04 17:42 nospam2000     Distribution              => Debian SID      
08-20-04 17:42 nospam2000     Kernel Version            => 2.6.6           
08-20-04 17:51 nospam2000     Bug Monitored: nospam2000                    
08-20-04 18:13 tiwai          Bugnote Added: 0001601                       
08-20-04 18:13 tiwai          File Added: ens1371-ac3-fix.dif                    
08-21-04 00:01 nospam2000     File Added: ens1371-ac3-fix_002.dif                    
08-21-04 00:54 nospam2000     Bugnote Added: 0001602                       
======================================================================


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
