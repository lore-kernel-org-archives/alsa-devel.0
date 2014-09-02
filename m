From: Dana Goyette <DanaGoyette@gmail.com>
Subject: Re: ALC1150 broken on SuperMicro X10SAT
Date: Mon, 01 Sep 2014 20:07:26 -0700
Message-ID: <5405346E.1010502@gmail.com>
References: <lttbnc$7ck$1@ger.gmane.org> <s5hmwaj8op1.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 0E9D926518B
 for <alsa-devel@alsa-project.org>; Mon,  1 Sep 2014 22:07:41 +0200 (CEST)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1XOXt3-00070Q-Pq
 for alsa-devel@alsa-project.org; Mon, 01 Sep 2014 22:07:37 +0200
Received: from 173-228-55-68.static.sonic.net ([173.228.55.68])
 by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Mon, 01 Sep 2014 22:07:37 +0200
Received: from DanaGoyette by 173-228-55-68.static.sonic.net with local
 (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Mon, 01 Sep 2014 22:07:37 +0200
In-Reply-To: <s5hmwaj8op1.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 09/01/2014 06:17 AM, Takashi Iwai wrote:
> What about the patch below?  It might be that only one of two changes
> is needed.
>
>
> thanks,
>
> Takashi
>
> ---
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> index d446ac3137b3..1ba22fb527c2 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -328,6 +328,7 @@ static void alc_auto_init_amp(struct hda_codec *codec, int type)
>   		case 0x10ec0885:
>   		case 0x10ec0887:
>   		/*case 0x10ec0889:*/ /* this causes an SPDIF problem */
> +		case 0x10ec0900:
>   			alc889_coef_init(codec);
>   			break;
>   		case 0x10ec0888:
> @@ -2350,6 +2351,7 @@ static int patch_alc882(struct hda_codec *codec)
>   	switch (codec->vendor_id) {
>   	case 0x10ec0882:
>   	case 0x10ec0885:
> +	case 0x10ec0900:
>   		break;
>   	default:
>   		/* ALC883 and variants */
>
I've applied the patch, and that fixes it without having to specify a 
model.  Thanks!

For reference, here's alsa-info after the patch:

http://www.alsa-project.org/db/?f=d3a135bd31671e545067821bbd2cacc9d8f6fff8
