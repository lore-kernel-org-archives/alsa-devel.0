Return-Path: <SRS0=1nsM=42=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE89C10F27
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Mar 2020 18:06:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77C83215A4
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Mar 2020 18:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="a0i6pDIr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77C83215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CE4BF1693;
	Mon,  9 Mar 2020 19:05:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CE4BF1693
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583777182;
	bh=+AOe4PIFjhkLgSsRMn+4KGJyF8Sk5Hsr2hHUMbxXN/U=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=a0i6pDIrC75tcHEOxKZSm80WewTvsFDKcI8aMnbo3WSxVj0U048gZPQamJi+wqR8S
	 Cp0dAGCmP2OClS2xtKOC0WJUlsxdbVmxoUca79c5sV1Kdp4EKYHJLAW7nitUMenTeo
	 GAXnZCUXY41mkgEZaB0HX9+//tD/XoQOEeNTBXHo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3F2C4F801A3;
	Mon,  9 Mar 2020 19:05:32 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 84E3EF801EB; Mon,  9 Mar 2020 19:05:30 +0100 (CET)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E6E4BF800DA
 for <alsa-devel@alsa-project.org>; Mon,  9 Mar 2020 19:05:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E6E4BF800DA
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 09 Mar 2020 11:05:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,534,1574150400"; d="scan'208";a="231020439"
Received: from jdbostic-mobl1.amr.corp.intel.com (HELO [10.251.152.35])
 ([10.251.152.35])
 by orsmga007.jf.intel.com with ESMTP; 09 Mar 2020 11:05:22 -0700
Subject: Re: [RFC PATCH] soundwire: bus: Add flag to mark DPN_BlockCtrl1 as
 readonly
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, vkoul@kernel.org
References: <20200309173755.955-1-srinivas.kandagatla@linaro.org>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <d94fca16-ed61-632a-6f8c-84e3a97869c7@linux.intel.com>
Date: Mon, 9 Mar 2020 13:05:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200309173755.955-1-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
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



On 3/9/20 12:37 PM, Srinivas Kandagatla wrote:
> According to SoundWire Specification Version 1.2.
> "A Data Port number X (in the range 0-14) which supports only one
> value of WordLength may implement the WordLength field in the
> DPX_BlockCtrl1 Register as Read-Only, returning the fixed value of
> WordLength in response to reads."

Interesting.

I think it's a spec issue that you want to bring to the MIPI Audio WG 
attention.

The note below says 'the DPx_BlockCtrl1 Register remains as Read-Write, 
but the value written to the Read-Only field is not used'

Ignoring a value and returning an error are two different behaviors indeed.

My recommendation would be to add a DisCo property stating the 
WordLength value can be used by the bus code but not written to the 
Slave device registers.

> 
> As WSA881x interfaces in PDM mode making the only field "WordLength"
> in DPX_BlockCtrl1" fixed and read-only. Behaviour of writing to this
> register on WSA881x soundwire slave with Qualcomm Soundwire Controller
> is throwing up an error. Not sure how other controllers deal with
> writing to readonly registers, but this patch provides a way to avoid
> writes to DPN_BlockCtrl1 register by providing a ro_blockctrl1_reg
> flag in struct sdw_port_runtime.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
> 
> I will send patch for WSA881x to include this change once this patch
> is accepted.
> 
>   drivers/soundwire/bus.h    |  2 ++
>   drivers/soundwire/stream.c | 17 ++++++++++-------
>   2 files changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/soundwire/bus.h b/drivers/soundwire/bus.h
> index 204204a26db8..791e8d14093e 100644
> --- a/drivers/soundwire/bus.h
> +++ b/drivers/soundwire/bus.h
> @@ -79,6 +79,7 @@ int sdw_find_col_index(int col);
>    * @num: Port number. For audio streams, valid port number ranges from
>    * [1,14]
>    * @ch_mask: Channel mask
> + * @ro_blockctrl1_reg: Read Only flag for DPN_BlockCtrl1 register
>    * @transport_params: Transport parameters
>    * @port_params: Port parameters
>    * @port_node: List node for Master or Slave port_list
> @@ -89,6 +90,7 @@ int sdw_find_col_index(int col);
>   struct sdw_port_runtime {
>   	int num;
>   	int ch_mask;
> +	bool ro_blockctrl1_reg;
>   	struct sdw_transport_params transport_params;
>   	struct sdw_port_params port_params;
>   	struct list_head port_node;
> diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
> index 00348d1fc606..4491643aeb4a 100644
> --- a/drivers/soundwire/stream.c
> +++ b/drivers/soundwire/stream.c
> @@ -167,13 +167,15 @@ static int sdw_program_slave_port_params(struct sdw_bus *bus,
>   		return ret;
>   	}
>   
> -	/* Program DPN_BlockCtrl1 register */
> -	ret = sdw_write(s_rt->slave, addr2, (p_params->bps - 1));
> -	if (ret < 0) {
> -		dev_err(&s_rt->slave->dev,
> -			"DPN_BlockCtrl1 register write failed for port %d\n",
> -			t_params->port_num);
> -		return ret;
> +	if (!p_rt->ro_blockctrl1_reg) {
> +		/* Program DPN_BlockCtrl1 register */
> +		ret = sdw_write(s_rt->slave, addr2, (p_params->bps - 1));
> +		if (ret < 0) {
> +			dev_err(&s_rt->slave->dev,
> +				"DPN_BlockCtrl1 register write failed for port %d\n",
> +				t_params->port_num);
> +			return ret;
> +		}
>   	}
>   
>   	/* Program DPN_SampleCtrl1 register */
> @@ -1195,6 +1197,7 @@ static struct sdw_port_runtime
>   
>   	p_rt->ch_mask = port_config[port_index].ch_mask;
>   	p_rt->num = port_config[port_index].num;
> +	p_rt->ro_blockctrl1_reg = port_config[port_index].ro_blockctrl1_reg;
>   
>   	return p_rt;
>   }
> 
