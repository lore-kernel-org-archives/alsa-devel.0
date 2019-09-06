Return-Path: <SRS0=qBPI=XB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10013C43331
	for <alsa-devel@archiver.kernel.org>; Fri,  6 Sep 2019 15:33:37 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F11A20838
	for <alsa-devel@archiver.kernel.org>; Fri,  6 Sep 2019 15:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Hlgp01hl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F11A20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6ACE142;
	Fri,  6 Sep 2019 17:07:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6ACE142
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1567782509;
	bh=EL+r4NLmSqKsKUO3Ve2b0/PwUQBuWGRc8iZwUFMrhXg=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Hlgp01hl5Bi94hAHSVMlMWsoaUlcg4HBXG98YFrjuxaBACIVLyhGmmrWklxmsRDjc
	 uCFVbXq+4eSblHKhRkwut1iyan4CzcLxF45reUHLv6lbeHkAgLdbc9Y9cbHkfUn9gl
	 gwRuJYu3TFs3wxuRcOzL5IBKcC81AEuq8XzV1eRQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C3B5CF80390;
	Fri,  6 Sep 2019 17:07:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 15CC2F80394; Fri,  6 Sep 2019 17:07:37 +0200 (CEST)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B8E8FF80171
 for <alsa-devel@alsa-project.org>; Fri,  6 Sep 2019 17:07:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B8E8FF80171
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 06 Sep 2019 08:07:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,473,1559545200"; d="scan'208";a="208251228"
Received: from linux.intel.com ([10.54.29.200])
 by fmsmga004.fm.intel.com with ESMTP; 06 Sep 2019 08:07:28 -0700
Received: from ravisha1-mobl1.amr.corp.intel.com (unknown [10.255.36.89])
 by linux.intel.com (Postfix) with ESMTP id EA988580858;
 Fri,  6 Sep 2019 08:07:27 -0700 (PDT)
To: Kai Vehmanen <kai.vehmanen@linux.intel.com>, alsa-devel@alsa-project.org, 
 tiwai@suse.de
References: <20190906142909.770-1-kai.vehmanen@linux.intel.com>
 <20190906142909.770-5-kai.vehmanen@linux.intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <ca81f61d-3ba8-3310-b75f-dabee7e0d766@linux.intel.com>
Date: Fri, 6 Sep 2019 10:07:23 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190906142909.770-5-kai.vehmanen@linux.intel.com>
Content-Language: en-US
Cc: libin.yang@intel.com
Subject: Re: [alsa-devel] [RFC PATCH v2 4/6] ALSA: hda/hdmi - implement
 mst_no_extra_pcms flag
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

On 9/6/19 9:29 AM, Kai Vehmanen wrote:
> When mst_no_exxtra_pcms flag is set, the codec should not

typo: extra

> use backup PCMs to handle DP-MST scenarios. Instead a simple
> 1:1 mapping is assumed between PCMs and converters.
> 
> Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
> ---
>   sound/pci/hda/patch_hdmi.c | 19 ++++++++++++++-----
>   1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
> index bca5de78e9ad..59aaee4a40fd 100644
> --- a/sound/pci/hda/patch_hdmi.c
> +++ b/sound/pci/hda/patch_hdmi.c
> @@ -2072,15 +2072,24 @@ static bool is_hdmi_pcm_attached(struct hdac_device *hdac, int pcm_idx)
>   static int generic_hdmi_build_pcms(struct hda_codec *codec)
>   {
>   	struct hdmi_spec *spec = codec->spec;
> -	int idx;
> +	int idx, pcm_num;
>   
>   	/*
>   	 * for non-mst mode, pcm number is the same as before
> -	 * for DP MST mode, pcm number is (nid number + dev_num - 1)
> -	 *  dev_num is the device entry number in a pin
> -	 *
> +	 * for DP MST mode without extra PCM, pcm number is same
> +	 * for DP MST mode with extra PCMs, pcm number is
> +	 *  (nid number + dev_num - 1)
> +	 * dev_num is the device entry number in a pin
>   	 */
> -	for (idx = 0; idx < spec->num_nids + spec->dev_num - 1; idx++) {
> +
> +	if (codec->mst_no_extra_pcms)
> +		pcm_num = spec->num_nids;
> +	else
> +		pcm_num = spec->num_nids + spec->dev_num - 1;
> +
> +	codec_dbg(codec, "hdmi: pcm_num set to %d\n", pcm_num);
> +
> +	for (idx = 0; idx < pcm_num; idx++) {
>   		struct hda_pcm *info;
>   		struct hda_pcm_stream *pstr;
>   
> 

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
