Return-Path: <SRS0=8UIF=YD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19408C4360C
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Oct 2019 15:45:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97CB821835
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Oct 2019 15:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="HZCilxev"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97CB821835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BD2D71680;
	Thu, 10 Oct 2019 17:44:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BD2D71680
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1570722319;
	bh=Ccp83PyuOkWhPtHGWEAlATz4pLI3RKg5Emmc9A8MDls=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HZCilxevq0MhtMBjRirStWzB8XFJoSim9TXeaXU5lrBZte1LQHiTYdinJlNziSfzM
	 IK3eP8HpYv1Mji8WRx7aknt1TL8eymJAz5TxyAw6k/yNK5uFwG13N2Xsj/H9vAxz8v
	 EQMN+bwfB36vq1pC8Si+GbHkR0x3UQt3EpKsIA+k=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 329B5F8063E;
	Thu, 10 Oct 2019 17:41:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C3E80F804CA; Thu, 10 Oct 2019 17:41:09 +0200 (CEST)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4752DF80322
 for <alsa-devel@alsa-project.org>; Thu, 10 Oct 2019 17:41:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4752DF80322
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 10 Oct 2019 08:41:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,280,1566889200"; d="scan'208";a="369125060"
Received: from aandraox-mobl1.amr.corp.intel.com (HELO [10.254.98.68])
 ([10.254.98.68])
 by orsmga005.jf.intel.com with ESMTP; 10 Oct 2019 08:41:00 -0700
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Mark Brown <broonie@kernel.org>
References: <87sgo2ilso.wl-kuninori.morimoto.gx@renesas.com>
 <8736g2ilpt.wl-kuninori.morimoto.gx@renesas.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <699c1364-425e-3049-5753-25990d7ef1e6@linux.intel.com>
Date: Thu, 10 Oct 2019 10:29:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <8736g2ilpt.wl-kuninori.morimoto.gx@renesas.com>
Content-Language: en-US
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
Subject: Re: [alsa-devel] [PATCH 18/21] ASoC: soc-core: use mutex_lock() at
 snd_soc_add_component()
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>



On 10/8/19 11:31 PM, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> snd_soc_component_add() is using mutex_lock(),
> but it should be used at snd_soc_add_component().
> This patch tidyup it.
> This is prepare for snd_soc_register_dais() cleanup
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>   sound/soc/soc-core.c | 26 +++++++++++++++-----------
>   1 file changed, 15 insertions(+), 11 deletions(-)
> 
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index 5d96ffa..d4f80c8 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -2748,8 +2748,6 @@ EXPORT_SYMBOL_GPL(snd_soc_component_exit_regmap);
>   
>   static void snd_soc_component_add(struct snd_soc_component *component)
>   {
> -	mutex_lock(&client_mutex);
> -
>   	if (!component->driver->write && !component->driver->read) {
>   		if (!component->regmap)
>   			component->regmap = dev_get_regmap(component->dev,
> @@ -2760,8 +2758,6 @@ static void snd_soc_component_add(struct snd_soc_component *component)
>   
>   	/* see for_each_component */
>   	list_add(&component->list, &component_list);
> -
> -	mutex_unlock(&client_mutex);
>   }
>   
>   static void snd_soc_component_del(struct snd_soc_component *component)
> @@ -2835,9 +2831,11 @@ int snd_soc_add_component(struct device *dev,
>   	int ret;
>   	int i;
>   
> +	mutex_lock(&client_mutex);
> +
>   	ret = snd_soc_component_initialize(component, component_driver, dev);
>   	if (ret)
> -		goto err_free;
> +		goto err_del;
>   
>   	if (component_driver->endianness) {
>   		for (i = 0; i < num_dai; i++) {
> @@ -2849,17 +2847,23 @@ int snd_soc_add_component(struct device *dev,
>   	ret = snd_soc_register_dais(component, dai_drv, num_dai);
>   	if (ret < 0) {
>   		dev_err(dev, "ASoC: Failed to register DAIs: %d\n", ret);
> -		goto err_cleanup;
> +		goto err_del;
>   	}
>   
>   	snd_soc_component_add(component);
> -	snd_soc_try_rebind_card();
>   
> -	return 0;
> +err_del:
> +	mutex_unlock(&client_mutex);
> +
> +	/*
> +	 * these should be called without
> +	 * mutex_unlock(client_mutex)
> +	 */
> +	if (ret < 0)
> +		snd_soc_del_component(component);

the first thing done in snd_soc_del_component is to take the same mutex.


> +	else
> +		snd_soc_try_rebind_card();
>   
> -err_cleanup:
> -	snd_soc_del_component(component);
> -err_free:
>   	return ret;
>   }
>   EXPORT_SYMBOL_GPL(snd_soc_add_component);
> 
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
