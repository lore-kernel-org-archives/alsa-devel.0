Return-Path: <SRS0=GKc0=DA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BEF6C2D0A8
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Sep 2020 09:27:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AC4921D43
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Sep 2020 09:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="HrnGf89j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AC4921D43
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E8CDD1710;
	Wed, 23 Sep 2020 11:26:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E8CDD1710
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600853265;
	bh=IxOoVTxSE8/X2fdD3t7NY0FO+ygTmUf7ez4mwW/mW2Q=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HrnGf89j5MdnGiVUajV2q8zy4Dpq7sqHlDKonSp5bQ1rlvdE04O/Un3R3c585E653
	 eqwrMS2MC3V+3JFSZ4hairIntcsZLhDL+Bh0KeYtMLwRboDY/u/RknZbf56ZrPov1i
	 Bq8YgV77IpSFDp2pS6XVHcV2ySVNrLrS4LQHBXsU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 693BDF80162;
	Wed, 23 Sep 2020 11:26:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4FB8CF80171; Wed, 23 Sep 2020 11:26:52 +0200 (CEST)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 60FADF800B4
 for <alsa-devel@alsa-project.org>; Wed, 23 Sep 2020 11:26:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 60FADF800B4
IronPort-SDR: 60iz/ZUGeKt5mkc9x6Q2sYiUGkUVQHHdrTTXNBRD49SG8hKUWuMaahrlUzTqO9gKXNoF3Dukhy
 4ncbfTeAuztQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9752"; a="178907839"
X-IronPort-AV: E=Sophos;i="5.77,293,1596524400"; d="scan'208";a="178907839"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2020 02:26:41 -0700
IronPort-SDR: 55RBMWP5lxcU55p4cSMsuJunP00KQboHKpLlIUR66jYHQe+phK/fWjovhAcLSF1MI7ssKnWztL
 3hOJvkLsmRmg==
X-IronPort-AV: E=Sophos;i="5.77,293,1596524400"; d="scan'208";a="486367262"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2020 02:26:38 -0700
Date: Wed, 23 Sep 2020 12:25:05 +0300 (EEST)
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@eliteleevi.tm.intel.com
To: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH 5/6] ASoC: Intel: sof_sdw_rt700: add codec prefix
In-Reply-To: <b9481c23-5a09-0518-b05b-c01b2d04e102@perex.cz>
Message-ID: <alpine.DEB.2.22.394.2009231213470.3186@eliteleevi.tm.intel.com>
References: <20200923080514.3242858-1-kai.vehmanen@linux.intel.com>
 <20200923080514.3242858-6-kai.vehmanen@linux.intel.com>
 <b9481c23-5a09-0518-b05b-c01b2d04e102@perex.cz>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Content-ID: <alpine.DEB.2.22.394.2009231223050.3186@eliteleevi.tm.intel.com>
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 alsa-devel@alsa-project.org, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>, lgirdwood@gmail.com,
 pierre-louis.bossart@linux.intel.com, broonie@kernel.org,
 ranjani.sridharan@linux.intel.com, daniel.baluta@nxp.com
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

Hi,

On Wed, 23 Sep 2020, Jaroslav Kysela wrote:

> Dne 23. 09. 20 v 10:05 Kai Vehmanen napsal(a):
>> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > --- a/sound/soc/intel/boards/sof_sdw_rt700.c
> > +++ b/sound/soc/intel/boards/sof_sdw_rt700.c
> > @@ -23,9 +23,9 @@ static const struct snd_soc_dapm_widget rt700_widgets[] = {
> >  
> >  static const struct snd_soc_dapm_route rt700_map[] = {
> >  	/* Headphones */
> > -	{ "Headphones", NULL, "HP" },
> > -	{ "Speaker", NULL, "SPK" },
> > -	{ "MIC2", NULL, "AMIC" },
> > +	{ "Headphones", NULL, "rt700 HP" },
> > +	{ "Speaker", NULL, "rt700 SPK" },
> 
> > +	{ "rt700 MIC2", NULL, "AMIC" },
> 
> This line looks suspicious. Perhaps, the prefix should be added before AMIC ?

I believe this is still correct. We prefix the codec-side entry of the 
dapm routes with codec string and here MIC2 is the codec. This is aligned 
with existing code for 711 in sof_sdw_rt711.c:

static const struct snd_soc_dapm_route rt711_map[] = {
»       /* Headphones */
»       { "Headphone", NULL, "rt711 HP" },
»       { "rt711 MIC2", NULL, "Headset Mic" },
};

Br, Kai
