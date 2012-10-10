From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Bug 48381 - [Regression][Bisected]Sound gets
 permanently muted a few minutes after booting
Date: Wed, 10 Oct 2012 16:37:31 +0200
Message-ID: <5075882B.6030002@canonical.com>
References: <CAMNub_Z-92W6ZWxpPPprWCOQpO9er2FXwVVpD4xMB8v6rFZvXQ@mail.gmail.com>
 <50757632.2070900@canonical.com>
 <CAMNub_Z3K-u2ENNgSsEAxqr4URgBcgySVw152Nw1oxw0PW+JcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050703050302050107000504"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 46836264ED1
 for <alsa-devel@alsa-project.org>; Wed, 10 Oct 2012 16:37:33 +0200 (CEST)
In-Reply-To: <CAMNub_Z3K-u2ENNgSsEAxqr4URgBcgySVw152Nw1oxw0PW+JcQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Da Fox <da.fox.mail@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------050703050302050107000504
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 10/10/2012 03:39 PM, Da Fox wrote:
> Dear Ben,

Actually, it's David :-)

> I mostly use mplayer to play audio and video files, using the 'alsa'
> output driver.
> I have attached the requested information to the bugtracker in full,
> the following is a quick diff of the two files:

After some attempts I think was able to find the culprit. Please test 
the attached patch and see if it resolves the problem.

