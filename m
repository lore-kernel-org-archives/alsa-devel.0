Return-Path: <SRS0=sxeJ=4J=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74298C35656
	for <alsa-devel@archiver.kernel.org>; Fri, 21 Feb 2020 14:45:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0029620679
	for <alsa-devel@archiver.kernel.org>; Fri, 21 Feb 2020 14:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="rUvS/97/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0029620679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 44F0316B2;
	Fri, 21 Feb 2020 15:45:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 44F0316B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582296353;
	bh=VKwF3VJS6pNHqxrTvowpCTEnvTTRksPoXXumpXBXuP4=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rUvS/97/e0laKtMm9tXbUsHXaIhV4vwizktZuANU05Ihao78PSR3/XsQjLe6gMpuS
	 f6YFb6eNW8cXcJ/zz3TzR7t3jfeZjlkAfXbDki+91333vU6GTulmZOjUZdqXGhjt0x
	 BdJyfnaADuCX1Q7Bd/I8KzEIKWgY5xAtT8yqQZ0o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B303CF800C5;
	Fri, 21 Feb 2020 15:45:02 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 92516F80240; Fri, 21 Feb 2020 15:45:00 +0100 (CET)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 53B8CF80114
 for <alsa-devel@alsa-project.org>; Fri, 21 Feb 2020 15:44:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 53B8CF80114
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 21 Feb 2020 06:44:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,468,1574150400"; d="scan'208";a="236590411"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by orsmga003.jf.intel.com with ESMTP; 21 Feb 2020 06:44:51 -0800
Date: Fri, 21 Feb 2020 16:44:51 +0200 (EET)
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@eliteleevi.tm.intel.com
To: Jaroslav Kysela <perex@perex.cz>, ranjani.sridharan@linux.intel.com
Subject: Re: [PATCH] ASoC: SOF - topology - do not change the link trigger
 order for pre-1.4 firmware
In-Reply-To: <20200221100739.3883842-1-perex@perex.cz>
Message-ID: <alpine.DEB.2.21.2002211510050.2957@eliteleevi.tm.intel.com>
References: <20200221100739.3883842-1-perex@perex.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Takashi Iwai <tiwai@suse.de>,
 ALSA development <alsa-devel@alsa-project.org>,
 Mark Brown <broonie@kernel.org>,
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

Hi,

+Ranjani who did the link reorder patch 

On Fri, 21 Feb 2020, Jaroslav Kysela wrote:

> This patch is for SOF v1.3 firmware. The DSP firmware will crash (DSP oops)
> without this patch. The 1.4.1 firmare has this issue fixed.
> 
> The ABI version is used for the comparison, because the firmware version
> for the firmware files before 1.4.2 was not set properly (git hash was
> used).

build fails when this is applied on broonie/for-next. You need an 
additional

--- a/sound/soc/sof/topology.c
+++ b/sound/soc/sof/topology.c
@@ -3108,6 +3108,7 @@ static int sof_link_load(struct snd_soc_component 
*scomp, int index,
                         struct snd_soc_dai_link *link,
                         struct snd_soc_tplg_link_config *cfg)
 {
+       struct snd_sof_dev *sdev = snd_soc_component_get_drvdata(scomp);
        struct snd_soc_tplg_private *private = &cfg->priv;


> -             /* set trigger order */
> -             link->trigger[0] = SND_SOC_DPCM_TRIGGER_POST;
> -             link->trigger[1] = SND_SOC_DPCM_TRIGGER_POST;
> +             /* this causes DSP panic on firmware v1.3 */
> +             if (v->abi_version > SOF_ABI_VER(3, 7, 0)) {
> +                     /* set trigger order */
> +                     link->trigger[0] = SND_SOC_DPCM_TRIGGER_POST;
> +                     link->trigger[1] = SND_SOC_DPCM_TRIGGER_POST;

My results with older firmwares and this patch are a bit mixed. When I 
apply this patch and boot with v1.3 FW on a CFL platform (ABI 3.7.0, 
version 1:1:0-5dd9a), I get a DSP panic at stream stop with this patch, 
but _without_ it, playback is fine. :P

I tested both v1.3.1 and v1.3, and I get a DSP panic at stream stop with 
your patch (ABI 3:7:0 on both of these so trigger order is not changed). 
With v1.4 and all newer, streaming works as expected.

The original problem was sensitive to timing, so apparently there is still 
some variation how this triggers on different platforms. With 1.4, 1.4.1 
and 1.4.2 now out, primary solution is just to upgrade the firmware.

If this fix helps with some real-life case to cope with an old firmware, 
we should probably still consider this. Ranjani, does the above make 
sense?

Br, Kai
