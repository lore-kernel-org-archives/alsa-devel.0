From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001611]: PCM to spdif blocked(any AC95), mic to spdif (in ALC650/655/850)
Date: Fri, 13 Jan 2006 01:09:51 +0100
Message-ID: <d60e0d453e1269971166a3b0b4d4c8db@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 482B713A
	for <alsa-devel@alsa-project.org>; Fri, 13 Jan 2006 01:09:51 +0100 (MET)
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
Last Modified:              01-13-2006 01:09 CET
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
 psa - 12-09-05 00:15 
----------------------------------------------------------------------
> Please read my comment carefully before emotional reaction.

Sorry if seemd emotional or personal!

> "spdif" PCM implies the I/O from/to SPDIF _and_ the formats accepted by
> _hardware_. In your case, it's S16_LE 2channels. It's quite hardware
specific, 
> not per SPDIF definition. Ditto for "surround51". It routes to analog
5.1
> outputs _and_ restricts the hardware configuration that the hardware
accepts.
> OK? (Also, I didn't mention about slots anywhere.)

> It's fine to allow the SPDIF-output with the "default" PCM output. But,
it's
> not mandatory. Instead, "spdif" PCM assures to output to SPDIF even
with
> non-audio data. For the "default" PCM, usually the concurrent access/mix
is
> allowed, so it's not suitable for non-audio data.

Hm! So only situation for a software to use "spdif" would be when it's not
stuff suitable for a DAC. Is that correct? If so that's exactly what my
complaint was about: "spdif" is wrong name for this, because it does not
imply non-audio (I assume you mean non audio PCM), "nonaudio" would be
much better. Is "spdif" used with ac3? The point is that hardware might
have many other ways to deal with non-audio-PCM than spdif output (e.g
build in decoder).

> About the mixer: You think obviously that the sound system consists of
only a
> kernel driver. No, we have a user-space layer to mangle many things. The
mixer 
> is indeed a part of alsa-lib stuff.

No! It would be nice though to have fully fledged software mixer that
would normally reside between any sound producing software and kernel.
However it should be optional systems setting. But as far I know that is
not currently part of ALSA architechture. Or is there such software? I
guess it would have two parts, controls inside the alsa-library that would
notify mixer (like alsamixer) the same way as driver, and the driver.
Still it would be silly not to use to the full the cababilities offered by
the hardware (through the driver) even in such a setting.

> About the SPDIF output sample rate: It's PRSR bits of register 3A.
You'll find 
> that only limited sample rates are available for SPIDF out with AC97
codecs.

I assume you mean SPSR. That is the rate(s) accepted by spdif transmitter.
This is totally besides the poin I was making! I was suggesting using MX2A
VCFG, SPCV and MX3A 15:0.

> Anyway, the further argument is pretty useless. Let's stop it. If you
want to > continue, please post it to alsa-devel ML instead of the bug
report.

How do I do that? Can you answer by e-mail?
Point has not been to argue, but understand what you mean. Hopefully you
have tryed to understand what I mean.

> Now, let's revise the possible improvements.
> For the SPDIF output on VIA823x, we have the following capabilities:

> - DXS3 dedicated for SPDIF

>  The merit is that you can play still 3 DXS analog streams
independently
> without signal mix. That is, you can avoid dmix and still use SPDIF
safely
> even with non-audio data. The demerit is that DXS output is fixed to
48kHz
> (it does SRC by itself). (So, basically, it's a bug to call
> snd_ac97_set_rate(AC97_SPDIF) in snd_via8233_playback_rate. It has to
be
> fixed...)

This is true up to 6 channel PCM, but not in 8 channel (supported by
ALC850).

>  We can set SPDIF slots 3&4 as default for the concurrent output, and
disable > DXS3 unless the "spdif" PCM is opened. The slot assigment can be
then changed > automatically to 10&11 when "spdif" PCM is opened (via
VIA8233.conf).

Again must somehow accord 8 channel output where 10&11 is used for back
surround.

> - Multi-channel stream for both analog and SPDIF with slot 3&4
>
>  The merit is that it allows you non-48k (32k and 44.1k), too. However,
> multi-channel stream is exclusive. That is, no DXS is possible. In
addition,
> we'll need a mechanism to shut up the analog output automatically in the
case
> of non-audio data by checking the SPDIF status bits.

Here I might be ignorant, but doesn't multi-channel mean using more than
one slot pair for more than two channels? And what I have understood of
the AC97 specs, rate can be set separately for each slot pair (provided
codec chip supports it). Why wouldn't it be possible to have let's say 6
channel audio through slots 3&4, 7&8, 6&9 with 44.1 to DACs, while putting
10&11 to spdif with 48. And as far as I understand you can put only one
slot pair to spdif transmitter. Though I have used for testing a setting
where in 6 channel mode surround channels were direceted to spdif (and
it's not totally unthinkable that in 4 channel mode analog output is used
for front speakers and spdif output for surround speakers ;-)

I guess here we hit the rate mess inherent in the AC97 specs. In that I
see two possible strategies:

1. when initializing the hardware, all the possible compinations mapped
somehow. This map is then used to limit what user can do whit
first-come-firs-seved pronciple.

2. Every time there is an attemted to change a rate or routing, it is
tested whether the resulting configutation is allowed. If not change is
denied.

Also I think the the ioctl should fail. Now it seems, if some change is
not allowed, it is just silently ignored.

This migh require quite total overhaul of the driver (at leat the AC97
part).
I migh be willing to look at it, and make some suggestions, if you so
want.
However if your first responce is going to be that what I'm suggesting is
all wrong (instead trying to find out what I mean in case it's unclear) I
won't bother.

> To my eyes, the first one looks simplier.

If choice must be made, I agree. Really what ever makes the two spdif
switches "Playback" and "Output" to merge in to one, and allow ordinary
PCM to be routed to spdif (with some rate control), is OK as far as I'm
concerned. That's what it has been all about from my point of view.
Basically: good defaults but maximal (sensible) freedom to human user.

It would be greatly appriciated if would answer my sincere questions (in
this and previous notes). They are there because I don't know the answers
(not to argue). I would help me to be more usefull.

This will be my last unsolicited note on this ID.

----------------------------------------------------------------------
 rlrevell - 01-13-06 01:09 
----------------------------------------------------------------------
What's the status of this, in 20 words or less?  Is it a bug, or multiple
bugs, or what?

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
12-07-05 15:56 tiwai          Note Added: 0006943                          
12-09-05 00:15 psa            Note Added: 0006964                          
01-13-06 01:09 rlrevell       Note Added: 0007611                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
