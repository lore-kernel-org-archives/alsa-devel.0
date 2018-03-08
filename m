From: Dennis Wassenberg <dennis.wassenberg@secunet.com>
Subject: Re: [PATCH] hda: realtek: Make dock sound work on
	ThinkPad L570
Date: Thu, 8 Mar 2018 14:13:20 +0100
Message-ID: <709f6a2b-1e3d-f7ab-17b7-eeb131e46221@secunet.com>
References: <46c65214-2a41-77ce-6484-979b08fc44c1@secunet.com>
 <s5h371a913a.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
 by alsa0.perex.cz (Postfix) with ESMTP id 46F1626742B
 for <alsa-devel@alsa-project.org>; Thu,  8 Mar 2018 14:17:07 +0100 (CET)
In-Reply-To: <s5h371a913a.wl-tiwai@suse.de>
Content-Language: en-US
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
Cc: Hui Wang <hui.wang@canonical.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

yes, exactly.

First I was confused because all other Lenovo 70's devices have ALC298
inside, even L470, but not L570 with this PCI SSID.

Best regards,

Dennis


On 08.03.2018 13:57, Takashi Iwai wrote:
> On Thu, 08 Mar 2018 13:17:54 +0100,
> Dennis Wassenberg wrote:
>>
>> One version of Lenovo Thinkpad T570 did not use ALC298
>> (like other Kaby Lake devices). Instead it uses ALC292.
>> In order to make the Lenovo dock working with that codec
>> the dock quirk for ALC292 will be used.
>>
>> Signed-off-by: Dennis Wassenberg <dennis.wassenberg@secunet.com>
> 
> So, although the PCI SSID appears to be a new one, this still needs
> the old quirk, not for T470 dock?  Just to be sure.
> 
> 
> thanks,
> 
> Takashi
> 
>> ---
>>  sound/pci/hda/patch_realtek.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
>> index b9c93fa..b5d0f8c 100644
>> --- a/sound/pci/hda/patch_realtek.c
>> +++ b/sound/pci/hda/patch_realtek.c
>> @@ -6508,6 +6508,7 @@ enum {
>>  	SND_PCI_QUIRK(0x17aa, 0x2245, "Thinkpad T470", ALC298_FIXUP_TPT470_DOCK),
>>  	SND_PCI_QUIRK(0x17aa, 0x2246, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
>>  	SND_PCI_QUIRK(0x17aa, 0x2247, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
>> +	SND_PCI_QUIRK(0x17aa, 0x2249, "Thinkpad", ALC292_FIXUP_TPT460),
>>  	SND_PCI_QUIRK(0x17aa, 0x224b, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
>>  	SND_PCI_QUIRK(0x17aa, 0x224c, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
>>  	SND_PCI_QUIRK(0x17aa, 0x224d, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
>> -- 
>> 1.9.1
>>
>>
>>
