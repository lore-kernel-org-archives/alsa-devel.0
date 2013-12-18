From: Hui Wang <hui.wang@canonical.com>
Subject: Re: [PATCH] ALSA: hda - Add Dell headset detection quirk for one
 more laptop model
Date: Wed, 18 Dec 2013 17:16:56 +0800
Message-ID: <52B16808.3090504@canonical.com>
References: <1387273183-11118-1-git-send-email-hui.wang@canonical.com> <52B01CC2.6040208@canonical.com> <52B0200A.6050400@canonical.com> <52B029DA.3030401@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <52B029DA.3030401@canonical.com>
Sender: stable-owner@vger.kernel.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 12/17/2013 06:39 PM, David Henningsson wrote:
>>>> --- a/sound/pci/hda/patch_realtek.c
>>>> >>>+++ b/sound/pci/hda/patch_realtek.c
>>>> >>>@@ -4309,6 +4309,7 @@ static const struct snd_pci_quirk
>>>> >>>alc269_fixup_tbl[] = {
>>>> >>>       SND_PCI_QUIRK(0x1028, 0x0638, "Dell Inspiron 5439",
>>>> >>>ALC290_FIXUP_MONO_SPEAKERS),
>>>> >>>       SND_PCI_QUIRK(0x1028, 0x063e, "Dell",
>>>> >>>ALC269_FIXUP_DELL1_MIC_NO_PRESENCE),
>>>> >>>       SND_PCI_QUIRK(0x1028, 0x063f, "Dell",
>>>> >>>ALC255_FIXUP_DELL1_MIC_NO_PRESENCE),
>>>> >>>+    SND_PCI_QUIRK(0x1028, 0x0640, "Dell",
>>>> >>>ALC269_FIXUP_DELL1_MIC_NO_PRESENCE),
>>> >>Are you sure it shouldn't be ALC255_FIXUP_... in this line instead of
>>> >>ALC269_FIXUP_... ?
>> >I also had the same concern as yours yesterday, so i let ShawnWang
>> >perform the test, he confirmed that adding "model=dell-headset-multi"
>> >can solve this problem. Below is the irc log:
>> >
>> ><hwang4> shawnwang, Does adding "options snd-hda-intel
>> >model=,dell-headset-multi" solve the problem on this machine (10280640)
>> ><shawnwang> hwang4, yes
>> ><hwang4> shawnwang, ok, got it, i will fix it.
> Well, just because the alc269 model works does not mean that the alc255
> model does not work. They are quite similar, with the only difference
> being a few verbs set on initial boot. Maybe those verbs handle some
> corner case that was not tested explicitly by Shawn.
Shawn has done the test, according to his test result, both ALC255_FIXUP 
and ALC269_FIXUP can fix headset detection bug, and furthermore he also 
did the record and playback test for them, the result was same, no 
matter we choose ALC255 or ALC269, the machine can correctly detect, 
record and playback.

Since the codec's vendor ID is 0x10ec0255, choosing ALC255_FIXUP is more 
reasonable and safer.

Regards,
Hui.
