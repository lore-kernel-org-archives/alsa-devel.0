Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CB0AC43334
	for <alsa-devel@archiver.kernel.org>; Wed,  6 Jul 2022 09:28:30 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 38D26168B;
	Wed,  6 Jul 2022 11:27:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 38D26168B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1657099708;
	bh=OqoSbqDwwOzRRi8jeyun12rYrQP6dVrQCq0Pp8SDvgk=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GLTZcw4ROnDeCMbqsvy/y+jTxjfUPQjj+/rhnrptm2Byj0IyvhtGHTzpdC6vJ/lTl
	 HVxGp9egRGoQBgAOCFuRTaO97i6NaH2+SsaewCXWA9gruw+jw4hapHWYUd2N5QTery
	 Ww0DuQzmWgLa6BnshMWBUt1qNU2txJcMhCTk2Qw0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8BBC9F8023A;
	Wed,  6 Jul 2022 11:27:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 38A14F8023A; Wed,  6 Jul 2022 11:27:34 +0200 (CEST)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A9EB4F80104;
 Wed,  6 Jul 2022 11:27:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A9EB4F80104
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="bLk4+1Ca"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1657099652; x=1688635652;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=OqoSbqDwwOzRRi8jeyun12rYrQP6dVrQCq0Pp8SDvgk=;
 b=bLk4+1CaauII4ubFY7hIF4CaxVGBG8MnWg9/PY2MENFdIrw8DmL4hgJs
 ULRJ7yU4VYKtmOk/X/U/eWgtuoIfYqDHfRpP0E9tDKtzdHYdRMSEvx2OK
 6jR02fLI+ABEB/1o09SwUFO1gsIrtl/9Bp5O2jtr6/5OKnU3ZIPB17EmK
 1nLY1qyGrhrL+7qQOvzD0IdDX4e18ptAJStZds95jlOLPXEZxAlSO0/Xq
 XTJpLUALhPe466v3MCHih0gQAuj9JLyf/f+6Y3FDYeWOUHxcvKj5CU5pQ
 JwhevX/TD1Y4zA5E8iwdHzZ03hXzCoLoA5hom82vCwEtRrp0ZdhBfawRh Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="282445811"
X-IronPort-AV: E=Sophos;i="5.92,249,1650956400"; d="scan'208";a="282445811"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2022 02:27:05 -0700
X-IronPort-AV: E=Sophos;i="5.92,249,1650956400"; d="scan'208";a="920089289"
Received: from gguerra-mobl1.ger.corp.intel.com (HELO [10.249.254.46])
 ([10.249.254.46])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2022 02:27:02 -0700
Message-ID: <2d7bb9f7-a316-16d8-b290-e0cae9b28127@linux.intel.com>
Date: Wed, 6 Jul 2022 12:27:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.10.0
Subject: Re: [PATCH 2/2] ASoC: SOF: sof-client-probes: cleanup tokenize_input()
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@oracle.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
References: <YsU4zCpaV7GBpHci@kili>
From: =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <YsU4zCpaV7GBpHci@kili>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>, Takashi Iwai <tiwai@suse.com>,
 kernel-janitors@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Mark Brown <broonie@kernel.org>, Daniel Baluta <daniel.baluta@nxp.com>,
 sound-open-firmware@alsa-project.org
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



On 06/07/2022 10:25, Dan Carpenter wrote:
> The tokenize_input() function is cleaner if it uses strndup_user()
> instead of simple_write_to_buffer().  The way it's written now, if
> *ppos is non-zero then it returns -EIO but normally we would return
> 0 in that case.  It's easier to handle that in the callers.

This patch breaks the probe point settings:

# echo 52,1,0 > /sys/kernel/debug/sof/probe_points
-bash: echo: write error: Invalid argument

I did not looked for the exact reason, but something is not correct.

> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  sound/soc/sof/sof-client-probes.c | 27 +++++++++++++--------------
>  1 file changed, 13 insertions(+), 14 deletions(-)
> 
> diff --git a/sound/soc/sof/sof-client-probes.c b/sound/soc/sof/sof-client-probes.c
> index 679bc7d371fc..6c922b683f67 100644
> --- a/sound/soc/sof/sof-client-probes.c
> +++ b/sound/soc/sof/sof-client-probes.c
> @@ -461,24 +461,17 @@ static int strsplit_u32(char *buf, const char *delim, u32 **tkns, size_t *num_tk
>  }
>  
>  static int tokenize_input(const char __user *from, size_t count,
> -			  loff_t *ppos, u32 **tkns, size_t *num_tkns)
> +			  u32 **tkns, size_t *num_tkns)
>  {
>  	char *buf;
>  	int ret;
>  
> -	buf = kmalloc(count + 1, GFP_KERNEL);
> -	if (!buf)
> -		return -ENOMEM;
> -
> -	ret = simple_write_to_buffer(buf, count, ppos, from, count);
> -	if (ret != count) {
> -		ret = ret >= 0 ? -EIO : ret;
> -		goto exit;
> -	}
> +	buf = strndup_user(from, count + 1);
> +	if (IS_ERR(buf))
> +		return PTR_ERR(buf);
>  
> -	buf[count] = '\0';
>  	ret = strsplit_u32(buf, ",", tkns, num_tkns);
> -exit:
> +
>  	kfree(buf);
>  	return ret;
>  }
> @@ -552,12 +545,15 @@ sof_probes_dfs_points_write(struct file *file, const char __user *from,
>  	u32 *tkns;
>  	int ret, err;
>  
> +	if (*ppos)
> +		return 0;
> +
>  	if (priv->extractor_stream_tag == SOF_PROBES_INVALID_NODE_ID) {
>  		dev_warn(dev, "no extractor stream running\n");
>  		return -ENOENT;
>  	}
>  
> -	ret = tokenize_input(from, count, ppos, &tkns, &num_tkns);
> +	ret = tokenize_input(from, count, &tkns, &num_tkns);
>  	if (ret < 0)
>  		return ret;
>  	bytes = sizeof(*tkns) * num_tkns;
> @@ -607,12 +603,15 @@ sof_probes_dfs_points_remove_write(struct file *file, const char __user *from,
>  	u32 *tkns;
>  	int ret, err;
>  
> +	if (*ppos)
> +		return 0;
> +
>  	if (priv->extractor_stream_tag == SOF_PROBES_INVALID_NODE_ID) {
>  		dev_warn(dev, "no extractor stream running\n");
>  		return -ENOENT;
>  	}
>  
> -	ret = tokenize_input(from, count, ppos, &tkns, &num_tkns);
> +	ret = tokenize_input(from, count, &tkns, &num_tkns);
>  	if (ret < 0)
>  		return ret;
>  	if (!num_tkns) {

-- 
Péter
