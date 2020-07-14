Return-Path: <SRS0=Ss6N=AZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D896C433E2
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Jul 2020 15:42:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF6182083B
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Jul 2020 15:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="MuVD7Glb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF6182083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 63C6A15F2;
	Tue, 14 Jul 2020 17:41:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 63C6A15F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594741321;
	bh=RZXSZ9xKR2Liw1B/2+DSp/kPs+oll6HWutFUyhWAe3I=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MuVD7GlbDl94zk96T3Nb++ltpVgU3c5JtI9vRPoMBWZlKkEGkKt2XxY9xwqeksxew
	 JKt1ot4SsgIbYLRbm+la++w4XFSdpJLr7rcvV4t9krMs9zVHzS5nnEOBItH51cjYCF
	 GuL0t56FLPsF1e7dIJYP5o/SZh9GqGuEQisbmt7c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CDB1EF8016F;
	Tue, 14 Jul 2020 17:41:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 441C1F8019B; Tue, 14 Jul 2020 17:41:09 +0200 (CEST)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4C019F800E5
 for <alsa-devel@alsa-project.org>; Tue, 14 Jul 2020 17:40:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4C019F800E5
IronPort-SDR: X178Ts0oA6EyFEpjIs5HzN6VjdiuwMpGtBKLQh+LlpKbYdjKbQKJyEIf8Vj/2oC1ovbQGxriyu
 pI+RakzEerMg==
X-IronPort-AV: E=McAfee;i="6000,8403,9681"; a="148939268"
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; d="scan'208";a="148939268"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2020 08:40:55 -0700
IronPort-SDR: m0BYAXeuu2TE6+1+xxM18alLnWjp1OFVtDLBDKdVS0ms3AvvByStz5Cz4x86L7PVh4nVv9vZ/l
 yVaMvNME4NxA==
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; d="scan'208";a="317758422"
Received: from pbusser-mobl1.amr.corp.intel.com (HELO [10.252.136.7])
 ([10.252.136.7])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2020 08:40:55 -0700
Subject: Re: [PATCH v3 07/10] topology: decode: Fix decoding PCM formats and
 rates
To: Piotr Maziarz <piotrx.maziarz@linux.intel.com>, alsa-devel@alsa-project.org
References: <1594725911-14308-1-git-send-email-piotrx.maziarz@linux.intel.com>
 <1594725911-14308-8-git-send-email-piotrx.maziarz@linux.intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <bca4e102-f734-df31-17aa-686bc1463819@linux.intel.com>
Date: Tue, 14 Jul 2020 10:40:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1594725911-14308-8-git-send-email-piotrx.maziarz@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: cezary.rojewski@intel.com, amadeuszx.slawinski@intel.com
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



On 7/14/20 6:25 AM, Piotr Maziarz wrote:
> Not checking _LAST format and rate, which are valid indexes in arrays,
> makes data loss while converting binary to standard ALSA configuration
> file.

I must be really thick on this one.

alsatplg converts from alsa-conf format to binary topology file.
The binary topology file is used by drivers.

In which cases would you convert from binary to alsa-conf files? And 
what tool would you use?


> Signed-off-by: Piotr Maziarz <piotrx.maziarz@linux.intel.com>
> ---
>   src/topology/pcm.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/src/topology/pcm.c b/src/topology/pcm.c
> index b15b950..db40114 100644
> --- a/src/topology/pcm.c
> +++ b/src/topology/pcm.c
> @@ -549,7 +549,7 @@ int tplg_save_stream_caps(snd_tplg_t *tplg ATTRIBUTE_UNUSED,
>   	if (err >= 0 && sc->formats) {
>   		err = tplg_save_printf(dst, pfx, "\tformats '");
>   		first = 1;
> -		for (i = 0; err >= 0 && i < SND_PCM_FORMAT_LAST; i++) {
> +		for (i = 0; err >= 0 && i <= SND_PCM_FORMAT_LAST; i++) {
>   			if (sc->formats & (1ULL << i)) {
>   				s = snd_pcm_format_name(i);
>   				err = tplg_save_printf(dst, NULL, "%s%s",
> @@ -563,7 +563,7 @@ int tplg_save_stream_caps(snd_tplg_t *tplg ATTRIBUTE_UNUSED,
>   	if (err >= 0 && sc->rates) {
>   		err = tplg_save_printf(dst, pfx, "\trates '");
>   		first = 1;
> -		for (i = 0; err >= 0 && i < SND_PCM_RATE_LAST; i++) {
> +		for (i = 0; err >= 0 && i <= SND_PCM_RATE_LAST; i++) {
>   			if (sc->rates & (1ULL << i)) {
>   				s = get_rate_name(i);
>   				err = tplg_save_printf(dst, NULL, "%s%s",
> 
