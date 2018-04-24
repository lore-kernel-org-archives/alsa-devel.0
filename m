From: Ruslan Bilovol <ruslan.bilovol@gmail.com>
Subject: Re: [PATCH 2/4] ALSA: usb-audio: ADC3: Fix channel
 mapping conversion for ADC3.
Date: Tue, 24 Apr 2018 11:03:40 +0300
Message-ID: <CAB=otbQur-_pvTNccni-sNYuemo2aeiyahXUBZLoSALxphAzaA@mail.gmail.com>
References: <20180420170327.31569-1-jorge.sanjuan@codethink.co.uk>
 <20180420170327.31569-3-jorge.sanjuan@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ot0-f194.google.com (mail-ot0-f194.google.com
 [74.125.82.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 69F12266CA1
 for <alsa-devel@alsa-project.org>; Tue, 24 Apr 2018 10:03:42 +0200 (CEST)
Received: by mail-ot0-f194.google.com with SMTP id w4-v6so20242620ote.12
 for <alsa-devel@alsa-project.org>; Tue, 24 Apr 2018 01:03:41 -0700 (PDT)
In-Reply-To: <20180420170327.31569-3-jorge.sanjuan@codethink.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, alsa-devel@alsa-project.org, Michael Drake <michael.drake@codethink.co.uk>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 20, 2018 at 8:03 PM, Jorge Sanjuan
<jorge.sanjuan@codethink.co.uk> wrote:
> From: Michael Drake <michael.drake@codethink.co.uk>
>
> The channel mapping is defined by bChRelationship, not bChPurpose.
>
> Signed-off-by: Michael Drake <michael.drake@codethink.co.uk>
> ---
>  sound/usb/stream.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/usb/stream.c b/sound/usb/stream.c
> index 6a8f5843334e..956be9f7c72a 100644
> --- a/sound/usb/stream.c
> +++ b/sound/usb/stream.c
> @@ -349,7 +349,7 @@ snd_pcm_chmap_elem *convert_chmap_v3(struct uac3_cluster_header_descriptor
>                          * TODO: this conversion is not complete, update it
>                          * after adding UAC3 values to asound.h
>                          */
> -                       switch (is->bChPurpose) {
> +                       switch (is->bChRelationship) {

Good catch!

Somehow I overlooked this, so in my case of Generic Audio it is always
mono.

Reviewed-by: Ruslan Bilovol <ruslan.bilovol@gmail.com>

>                         case UAC3_CH_MONO:
>                                 map = SNDRV_CHMAP_MONO;
>                                 break;
> --
> 2.11.0
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
