Return-Path: <SRS0=72a4=G6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64931C433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 27 Jan 2021 01:46:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 999402054F
	for <alsa-devel@archiver.kernel.org>; Wed, 27 Jan 2021 01:46:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 999402054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0C4861757;
	Wed, 27 Jan 2021 02:45:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0C4861757
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611711989;
	bh=QCMhHWRkEazXwveGrg2WFHGznZkISBzg3LHloH43pHg=;
	h=Subject:From:To:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sinnMUkToeOrTehihyPxXJQnwDqMrrEZKPk+l6XXvTm12tC/z6k3e/5e5kOQIufX+
	 kvSMF47buCLSyacKTNtCVTwd0RMts6wCciuAq73vaoRQvLDISRUTtns28cta4kulDa
	 hWJg9hv7J0W87dZDu4yLS2cHEScEnO1hQeutRWP0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 774F5F80158;
	Wed, 27 Jan 2021 02:45:38 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1AF6FF8015B; Wed, 27 Jan 2021 02:45:37 +0100 (CET)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 066CEF8011C
 for <alsa-devel@alsa-project.org>; Wed, 27 Jan 2021 02:45:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 066CEF8011C
IronPort-SDR: 7sVw4kjigM1tZvuxDZQRq2Vgk+7ceAiFLIyMs1yMEciB8lsXvNjLDHPRZuWcla1AF7Js/6hf7X
 uZZyAnZjrxQQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9876"; a="264824234"
X-IronPort-AV: E=Sophos;i="5.79,378,1602572400"; d="scan'208";a="264824234"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jan 2021 17:45:20 -0800
IronPort-SDR: Kfsl6iHhANdfI89KNyycECUcKTJtXlipMCvsrutIx7L8IkdeLdySyDe7dwbgP7+gjUig7tKRuz
 P773VvZrdhIg==
X-IronPort-AV: E=Sophos;i="5.79,378,1602572400"; d="scan'208";a="472968850"
Received: from laurafux-mobl.amr.corp.intel.com ([10.254.96.47])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jan 2021 17:45:19 -0800
Message-ID: <38171d9c2cc6093676490cb0a9cf3123251fe1c0.camel@linux.intel.com>
Subject: Re: [PATCH 1/2] ASoC: SOF: Intel: hda: enable DMI L1 for
 D0i3-compatible streams
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
To: alsa-devel@alsa-project.org
Date: Tue, 26 Jan 2021 17:45:18 -0800
In-Reply-To: <20210126015130.1023840-2-ranjani.sridharan@linux.intel.com>
References: <20210126015130.1023840-1-ranjani.sridharan@linux.intel.com>
 <20210126015130.1023840-2-ranjani.sridharan@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Cc: broonie@kernel.org, tiwai@suse.com,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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

On Mon, 2021-01-25 at 17:51 -0800, Ranjani Sridharan wrote:
> DMI L1 entry is currently disabled whenever any capture stream is
> opened to prevent xruns during pause/release. But, in
> order to maximise power savings for the wake-on-voice usecase,
> DMI L1 entry should be enabled for D0i3-compatible capture streams.
> Introduce a new field, flags in struct sof_intel_hda_stream
> that stores whether a stream is dmi_l1_compatible. All playback
> streams,
> and D0i3-compatible capture streams are DMI L1 compatible.
> 
> Reviewed-by: Pierre-Louis Bossart <
> pierre-louis.bossart@linux.intel.com>
> Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
> Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> ---
>  sound/soc/sof/intel/hda-compress.c |  2 +-
>  sound/soc/sof/intel/hda-loader.c   |  2 +-
>  sound/soc/sof/intel/hda-pcm.c      | 16 ++++++++++++-
>  sound/soc/sof/intel/hda-stream.c   | 38 +++++++++++++++++-----------
> --
>  sound/soc/sof/intel/hda-trace.c    |  3 +--
>  sound/soc/sof/intel/hda.h          |  6 ++++-
>  6 files changed, 45 insertions(+), 22 deletions(-)
> 
> diff --git a/sound/soc/sof/intel/hda-compress.c
> b/sound/soc/sof/intel/hda-compress.c
> index 53c08034fa22..7899004df8d1 100644
> --- a/sound/soc/sof/intel/hda-compress.c
> +++ b/sound/soc/sof/intel/hda-compress.c
> @@ -25,7 +25,7 @@ int hda_probe_compr_assign(struct snd_sof_dev
> *sdev,
>  {
>  	struct hdac_ext_stream *stream;
>  
> -	stream = hda_dsp_stream_get(sdev, cstream->direction);
> +	stream = hda_dsp_stream_get(sdev, cstream->direction, 0)
Hi Mark,

Sorry, this wont build with the probes feature enabled in Kconfig
because of the missing semicolon. I will post v2 soon.

Thanks,
Ranjani

