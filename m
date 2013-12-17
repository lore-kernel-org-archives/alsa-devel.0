From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] ALSA: hda - Add Dell headset detection quirk for one
 more laptop model
Date: Tue, 17 Dec 2013 11:39:22 +0100
Message-ID: <52B029DA.3030401@canonical.com>
References: <1387273183-11118-1-git-send-email-hui.wang@canonical.com> <52B01CC2.6040208@canonical.com> <52B0200A.6050400@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <52B0200A.6050400@canonical.com>
Sender: stable-owner@vger.kernel.org
To: Hui Wang <hui.wang@canonical.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 12/17/2013 10:57 AM, Hui Wang wrote:
> On 12/17/2013 05:43 PM, David Henningsson wrote:
>> On 12/17/2013 10:39 AM, Hui Wang wrote:
>>> On the Dell machines with codec whose Subsystem Id is 0x10280640,
>>> no external microphone can be detected when plugging a 3-ring headset.
>>> If we add "model=dell-headset-multi" for the snd-hda-intel.ko, the
>>> problem will disappear.
>>>
>>> The codec (Vendor ID: 0x10ec0255) on the machine belongs to alc_269
>>> family.
>>>
>>> BugLink: https://bugs.launchpad.net/bugs/1260303
>>> Cc: David Henningsson <david.henningsson@canonical.com>
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Hui Wang <hui.wang@canonical.com>
>>> ---
>>> This patch was generated against the master branch of
>>> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
>>>
>>>   sound/pci/hda/patch_realtek.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/sound/pci/hda/patch_realtek.c
>>> b/sound/pci/hda/patch_realtek.c
>>> index 3578f11..4d7c602 100644
>>> --- a/sound/pci/hda/patch_realtek.c
>>> +++ b/sound/pci/hda/patch_realtek.c
>>> @@ -4309,6 +4309,7 @@ static const struct snd_pci_quirk
>>> alc269_fixup_tbl[] = {
>>>       SND_PCI_QUIRK(0x1028, 0x0638, "Dell Inspiron 5439",
>>> ALC290_FIXUP_MONO_SPEAKERS),
>>>       SND_PCI_QUIRK(0x1028, 0x063e, "Dell",
>>> ALC269_FIXUP_DELL1_MIC_NO_PRESENCE),
>>>       SND_PCI_QUIRK(0x1028, 0x063f, "Dell",
>>> ALC255_FIXUP_DELL1_MIC_NO_PRESENCE),
>>> +    SND_PCI_QUIRK(0x1028, 0x0640, "Dell",
>>> ALC269_FIXUP_DELL1_MIC_NO_PRESENCE),
>> Are you sure it shouldn't be ALC255_FIXUP_... in this line instead of
>> ALC269_FIXUP_... ?
> I also had the same concern as yours yesterday, so i let ShawnWang
> perform the test, he confirmed that adding "model=dell-headset-multi"
> can solve this problem. Below is the irc log:
> 
> <hwang4> shawnwang, Does adding "options snd-hda-intel
> model=,dell-headset-multi" solve the problem on this machine (10280640)
> <shawnwang> hwang4, yes
> <hwang4> shawnwang, ok, got it, i will fix it.

Well, just because the alc269 model works does not mean that the alc255
model does not work. They are quite similar, with the only difference
being a few verbs set on initial boot. Maybe those verbs handle some
corner case that was not tested explicitly by Shawn.

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
