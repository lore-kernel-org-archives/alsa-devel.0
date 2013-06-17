From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH 2/2] ALSA: hda - Add models for Dell
	headset jacks
Date: Mon, 17 Jun 2013 09:58:46 +0200
Message-ID: <51BEC1B6.2050702@canonical.com>
References: <1370941609-5056-1-git-send-email-david.henningsson@canonical.com>
 <1370941609-5056-2-git-send-email-david.henningsson@canonical.com>
 <s5hobb5npln.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 914D12610CA
 for <alsa-devel@alsa-project.org>; Mon, 17 Jun 2013 09:58:48 +0200 (CEST)
In-Reply-To: <s5hobb5npln.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, 1189363@bugs.launchpad.net
List-Id: alsa-devel@alsa-project.org

On 06/17/2013 09:49 AM, Takashi Iwai wrote:
> At Tue, 11 Jun 2013 11:06:49 +0200,
> David Henningsson wrote:
>>
>> These headset jacks keep coming in on more and more platforms, and
>> it's possible I don't catch them all. Make it easier to test and
>> verify by making models.
>>
>> Signed-off-by: David Henningsson <david.henningsson@canonical.com>
>
> The patch does more than it says; it reformats and modifies
> HD-Audio-Models.txt.  If it's intended to be merged to 3.10 kernel,
> please make things as minimal as possible, then prepare another patch
> for cleaning up the whole document.

Given Linus's latest "don't send me non-critical stuff" comment [1], I 
was expecting you to defer this patch to 3.11 anyway. If you can merge 
the first patch (the one that adds three headset IDs) to 3.10, that 
would be appreciated though.

Also, I'm not sure how to split this patch, all reformat/modifications 
are just because of the documentation of the added models.

>
>
> thanks,
>
> Takashi
>
>> ---
>>   Documentation/sound/alsa/HD-Audio-Models.txt |   41 ++++++++++++++------------
>>   sound/pci/hda/patch_realtek.c                |    3 ++
>>   2 files changed, 25 insertions(+), 19 deletions(-)
>>
>> diff --git a/Documentation/sound/alsa/HD-Audio-Models.txt b/Documentation/sound/alsa/HD-Audio-Models.txt
>> index bb8b0dc..9a0927c 100644
>> --- a/Documentation/sound/alsa/HD-Audio-Models.txt
>> +++ b/Documentation/sound/alsa/HD-Audio-Models.txt
>> @@ -21,27 +21,30 @@ ALC267/268
>>   ==========
>>     inv-dmic	Inverted internal mic workaround
>>
>> -ALC269/270/275/276/280/282
>> +ALC269/270/275/276/28x/29x
>>   ======
>> -  laptop-amic	Laptops with analog-mic input
>> -  laptop-dmic	Laptops with digital-mic input
>> -  alc269-dmic	Enable ALC269(VA) digital mic workaround
>> -  alc271-dmic	Enable ALC271X digital mic workaround
>> -  inv-dmic	Inverted internal mic workaround
>> -  lenovo-dock   Enables docking station I/O for some Lenovos
>> -
>> -ALC662/663/272
>> +  laptop-amic		Laptops with analog-mic input
>> +  laptop-dmic		Laptops with digital-mic input
>> +  alc269-dmic		Enable ALC269(VA) digital mic workaround
>> +  alc271-dmic		Enable ALC271X digital mic workaround
>> +  inv-dmic		Inverted internal mic workaround
>> +  lenovo-dock		Enables docking station I/O for some Lenovos
>> +  dell-headset-multi	Headset jack, which can also be used as mic-in
>> +  dell-headset-dock	Headset jack (without mic-in), and also dock I/O
>> +
>> +ALC662/663/668/272
>>   ==============
>> -  mario		Chromebook mario model fixup
>> -  asus-mode1	ASUS
>> -  asus-mode2	ASUS
>> -  asus-mode3	ASUS
>> -  asus-mode4	ASUS
>> -  asus-mode5	ASUS
>> -  asus-mode6	ASUS
>> -  asus-mode7	ASUS
>> -  asus-mode8	ASUS
>> -  inv-dmic	Inverted internal mic workaround
>> +  mario			Chromebook mario model fixup
>> +  asus-mode1		ASUS
>> +  asus-mode2		ASUS
>> +  asus-mode3		ASUS
>> +  asus-mode4		ASUS
>> +  asus-mode5		ASUS
>> +  asus-mode6		ASUS
>> +  asus-mode7		ASUS
>> +  asus-mode8		ASUS
>> +  inv-dmic		Inverted internal mic workaround
>> +  dell-headset-multi	Headset jack, which can also be used as mic-in
>>
>>   ALC680
>>   ======
>> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
>> index af9e71b..403010c 100644
>> --- a/sound/pci/hda/patch_realtek.c
>> +++ b/sound/pci/hda/patch_realtek.c
>> @@ -3599,6 +3599,8 @@ static const struct hda_model_fixup alc269_fixup_models[] = {
>>   	{.id = ALC269_FIXUP_INV_DMIC, .name = "inv-dmic"},
>>   	{.id = ALC269_FIXUP_LENOVO_DOCK, .name = "lenovo-dock"},
>>   	{.id = ALC269_FIXUP_HP_GPIO_LED, .name = "hp-gpio-led"},
>> +	{.id = ALC269_FIXUP_DELL1_MIC_NO_PRESENCE, .name = "dell-headset-multi"},
>> +	{.id = ALC269_FIXUP_DELL2_MIC_NO_PRESENCE, .name = "dell-headset-dock"},
>>   	{}
>>   };
>>
>> @@ -4278,6 +4280,7 @@ static const struct hda_model_fixup alc662_fixup_models[] = {
>>   	{.id = ALC662_FIXUP_ASUS_MODE7, .name = "asus-mode7"},
>>   	{.id = ALC662_FIXUP_ASUS_MODE8, .name = "asus-mode8"},
>>   	{.id = ALC662_FIXUP_INV_DMIC, .name = "inv-dmic"},
>> +	{.id = ALC668_FIXUP_DELL_MIC_NO_PRESENCE, .name = "dell-headset-multi"},
>>   	{}
>>   };
>>
>> --
>> 1.7.9.5
>>
>



-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic

[1] https://lkml.org/lkml/2013/6/8/108
