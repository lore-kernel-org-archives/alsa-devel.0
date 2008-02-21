From: =?ISO-8859-1?Q?Anders_R=F8nningen?= <andersronningen@gmail.com>
Subject: Re: [PATCH] hda: STAC927x invalid association value
Date: Thu, 21 Feb 2008 16:17:53 +0100
Message-ID: <47BD9621.5040101@gmail.com>
References: <47BCA495.5050201@embeddedalley.com> <s5hfxvmss9c.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.188])
	by alsa0.perex.cz (Postfix) with ESMTP id 066582434B
	for <alsa-devel@alsa-project.org>; Thu, 21 Feb 2008 16:17:57 +0100 (CET)
Received: by nf-out-0910.google.com with SMTP id b21so36784nfd.32
	for <alsa-devel@alsa-project.org>; Thu, 21 Feb 2008 07:17:56 -0800 (PST)
In-Reply-To: <s5hfxvmss9c.wl%tiwai@suse.de>
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
Cc: Jiang zhe <zhe.jiang@intel.com>, alsa-devel@alsa-project.org, Matthew Ranostay <mranostay@embeddedalley.com>
List-Id: alsa-devel@alsa-project.org

I tried with "alsa-driver-hg20080221", and now left HP and internal 
speakers are gone again.

dmesg:
[   15.444000] ALSA 
/mnt/storage/source/alsa/alsa-driver-hg20080221/pci/hda/hda_codec.c:2994: 
autoconfig: line_outs=1 (0xf/0x0/0x0/0x0/0x0)
[   15.444000] ALSA 
/mnt/storage/source/alsa/alsa-driver-hg20080221/pci/hda/hda_codec.c:2998:    
speaker_outs=1 (0xd/0x0/0x0/0x0/0x0)
[   15.444000] ALSA 
/mnt/storage/source/alsa/alsa-driver-hg20080221/pci/hda/hda_codec.c:3002:    
hp_outs=1 (0xa/0xf/0x0/0x0/0x0)
[   15.444000] ALSA 
/mnt/storage/source/alsa/alsa-driver-hg20080221/pci/hda/hda_codec.c:3003:    
mono: mono_out=0x0
[   15.444000] ALSA 
/mnt/storage/source/alsa/alsa-driver-hg20080221/pci/hda/hda_codec.c:3011:    
inputs: mic=0xe, fmic=0x0, line=0x0, fline=0x0, cd=0x0, aux=0x0
[   15.448000] ALSA 
/mnt/storage/source/alsa/alsa-driver-hg20080221/pci/hda/../../alsa-kernel/pci/hda/patch_sigmatel.c:2222: 
dac_nids=2 (0x5/0x4/0x0/0x0/0x0)

alsa-info.sh
http://pastebin.ca/912640

Was this sw with the fix?

- Anders

Takashi Iwai wrote:
> At Wed, 20 Feb 2008 17:07:17 -0500,
> Matthew Ranostay wrote:
>   
>> STAC_DELL_BIOS quirks were setting the association value wrong for port 0x0f, which prevented it from
>> being included in hp_outs[].
>>
>> Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>
>>     
>
> Applied to HG tree.
> Hopefully this fixes the problem with Dell XP M1530...
>
> Thanks,
>
> Takashi
>
>   
>> ---
>> diff -r 30701aaf404c pci/hda/patch_sigmatel.c
>> --- a/pci/hda/patch_sigmatel.c	Wed Feb 20 12:13:29 2008 +0100
>> +++ b/pci/hda/patch_sigmatel.c	Wed Feb 20 15:01:35 2008 -0700
>> @@ -3630,7 +3630,7 @@ static int patch_stac927x(struct hda_cod
>>  		break;
>>  	case STAC_DELL_BIOS:
>>  		/* correct the front output jack as a hp out */
>> -		stac92xx_set_config_reg(codec, 0x0f, 0x02270110);
>> +		stac92xx_set_config_reg(codec, 0x0f, 0x0227011f);
>>  		/* correct the front input jack as a mic */
>>  		stac92xx_set_config_reg(codec, 0x0e, 0x02a79130);
>>  		/* fallthru */
>>
>>     
