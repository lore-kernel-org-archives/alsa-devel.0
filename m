From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000457]: No AC3 via SPDIF possible
Date: Thu, 26 Aug 2004 17:59:15 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040826155915.D8DEC24006@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 2119D280
	for <alsa-devel@alsa-project.org>; Thu, 26 Aug 2004 17:59:16 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000457
======================================================================
Reported By:                nospam2000
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     457
Category:                   PCI - ens1371
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     resolved
Distribution:               Debian SID
Kernel Version:             2.6.6
Resolution:                 fixed
======================================================================
Date Submitted:             08-20-2004 17:42 CEST
Last Modified:              08-26-2004 17:59 CEST
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

----------------------------------------------------------------------
 tiwai - 08-23-2004 15:46 CEST 
----------------------------------------------------------------------
I think BYPASS_P1 suffices (P2 isn't used for SPDIF out), right?

Dsabling SRC for 48k would be fine.  This doesn't break compatibility.
Does non-48k SPDIF work?  If yes, we can disable SRC always for SPDIF
output at any rate.

Also, disabling the PCM output can be put into iec958 plug hook
in /usr/share/alsa/cards/ENS1371.conf.  The disadvantage is that
PCM is always disabled regardless of audio or non-audio SPDIF.

Auto-muting in the driver is doable (e.g. cmipci driver does it),
but it results in more codes.

----------------------------------------------------------------------
 nospam2000 - 08-25-2004 04:55 CEST 
----------------------------------------------------------------------
> I think BYPASS_P1 suffices (P2 isn't used for SPDIF out), right?

Yes, that's correct.

 > Does non-48k SPDIF work? If yes, we can disable SRC
 > always for SPDIF output at any rate.

Good question. According to the documentation which I have (Preliminary
ENSONIQ AudioPCI™ 97 ES1373 Specification), the only supported samplerate
for SPDIF is 48 kHz.

I played a song using 44.1 kHz PCM with mplayer:
mplayer -ao alsa1x:spdif -vo null -rawaudio on:rate=44100:format=0x1
/video/track01.raw

Without SRC, it sounds horrible (I think a lot of frames are just dropped
which results in a high frequency noise), so SRC is needed for any
samplerate but 48kHz. With 48kHz I couldn't hardly hear a difference
with/without SRC (without the volume seemed to be slightly higher).

Setting the SPDIF datarate to 44.1 kHz using iecset had no effect.

To put it together:
1. for 48kHz it seems safe to disable SRC. This is sufficient for AC3
playback and should not have any side effects to PCM playback. (in
general: if the input samplerate equals the output datarate for SPDIF and
this datarate is fixed at 48 kHz).

2. for any other samplerate, the SRC must be enabled (as it is today)

----------------------------------------------------------------------
 tiwai - 08-25-2004 11:10 CEST 
----------------------------------------------------------------------
Ok, then the attached simple patch (ens1371-fix-src.dif) should fix
this problem.  Could you check it?

----------------------------------------------------------------------
 nospam2000 - 08-25-2004 21:26 CEST 
----------------------------------------------------------------------
Great, works as expected :-)

Testcases:
1. AC3 48 kHz samplerate via SPDIF (datarate 48 kHz) -> OK
2. AC3 44.1 kHz samplerate via SPDIF (datarate 48 kHz) -> not tested(see
below)
3. PCM 48 kHz samplerate via SPDIF (datarate 48 kHz)-> OK
4. PCM 44.1 kHz samplerate via SPDIF (datarate 48 kHz) -> OK
5. PCM 48 kHz samplerate via analog output-> OK
6. PCM 44.1 kHz samplerate via analog output -> OK

I have no AC3 testfiles with samplerates of 44.1 kHz, so I was unable to
test case 2. Googles says, that there are some AC3 file at
http://www.diatonis.com/downloads_dts_ac3.html but i cannot reach that
server at the moment.

Can you think of any other test cases?

edited on: 08-25-04 21:26

----------------------------------------------------------------------
 tiwai - 08-26-2004 17:59 CEST 
----------------------------------------------------------------------
No, but I believe it won't work except for 48k.

Anyway, the patch is already on cvs, and I close now this bug.

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
08-23-04 15:46 tiwai          Bugnote Added: 0001613                       
08-25-04 04:55 nospam2000     Bugnote Added: 0001617                       
08-25-04 11:10 tiwai          Bugnote Added: 0001620                       
08-25-04 11:11 tiwai          File Added: ens1371-fix-src.dif                    
08-25-04 21:25 nospam2000     Bugnote Added: 0001627                       
08-25-04 21:26 nospam2000     Bugnote Edited: 0001627                      
08-26-04 17:59 tiwai          Bugnote Added: 0001633                       
08-26-04 17:59 tiwai          Assigned To               => tiwai           
08-26-04 17:59 tiwai          Resolution               open => fixed       
08-26-04 17:59 tiwai          Status                   new => resolved     
======================================================================


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
