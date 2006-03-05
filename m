From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001161]: Midi in still does not work for Hoontech/STAudio DSP2000 C-Port
Date: Sun, 5 Mar 2006 13:22:18 +0100
Message-ID: <b071cdecd47f677647e678feabb927e4@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A4AE6176
	for <alsa-devel@alsa-project.org>; Sun,  5 Mar 2006 13:22:18 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1161> 
======================================================================
Reported By:                vandongen2
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1161
Category:                   PCI - ice1712
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               linux from scratch
Kernel Version:             2.6.12-rc4-RT-V0.7.47-03
======================================================================
Date Submitted:             06-06-2005 15:29 CEST
Last Modified:              03-05-2006 13:22 CET
======================================================================
Summary:                    Midi in still does not work for Hoontech/STAudio
DSP2000 C-Port
Description: 
As reported before in bug 000055 that is now marked resolved.
It has not been resolved.
The problem seems to be related to hardware specific registers on the card
that need to be set.

I will be happy to spend a couple of days trying different flags/bits with
the initialisation code, if somebody gives me an idea of where to start.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0000055 Midi in does not work for Hoontech/STAu...
======================================================================

----------------------------------------------------------------------
 vandongen2 - 06-17-05 11:13 
----------------------------------------------------------------------
The patch doesn't change anything as far as I can tell.

----------------------------------------------------------------------
 sbahling - 03-05-06 13:22 
----------------------------------------------------------------------
I can't speak for the DSP24 card, but I have a mkII version and once I
traced out the logic on the board. I recall that INSEL and DAREAR signal
went no where. They clock-in on a latch, but those outputs of the latch
are not connected to anything. Also, I found that the MUTE signal was
inversed, so I have to patch hoontech.c to MUTE my inputs to turn them on
(for my ADCIII box).

To get MIDI_IN to work on my ADCIII (not sure if this works on c-port), I
need the following part of my default hoontech patch:

-   for (box = 0; box < 4; box++) {
+   for (box = 1; box < 2; box++) {

I'm using midi in on a box addressed as box 1. This patch is obviously not
addressing the root issue, but it works for me. Maybe it gives clue to
someone who knows the code better. It seems like there is some global
signal that is clearing the settings so if I do not limit this loop to the
my box, it gets cleared again when addressing the next.

My hoontech patch:

Index: hoontech.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/ice1712/hoontech.c,v
retrieving revision 1.10
diff -u -r1.10 hoontech.c
--- hoontech.c  16 Jan 2006 16:34:25 -0000  1.10
+++ hoontech.c  5 Mar 2006 12:04:24 -0000
@@ -190,23 +190,23 @@
    ICE1712_STDSP24_3_INSEL(ice->spec.hoontech.boxbits, 0);

    /* let's go - activate only functions in first box */
-   ice->spec.hoontech.config = 0;
-               /* ICE1712_STDSP24_MUTE |
-                  ICE1712_STDSP24_INSEL |
-                  ICE1712_STDSP24_DAREAR; */
-   ice->spec.hoontech.boxconfig[0] = ICE1712_STDSP24_BOX_CHN1 |
+   /* need to set MUTE flag to un-mute ADCIII */
+   ice->spec.hoontech.config = ICE1712_STDSP24_MUTE;
+                   /*ICE1712_STDSP24_INSEL |*/
+                  /*ICE1712_STDSP24_DAREAR; */
+   ice->spec.hoontech.boxconfig[0] =
+   ice->spec.hoontech.boxconfig[1] =
+   ice->spec.hoontech.boxconfig[2] =
+   ice->spec.hoontech.boxconfig[3] = ICE1712_STDSP24_BOX_CHN1 |
                     ICE1712_STDSP24_BOX_CHN2 |
                     ICE1712_STDSP24_BOX_CHN3 |
                     ICE1712_STDSP24_BOX_CHN4 |
                     ICE1712_STDSP24_BOX_MIDI1 |
                     ICE1712_STDSP24_BOX_MIDI2;
-   ice->spec.hoontech.boxconfig[1] =
-   ice->spec.hoontech.boxconfig[2] =
-   ice->spec.hoontech.boxconfig[3] = 0;    
snd_ice1712_stdsp24_darear(ice, (ice->spec.hoontech.config &
ICE1712_STDSP24_DAREAR) ? 1 : 0);     snd_ice1712_stdsp24_mute(ice,
(ice->spec.hoontech.config & ICE1712_STDSP24_MUTE) ? 1 : 0);    
snd_ice1712_stdsp24_insel(ice, (ice->spec.hoontech.config &
ICE1712_STDSP24_INSEL) ? 1 : 0);
-   for (box = 0; box < 4; box++) {
+   for (box = 1; box < 2; box++) {
        for (chn = 0; chn < 4; chn++)            
snd_ice1712_stdsp24_box_channel(ice, box, chn,
(ice->spec.hoontech.boxconfig[box] & (1 << chn)) ? 1 : 0);
        snd_ice1712_stdsp24_box_midi(ice, box,

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-06-05 15:29 vandongen2     New Issue                                    
06-06-05 15:29 vandongen2     Distribution              => linux from scratch
06-06-05 15:29 vandongen2     Kernel Version            =>
2.6.12-rc4-RT-V0.7.47-03
06-07-05 08:24 perex          Relationship added       related to 0000055  
06-16-05 14:54 perex          Note Added: 0005055                          
06-17-05 11:13 vandongen2     Note Added: 0005066                          
03-05-06 13:22 sbahling       Note Added: 0008357                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
