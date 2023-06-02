Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B20CAC7EE24
	for <alsa-devel@archiver.kernel.org>; Fri,  2 Jun 2023 16:25:45 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6F0C7839;
	Fri,  2 Jun 2023 18:24:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6F0C7839
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1685723143;
	bh=2vScx9xL+4WATF6N210Q9YVlE3QByB+nFbRWxvKBxXE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=eqemMIzE1l80Cb50NIE4nTVtPxo9MmC2oVNBQNo+zKaOz2EPY2DFSUc24Py5mnja+
	 +T8F6soXXdq4ZQ+ZE29qyBZ13bmoqWHu65QhVWtoIozM7kyMPxTzLrCEh3jJFjVOZe
	 jAHOhvemUXu7hQwErAS9oar61pIXPEJ2pqWMScuE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1EDC5F805A0; Fri,  2 Jun 2023 18:23:45 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 851C4F80589;
	Fri,  2 Jun 2023 18:23:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7C3EDF80563; Fri,  2 Jun 2023 18:23:38 +0200 (CEST)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 00073F800ED
	for <alsa-devel@alsa-project.org>; Fri,  2 Jun 2023 18:23:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 00073F800ED
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=nl2hXBdA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685723010; x=1717259010;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2vScx9xL+4WATF6N210Q9YVlE3QByB+nFbRWxvKBxXE=;
  b=nl2hXBdA5oYUp+BphlSOV72Sw3eJwjOTI3drELAgsOd6bgcVYkYhhsKF
   3wF5NvD8EZiF02r+EezwXsO7UwUN4/S8gBY6VlKWo/qYNWO1PbTObR7yb
   K7AREQa7f5RDOUIn5zduU7FpiKpgn5ANeubnUwb19dsHJuuef9dd/PDlT
   UwmAh9opc1TADFB8fQaV9gAxVj3aYnvh7ieIYscaCjnGCQqeHblR/5HDO
   VCPXilAihDoCawToWkPqCF97tpTg/8lBFTLoubAI0AW10ZaebEQSCXEW7
   NLJLC7kEFS8iWrlfJ/LcnnRTukerwDPgVtyg9Ves9mdmlQ7km0gLtcwkg
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="442285456"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400";
   d="scan'208";a="442285456"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2023 09:23:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="685367783"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400";
   d="scan'208";a="685367783"
Received: from joshkuo-mobl.amr.corp.intel.com (HELO [10.209.39.242])
 ([10.209.39.242])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2023 09:23:14 -0700
Message-ID: <8ad62f37-8cf7-6bd0-3d4d-d04d5def893c@linux.intel.com>
Date: Fri, 2 Jun 2023 10:01:20 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH v2 4/5] soundwire: stream: Invert logic on runtime alloc
 flags
Content-Language: en-US
To: Charles Keepax <ckeepax@opensource.cirrus.com>, vkoul@kernel.org
Cc: yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 patches@opensource.cirrus.com
References: <20230602101140.2040141-1-ckeepax@opensource.cirrus.com>
 <20230602101140.2040141-4-ckeepax@opensource.cirrus.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230602101140.2040141-4-ckeepax@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID-Hash: OWS3BGHO2X4ID3NGCTESQZ5QJPWOIWGW
X-Message-ID-Hash: OWS3BGHO2X4ID3NGCTESQZ5QJPWOIWGW
X-MailFrom: pierre-louis.bossart@linux.intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/OWS3BGHO2X4ID3NGCTESQZ5QJPWOIWGW/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>



On 6/2/23 05:11, Charles Keepax wrote:
> sdw_stream_add_slave/master have flags to indicate if the master or
> slave runtime where allocated in that call to the function. Currently
> these flags are cleared on all the paths where the runtime is not
> allocated, it is more logic and simpler to set the flag on the one path
> where the runtime is allocated.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Much easier to review indeed, thanks!

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
> 
> Changes since v1:
>  - Split out of the goto patch to ease review
> 
> Also worth noting I guess this patch could be squashed with patch 1 in
> the series really, but I opted to leave them separate as patch 1 is a
> much simpler fix to be cherry-picked back to older kernels if someone
> needs the fixup, rather than mixing the fixup and tidy up.
> 
> Thanks,
> Charles
> 
>  drivers/soundwire/stream.c | 25 ++++++++++++-------------
>  1 file changed, 12 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
> index 6595f47b403b5..df5600a80c174 100644
> --- a/drivers/soundwire/stream.c
> +++ b/drivers/soundwire/stream.c
> @@ -1854,7 +1854,7 @@ int sdw_stream_add_master(struct sdw_bus *bus,
>  			  struct sdw_stream_runtime *stream)
>  {
>  	struct sdw_master_runtime *m_rt;
> -	bool alloc_master_rt = true;
> +	bool alloc_master_rt = false;
>  	int ret;
>  
>  	mutex_lock(&bus->bus_lock);
> @@ -1876,10 +1876,8 @@ int sdw_stream_add_master(struct sdw_bus *bus,
>  	 * it first), if so skip allocation and go to configuration
>  	 */
>  	m_rt = sdw_master_rt_find(bus, stream);
> -	if (m_rt) {
> -		alloc_master_rt = false;
> +	if (m_rt)
>  		goto skip_alloc_master_rt;
> -	}
>  
>  	m_rt = sdw_master_rt_alloc(bus, stream);
>  	if (!m_rt) {
> @@ -1888,6 +1886,8 @@ int sdw_stream_add_master(struct sdw_bus *bus,
>  		ret = -ENOMEM;
>  		goto unlock;
>  	}
> +
> +	alloc_master_rt = true;
>  skip_alloc_master_rt:
>  
>  	if (sdw_master_port_allocated(m_rt))
> @@ -1980,8 +1980,8 @@ int sdw_stream_add_slave(struct sdw_slave *slave,
>  {
>  	struct sdw_slave_runtime *s_rt;
>  	struct sdw_master_runtime *m_rt;
> -	bool alloc_master_rt = true;
> -	bool alloc_slave_rt = true;
> +	bool alloc_master_rt = false;
> +	bool alloc_slave_rt = false;
>  
>  	int ret;
>  
> @@ -1992,10 +1992,8 @@ int sdw_stream_add_slave(struct sdw_slave *slave,
>  	 * and go to configuration
>  	 */
>  	m_rt = sdw_master_rt_find(slave->bus, stream);
> -	if (m_rt) {
> -		alloc_master_rt = false;
> +	if (m_rt)
>  		goto skip_alloc_master_rt;
> -	}
>  
>  	/*
>  	 * If this API is invoked by Slave first then m_rt is not valid.
> @@ -2009,21 +2007,22 @@ int sdw_stream_add_slave(struct sdw_slave *slave,
>  		goto unlock;
>  	}
>  
> +	alloc_master_rt = true;
> +
>  skip_alloc_master_rt:
>  	s_rt = sdw_slave_rt_find(slave, stream);
> -	if (s_rt) {
> -		alloc_slave_rt = false;
> +	if (s_rt)
>  		goto skip_alloc_slave_rt;
> -	}
>  
>  	s_rt = sdw_slave_rt_alloc(slave, m_rt);
>  	if (!s_rt) {
>  		dev_err(&slave->dev, "Slave runtime alloc failed for stream:%s\n", stream->name);
> -		alloc_slave_rt = false;
>  		ret = -ENOMEM;
>  		goto alloc_error;
>  	}
>  
> +	alloc_slave_rt = true;
> +
>  skip_alloc_slave_rt:
>  	if (sdw_slave_port_allocated(s_rt))
>  		goto skip_port_alloc;
