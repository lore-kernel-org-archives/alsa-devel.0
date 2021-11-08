Return-Path: <SRS0=zqBf=P3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B345EC433EF
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Nov 2021 13:40:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBB2861506
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Nov 2021 13:40:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DBB2861506
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E4AD91658;
	Mon,  8 Nov 2021 14:39:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E4AD91658
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1636378839;
	bh=CrHP5NclVNyUq69I51rHPowogQnUmiCP6Jq80Vci0L4=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Fqxcyj9rk9Iu7wzOKY+U0Nk8tLOLCaNImEgplfVLG/0p7xsoE8YU7xdIrB3Z+Wbvq
	 dSKzPsoAfpsNVpf8dQSRmJuvdOkIFIDuUyHRNa8peHlpu5gLO8fIfVEn1Bz3DwXfRj
	 3Idq4Ek5HtUda3TJIC/ZY5R21cKDwwbPmWRSjZAQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2BD60F8049E;
	Mon,  8 Nov 2021 14:39:47 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3D3FFF8049E; Mon,  8 Nov 2021 14:39:45 +0100 (CET)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 620EBF801D8;
 Mon,  8 Nov 2021 14:39:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 620EBF801D8
X-IronPort-AV: E=McAfee;i="6200,9189,10161"; a="212267307"
X-IronPort-AV: E=Sophos;i="5.87,218,1631602800"; d="scan'208";a="212267307"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Nov 2021 05:39:33 -0800
X-IronPort-AV: E=Sophos;i="5.87,218,1631602800"; d="scan'208";a="533315761"
Received: from anushave-mobl1.amr.corp.intel.com (HELO [10.255.85.158])
 ([10.255.85.158])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Nov 2021 05:39:31 -0800
Subject: Re: [PATCH] ASoC: SOF: build compression interface into snd_sof.ko
To: Arnd Bergmann <arnd@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Daniel Baluta <daniel.baluta@nxp.com>
References: <20211108111132.3800548-1-arnd@kernel.org>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <63c5b1fb-575e-f026-5a76-f08a366f7f38@linux.intel.com>
Date: Mon, 8 Nov 2021 07:39:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211108111132.3800548-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>,
 Bud Liviu-Alexandru <budliviu@gmail.com>, Randy Dunlap <rdunlap@infradead.org>,
 Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
 Paul Olaru <paul.olaru@oss.nxp.com>, Colin Ian King <colin.king@canonical.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, linux-kernel@vger.kernel.org,
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



On 11/8/21 5:11 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> With CONFIG_SND_SOC_SOF_COMPRESS=m, the compression code is
> not built into a the main SOF driver when that is built-in:
> 
> x86_64-linux-ld: sound/soc/sof/ipc.o: in function `ipc_stream_message':
> ipc.c:(.text+0x5a2): undefined reference to `snd_sof_compr_fragment_elapsed'
> x86_64-linux-ld: sound/soc/sof/topology.o: in function `sof_dai_load':
> topology.c:(.text+0x32d1): undefined reference to `snd_sof_compr_init_elapsed_work'
> x86_64-linux-ld: topology.c:(.text+0x32e1): undefined reference to `snd_sof_compr_init_elapsed_work'
> 
> Make this a 'bool' symbol so it just decides whether the
> code gets built at all.
> 
> Fixes: 858f7a5c45ca ("ASoC: SOF: Introduce fragment elapsed notification API")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

It's Monday morning and my memory is still foggy but I think we fixed
this problem with https://github.com/thesofproject/linux/pull/3180,
where we changed the Kconfigs for i.MX. We haven't sent this update
upstream for some reason.

Arnd, can you share the configuration that breaks with the existing
upstream code, I can check if the problem still exists.

Thanks!
