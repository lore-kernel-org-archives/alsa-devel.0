From: Andres Mejia <mcitadel@gmail.com>
Subject: Re: [PATCH - Set EAPD for Realtek ALC665 (Vendor Id:
 0x10eSet EAPD for Realtek ALC665 (Vendor Id: 0x10ec0665).
Date: Sun, 20 Mar 2011 17:57:50 -0400
Message-ID: <AANLkTinp-Q-B1dWANH2jKMNJURFzTGO_ogW_Ce+BHZqA@mail.gmail.com>
References: <1300644460-5968-1-git-send-email-mcitadel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 2AEFE103811
	for <alsa-devel@alsa-project.org>; Sun, 20 Mar 2011 22:57:52 +0100 (CET)
Received: by ewy28 with SMTP id 28so1165709ewy.38
	for <alsa-devel@alsa-project.org>; Sun, 20 Mar 2011 14:57:51 -0700 (PDT)
In-Reply-To: <1300644460-5968-1-git-send-email-mcitadel@gmail.com>
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

On 3/20/11, Andres Mejia <mcitadel@gmail.com> wrote:
>
> Signed-off-by: Andres Mejia <mcitadel@gmail.com>
>
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> index 50855cf..be910fa6 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -1264,6 +1264,7 @@ static void alc_auto_init_amp(struct hda_codec *codec,
> int type)
>  		case 0x10ec0660:
>  		case 0x10ec0662:
>  		case 0x10ec0663:
> +		case 0x10ec0665:
>  		case 0x10ec0862:
>  		case 0x10ec0889:
>  			set_eapd(codec, 0x14, 1);
> @@ -4236,6 +4237,7 @@ static void alc_power_eapd(struct hda_codec *codec)
>  	case 0x10ec0660:
>  	case 0x10ec0662:
>  	case 0x10ec0663:
> +	case 0x10ec0665:
>  	case 0x10ec0862:
>  	case 0x10ec0889:
>  		set_eapd(codec, 0x14, 0);
> --
> 1.7.4.1
>
>

About this patch, this was needed to enable sound on my system. Here
are the details.
http://www.alsa-project.org/db/?f=510193d676a7cc990a58800968afc7f91c4962b5

As far as I know, this was the only change necessary to get sound
working normally on my system.

-- 
Regards,
Andres Mejia
