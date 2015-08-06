From: Kailang <kailang@realtek.com>
Subject: Re: Verb for 0x17 pin config
Date: Thu, 6 Aug 2015 07:49:23 +0000
Message-ID: <6FAB7C47BCF00940BB0999A99BE3547A17A1F86F@RTITMBSV09.realtek.com.tw>
References: <6FAB7C47BCF00940BB0999A99BE3547A17A1F778@RTITMBSV09.realtek.com.tw>
 <s5hh9oeb4qy.wl-tiwai@suse.de>
 <6FAB7C47BCF00940BB0999A99BE3547A17A1F78C@RTITMBSV09.realtek.com.tw>
 <s5hd1z2b3wh.wl-tiwai@suse.de>
 <6FAB7C47BCF00940BB0999A99BE3547A17A1F7A4@RTITMBSV09.realtek.com.tw>
 <s5h7fpaui7t.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 19716260438
 for <alsa-devel@alsa-project.org>; Thu,  6 Aug 2015 09:49:28 +0200 (CEST)
In-Reply-To: <s5h7fpaui7t.wl-tiwai@suse.de>
Content-Language: zh-TW
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
Cc: " (alsa-devel@alsa-project.org)" <alsa-devel@alsa-project.org>, Woodrow Shen <woodrow.shen@canonical.com>
List-Id: alsa-devel@alsa-project.org

 

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de] 
> Sent: Wednesday, August 05, 2015 6:45 PM
> To: Kailang
> Cc: Woodrow Shen; (alsa-devel@alsa-project.org)
> Subject: Re: Verb for 0x17 pin config
> 
> On Wed, 05 Aug 2015 10:13:33 +0200,
> Kailang wrote:
> > 
> > 
> > Hi Takashi,
> > 
> > Update patch as attach.
> 
> Thanks.  The addition for 0x90170110 was already done by 
> Woodrow's patch, so only 0x90170150 is missing.
> 
> Below is the patch I'm going to apply on top.

Many Thanks.

> 
> 
> Takashi
> 
> ---
> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH] ALSA: hda - yet another fix for Dell headset 
> mic with ALC3266
> 
> It turned out that there are three variants of pin config 
> values of NID 0x17 on Dell laptops with ALC3266 (alias of 
> ALC298): 0x90170110, 0x90170140 and 0x90170150.  The first 
> two have been already covered by commits 703867e2f252 and 
> 977e627684df, so this commit adds the missing last entry.
> 
> While we're at it, rearrange the three entries in the order 
> of pincfg values.
> 
> Reported-by: Kailang Yang <kailang@realtek.com>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/pci/hda/patch_realtek.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/pci/hda/patch_realtek.c 
> b/sound/pci/hda/patch_realtek.c index 
> 9107929dc545..88ddbb0668b7 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -5574,10 +5574,13 @@ static const struct snd_hda_pin_quirk 
> alc269_pin_fixup_tbl[] = {
>  		{0x13, 0x90a60140}),
>  	SND_HDA_PIN_QUIRK(0x10ec0298, 0x1028, "Dell", 
> ALC298_FIXUP_DELL1_MIC_NO_PRESENCE,
>  		ALC298_STANDARD_PINS,
> +		{0x17, 0x90170110}),
> +	SND_HDA_PIN_QUIRK(0x10ec0298, 0x1028, "Dell", 
> ALC298_FIXUP_DELL1_MIC_NO_PRESENCE,
> +		ALC298_STANDARD_PINS,
>  		{0x17, 0x90170140}),
>  	SND_HDA_PIN_QUIRK(0x10ec0298, 0x1028, "Dell", 
> ALC298_FIXUP_DELL1_MIC_NO_PRESENCE,
>  		ALC298_STANDARD_PINS,
> -		{0x17, 0x90170110}),
> +		{0x17, 0x90170150}),
>  	{}
>  };
>  
> --
> 2.5.0
> 
> 
> ------Please consider the environment before printing this e-mail.
> 
