Return-Path: <SRS0=Xi7p=LT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55CEBC2B9F4
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Jun 2021 20:27:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26F5861926
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Jun 2021 20:27:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26F5861926
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=b4.vu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 442181660;
	Fri, 25 Jun 2021 22:26:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 442181660
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1624652830;
	bh=5PixrmusxTI09h29SGZqts9LbD5PntagiYggPfWvaAc=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=izCt7YyW/nUhvTGHBcKKJol4gY2M+u//1fW0QJT/ZcyQe7Ywkj3jG2bs7A+M/JbuM
	 2Io31MfgjMVDOtSu8CsOxSizQvEBzitr93JD5jOpUSRNT4EqlwmeRaSVycDdc+JffM
	 ryHdyaSd3vwHpaf8Gr5EJyAatVdddjK/P/Llc918=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BC016F8016D;
	Fri, 25 Jun 2021 22:26:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AFB73F801D5; Fri, 25 Jun 2021 22:26:17 +0200 (CEST)
Received: from m.b4.vu (m.b4.vu [203.16.231.148])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DBCB2F800E1
 for <alsa-devel@alsa-project.org>; Fri, 25 Jun 2021 22:26:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DBCB2F800E1
Received: by m.b4.vu (Postfix, from userid 1000)
 id E89B461E5F02; Sat, 26 Jun 2021 05:56:04 +0930 (ACST)
Date: Sat, 26 Jun 2021 05:56:04 +0930
From: "Geoffrey D. Bennett" <g@b4.vu>
To: Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH v4] ALSA: usb-audio: scarlett2: Fix for loop increment in
 scarlett2_usb_get_config
Message-ID: <20210625202604.GB23780@m.b4.vu>
References: <20210625200549.1061113-1-nathan@kernel.org>
 <20210625201150.1523987-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210625201150.1523987-1-nathan@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, Nick Desaulniers <ndesaulniers@google.com>,
 linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 clang-built-linux@googlegroups.com
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Fri, Jun 25, 2021 at 01:11:51PM -0700, Nathan Chancellor wrote:
> Clang warns:
> 
> sound/usb/mixer_scarlett_gen2.c:1189:32: warning: expression result
> unused [-Wunused-value]
>                         for (i = 0; i < count; i++, (u16 *)buf++)
>                                                     ^      ~~~~~
> 1 warning generated.
> 
> It appears the intention was to cast the void pointer to a u16 pointer
> so that the data could be iterated through like an array of u16 values.
> However, the cast happens after the increment because a cast is an
> rvalue, whereas the post-increment operator only works on lvalues, so
> the loop does not iterate as expected.

Your note about no bug which was added in v2 went missing in v3:

> > the loop does not iterate as expected. This is not a bug in practice
> > because count is not greater than one at the moment but this could
> > change in the future so this should be fixed.

> Replace the cast with a temporary variable of the proper type, which is
> less error prone and fixes the iteration. Do the same thing for the
> 'u8 *' below this if block.
> 
> Fixes: ac34df733d2d ("ALSA: usb-audio: scarlett2: Update get_config to do endian conversion")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1408
> Acked-by: Geoffrey D. Bennett <g@b4.vu>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
> 
> v1 -> v2:
> 
> * Use temporary variables of proper type rather than casting, as
>   requested by Takashi.
> 
> * Mention that there is not a bug at the moment per Geoffrey's comment.
> 
> v2 -> v3:
> 
> * Restrict scope of buf_16 more, as requested by Geoffrey.
> 
> * Add Geoffrey's ack.
> 
> v3 -> v4:
> 
> * Fix stray newline added below
> 
>   if (config_item->size >= 8) {
> 
>   leftover from buf_16's declaration.
> 
>  sound/usb/mixer_scarlett_gen2.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/usb/mixer_scarlett_gen2.c b/sound/usb/mixer_scarlett_gen2.c
> index fcba682cd422..161d832cafef 100644
> --- a/sound/usb/mixer_scarlett_gen2.c
> +++ b/sound/usb/mixer_scarlett_gen2.c
> @@ -1177,6 +1177,7 @@ static int scarlett2_usb_get_config(
>  	const struct scarlett2_config *config_item =
>  		&scarlett2_config_items[info->has_mixer][config_item_num];
>  	int size, err, i;
> +	u8 *buf_8;
>  	u8 value;
>  
>  	/* For byte-sized parameters, retrieve directly into buf */
> @@ -1185,9 +1186,12 @@ static int scarlett2_usb_get_config(
>  		err = scarlett2_usb_get(mixer, config_item->offset, buf, size);
>  		if (err < 0)
>  			return err;
> -		if (size == 2)
> -			for (i = 0; i < count; i++, (u16 *)buf++)
> -				*(u16 *)buf = le16_to_cpu(*(__le16 *)buf);
> +		if (size == 2) {
> +			u16 *buf_16 = buf;
> +
> +			for (i = 0; i < count; i++, buf_16++)
> +				*buf_16 = le16_to_cpu(*(__le16 *)buf_16);
> +		}
>  		return 0;
>  	}
>  
> @@ -1197,8 +1201,9 @@ static int scarlett2_usb_get_config(
>  		return err;
>  
>  	/* then unpack from value into buf[] */
> +	buf_8 = buf;
>  	for (i = 0; i < 8 && i < count; i++, value >>= 1)
> -		*(u8 *)buf++ = value & 1;
> +		*buf_8++ = value & 1;
>  
>  	return 0;
>  }
> 
> base-commit: 0cbbeaf370221fc469c95945dd3c1198865c5fe4
> -- 
> 2.32.0.93.g670b81a890
> 
