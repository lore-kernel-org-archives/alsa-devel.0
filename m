From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: Re: [PATCH] hda: incorrect DAC mixer on 92hd71bxxx
Date: Fri, 29 Feb 2008 07:55:00 -0500
Message-ID: <04205BAE-B317-46D5-97B4-3715236C2FFF@embeddedalley.com>
References: <47C72FB8.2070900@embeddedalley.com> <s5hmypkqdbz.wl%tiwai@suse.de>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp101.biz.mail.mud.yahoo.com (smtp101.biz.mail.mud.yahoo.com
	[68.142.200.236]) by alsa0.perex.cz (Postfix) with SMTP id 59F682470E
	for <alsa-devel@alsa-project.org>; Fri, 29 Feb 2008 13:55:08 +0100 (CET)
In-Reply-To: <s5hmypkqdbz.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


On Feb 29, 2008, at 5:14 AM, Takashi Iwai wrote:

> At Thu, 28 Feb 2008 17:03:36 -0500,
> Matthew Ranostay wrote:
>>
>> If there was two line_outs[] it would overrun into the dmic nid  
>> struct below
>> and create a phantom "Surround" mixer.
>
> My bad.  But isn't the fix below simpler?
>
Yes it is :)
>
> thanks,
>
> Takashi
>
> ---
> diff -r 54a51b975975 pci/hda/patch_sigmatel.c
> --- a/pci/hda/patch_sigmatel.c	Thu Feb 28 12:46:32 2008 +0100
> +++ b/pci/hda/patch_sigmatel.c	Fri Feb 29 11:17:54 2008 +0100
> @@ -2344,7 +2344,7 @@ static int stac92xx_auto_create_multi_ou
>  	unsigned int wid_caps, pincap;
>
>
> -	for (i = 0; i < cfg->line_outs; i++) {
> +	for (i = 0; i < cfg->line_outs && i < spec->multiout.num_dacs; i+ 
> +) {
>  		if (!spec->multiout.dac_nids[i])
>  			continue;
>
>
