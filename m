From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001611]: PCM to spdif blocked(any AC95), mic to spdif (in ALC650/655/850)
Date: Mon, 5 Dec 2005 21:15:04 +0100
Message-ID: <d9e9a898c3c91c5b4c221f62721cb3f6@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 54B27186
	for <alsa-devel@alsa-project.org>; Mon,  5 Dec 2005 21:15:05 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1611> 
======================================================================
Reported By:                psa
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1611
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             12-02-2005 16:49 CET
Last Modified:              12-05-2005 21:15 CET
======================================================================
Summary:                    PCM to spdif blocked(any AC95), mic to spdif (in
ALC650/655/850)
Description: 
After transition 1.0.9b -> 1.0.10 PCM output (or 'Analig In', if ADC ->
spdif supported) can't be directed to spdif output. Caused by a feature
bug in via82xx-driver. Driver now enables spdif out only if IEC958
Playback AC97-SPSA dxs3 (slot 10/11 reserved for non PCM like ac3) is
selected. This is obviously done with the assumtion that if user program
wants to send something to spdif it uses dxs3 and/or with the assumption
that only non PCM strams can be directed to spdif port. However both of
these assumtions are too restrictive. Even further these assumprions
ignore the fact that several ac97 chips (like ALC650) can direct ADC
output (originaly intended for capture) to spdif output; and some chips
(e.g. ALC655/850) can direct spdif input directly to spdif output.

However many ordinary sound programs (like internet radio) have no control
on which dxs they direct their output. They put PCM (stereo or prologic)
to standard stereo output which is dxs0 (slot 3/4). In the other end of
the spdif cable there can be all kind of hardware, including amplifiers
that can take several formats including standard PCM. In makes perfect
sense to direct dxs0 to such spdif devices. Also since, although slots
have certain standard usages, user software is free to use them as they
wish, there is no reason to restrict the slot selection.

In addition dxs selection is of no relevance when spdif out signal is
taken from ADC or spdif input. Yet it should be possible to enable spdif
output.

The first restriction is implemented in the code in pci/via82xx.c in
snd_via8233_playback_prepare():

        if (chip->spdif_on && viadev->reg_offset == 0x30)
                snd_ac97_set_rate(chip->ac97, AC97_SPDIF, runtime->rate);

where reg_offset 0x30 is the offset of DXS3. snd_ac97_set_rate() again is
the place (only place as far as I can see) spdif output is enabled. The
second restriction is implemeted by the fact that 'IEC958 Output'-swicth
does not enable spdif output. It only  sets '->spdif_on'. This all means
that spdif output is anabled only if user software is started with
spdif_on set (by 'IEC958 Output'-swicth). E.g can't do the following: Set
'Capture Source' select to Mic, redirect ADC (Analog In) to spdif output,
set 'IEC958 Output'-swicth (, select DXS0). Now you should here microphone
trouhg you external amplifier connected by spdif even if no software is
running. No can do.

Suggested fix:

The first restriction is simply removed by removin the second condition in
the if-statement:

        if (chip->spdif_on)
                snd_ac97_set_rate(chip->ac97, AC97_SPDIF, runtime->rate);

The second restriction is removed by adding to
snd_via8233_dxs3_spdif_put() enbaling/disabling spdif output.

In addition it suggested that in case ac97 chip supports directing ADC to
spdif output (like ALC650/655/850), in pci/ac97/ac97_patch.c in
appropriate *_patch a ADC source select is added on the playback side
(kind of duplicating 'Capture Source') since this select is used also to
select spdif output in case ADC is directed to spdif output, and is thus a
'playback'-mixer-control.

Diffs are included. Note that snd_via8233_dxs3_spdif_*:s have been changed
to snd_via8233_spdif_*:s since they are no more specific to dxs3. There is
also a diff for adding the mixer control descriped above for ALC850 as an
exsample.

In setting available for me everything seems to work fine above
restrictions removed.

via82xx diff enclosed.

ac97_patch diff:
-----------------------------------------------------------------------------

*** pci/ac97/ac97_patch.c.myorg Thu Nov 24 19:22:05 2005
--- pci/ac97/ac97_patch.c       Sun Nov 27 23:22:48 2005
***************
*** 2106,2111 ****
--- 2106,2115 ----
                                     0);
  }

