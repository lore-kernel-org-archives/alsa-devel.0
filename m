Return-Path: <SRS0=L/cl=FI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2911C4361A
	for <alsa-devel@archiver.kernel.org>; Fri,  4 Dec 2020 11:47:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2741A22A85
	for <alsa-devel@archiver.kernel.org>; Fri,  4 Dec 2020 11:47:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2741A22A85
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 87D7D1867;
	Fri,  4 Dec 2020 12:46:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 87D7D1867
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607082468;
	bh=F+/ErHovTdtUsCMpIvEKrgPVJOpwVez3+Uw4pVqQnXM=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qVTQyYlHDMpfPQTlKTcwFhEEjxkqZjLTbzge6J84y9tBQjKRftp+XvmGzVGIIUrJ9
	 Xnkz0pdFMhH+Jf/eyNNfo0SfiSTZA4JGgSGaN64jfjFE1wIeTVVaUZZdyCHlTrPLhw
	 taxrS29jB+6ND617f8NcyCHZ3vpZWI/0lbPuGxls=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0A80CF80273;
	Fri,  4 Dec 2020 12:46:58 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2E4DDF80278; Fri,  4 Dec 2020 12:46:56 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3A4D6F8012A
 for <alsa-devel@alsa-project.org>; Fri,  4 Dec 2020 12:46:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3A4D6F8012A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
 header.i=@linuxfoundation.org header.b="lCi+qOLQ"
Date: Fri, 4 Dec 2020 12:48:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1607082405;
 bh=F+/ErHovTdtUsCMpIvEKrgPVJOpwVez3+Uw4pVqQnXM=;
 h=From:To:Cc:Subject:References:In-Reply-To:From;
 b=lCi+qOLQegcb1zS0cQxC6f3qalRxPBxOGNFLeqnQnpnhL8KrPTeDz11jk5YYAG4YW
 ODrdlMvx89SV4f6XpOJUwGwjthd3ygdvOwVXN/TdFeG/yxZj1ATvi8gOlYXt7lO1iZ
 DPPoLdfHnWsVA+fm38acp7krMijKmzrgSEtaDY+k=
From: Greg KH <gregkh@linuxfoundation.org>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 3/3] driver core: auxiliary bus: minor coding style tweaks
Message-ID: <X8oh8SCN0D2aF08t@kroah.com>
References: <160695681289.505290.8978295443574440604.stgit@dwillia2-desk3.amr.corp.intel.com>
 <X8ogtmrm7tOzZo+N@kroah.com> <X8og8xi3WkoYXet9@kroah.com>
 <X8ohB1ks1NK7kPop@kroah.com> <X8ohGE8IBKiafzka@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X8ohGE8IBKiafzka@kroah.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org, Kiran Patil <kiran.patil@intel.com>,
 linux-rdma@vger.kernel.org, Shiraz Saleem <shiraz.saleem@intel.com>,
 Martin Habets <mhabets@solarflare.com>, lgirdwood@gmail.com,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Fred Oh <fred.oh@linux.intel.com>, broonie@kernel.org, jgg@nvidia.com,
 Dave Ertman <david.m.ertman@intel.com>, kuba@kernel.org,
 netdev@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>,
 davem@davemloft.net, linux-kernel@vger.kernel.org,
 Parav Pandit <parav@mellanox.com>
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

On Fri, Dec 04, 2020 at 12:44:24PM +0100, Greg KH wrote:
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> For some reason, the original aux bus patch had some really long lines
> in a few places, probably due to it being a very long-lived patch in
> development by many different people.  Fix that up so that the two files
> all have the same length lines and function formatting styles.
> 
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/base/Kconfig     |  2 +-
>  drivers/base/auxiliary.c | 58 ++++++++++++++++++++++------------------
>  2 files changed, 33 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
> index 040be48ce046..ba52b2c40202 100644
> --- a/drivers/base/Kconfig
> +++ b/drivers/base/Kconfig
> @@ -2,7 +2,7 @@
>  menu "Generic Driver Options"
>  
>  config AUXILIARY_BUS
> -	bool
> +	tristate "aux bus!"
>  
>  config UEVENT_HELPER
>  	bool "Support for uevent helper"

Argh, wrong version of this patch, this was added locally for me to test
with, let me fix up and resend a v2 of this patch.

thanks,

greg k-h