>
> ---8<---------
> --- alsa-info_fresh-boot-speakers-working.txt	2012-10-10
> 15:31:13.787442105 +0200
> +++ alsa-info_after-a-minute-speakers-NOT-working.txt	2012-10-10
> 15:32:29.395605762 +0200
> @@ -3,7 +3,7 @@
>   !!ALSA Information Script v 0.4.61
>   !!################################
>
> -!!Script ran on: Wed Oct 10 13:31:13 UTC 2012
> +!!Script ran on: Wed Oct 10 13:32:28 UTC 2012
>
>
>   !!Linux Distribution
> @@ -275,7 +275,7 @@
>       Conn = ATAPI, Color = Unknown
>       DefAssociation = 0x1, Sequence = 0x0
>       Misc = NO_PRESENCE
> -  Pin-ctls: 0x40: OUT
> +  Pin-ctls: 0x00:
>     Unsolicited: tag=00, enabled=0
>     Power states:  D0 D1 D2 D3 EPSS
>     Power: setting=D0, actual=D0
> @@ -530,7 +530,7 @@
>
>   crw-rw---- 1 root audio 116,  6 Oct 10  2012 /dev/snd/controlC0
>   crw-rw---- 1 root audio 116,  5 Oct 10  2012 /dev/snd/pcmC0D0c
> -crw-rw---- 1 root audio 116,  4 Oct 10 15:30 /dev/snd/pcmC0D0p
> +crw-rw---- 1 root audio 116,  4 Oct 10 15:32 /dev/snd/pcmC0D0p
>   crw-rw---- 1 root audio 116,  3 Oct 10  2012 /dev/snd/pcmC0D1p
>   crw-rw---- 1 root audio 116,  2 Oct 10  2012 /dev/snd/pcmC0D3p
>   crw-rw---- 1 root audio 116,  1 Oct 10  2012 /dev/snd/seq
> @@ -550,7 +550,7 @@
>
>   **** List of PLAYBACK Hardware Devices ****
>   card 0: PCH [HDA Intel PCH], device 0: ALC665 Analog [ALC665 Analog]
> -  Subdevices: 0/1
> +  Subdevices: 1/1
>     Subdevice #0: subdevice #0
>   card 0: PCH [HDA Intel PCH], device 1: ALC665 Digital [ALC665 Digital]
>     Subdevices: 1/1
> --->8---------
>
> Best regards,
>    Da Fox
>
> On Wed, Oct 10, 2012 at 3:20 PM, David Henningsson
> <david.henningsson@canonical.com> wrote:
>> On 10/10/2012 02:59 PM, Da Fox wrote:
>>>
>>> Hi all,
>>>
>>> Since the official bug-tracker at
>>> https://bugtrack.alsa-project.org/alsa-bug/ seems to be down (and
>>> moreover this appears to be a kernel bug), I have filed a bug at the
>>> kernel's bug-tracker last week (
>>> https://bugzilla.kernel.org/show_bug.cgi?id=48381 ). However, it seems
>>> to have gone unnoticed thus-far.
>>>
>>> Quick summary of the issue:
>>> After a while of inactivity the sound-card seems to go into a sort of
>>> power-saving mode (you can hear a faint 'pop' from the speakers).
>>> Before the sound would automatically turn back on again as soon as a
>>> program attempted to play sound. However now it seems that after
>>> resuming from the power-saving mode the driver thinks that there is
>>> always a headphone connected, even when it is not. I think this is
>>> what happens because toggling the 'Auto-Mute Mode' (setting it to
>>> 'Disabled') in alsamixer allows the speakers to produce sound again.
>>> This is all on a laptop (please see the linked bug report for more
>>> detailed hardware description).
>>>
>>> Would a developer please take a look at it? I have bisected the issue
>>> down to a commit made by David Henningsson and/or Takashi Iwai:
>>> ---8<---------
>>> 80c8bfbe76869bfd6bdf3d260d316e7a32f318c3 is the first bad commit
>>> commit 80c8bfbe76869bfd6bdf3d260d316e7a32f318c3
>>> Author: David Henningsson <david.henningsson@canonical.com>
>>> Date:   Mon Jun 4 09:33:51 2012 +0200
>>>
>>>       ALSA: HDA: Create phantom jacks for fixed inputs and outputs
>>>
>>>       PulseAudio sometimes have difficulties knowing that there is a
>>>       "Speaker" or "Internal Mic", if they have no individual volume
>>>       controls or selectors. As a result, only e g "Headphone" might
>>>       be created for a laptop, but no "Speaker".
>>>       To help out, create phantom jacks (that are always present,
>>>       at least for now) for "Speaker", "Internal Mic" etc, in case we
>>>       detect them.
>>>       The naming convention is e g "Speaker Phantom Jack".
>>>
>>>       In order not to pollute the /dev/input namespace with even more
>>>       devices, these are added to the kcontrols only, not the input
>>> devices.
>>>
>>>       Signed-off-by: David Henningsson <david.henningsson@canonical.com>
>>>       Signed-off-by: Takashi Iwai <tiwai@suse.de>
>>>
>>> :040000 040000 7a954b731bef80cee731763521f64a424a7058a0
>>> 7d176b02ebb4553b0b0f97d200f7527cb69c122a M    sound
>>> --->8---------
>>>
>>> If any additional information is required please let me know.
>>
>>
>> Thanks for the heads up. I would need the following additional information:
>>
>> 1) One alsa-info taken during playback through internal speakers, when the
>> internal speakers are working, and
>> 2) One alsa-info taken during playback through internal speakers, when the
>> internal speakers are not working.
>>
>> (See https://wiki.ubuntu.com/Audio/AlsaInfo if you don't know what alsa-info
>> is.)
>>
>> If you're using PulseAudio for playback, please also include the output of
>> "pacmd list" in the above two scenarios.
>>
>>
>> --
>> David Henningsson, Canonical Ltd.
>> https://launchpad.net/~diwic
>



-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic

--------------050703050302050107000504
Content-Type: text/x-patch;
 name="0001-ALSA-hda-do-not-detect-jack-on-internal-speakers-for.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-ALSA-hda-do-not-detect-jack-on-internal-speakers-for.pa";
 filename*1="tch"

>From 17d858f06b5b03c733940a4c3e45dab0108c425b Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Wed, 10 Oct 2012 16:32:09 +0200
Subject: [PATCH] ALSA: hda - do not detect jack on internal speakers for
 Realtek

This caused the internal speaker to mute itself because it was
present, which happened after powersave.
It was found on Dell XPS 15 (L502x), ALC665.

Reported-by: Da Fox <da.fox.mail@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_realtek.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 8568aee..12d16e2 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -611,6 +611,8 @@ static void alc_line_automute(struct hda_codec *codec, struct hda_jack_tbl *jack
 {
 	struct alc_spec *spec = codec->spec;
 
+	if (spec->autocfg.line_out_type == AUTO_PIN_SPEAKER_OUT)
+		return;
 	/* check LO jack only when it's different from HP */
 	if (spec->autocfg.line_out_pins[0] == spec->autocfg.hp_pins[0])
 		return;
-- 
1.7.9.5


--------------050703050302050107000504
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------050703050302050107000504--
