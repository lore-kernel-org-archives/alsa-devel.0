Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA2FFC83F15
	for <alsa-devel@archiver.kernel.org>; Wed, 30 Aug 2023 17:14:51 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6212A203;
	Wed, 30 Aug 2023 19:13:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6212A203
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1693415688;
	bh=ANfXAO5TdW9bfyaLHG5RVf/5RWD0EfUwUeq0Rle47AU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=pKkEy+40tKkZZy6sDV9b0hJDlgPQeP6Hu/13MYsybb7MRh4KQIkqIwJsOZxJWJHUz
	 hwIZIxqxIKYmxenlcMNY4OrDMxOTo/aRdcMfyu55MwCkyzRljAC6CCmNzgWojCtqgO
	 cGdxadDI2VjMvzsztuHU9ipNZq9cDExAs3850QWE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1CCD0F80074; Wed, 30 Aug 2023 19:13:36 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 86E21F80094;
	Wed, 30 Aug 2023 19:13:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 01DEAF80155; Wed, 30 Aug 2023 19:13:30 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 9E15AF80094;
	Wed, 30 Aug 2023 19:13:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9E15AF80094
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=FCK3LPHl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693415607; x=1724951607;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ANfXAO5TdW9bfyaLHG5RVf/5RWD0EfUwUeq0Rle47AU=;
  b=FCK3LPHlZFo1+r1zXgX8Ub6NXpTMGNMrfCfygh+YpKYKBm93dE4Svbc6
   DbPRc/wFBTFK9ruv92aMz+x9jPmVf8J4UB7Vd3M0oHhZC7brCh13VWGzo
   GEuMxZ039GwFV1PaivDpVjI2Iw8mjE3n1XvlaUyeJ5dG6HuB6QkN11LnI
   tAkFDzw/LR4KCSJrbB+hviIfADZ+e2m33Vmjh2hlOajn1zTbnUyhZ/rmy
   WPD+V7e9glIH/PZeUYN5/UpPJXXd8twqaDyvAHWle/PLEteAzspH87H/0
   4QrlnwT5AVvBDtmZu73bRJevRw6uP2RMVqcfcUoJq71isx2S1rBmLBHV/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="356019144"
X-IronPort-AV: E=Sophos;i="6.02,214,1688454000";
   d="scan'208";a="356019144"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Aug 2023 10:13:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="774175297"
X-IronPort-AV: E=Sophos;i="6.02,214,1688454000";
   d="scan'208";a="774175297"
Received: from cunningh-mobl.amr.corp.intel.com (HELO [10.212.55.116])
 ([10.212.55.116])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Aug 2023 10:13:18 -0700
Message-ID: <ac21f644-dedc-289b-3783-0cf2db8c0a73@linux.intel.com>
Date: Wed, 30 Aug 2023 12:13:17 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v4 01/11] ASoC: SOF: core: add 'no_wq' probe and remove
 callbacks
Content-Language: en-US
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 alsa-devel@alsa-project.org
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, Mark Brown
 <broonie@kernel.org>, Daniel Baluta <daniel.baluta@nxp.com>,
 linux-kernel@vger.kernel.org, sound-open-firmware@alsa-project.org
References: <20230830153652.217855-1-maarten.lankhorst@linux.intel.com>
 <20230830153652.217855-2-maarten.lankhorst@linux.intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230830153652.217855-2-maarten.lankhorst@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID-Hash: YJQ5LOAXYCZE5OBSYQQOYQP3KLXHZC6O
X-Message-ID-Hash: YJQ5LOAXYCZE5OBSYQQOYQP3KLXHZC6O
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/YJQ5LOAXYCZE5OBSYQQOYQP3KLXHZC6O/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


> +static inline int snd_sof_remove_no_wq(struct snd_sof_dev *sdev)
> +{
> +	if (sof_ops(sdev)->remove_no_wq)
> +		return sof_ops(sdev)->remove_no_wq(sdev);
> +
> +	return 0;
> +}

>  	/* probe/remove/shutdown */
> +	int (*probe_no_wq)(struct snd_sof_dev *sof_dev); /* optional */
> +	int (*remove_no_wq)(struct snd_sof_dev *sof_dev); /* optional */

My initial PR didn't have this remove_no_wq() callback.

For symmetry it could be useful if it is meant to undo what the
probe_no_wq() did, but conceptually the first thing we do in the remove
is make sure that workqueue is either not scheduled or we wait until it
completes.

int snd_sof_device_remove(struct device *dev)
{
	struct snd_sof_dev *sdev = dev_get_drvdata(dev);
	struct snd_sof_pdata *pdata = sdev->pdata;
	int ret;

	if (IS_ENABLED(CONFIG_SND_SOC_SOF_PROBE_WORK_QUEUE))
		cancel_work_sync(&sdev->probe_work);

