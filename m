Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0124FC433EF
	for <alsa-devel@archiver.kernel.org>; Wed, 13 Jul 2022 14:33:00 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4D03A173E;
	Wed, 13 Jul 2022 16:32:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4D03A173E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1657722779;
	bh=2J6SXMWdLRY7k+Xu1M4COjz6hfN05sGZcty/Ghsevy8=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LCPJ7R9Uw9WoSRHancAlx0SPHT98+vK8aYUoeLL/STdMkZbS8GVqmmEWuvMsIWo+7
	 +g0NF8++jraPcMYBq6IUhyEXdRjZSRr2bSrXLeIDtLGc33HpK/QldzKvkRnUZPseZH
	 fzSVbU2h5MAo4T7jApY+nZD8Zif/Wd53RQ1Hj7vA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EF76DF8019B;
	Wed, 13 Jul 2022 16:32:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E3947F80310; Wed, 13 Jul 2022 16:32:07 +0200 (CEST)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 54FD3F8019B
 for <alsa-devel@alsa-project.org>; Wed, 13 Jul 2022 16:31:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 54FD3F8019B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="dTsZjT2R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1657722722; x=1689258722;
 h=message-id:date:mime-version:subject:to:references:from:
 in-reply-to:content-transfer-encoding;
 bh=2J6SXMWdLRY7k+Xu1M4COjz6hfN05sGZcty/Ghsevy8=;
 b=dTsZjT2R2yfNUfi/a/Y2FrrxpfO6kyQAvaG52eRdSqV1qqZ8jKw13GQE
 Dz/qKzHaIORmd1De1r6pbxOHYnhyX/i4o6NlsctcFsciBcO2y8Z7ROf5j
 3CNskvXse805WI5PFzBm99FWlK7O0WoqA7ng/sifhyoXoy7zOV2e0nAmC
 l1uibTHQSCZuD0PBJGPV3tcPVacEo91KuUE5UtEvU9ikR0oBEYl6teEpT
 kUx70qQH+7AIbSYExp71Jvb45S+Uh2P7bhnzPJjLtwY7nre8vR5AOYlg3
 BlSH+rHUR9SgmD+Bi8envRxkSc8x8LkNK+yOxls/GhxOsYiGK93dPDZOi w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10407"; a="268261094"
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; d="scan'208";a="268261094"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jul 2022 07:31:54 -0700
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; d="scan'208";a="593010229"
Received: from melanief-mobl.amr.corp.intel.com (HELO [10.212.10.37])
 ([10.212.10.37])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jul 2022 07:31:53 -0700
Message-ID: <75e9b775-3bbe-0b34-2bd6-b4ac74620672@linux.intel.com>
Date: Wed, 13 Jul 2022 09:23:28 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.10.0
Subject: Re: [PATCH] soundwire: qcom: Update error prints to debug prints
Content-Language: en-US
To: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>, vkoul@kernel.org,
 agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
 broonie@kernel.org, robh+dt@kernel.org, quic_plai@quicinc.com,
 bgoswami@quicinc.com, perex@perex.cz, tiwai@suse.com,
 srinivas.kandagatla@linaro.org, quic_rohkumar@quicinc.com,
 linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 swboyd@chromium.org, judyhsiao@chromium.org
References: <1657714921-28072-1-git-send-email-quic_srivasam@quicinc.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <1657714921-28072-1-git-send-email-quic_srivasam@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 7/13/22 07:22, Srinivasa Rao Mandadapu wrote:
> Upadte error prints to debug prints to avoid redundant logging in kernel

update

> boot time, as these prints are informative prints in irq handler.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> ---
>  drivers/soundwire/qcom.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
> index 9df970e..a4293d0 100644
> --- a/drivers/soundwire/qcom.c
> +++ b/drivers/soundwire/qcom.c
> @@ -573,11 +573,10 @@ static irqreturn_t qcom_swrm_irq_handler(int irq, void *dev_id)
>  				break;
>  			case SWRM_INTERRUPT_STATUS_NEW_SLAVE_ATTACHED:
>  			case SWRM_INTERRUPT_STATUS_CHANGE_ENUM_SLAVE_STATUS:
> -				dev_err_ratelimited(swrm->dev, "%s: SWR new slave attached\n",
> -					__func__);
> +				dev_dbg(swrm->dev, "%s: SWR new slave attached\n", __func__);

any reason why the rate limitation was dropped?

>  				swrm->reg_read(swrm, SWRM_MCP_SLV_STATUS, &slave_status);
>  				if (swrm->slave_status == slave_status) {
> -					dev_err(swrm->dev, "Slave status not changed %x\n",
> +					dev_dbg(swrm->dev, "Slave status not changed %x\n",
>  						slave_status);
>  				} else {
>  					qcom_swrm_get_device_status(swrm);
