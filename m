Return-Path: <SRS0=I/J9=ZL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A26C432C3
	for <alsa-devel@archiver.kernel.org>; Tue, 19 Nov 2019 14:27:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99CA2222A9
	for <alsa-devel@archiver.kernel.org>; Tue, 19 Nov 2019 14:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="JT43Y+LG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99CA2222A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7925D168E;
	Tue, 19 Nov 2019 15:26:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7925D168E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1574173655;
	bh=R2mPzikI4yUcaig1vTd89utBGT5zVaO/l1IWL0C/Y9o=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JT43Y+LGJ4yLm/IWSvZ5TCKklSwHqJn8dr6Jtbb6DggwMM5fDLr47YRo/SVFPnf9W
	 39BnMGyLT6zgxiFoNw0NJ9TReIaa5DZSa4mKVMlhmddtEHtWTdaGXjxzAcZFdFVt4P
	 fiTe6n+l0ZmObYwxJTcNCl8FGXkqTKyyT4nqI1ic=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BAEDBF80137;
	Tue, 19 Nov 2019 15:25:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 32F58F80148; Tue, 19 Nov 2019 15:25:51 +0100 (CET)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 735EFF800FF
 for <alsa-devel@alsa-project.org>; Tue, 19 Nov 2019 15:25:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 735EFF800FF
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 19 Nov 2019 06:25:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,324,1569308400"; d="scan'208";a="215551241"
Received: from trgallx-mobl.amr.corp.intel.com (HELO [10.251.154.79])
 ([10.251.154.79])
 by fmsmga001.fm.intel.com with ESMTP; 19 Nov 2019 06:25:44 -0800
To: Colin King <colin.king@canonical.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Jie Yang <yang.jie@linux.intel.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 "Subhransu S . Prusty" <subhransu.s.prusty@intel.com>,
 Vinod Koul <vkoul@kernel.org>, alsa-devel@alsa-project.org
References: <20191119113640.166940-1-colin.king@canonical.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <f084c578-2fd5-e090-7d90-1ddffa1e22be@linux.intel.com>
Date: Tue, 19 Nov 2019 08:23:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191119113640.166940-1-colin.king@canonical.com>
Content-Language: en-US
Cc: Sanyog Kale <sanyog.r.kale@intel.com>, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [alsa-devel] [PATCH] ASoC: Intel: mrfld: fix incorrect check on
	p->sink
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



On 11/19/19 5:36 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The check on p->sink looks bogus, I believe it should be p->source
> since the following code blocks are related to p->source. Fix
> this by replacing p->sink with p->source.
> 
> Addresses-Coverity: ("Copy-paste error")
> Fixes: 24c8d14192cc ("ASoC: Intel: mrfld: add DSP core controls")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
> 
> [ Note: this has not been tested ]
> 

wow, nice catch. this dates from October 2014 and was merged in Linux 3.19.

I did look at the entire function and indeed it does not seem logical at 
all and rather an unintentional bad copy-paste, probably undetected 
since changing the gains on capture is less straightforward to test.

	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
		dev_dbg(dai->dev, "Stream name=%s\n",
				dai->playback_widget->name);
		w = dai->playback_widget;
		snd_soc_dapm_widget_for_each_sink_path(w, p) {
			if (p->connected && !p->connected(w, p->sink))
				continue;
[snip]
		}
	} else {
		dev_dbg(dai->dev, "Stream name=%s\n",
				dai->capture_widget->name);
		w = dai->capture_widget;
		snd_soc_dapm_widget_for_each_source_path(w, p) {
			if (p->connected && !p->connected(w, p->sink))

<< here it doesn't look right to use sink here.

				continue;

This macro snd_soc_dapm_widget_for_each_source_path() is also used in 
the skylake/skl-topology.c but without any source/sink inversion.

I don't think anyone on the Intel side will have time to investigate 
further, and unless someone from the initial contributors states this 
was intentional (Vinod/Sanyog?), we should merge this.

let's see if there's any feedback and if not I'll ack this.


> ---
>   sound/soc/intel/atom/sst-atom-controls.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/intel/atom/sst-atom-controls.c b/sound/soc/intel/atom/sst-atom-controls.c
> index baef461a99f1..f883c9340eee 100644
> --- a/sound/soc/intel/atom/sst-atom-controls.c
> +++ b/sound/soc/intel/atom/sst-atom-controls.c
> @@ -1333,7 +1333,7 @@ int sst_send_pipe_gains(struct snd_soc_dai *dai, int stream, int mute)
>   				dai->capture_widget->name);
>   		w = dai->capture_widget;
>   		snd_soc_dapm_widget_for_each_source_path(w, p) {
> -			if (p->connected && !p->connected(w, p->sink))
> +			if (p->connected && !p->connected(w, p->source))
>   				continue;
>   
>   			if (p->connect &&  p->source->power &&
> 
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
