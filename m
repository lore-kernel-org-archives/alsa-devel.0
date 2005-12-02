From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001611]: PCM to spdif blocked(any AC95), mic to spdif (in ALC650/655/850)
Date: Fri, 2 Dec 2005 16:49:30 +0100
Message-ID: <385f1b3dc8b5fd56f9ef41241a3d9879@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 156E8160
	for <alsa-devel@alsa-project.org>; Fri,  2 Dec 2005 16:49:31 +0100 (MET)
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


The following issue has been SUBMITTED.
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
Last Modified:              12-02-2005 16:49 CET
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

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-02-05 16:49 psa            New Issue                                    
12-02-05 16:49 psa            File Added: via82xx.c.diff                    
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