+ static const char *alc655_rec_sel[] = { "Mic", "CD", "Mute", "Aux",
"Line", "Mix", "Mono Mix", "Phone"};
+
+ static const struct ac97_enum alc655_enum =
AC97_ENUM_DOUBLE(AC97_REC_SEL, 8,
0, 8, alc655_rec_sel);
+
  static const snd_kcontrol_new_t snd_ac97_spdif_controls_alc655[] = {
          AC97_PAGE_SINGLE(SNDRV_CTL_NAME_IEC958("",CAPTURE,SWITCH),
AC97_ALC650_MULTICH, 11, 1, 0, 0),
        /* disable this controls since it doesn't work as expected */
***************
*** 2117,2122 ****
--- 2121,2127 ----
                .get    = alc655_iec958_route_get,
                .put    = alc655_iec958_route_put,
        },
+       AC97_ENUM(SNDRV_CTL_NAME_IEC958("Analog ",PLAYBACK,NONE),
alc655_enum),
  };

  static int patch_alc655_specific(ac97_t * ac97)
---------------------------------------------------------------------------



======================================================================

----------------------------------------------------------------------
 tiwai - 12-05-05 12:02 
----------------------------------------------------------------------
-> 1: The latest version is ALSA CVS tree.

-> 2: It's PCM name from ALSA point of view, i.e. the string argument to
be used in snd_pcm_open().  There are some standard names like "default",
"spdif", "surround51".  The apps are supposed to use these standard names
as much as possible.  In the case of via82xx, "spdif" PCM is provided to
choose DXS3.

-> 3: "IEC958 Playback Switch" is created in ac97_codec.c while "IEC958
Output Switch" is created in via82xx.c.  I know it doesn't make much sense
to have both, though.

-> 4: But still you shouldn't have multiple controls for the very same
thing.  They conflict with each other.  What if happens if you change one
of them while you keep setting a different value to another?  It's a
race.

-> 5: I see these reasons.  But, as long as the IEC958 status bits on ac97
codec doesn't accept the specified sample rates, we can't use other
rates...

----------------------------------------------------------------------
 psa - 12-05-05 21:15 
----------------------------------------------------------------------
-> 1: The latest version is ALSA CVS tree.

Ok, will use it.

-> 2: It's PCM name from ALSA point of view, i.e. the string argument to
be
-> used in snd_pcm_open(). There are some standard names like "default",
-> "spdif", "surround51". The apps are supposed to use these standard
names as
-> much as possible. In the case of via82xx, "spdif" PCM is provided to
choose
-> DXS3.

What do they mean conceptually? ALSA Documentation is not exactly helpfull
here.
They seem to be mutually incompatible: "spdif" refers to playback route,
not to the type of content, whereas "surround51" refers to the type of
content, not neccessarily to the route. As can be seen from the AC97
specs, in case the codec chip has spdif output, it must provide posibility
to play back PCM simultaneusly through mixer and spdif. The software is
not suppose to make such choices, it is the 'human user' via a mixer. Ac97
2.3:

 All S/PDIF capable Primary Codecs must be configurable to accept 48 kHz
PCM
 data on AC-link slots 3&4 for DA conversion and concurrent S/PDIF
transmission. 

So statement 'SPDIF output is supposed to be "spdif" PCM' is not correct
if it implies that 'PCM output is supposed to go to SPDIF output only if
software specifies directly or indirectly spdif and/or dxs3'. It might be
correct to say that '"spdif" PCM is supposed to go to SPDIF output through
dxs3, "default" stereo PCM is supposed to go through dxs0, depending mixer
settings, to DAC and/or SPDIF output'. Could we agree on this?

-> 3: "IEC958 Playback Switch" is created in ac97_codec.c while "IEC958
Output
-> Switch" is created in via82xx.c. I know it doesn't make much sense to
have
-> both, though.

Ok, you're right there. I wasn't aware of the two switches. In the mixer I
could see only "IEC958 Output Switch". In ac97_patch.c ALC655(850)-code
there is a selector called "IEC958 Playback Route". For reasons I have had
no time to study, the mixer code (both amixer and alsamixer) ignores the
"Route" part (I assume it has reserved meaning in the mixer code like
"Switch"). So mixer took this selector as "IEC958 Playback" and
disrecarded the "IEC958 Playback Switch".

