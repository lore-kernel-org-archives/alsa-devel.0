From: Jan Hinnerk Stosch <janhinnerk.stosch@gmail.com>
Subject: Re: Low volume since linux 3.19
Date: Wed, 13 May 2015 18:29:29 +0200
Message-ID: <CAO_aot7J+RAnK9oONtHYAceBk82obm39P9OZHTUz6dD0=L+fJw@mail.gmail.com>
References: <CAO_aot5hLoXp1XkJ3SOSSBAYUbZWB63+VD2pGvVL=2gq6dJZUA@mail.gmail.com>
 <s5hiodndg1h.wl-tiwai@suse.de>
 <CAO_aot4w1Xhz652s+6XQwTHH8Bt6LLVYcrpdJPd9_xaBFVgDtg@mail.gmail.com>
 <s5h7fu3deby.wl-tiwai@suse.de>
 <CAO_aot7JtMwcMB2R95-8RQZM0KZWCkbMpGFM7av=u25ror0_rQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f44.google.com (mail-la0-f44.google.com
 [209.85.215.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 4A9E2265D22
 for <alsa-devel@alsa-project.org>; Wed, 13 May 2015 18:29:30 +0200 (CEST)
Received: by laat2 with SMTP id t2so33495357laa.1
 for <alsa-devel@alsa-project.org>; Wed, 13 May 2015 09:29:29 -0700 (PDT)
In-Reply-To: <CAO_aot7JtMwcMB2R95-8RQZM0KZWCkbMpGFM7av=u25ror0_rQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Hi,

a few weeks ago you wrote a patch for a lifebook T731 which fixed some
wrong BIOS configuration concerning the headphone pin.
A tried the patch with my Lifebook E753 and it worked. The Speaker+LO
setting is gone. In alsamixer only 'Speaker' and 'Headphone' remain.
'Speaker' is muted when I plug in a headphone.
So if I don't get something wrong this is the same issue!?
If it is and you don't mind, would you add the following quirk-patch?

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index e2afd53..8491429 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5119,6 +5119,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
     SND_PCI_QUIRK(0x104d, 0x9099, "Sony VAIO S13",
ALC275_FIXUP_SONY_DISABLE_AAMIX),
     SND_PCI_QUIRK(0x10cf, 0x1475, "Lifebook", ALC269_FIXUP_LIFEBOOK),
     SND_PCI_QUIRK(0x10cf, 0x15dc, "Lifebook T731",
ALC269_FIXUP_LIFEBOOK_HP_PIN),
+    SND_PCI_QUIRK(0x10cf, 0x1757, "Lifebook E753",
ALC269_FIXUP_LIFEBOOK_HP_PIN),
     SND_PCI_QUIRK(0x10cf, 0x1845, "Lifebook U904",
ALC269_FIXUP_LIFEBOOK_EXTMIC),
     SND_PCI_QUIRK(0x144d, 0xc109, "Samsung Ativ book 9 (NP900X3G)",
ALC269_FIXUP_INV_DMIC),
     SND_PCI_QUIRK(0x1458, 0xfa53, "Gigabyte BXBT-2807",
ALC283_FIXUP_BXBT2807_MIC),

If I got something wrong, please tell me.

Regards,

jhs

2015-03-26 16:48 GMT+01:00 Jan Hinnerk Stosch <janhinnerk.stosch@gmail.com>:
> Yes, it works (only until next reboot). I assume the "k" after "set"
> was a typo. I ran
> % amixer amixer -c0 set 'Speaker+LO' 0dB
>
> I have pulseaudio version 6.0
>
> regards,
>
> jhs
>
> 2015-03-26 15:26 GMT+01:00 Takashi Iwai <tiwai@suse.de>:
>> At Thu, 26 Mar 2015 15:22:28 +0100,
>> Jan Hinnerk Stosch wrote:
>>>
>>> Thx for your quick reply.
>>> I ran the script with linux 3.18.6 and 3.19.2 and attached the output
>>> in compressed form.
>>
>> I guess running the following once should recover:
>>    % amixer -c0 set k 'Speaker+LO' 0dB
>>
>> But still the question is who lowered it.  Which PulseAudio version
>> are you running?
>>
>>
>> Takashi
>>
>>>
>>> regards,
>>>
>>> jhs
>>>
>>> 2015-03-26 14:50 GMT+01:00 Takashi Iwai <tiwai@suse.de>:
>>> > At Thu, 26 Mar 2015 13:53:30 +0100,
>>> > Jan Hinnerk Stosch wrote:
>>> >>
>>> >> Hi,
>>> >>
>>> >> I hope this is the right place to report my issue!?
>>> >> Since linux 3.19 I have very low volume on my Fujitsu E753 headphone
>>> >> even on highest volume level.
>>> >> As I don't have much experience with audio configuration and it worked
>>> >> before I did a kernel bisect and found out, that commit
>>> >> "03ad6a8c93b6df2d65c305b5b5f9474068b45bfb" is "responsible" for this.
>>> >
>>> > Adding David to Cc.
>>> >
>>> >> Is there something that I have to change in my configuration? Or do
>>> >> you need some further information?
>>> >
>>> > Please take alsa-info.sh outputs before and after the patch.  Run the
>>> > script with --no-upload option, and attach two output files.  (Maybe
>>> > better to compress when attaching.)
>>> >
>>> > The commit does basically only renaming some control elements.
>>> > Possibly some volumes are set lower than before now.
>>> >
>>> >
>>> > thanks,
>>> >
>>> > Takashi
>>> [2 alsainfo.tar.xz <application/x-xz (base64)>]
>>>
