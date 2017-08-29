From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3] sound: aoa: Convert to using %pOF
	instead of full_name
Date: Tue, 29 Aug 2017 07:35:03 -0500
Message-ID: <CAL_JsqKXYubBHVhcJ9ist8d6gFOCthdgc_pwnMGxNR7ajuXPrg@mail.gmail.com>
References: <20170807232919.30247-2-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by alsa0.perex.cz (Postfix) with ESMTP id 275EB266C6D
 for <alsa-devel@alsa-project.org>; Tue, 29 Aug 2017 14:35:26 +0200 (CEST)
Received: from mail-qt0-f170.google.com (mail-qt0-f170.google.com
 [209.85.216.170])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B096B21A94
 for <alsa-devel@alsa-project.org>; Tue, 29 Aug 2017 12:35:24 +0000 (UTC)
Received: by mail-qt0-f170.google.com with SMTP id t22so13922875qtg.4
 for <alsa-devel@alsa-project.org>; Tue, 29 Aug 2017 05:35:24 -0700 (PDT)
In-Reply-To: <20170807232919.30247-2-robh@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 7, 2017 at 6:29 PM, Rob Herring <robh@kernel.org> wrote:
> Now that we have a custom printf format specifier, convert users of
> full_name to use %pOF instead. This is preparation to remove storing
> of the full path string for each node.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: Jaroslav Kysela <perex@perex.cz>
> Cc: Takashi Iwai <tiwai@suse.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: alsa-devel@alsa-project.org
> ---
> v3: Split aoa to separate patch

Ping.

>
>  sound/aoa/codecs/tas.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/sound/aoa/codecs/tas.c b/sound/aoa/codecs/tas.c
> index 733b6365dad6..15c05755d270 100644
> --- a/sound/aoa/codecs/tas.c
> +++ b/sound/aoa/codecs/tas.c
> @@ -905,8 +905,8 @@ static int tas_i2c_probe(struct i2c_client *client,
>                 goto fail;
>         }
>         printk(KERN_DEBUG
> -              "snd-aoa-codec-tas: tas found, addr 0x%02x on %s\n",
> -              (unsigned int)client->addr, node->full_name);
> +              "snd-aoa-codec-tas: tas found, addr 0x%02x on %pOF\n",
> +              (unsigned int)client->addr, node);
>         return 0;
>   fail:
>         mutex_destroy(&tas->mtx);
> --
> 2.11.0
>