Once I changed "IEC958 Playback Route" to "IEC958 Playback Source", which
is better name anyway, I could see both switches in the mixer. So that
takes some of my complaints away. I can manually enable spdif output
recardless the slot (dxs). I can make my internet radio and mic to work.
The diff:
-----------------------------------------------------------------
org ac97_patch.c
--- ac97_patch.c.myorg  2005-12-05 18:09:49.000000000 +0200
+++ ac97_patch.c        2005-12-05 18:12:45.000000000 +0200
@@ -2116,7 +2116,7 @@
         /* AC97_PAGE_SINGLE("IEC958 Input Monitor", AC97_ALC650_MULTICH,
14, 1, 0, 0), */
        {
                .iface  = SNDRV_CTL_ELEM_IFACE_MIXER,
-               .name   = SNDRV_CTL_NAME_IEC958("",PLAYBACK,NONE)
"Route",
+               .name   = SNDRV_CTL_NAME_IEC958("",PLAYBACK,NONE)
"Source",
                .info   = alc655_iec958_route_info,
                .get    = alc655_iec958_route_get,
                .put    = alc655_iec958_route_put,
--------------------------------------------------------------------------
Is there any reason not to change the name? If not this fixes an obvius
bug.

However the real question now, as you pointed out, is the two similar
switches. I don't have VT8237(R) Datasheet available, but it seems that
the purpose of the "IEC958 Output Switch" (besides toggling spdif_on) is
to enable/disable spdif in a VIA-register. In my enviroment that seems to
have no effect whatsoever (whether using slot 3/4 or 10/11, PCM or AC3).
What is it supposed to do? And shouldn't it rather be the "IEC958 Playback
Switch" that toggles spdif_on?

If these both switches are really needed, it is somewhat a challange to
ALSA achitechture. There is no natural connection between the controller
chip code (via82xx.c in this case) and codec chip code (e.e. ALC850).

In any case again from "human mixer user" point of view there should be
only one switch to take care of both the VIA-settings and AC97 codec
settings for enabling/disabling spdif. A way to code it should be figured
out. Can we agree on this?

-> 4: But still you shouldn't have multiple controls for the very same
thing.
-> They conflict with each other. What if happens if you change one of
them
-> while you keep setting a different value to another? It's a race.

Yes, there is no protection against such race in the code (except: on AC97
codec register level there are appropriate locks). But same problem arises
if e.g. two user level mixer softwares are setting the same switch at the
same time. Actually in some AC97 code lock's are used (e.g. in
snd_ac97_put_spsa()). up()s and down()s could/should be added if needed.

There is an other thing though. If I change value in Capture page also the
new selector on the Playback page changes, but not the other way round. I
will look if there is a way to remove this problem.

-> 5: I see these reasons. But, as long as the IEC958 status bits on ac97
codec
-> doesn't accept the specified sample rates, we can't use other rates...

In current code yes. But code could be enhanced there: E.g. assume we have
hardware where AC-link/DAC supports 44.1/48 kHz, DAC and ADC have
independent rates, spdif transmitter supports only 48 kHz (MX3A,
rates[AC97_RATES_SPDIF]). Then following is possible: internal analog
mixer is connected to ADC, ADC is connected to spdif tramsmitter, ADC is
set to 48, but AC-link/DAC is still set to 44.1. Totally leagal and
functioning setup (enabling listening CD:s without software up-sampling
trough 48 kHz spdif). But current code does not support it. In reality the
hw.rate is not univalued concept. In above exsample there would be no
reason to limit the AC-link/DAC rate to 48 kHz as current code does. (This
discussion does not actually belong at all under this title, but is
completely different discussion on the potential further development of
the AC97 driver.)

No new diff attached till above issues are cleared.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-02-05 16:49 psa            New Issue                                    
12-02-05 16:49 psa            File Added: via82xx.c.diff                    
12-02-05 16:51 psa            File Added: ac97_patch.c.diff                    
12-02-05 17:39 tiwai          Note Added: 0006897                          
12-03-05 19:07 psa            File Added: via82xx.c.udiff                    
12-03-05 19:08 psa            File Added: ac97_patch.c.udiff                    
12-03-05 21:18 psa            Note Added: 0006903                          
12-05-05 12:02 tiwai          Note Added: 0006910                          
12-05-05 21:15 psa            Note Added: 0006916                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
