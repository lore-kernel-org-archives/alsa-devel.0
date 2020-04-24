Return-Path: <SRS0=j21J=6I=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9AB7C54FD0
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Apr 2020 19:57:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BAAF20781
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Apr 2020 19:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="pn2/t65e";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GijluJZW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BAAF20781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B79D816BD;
	Fri, 24 Apr 2020 21:56:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B79D816BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587758230;
	bh=+pvfaz3IqMnYjGkxO7GfD49G6/HakD3bt1eBbh5tgI0=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pn2/t65eKT1GfpGVruRnnGGBkPdTopF27IBOl0/esWhR0eXnGeJ4tGkrdiMMLpZv7
	 ho46XwXL7A3YWWfzkbC5cEjoNtGkxQPuthvX0HgMgg883j3T+q0VX+g3ltKZxz91NK
	 UWf4ASOALqRGahvQWZuGuxTHsEaMerfb8spBsnmo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2E44AF80116;
	Fri, 24 Apr 2020 21:56:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6538BF80142; Fri, 24 Apr 2020 21:56:13 +0200 (CEST)
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com
 [IPv6:2607:f8b0:4864:20::343])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 39F2FF80116
 for <alsa-devel@alsa-project.org>; Fri, 24 Apr 2020 21:56:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 39F2FF80116
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="GijluJZW"
Received: by mail-ot1-x343.google.com with SMTP id z17so14578707oto.4
 for <alsa-devel@alsa-project.org>; Fri, 24 Apr 2020 12:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=mxyNAcrpAygdl0PQUuE7YWHqIPwtRko8aJ9V9gG70nQ=;
 b=GijluJZWWp+LFBb7h6DeNgHOUecBxi1OD1hjb1vB7Iy4+Kc0JoPmtDax/Y20FupRuB
 FC3NU4SMoI6Fdl799BRM5BErL+sM7F66CeL4m93b7RfJ2UBMuhjPFL9mWWtUECF+bn5R
 /fBFRf9252j1gSjzpg+ifbxcmQ7dQIuXqMfjVbtCbAiO2cEVIcvkHom/B22omI84P9cj
 C5BUksbGxK1dKwTb6fTA5k0Rty3wKtgcEsdCc6kdDQCD7oZMMNqIPtJbyCpbnOFNkYWw
 COw8AwCgEBjo3Wj9sItt/5LNsOyhX7XQSvPJpSYwfIiI4V5aIGTtWpOTqTHKyzpOux+N
 FFxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=mxyNAcrpAygdl0PQUuE7YWHqIPwtRko8aJ9V9gG70nQ=;
 b=ZgEnrgkNQ5EXkSkrOZMgZFbBjvWI6K0cgvDoOL/LFlOFoBnCaLrYu98k4UlY2tUcUE
 Huse9pr8PF5axxcgv1fhVRZUHw7OI2/1R5xy3+n8R7us6jEtWnabfsSeS6dkfJGGU8ZV
 GDzkH1uctZYg74t3kXee3Rd7Yr26Y7YoosGZGUvV7UuZDauGJI+pVVIVgYKWUS4FuN2D
 9gJSAA/BMVEl9B4hlj5sowdo0D85u4fSqysm6yE/0owGbB8dWujGH/8q4MxwIpujCKf4
 Qew0lqFc4UW/XP+LmgjMunhOgA7BV6SE6CTFqiOwDin8ryHeTIVMmqa4TaQCmszCRXT8
 yG7A==
X-Gm-Message-State: AGi0Pubtbl75TCPS/wG0dsfYkj6OESEPs/XVyelYzVh5BOInmn7pO9ap
 XK8s8oXg+yh1hu6yQK9EgRA=
X-Google-Smtp-Source: APiQypKG99R9/t7a1R4PtD4C2Aa45HoghelBN5DZhIdQpZzDWtIT9YE/s90axTBUiQUGswriUfMh9A==
X-Received: by 2002:a05:6808:b0c:: with SMTP id
 s12mr8412430oij.163.1587758162094; 
 Fri, 24 Apr 2020 12:56:02 -0700 (PDT)
Received: from ubuntu-s3-xlarge-x86 ([2604:1380:4111:8b00::1])
 by smtp.gmail.com with ESMTPSA id h24sm1767443otj.25.2020.04.24.12.56.01
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 24 Apr 2020 12:56:01 -0700 (PDT)
Date: Fri, 24 Apr 2020 12:56:00 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH] soundwire: intel: Remove unused function
Message-ID: <20200424195600.GA45659@ubuntu-s3-xlarge-x86>
References: <20200422190815.5975-1-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200422190815.5975-1-sudipm.mukherjee@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
 Sanyog Kale <sanyog.r.kale@intel.com>, alsa-devel@alsa-project.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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

On Wed, Apr 22, 2020 at 08:08:15PM +0100, Sudip Mukherjee wrote:
> The function sdw_intel_init() is not used anywhere, remove it for now.
> 
> Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> ---
>  drivers/soundwire/intel_init.c | 23 -----------------------
>  1 file changed, 23 deletions(-)
> 
> diff --git a/drivers/soundwire/intel_init.c b/drivers/soundwire/intel_init.c
> index ad7053463889..2f37dad06321 100644
> --- a/drivers/soundwire/intel_init.c
> +++ b/drivers/soundwire/intel_init.c
> @@ -183,29 +183,6 @@ static acpi_status sdw_intel_acpi_cb(acpi_handle handle, u32 level,
>  }
>  
>  /**
> - * sdw_intel_init() - SoundWire Intel init routine
> - * @parent_handle: ACPI parent handle
> - * @res: resource data
> - *
> - * This scans the namespace and creates SoundWire link controller devices
> - * based on the info queried.
> - */
> -static void *sdw_intel_init(acpi_handle *parent_handle,
> -			    struct sdw_intel_res *res)
> -{
> -	acpi_status status;
> -
> -	status = acpi_walk_namespace(ACPI_TYPE_DEVICE,
> -				     parent_handle, 1,
> -				     sdw_intel_acpi_cb,
> -				     NULL, res, NULL);
> -	if (ACPI_FAILURE(status))
> -		return NULL;
> -
> -	return sdw_intel_add_controller(res);
> -}
> -
> -/**
>   * sdw_intel_exit() - SoundWire Intel exit
>   * @arg: callback context
>   *
> -- 
> 2.11.0
> 

This patch will cause two more warnings.

$ make -j$(nproc) -s O=out allyesconfig drivers/soundwire/intel_init.o
../drivers/soundwire/intel_init.c:152:20: warning: ‘sdw_intel_acpi_cb’
defined but not used [-Wunused-function]
 static acpi_status sdw_intel_acpi_cb(acpi_handle handle, u32 level,
                    ^~~~~~~~~~~~~~~~~
../drivers/soundwire/intel_init.c:51:2: warning:
‘sdw_intel_add_controller’ defined but not used [-Wunused-function]
 *sdw_intel_add_controller(struct sdw_intel_res *res)
  ^~~~~~~~~~~~~~~~~~~~~~~~

Removing these two functions seems to be enough. link_mask should also
be removed at that point.

Cheers,
Nathan
