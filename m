From: =?ISO-8859-1?Q?Ortwin_Gl=FCck?= <odi@odi.ch>
Subject: Re: hda Regression: jack doesn't mute speaker
Date: Fri, 17 Apr 2009 19:28:23 +0200
Message-ID: <49E8BC37.2030202@odi.ch>
References: <49E65947.1090406@odi.ch>
	<s5hd4bd2kbl.wl%tiwai@suse.de>	<49E6D8C0.4040206@odi.ch>
	<s5hzleh138t.wl%tiwai@suse.de>	<49E6DCED.90804@odi.ch>
	<s5h8wm1yoqv.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from viefep18-int.chello.at (viefep18-int.chello.at [62.179.121.38])
	by alsa0.perex.cz (Postfix) with ESMTP id 608D324456
	for <alsa-devel@alsa-project.org>;
	Fri, 17 Apr 2009 19:28:26 +0200 (CEST)
Received: from edge04.upc.biz ([192.168.13.239]) by viefep18-int.chello.at
	(InterMail vM.7.09.01.00 201-2219-108-20080618) with ESMTP
	id <20090417172826.PPNK25163.viefep18-int.chello.at@edge04.upc.biz>
	for <alsa-devel@alsa-project.org>; Fri, 17 Apr 2009 19:28:26 +0200
Received: from [192.168.111.10] (mithril [192.168.111.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by gollum.odi.ch (Postfix) with ESMTPSA id EAB8355FDA
	for <alsa-devel@alsa-project.org>;
	Fri, 17 Apr 2009 19:28:23 +0200 (CEST)
In-Reply-To: <s5h8wm1yoqv.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



Takashi Iwai wrote:
> The problem is likely because hp_detect field isn't set on your
> machine because the headphone shares the same audio-out widget with
> the speaker out.
> 
> Could you try the patch below?

Yes, this patch does the trick. The HP jack correctly mutes the speakers now.
Thanks a lot. I guess this will make it into mainline with the next rc?

Cheers,

Ortwin

> 
> thanks,
> 
> Takashi
> 
> ---
> diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
> index ce30b45..917bc5d 100644
> --- a/sound/pci/hda/patch_sigmatel.c
> +++ b/sound/pci/hda/patch_sigmatel.c
> @@ -3076,6 +3076,11 @@ static int create_multi_out_ctls(struct hda_codec *codec, int num_outs,
>  	unsigned int wid_caps;
>  
>  	for (i = 0; i < num_outs && i < ARRAY_SIZE(chname); i++) {
> +		if (type == AUTO_PIN_HP_OUT && !spec->hp_detect) {
> +			wid_caps = get_wcaps(codec, pins[i]);
> +			if (wid_caps & AC_WCAP_UNSOL_CAP)
> +				spec->hp_detect = 1;
> +		}
>  		nid = dac_nids[i];
>  		if (!nid)
>  			continue;
> @@ -3119,11 +3124,6 @@ static int create_multi_out_ctls(struct hda_codec *codec, int num_outs,
>  			err = create_controls_idx(codec, name, idx, nid, 3);
>  			if (err < 0)
>  				return err;
> -			if (type == AUTO_PIN_HP_OUT && !spec->hp_detect) {
> -				wid_caps = get_wcaps(codec, pins[i]);
> -				if (wid_caps & AC_WCAP_UNSOL_CAP)
> -					spec->hp_detect = 1;
> -			}
>  		}
>  	}
>  	return 0;
