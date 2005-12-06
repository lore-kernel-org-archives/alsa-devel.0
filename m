From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001611]: PCM to spdif blocked(any AC95), mic to spdif (in ALC650/655/850)
Date: Tue, 6 Dec 2005 03:28:14 +0100
Message-ID: <cd5ff181460a4c672ea83ee8dc3fbac8@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E63AA173
	for <alsa-devel@alsa-project.org>; Tue,  6 Dec 2005 03:28:14 +0100 (MET)
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
Last Modified:              12-06-2005 03:28 CET
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
 tiwai - 12-05-05 21:45 
----------------------------------------------------------------------
-> 2: The ALSA PCM name refers to both the route and its content.
For example, "spdif" means the SPDIF I/O and its accepted h/w
configuration (e.g. format, channels - in most cases S16, 2 channel). 
Ditto for "surround51".  It refers to the 5.1 output and its accepted h/w
format.  So, it's not conceptually mutual.

It's software who determines the output to use, indeed, from the system
viewpoint.  We can make the arbitrary output and change the output route
dynamically, but it's a different question.  This is not what the kernel
driver code is involved.  That is, your approach isn't a good solution.

-> 3: Yes, "IEC958 Playback Route" was fixed right now incidentally by
another patch :)

-> 4: Your patch doesn't provide the proper notification to multiple
controls, so the race occurs very easily on a single app.  As said, having
two identical controls with different names is simply bad.  Please don't.

-> 5: I don't understand your statement.  If the codec chip can't set the
proper IEC958 status bits for the given sample rate, you can't use it. 
(And, if ADC is linked to SPDIF, why bother to change the PCM code?)

----------------------------------------------------------------------
 psa - 12-06-05 03:28 
----------------------------------------------------------------------
> 2: The ALSA PCM name refers to both the route and its content.
> For example, "spdif" means the SPDIF I/O and its accepted h/w
configuration
> (e.g. format, channels - in most cases S16, 2 channel). Ditto for
> "surround51". It refers to the 5.1 output and its accepted h/w format.
So,
> it's not conceptually mutual.

Aren't you hard headed. Now tell me please from where do get your
argument. By whos definition SPDIF implies format or slot? It implies only
route, nothing else. Havn't you read the AC97 specs or IEC958 specs? It is
really the contrary to what you say: PCM implies format, SPDIF does not;
it allows all kind of formats and contents; it's just a carrier. As to the
"surround51", it is quite ambiguous as well. It implies content but not
format. It can be 6 channel (3 * PCM slot), AC3 or DTS at least. But since
that call is snd_pcm_open() I assume it means 3 * PCM. How do you open AC3
stream? I can well see that it must be determined befor the driver whether
to use software AC3-decoder or put it trough as such to driver. But even
if it is put to driver it does not yet imply SPDIF. There could be a
hardware decoder on the controller or codec chip (not AC97 though). Then
again it would be the driver to determine what to do with the stream.
There again it would make sense to have a mixer switch to let the human
user to determine final destination.

In my opinion it is for sound producing software to determine the final
output only if the format and content allows no alternatives or if the
software has a human interface to set it. Other wise it must be left to
the mixer. Standard PCM allows alternatives, so why not to leave it to
mixer to route?

> It's software who determines the output to use, indeed, from the system
> viewpoint. We can make the arbitrary output and change the output route
> dynamically, but it's a different question. This is not what the kernel
driver > code is involved. That is, your approach isn't a good solution.

If it is for sound producing software to determine the final destination
of its product, then what are the mixer software for? Indeed what do you
think there are any sound mixers in the world, if not for 'the arbitrary
output and change the output route dynamically'. And if that is not what
the kernel driver code is involved with, then how can the mixer inside the
codec chip be controlled by the user. Isn't the alsamixer there exactly
for doing that trough kernel driver.

Are you really saying, that you have decided, that it is wrong to listen
arbitary sound program, that produces standard stereo PCM, trough my
amplifier that is connected to my computer by SPDIF-cable, even though it
works in practice and comforms with AC97 specs? And how would it
contradict the driver design? It seems to me that the driver and controls
there are designed exactly for that. If not, for what? And what is the
alsamixer for? I would hate to extend this discussion to more complex
mixers (like SB Live!) that has several SPDIF inputs and outputs (and
other inputs and outputs of all kinds). How on earth could the sound
producing software know where the sound is supposed to end up. It would be
possible only if there would be fully fledged mixer as part of every sound
producing software.

Conceptually mixer is a device that can take input (in this case sound
input) from various different sources in various formats as the human user
determines mix them together and route them (and maybe translate their
format) to various output connectors in various formats as determined by
human user. Why pretend that there isn't such capability (albeit limited)
in the hardware (that's what the harware designer has intended it for).

If you have not decided that it is wrong to listen simple internet radio
program or simple CD-player program, that has not a comprehensive mixer as
part of it, trough a spdif cable, then what is your sollution?

-> 4: Your patch doesn't provide the proper notification to multiple
controls,
-> so the race occurs very easily on a single app. As said, having two
-> identical controls with different names is simply bad. Please don't.

Ok, mayby it's bad. But then other sollution must be found. I just wonder
why the notification goes only one way. The code for both in the driver is
exactly the same. Only difference is the name: "Capture Source" vs.
"Playback Analog Source". It must be in the actual alsamixer code since
the latter control appears as standard two channel enum control while the
former has special format of display. My guess is, the capture side code
of the mixer does not react to notification since it has different name,
while the standard enum code somehow recognizes that this is really same
control just with different name.

Any way alternate sollution would be to change alsamixer code. But how
could it know if the codec chip has this capability?

-> 5: I don't understand your statement. If the codec chip can't set the
proper
-> IEC958 status bits for the given sample rate, you can't use it. (And,
if ADC
-> is linked to SPDIF, why bother to change the PCM code?)

Ah, now I get it. Are you talking about the 'Validity bits' in MAX2A and
MX3A? It would be a good idea to use them. But current code does not.
Instead it just puts max and min valus for hw.rate inside
snd_pcm_limit_hw_rates(). No checking of validity bits, at least not
here.

        if (chip->spdif_on && viadev->reg_offset == 0x30) {
                /* DXS#3 and spdif is on */
                runtime->hw.rates = chip->ac97->rates[AC97_RATES_SPDIF];
                snd_pcm_limit_hw_rates(runtime);

The exsample situation I was descriping would not require setting limits
to AC-link/DAC rate, as this code does. I.e code does not allow
AC-link/DAC run 44.1 and ADC/SPDIF-transmitter 48, but forces both to run
48.

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
12-05-05 21:45 tiwai          Note Added: 0006917                          
12-06-05 03:28 psa            Note Added: 0006919                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
