From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] ALSA: hda - mute LEDs on HP: also check
	PCI SSID
Date: Mon, 14 Jan 2013 14:24:37 +0100
Message-ID: <50F40715.4080907@canonical.com>
References: <1358164750-16144-1-git-send-email-david.henningsson@canonical.com>
 <s5h6230c4is.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 92C1A2615F5
 for <alsa-devel@alsa-project.org>; Mon, 14 Jan 2013 14:24:38 +0100 (CET)
In-Reply-To: <s5h6230c4is.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, 1099372@bugs.launchpad.net
List-Id: alsa-devel@alsa-project.org

On 01/14/2013 01:50 PM, Takashi Iwai wrote:
> At Mon, 14 Jan 2013 12:59:10 +0100,
> David Henningsson wrote:
>>
>> If the codec subvendor is not set to HP, maybe the PCI SSID is set
>> to HP. If so, there might still be a valid mute LED string in BIOS/UEFI.
>>
>> Cc: stable@vger.kernel.org
>> Buglink: https://bugs.launchpad.net/bugs/1099372
>> Reported-and-tested-by: Tammy Yang <tammy.yang@canonical.com>
>> Signed-off-by: David Henningsson <david.henningsson@canonical.com>
>
> Is there any real machine showing this bug?

Yes, but it is pre-release hardware, so maybe the BIOS/UEFI might not be 
the final version. If you like, we can wait and see if the problem is 
corrected in later BIOS/UEFI versions.

I was thinking that this patch does not hurt anyway.

> If yes, could you give alsa-info.sh output?

https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1099372/+attachment/3482841/+files/alsa-info-hp.txt

>
>
> thanks,
>
> Takashi
>
>> ---
>>   sound/pci/hda/patch_sigmatel.c |    3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
>> index a86547c..40c74a2 100644
>> --- a/sound/pci/hda/patch_sigmatel.c
>> +++ b/sound/pci/hda/patch_sigmatel.c
>> @@ -4948,7 +4948,8 @@ static int find_mute_led_cfg(struct hda_codec *codec, int default_polarity)
>>   			     &spec->gpio_led_polarity);
>>   		return 1;
>>   	}
>> -	if ((codec->subsystem_id >> 16) == PCI_VENDOR_ID_HP) {
>> +	if ((codec->subsystem_id >> 16) == PCI_VENDOR_ID_HP ||
>> +	   codec->bus->pci->subsystem_vendor == PCI_VENDOR_ID_HP) {
>>   		while ((dev = dmi_find_device(DMI_DEV_TYPE_OEM_STRING,
>>   								NULL, dev))) {
>>   			if (sscanf(dev->name, "HP_Mute_LED_%d_%x",
>> --
>> 1.7.9.5
>>
>



-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
