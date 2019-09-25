Return-Path: <SRS0=mf6l=XU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C95FEC432C2
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Sep 2019 17:06:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C32692146E
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Sep 2019 17:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="LRDHq8Va"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C32692146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5710016D0;
	Wed, 25 Sep 2019 19:05:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5710016D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1569431201;
	bh=LCn9dSBn/M+soTW8CCRdwW4KFUGgNWD7wdiJPfKiQgc=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LRDHq8Va3oPxCcqIwf56ojzIPjozBv3DbyHk9zN8mDCiThaRFHaHReDJCTNNFLE7Z
	 pO+Z8LOjJfRww/EwKXCnwpUbCTiePK8iSMi9alyExHq/lo3Pmhnpn9tcs8EAbeGhz9
	 b+4rlp2GycVgH41VZwheZYcfHclekg2HYHvSMl2o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DD659F80323;
	Wed, 25 Sep 2019 19:05:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2B455F8044C; Wed, 25 Sep 2019 19:05:36 +0200 (CEST)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1CFA5F80138
 for <alsa-devel@alsa-project.org>; Wed, 25 Sep 2019 19:05:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1CFA5F80138
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 25 Sep 2019 10:05:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,548,1559545200"; d="scan'208";a="203645824"
Received: from linux.intel.com ([10.54.29.200])
 by fmsmga001.fm.intel.com with ESMTP; 25 Sep 2019 10:05:25 -0700
Received: from aabousam-mobl1.amr.corp.intel.com (unknown [10.251.27.167])
 by linux.intel.com (Postfix) with ESMTP id 74B99580406;
 Wed, 25 Sep 2019 10:05:24 -0700 (PDT)
To: Navid Emamdoost <navid.emamdoost@gmail.com>
References: <20190925161922.22479-1-navid.emamdoost@gmail.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <13f4bd40-dbaa-e24e-edca-4b4acff9d9c5@linux.intel.com>
Date: Wed, 25 Sep 2019 12:05:28 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190925161922.22479-1-navid.emamdoost@gmail.com>
Content-Language: en-US
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, alsa-devel@alsa-project.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kjlu@umn.edu,
 Mark Brown <broonie@kernel.org>, Jie Yang <yang.jie@linux.intel.com>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 emamd001@umn.edu, smccaman@umn.edu, Thomas Gleixner <tglx@linutronix.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Enrico Weigelt <info@metux.net>, linux-kernel@vger.kernel.org
Subject: Re: [alsa-devel] [PATCH v2] ASoC: Intel: Skylake: prevent memory
 leak in snd_skl_parse_uuids
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

On 9/25/19 11:19 AM, Navid Emamdoost wrote:
> In snd_skl_parse_uuids if allocation for module->instance_id fails, the
> allocated memory for module shoulde be released. I changes the
> allocation for module to use devm_kzalloc to be resource_managed
> allocation and avoid the release in error path.

if you use devm_, don't you need to fix the error path as well then, I 
see a kfree(uuid) in skl_freeup_uuid_list().

I am not very familiar with this code but the error seems to be that the 
list_add_tail() is called after the module->instance_id is allocated, so 
there is a risk that the module allocated earlier is not freed (since 
it's not yet added to the list). Freeing the module as done in patch 1 
works, using devm_ without fixing the error path does not seem correct 
to me.

> 
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> ---
> Changes in v2:
> 	- Changed the allocation for module from kzalloc to devm_kzalloc
> ---
>   sound/soc/intel/skylake/skl-sst-utils.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/intel/skylake/skl-sst-utils.c b/sound/soc/intel/skylake/skl-sst-utils.c
> index d43cbf4a71ef..ac37f04b0eea 100644
> --- a/sound/soc/intel/skylake/skl-sst-utils.c
> +++ b/sound/soc/intel/skylake/skl-sst-utils.c
> @@ -284,7 +284,7 @@ int snd_skl_parse_uuids(struct sst_dsp *ctx, const struct firmware *fw,
>   	 */
>   
>   	for (i = 0; i < num_entry; i++, mod_entry++) {
> -		module = kzalloc(sizeof(*module), GFP_KERNEL);
> +		module = devm_kzalloc(ctx->dev, sizeof(*module), GFP_KERNEL);
>   		if (!module) {
>   			ret = -ENOMEM;
>   			goto free_uuid_list;
> 

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
