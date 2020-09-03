Return-Path: <SRS0=NgmJ=CM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E75B5C433E2
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Sep 2020 02:49:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5021E20758
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Sep 2020 02:49:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Mdg4yJdO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5021E20758
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AF83E18A9;
	Thu,  3 Sep 2020 04:48:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AF83E18A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599101368;
	bh=wR7idVxyX2tTDfBSzRp5AFE0S58IGRZ2MpDsYw7/ppA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Mdg4yJdOoMmzP7qo1AHCR8SwZbu5kHVkDwFTWi/dsZ0Y+3iHyQ1O/SoOKRIyLkfiB
	 p6CEDaTz6nDdy8PAADIr43bQB2MMI4iwFc4LqbjsUJRbEWZQm0ZLsms9vG7sg61DdR
	 +OSFSg43qLsFySLONQD7dMqSwcwpnWFAo70fnxLY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 35684F801DA;
	Thu,  3 Sep 2020 04:48:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AB771F80217; Thu,  3 Sep 2020 04:48:35 +0200 (CEST)
Received: from r3-20.sinamail.sina.com.cn (r3-20.sinamail.sina.com.cn
 [202.108.3.20]) by alsa1.perex.cz (Postfix) with SMTP id 7D5ADF800BA
 for <alsa-devel@alsa-project.org>; Thu,  3 Sep 2020 04:48:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7D5ADF800BA
Received: from unknown (HELO localhost.localdomain)([123.115.164.148])
 by sina.com with ESMTP
 id 5F50596B00017011; Thu, 3 Sep 2020 10:48:18 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
X-SMAIL-MID: 54947415074172
From: Hillf Danton <hdanton@sina.com>
To: trix@redhat.com
Subject: Re: [PATCH v2] soundwire: fix double free of dangling pointer
Date: Thu,  3 Sep 2020 10:48:01 +0800
Message-Id: <20200903024801.9032-1-hdanton@sina.com>
In-Reply-To: <20200902202650.14189-1-trix@redhat.com>
References: <20200902202650.14189-1-trix@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, ndesaulniers@google.com,
 pierre-louis.bossart@linux.intel.com, hdanton@sina.com,
 linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
 vkoul@kernel.org, shreyas.nc@intel.com, natechancellor@gmail.com,
 yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com
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


Wed,  2 Sep 2020 13:26:50 -0700
> From: Tom Rix <trix@redhat.com>
> 
> clang static analysis flags this problem
> 
> stream.c:844:9: warning: Use of memory after
>   it is freed
>         kfree(bus->defer_msg.msg->buf);
>               ^~~~~~~~~~~~~~~~~~~~~~~
> 
> This happens in an error handler cleaning up memory
> allocated for elements in a list.
> 
> 	list_for_each_entry(m_rt, &stream->master_list, stream_node) {
> 		bus = m_rt->bus;
> 
> 		kfree(bus->defer_msg.msg->buf);
> 		kfree(bus->defer_msg.msg);
> 	}
> 
> And is triggered when the call to sdw_bank_switch() fails.
> There are a two problems.
> 
> First, when sdw_bank_switch() fails, though it frees memory it
> does not clear bus's reference 'defer_msg.msg' to that memory.
> 
> The second problem is the freeing msg->buf. In some cases
> msg will be NULL so this will dereference a null pointer.
> Need to check before freeing.
> 
> Fixes: 99b8a5d608a6 ("soundwire: Add bank switch routine")
> Signed-off-by: Tom Rix <trix@redhat.com>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
> v2 : change title, was 'soundwire: fix error handling'
> ---
> drivers/soundwire/stream.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
> index 37290a799023..6e36deb505b1 100644
> --- a/drivers/soundwire/stream.c
> +++ b/drivers/soundwire/stream.c
> @@ -717,6 +717,7 @@ static int sdw_bank_switch(struct sdw_bus *bus, int m_rt_count)
>  	kfree(wbuf);
>  error_1:
>  	kfree(wr_msg);
> +	bus->defer_msg.msg = NULL;
>  	return ret;
>  }
>  
> @@ -840,9 +841,10 @@ static int do_bank_switch(struct sdw_stream_runtime *stream)
>  error:
>  	list_for_each_entry(m_rt, &stream->master_list, stream_node) {
>  		bus = m_rt->bus;
> -
> -		kfree(bus->defer_msg.msg->buf);
> -		kfree(bus->defer_msg.msg);
> +		if (bus->defer_msg.msg) {
> +			kfree(bus->defer_msg.msg->buf);
> +			kfree(bus->defer_msg.msg);
> +		}
>  	}
>  
>  msg_unlock:
> -- 
> 2.18.1

Looks like it needs also to release the current buf before putting the new
one into place.

--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -665,6 +665,10 @@ static int sdw_bank_switch(struct sdw_bu
 	if (!wr_msg)
 		return -ENOMEM;
 
+	if (bus->defer_msg.msg) {
+		kfree(bus->defer_msg.msg->buf);
+		kfree(bus->defer_msg.msg);
+	}
 	bus->defer_msg.msg = wr_msg;
 
 	wbuf = kzalloc(sizeof(*wbuf), GFP_KERNEL);

