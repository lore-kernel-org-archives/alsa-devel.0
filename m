Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F531F54AB0
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Mar 2026 13:26:32 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9FE4A601F3;
	Tue, 24 Mar 2026 14:26:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9FE4A601F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1774358790;
	bh=Y9i2D2cIw/y2BtdExkwbdsEZNmugJ2kDBJHl7/zF1F0=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=r9rbm9fTOSRP5doncXlLPPx7CpoP6M9EOQpf2HtKsKDCrY8D+NzD4dbgqyWo1knD+
	 zISva4gfXBXjLQ7aps6rQKTZ6LavWXNiSzsYHiuQ9Co/RSnyFOV0otyAVvbHHuEF+C
	 0vlIiI2bx8xv60lmeBhPw6SR2iT7aYAk6AREoVBc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8BC0AF805F1; Tue, 24 Mar 2026 14:25:56 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 217FFF805E8;
	Tue, 24 Mar 2026 14:25:56 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CC523F805BA; Tue, 24 Mar 2026 14:25:47 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 32145F800E2
	for <alsa-devel@alsa-project.org>; Tue, 24 Mar 2026 14:25:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 32145F800E2
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=SJajZZe6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774358746; x=1805894746;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=Y9i2D2cIw/y2BtdExkwbdsEZNmugJ2kDBJHl7/zF1F0=;
  b=SJajZZe6a3aj0mv0B2Nq9DmZqoUmP60brcsrqN8roPvREbPVXU9m7xOB
   qMkO3n8CTYzosnxwk0B4aTYl973CnSGZvGlph6wGRCF8xdJUX1oKKTczJ
   oVrujnKucWmIrQ0hpDIvB3h+85+hJi8w0dMWzti2KzBz+odm7E9LCTDlJ
   AzwVKxhVYHeutzvftIomerJTc3653Z3VG7WBzQcEE7U/cmGzE2bkqZ1Gm
   cJMy5dgTmRfSXljvuJcxztUBwHoKLXEH5FhAMDwic6qO9EAhNq+S7gmi+
   YnATPX0VZTzq1JsI6BtZA0kl7Lz6CpdYI+GY5vcGCSbwCZ8NLowE6jYdl
   Q==;
X-CSE-ConnectionGUID: Km2BHIyDSdiL1YepQpFzqg==
X-CSE-MsgGUID: AhVkayomT2qdcMXYWI+gZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="78969069"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000";
   d="scan'208";a="78969069"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2026 06:25:41 -0700
X-CSE-ConnectionGUID: Yq78sIntSxCzxP9bx/jjdQ==
X-CSE-MsgGUID: LKilQjOcTZqgh9UCtUx/Pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000";
   d="scan'208";a="262285658"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO [10.245.244.138])
 ([10.245.244.138])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2026 06:25:39 -0700
Message-ID: <fa31bed8-7446-4b83-b234-81f3cbfe3450@linux.intel.com>
Date: Tue, 24 Mar 2026 15:25:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (re)use and (re)definition of snd_pcm_hw_params->fifo_size for
 'jumpy DMA'
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Mark Brown <broonie@kernel.org>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>,
 "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, arun@asymptotic.io,
 wim.taymans@gmail.com
References: <a03350b3-5828-4ffe-ade7-b94bb6ec7d64@linux.intel.com>
 <c521e0d9-4d69-4fd4-9c29-bb9b62c93310@perex.cz>
 <8fe7f61b-dae4-4ae6-aa96-7e604a37e624@linux.intel.com>
 <813612ea-f942-432f-9bf1-7b1ccfe59046@perex.cz>
 <6b129498-f130-44a0-a679-6fa1c639046e@linux.intel.com>
Content-Language: en-US
In-Reply-To: <6b129498-f130-44a0-a679-6fa1c639046e@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: IVPM23AKPLNY3LDLCLWV5FBJJZ4MUDAL
X-Message-ID-Hash: IVPM23AKPLNY3LDLCLWV5FBJJZ4MUDAL
X-MailFrom: peter.ujfalusi@linux.intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/IVPM23AKPLNY3LDLCLWV5FBJJZ4MUDAL/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>



On 24/03/2026 12:51, Péter Ujfalusi wrote:
> The question is: is it enough to only have single value exposed or do we
> need/want add all small variations of this to be exposed?
> I would think that a single dma_fifo_size should be OK and apps should
> prepare for the crawling DMA case.
> 
>> But if we agree on other name like 'burst_size' or 'batch_size', I'll be
>> fine with it, too.
> 
> I think neither of these are right, unless we substitute them with a
> variable which tells the size of the FIFO in hardware that is going to
> be filled.
> max_hw_ptr_burst_size or max_dma_burst_size or max_burst_size - in frames?

something like this in kernel and then we need alsa-lib update and then we can introduce the use in pipewire?

diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index d3ce75ba938a..3a1872b3e701 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -421,7 +421,8 @@ struct snd_pcm_hw_params {
 	unsigned int rate_den;		/* R: rate denominator */
 	snd_pcm_uframes_t fifo_size;	/* R: chip FIFO size in frames */
 	unsigned char sync[16];		/* R: synchronization ID (perfect sync - one clock source) */
-	unsigned char reserved[48];	/* reserved for future */
+	snd_pcm_uframes_t max_dma_burst_size;	/* R: maximum DMA burst size in frames */
+	unsigned char reserved[48 - sizeof(snd_pcm_uframes_t)];	/* reserved for future */
 };
 
 enum {
diff --git a/sound/core/pcm_compat.c b/sound/core/pcm_compat.c
index e71f393d3b01..462588f3527b 100644
--- a/sound/core/pcm_compat.c
+++ b/sound/core/pcm_compat.c
@@ -64,7 +64,9 @@ struct snd_pcm_hw_params32 {
 	u32 rate_num;
 	u32 rate_den;
 	u32 fifo_size;
-	unsigned char reserved[64];
+	unsigned char sync[16];
+	u32 max_dma_burst_size;
+	unsigned char reserved[44];
 };
 
 struct snd_pcm_sw_params32 {
@@ -247,9 +249,11 @@ static int snd_pcm_ioctl_hw_params_compat(struct snd_pcm_substream *substream,
 	if (!data)
 		return -ENOMEM;
 
-	/* only fifo_size (RO from userspace) is different, so just copy all */
+	/* copy common members and fix up 32-bit uframe fields explicitly */
 	if (copy_from_user(data, data32, sizeof(*data32)))
 		return -EFAULT;
+	data->fifo_size = data32->fifo_size;
+	data->max_dma_burst_size = data32->max_dma_burst_size;
 
 	if (refine) {
 		err = snd_pcm_hw_refine(substream, data);
@@ -262,7 +266,8 @@ static int snd_pcm_ioctl_hw_params_compat(struct snd_pcm_substream *substream,
 	if (err < 0)
 		return err;
 	if (copy_to_user(data32, data, sizeof(*data32)) ||
-	    put_user(data->fifo_size, &data32->fifo_size))
+	    put_user(data->fifo_size, &data32->fifo_size) ||
+	    put_user(data->max_dma_burst_size, &data32->max_dma_burst_size))
 		return -EFAULT;
 
 	if (! refine) {


-- 
Péter

