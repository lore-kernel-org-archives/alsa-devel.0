From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001611]: PCM to spdif blocked(any AC95), mic to spdif (in ALC650/655/850)
Date: Mon, 5 Dec 2005 12:02:52 +0100
Message-ID: <aaac9e9527b8f705a61bc9a9de75d86b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 17A7015D
	for <alsa-devel@alsa-project.org>; Mon,  5 Dec 2005 12:02:52 +0100 (MET)
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
Last Modified:              12-05-2005 12:02 CET
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
 psa - 12-03-05 21:18 
----------------------------------------------------------------------
> 1. Please make a unified diff against the latest ALSA version.

Ok. Which is latest, alsa-1.0.10 or kernel-2.6.14.2? These diffs are
against 1.0.10. (Diffs are on two diffent files since they are not
technicly dependent on each outher.)

> 2. Note that the SPDIF output is supposed to be "spdif" PCM. If this PCM
is
> selected, the dxs 3 is selected automagically. Output to SPDIF though
the
> default PCM is a side-effect, and not guaranteed to work always.

There is no separate PCM format such as "spdif" PCM (unless you mean PCM
encapsulated in accordance of IEC958 Consumer encapsulation and electric
specs in spdif transmitter for the spdif cable, which has nothing to do
with this discussion). What is used in these ordinary consumer audio
products is raw (mono or stereo or prologic) 'Linear PCM' (other formats
like A-law are used for cordless connections, like phone). There is no
such basis for restricting the AC-link slot for spdif output to slot 10/11
(dxs3) only. On the contrary that would be against the AC97 specs.

>From AC97 2.3 specs:

 There are two principal sources of audio data to consider:
   &#183; "Mixed" data originating from the OS mixer service. This data is
typically
     stereo PCM format and passed on AC-link slots 3&4. Requirement
5.10.1.1
     below ensures 48 kHz OS mixer output on AC-link slots 3&4 can be
routed to
     both DAC and S/PDIF transmitter. Option 5.10.2.1 below expands
support to
     8-48 kHz OS mixer output.
   &#183; "Pass-thru" data originating from an "independent S/PDIF
source". This
     data can be PCM, AC-3**, MPEG, DTS, or other format, and is
typically
     passed on AC-link slots 7&8 in 2-ch systems, AC-link slots 6&9 in
4-ch
     systems, and AC-link slots 10&11 in 6-ch systems. The sample rate of
     "independent S/PDIF source" data passed across AC-link must match
the
     programmed SPSR (typically 48 kHz). Requirements 5.10.1.21 through
     5.10.1.4 ensure availability of independent AC-link slot allocation
for
     "pass-thru" data.

And further concerning register MX2A:

 Bits D5-D4, SPSA[1:0], are read/write bits that control the S/PDIF
AC-link
 Slot Assignment. Support for slots 3&4, 7&8, and 6&9 is required, and
10&11 is
 also recommended.

So, as you can see, opposite to what you said, 3/4 (dxs0) must work, 10/11
(dxs3) is optional. If ALSA specs limit spdif dxs:s then ALSA is not AC97
compatible.

Also from practical point of view, typical linux audio software has no way
to select dxs (and no need or reason either) in case it uses only standard
stereo (or prologic) PCM. Nor is there such basis, need or reason for ALSA
library. It is really for the user trough mixer software to control
whether he wants to listen it trough analog or digital interface (or both,
as you can find from the AC97 spec). E.g without the above fixes I can't
listen to my internet radio (only spdif connected to the amplifier; and if
I put it trough the codec's analog mixer I loose prologic).

BTW. in ALC850 10/11 is also directed to the DAC for the back rear
surround channles (there is currently in ALSA no support for 8 channels
though).

> 3. It's wrong to toggle AC97 register bit in spdif_put callback. It
conflicts > with "IEC958 Playback Switch".

Now you lost me there. The (dxs3)_spdif_put() is the very put-function for
"IEC958 Playback Switch". Where is the contradiction?

There must be a way to enable spdif output even if there is no user audio
program running. E.g without that fix I can't hear my Mic in my speakers.

> 4. "IEC958 Analog Playback" is nonsense. It's identical with "Capture
Source"
> control.

Yes, as I said, it is identical from technical poit of view, but not from
conceptual point of view. For an ordinary user it is difficult to
understand that he has to change recording settings in order to hear from
the speakers what he wants. Techies have tendency to make user interfaces
purely from technical point of view, but user point of view must also be
accorded. Here (in case the of spdif output) the user point of view is
that this is a playback setting, thus it should appear in mixer as such.
E.g. in alsamixer "Playback" and "Capture" are on separate pages.

It could be argued that this feature should be in the user space mixer
software, not in driver mixer software. However in current ALSA
architechture only driver can know whether this control is relevant with
the codec chip in question.

> 5. It's correct to restrict the output sample rates to
> chip->ac97->rates[AC97_RATES_SPDIF] because the IEC958 itself supports
only
> limited sample rates (regardless what source you use).

There are no changes to the code in the diffs in this respect. The "FIXME"
comment I admid is not very clear. However there are reasons for it. It is
a reminder of following things.

In many codec chips it is possible to direct spdif input directly to spdif
output (like ALC850). In that case AC-link input sample rate is of no
relevance, it is the spdif input sample rate that should be restricted.

This is also connected to a larger issue of sample rates in an audio
system. AC97 (2.2/2.3) spec is very vague in this. It allows SRC:s in all
possible places. There can be SRC:s in both the controller and the codec
chip. So there can be SRC(s) in between the CPU and AC-link, there can be
an SRC in between the AC-link and the DAC, in between the AC-link and
spdif transmitter, in between the ADC and AC-link, in between the ADC and
spdif transmitter, etc. It's a real mess.

So, e.g. it could be the is an automatic SRC in between AC-link and spdif
output but not in betbeen ADC and spdif output, making above rate control
much more complex.
 
Eventually ALSA should accomodate all those combinations. "FIXME" is
really a reminder of that.

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
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
