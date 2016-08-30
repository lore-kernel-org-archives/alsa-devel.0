From: Kai Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH] ALSA: hda - Enable subwoofer on Dell Inspiron 7559
Date: Tue, 30 Aug 2016 14:25:18 +0800
Message-ID: <CAAd53p4stFs1GzGtbzRKVa6GVcotrFprsN_OO5ZA7jjQnf+3wg@mail.gmail.com>
References: <20160830052741.20190-1-kai.heng.feng@canonical.com> <s5h4m624y7s.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5h4m624y7s.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Hui Wang <hui.wang@canonical.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 30, 2016 at 1:33 PM, Takashi Iwai <tiwai@suse.de> wrote:
> On Tue, 30 Aug 2016 07:27:41 +0200,
> Kai-Heng Feng wrote:
>>
>> The subwoofer on Inspiron 7559 does not work originally.
>> Applying a pin fixup can make it work.
>>
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> ---
>>  sound/pci/hda/patch_realtek.c | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
>> index 7100f05..2a3dd18 100644
>> --- a/sound/pci/hda/patch_realtek.c
>> +++ b/sound/pci/hda/patch_realtek.c
>> @@ -4855,6 +4855,7 @@ enum {
>>       ALC221_FIXUP_HP_FRONT_MIC,
>>       ALC292_FIXUP_TPT460,
>>       ALC298_FIXUP_SPK_VOLUME,
>> +     ALC256_FIXUP_DELL_INSPIRON_7559_SUBWOOFER,
>>  };
>>
>>  static const struct hda_fixup alc269_fixups[] = {
>> @@ -5516,6 +5517,15 @@ static const struct hda_fixup alc269_fixups[] = {
>>               .chained = true,
>>               .chain_id = ALC298_FIXUP_DELL1_MIC_NO_PRESENCE,
>>       },
>> +     [ALC256_FIXUP_DELL_INSPIRON_7559_SUBWOOFER] = {
>> +             .type = HDA_FIXUP_PINS,
>> +             .v.pins = (const struct hda_pintbl[]) {
>> +                     { 0x1b, 0x90170151 },
>
> What's the original value of this pin?
>
>
> Takashi

The original value of 0x1b is 0x411111f0.
