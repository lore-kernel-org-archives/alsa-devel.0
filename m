From: Justin Mattock <justinmattock@gmail.com>
Subject: Re: [PATCH 20/21]sound:pci:hda:patch_realtek.c remove
	one to many l's in the word.
Date: Thu, 24 Feb 2011 23:58:49 -0800
Message-ID: <2621AB8F-E727-4555-8DE4-A2ECC84DC8A9@gmail.com>
References: <1298614562-4230-1-git-send-email-justinmattock@gmail.com>
	<s5hpqqgh7o2.wl%tiwai@suse.de>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id CB8231037F5
	for <alsa-devel@alsa-project.org>; Fri, 25 Feb 2011 08:58:54 +0100 (CET)
Received: by iwc10 with SMTP id 10so937107iwc.38
	for <alsa-devel@alsa-project.org>; Thu, 24 Feb 2011 23:58:54 -0800 (PST)
In-Reply-To: <s5hpqqgh7o2.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, trivial@kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


On Feb 24, 2011, at 11:53 PM, Takashi Iwai wrote:

> At Thu, 24 Feb 2011 22:16:02 -0800,
> Justin P. Mattock wrote:
>>
>> The patch below removes an extra "l" in the word.
>>
>> Signed-off-by: Justin P. Mattock <justinmattock@gmail.com>
>
> Thanks, applied both patches 19 and 20 to sound git tree.
>
>
> Takashi
>

alright!!

>>
>> ---
>> sound/pci/hda/patch_realtek.c |    2 +-
>> 1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/ 
>> patch_realtek.c
>> index 3328a25..c5208c9 100644
>> --- a/sound/pci/hda/patch_realtek.c
>> +++ b/sound/pci/hda/patch_realtek.c
>> @@ -4705,7 +4705,7 @@ static struct snd_pci_quirk alc880_cfg_tbl[]  
>> = {
>> 	SND_PCI_QUIRK(0x1558, 0x5401, "ASUS", ALC880_ASUS_DIG2),
>> 	SND_PCI_QUIRK(0x1565, 0x8202, "Biostar", ALC880_5ST_DIG),
>> 	SND_PCI_QUIRK(0x1584, 0x9050, "Uniwill", ALC880_UNIWILL_DIG),
>> -	SND_PCI_QUIRK(0x1584, 0x9054, "Uniwlll", ALC880_F1734),
>> +	SND_PCI_QUIRK(0x1584, 0x9054, "Uniwill", ALC880_F1734),
>> 	SND_PCI_QUIRK(0x1584, 0x9070, "Uniwill", ALC880_UNIWILL),
>> 	SND_PCI_QUIRK(0x1584, 0x9077, "Uniwill P53", ALC880_UNIWILL_P53),
>> 	SND_PCI_QUIRK(0x161f, 0x203d, "W810", ALC880_W810),
>> -- 
>> 1.7.4.1
>>


Justin P. Mattock
