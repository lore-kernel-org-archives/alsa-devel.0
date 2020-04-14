Return-Path: <SRS0=tzaW=56=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67101C352BE
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Apr 2020 16:15:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD88720678
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Apr 2020 16:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="vRX9Vwo/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD88720678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 288D01693;
	Tue, 14 Apr 2020 18:14:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 288D01693
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586880920;
	bh=9vFHwdygG/1mZ20+N+A/5fVDKfjUCafUsG3NfidVudI=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vRX9Vwo/IJRrb4wwKsHsdizzUgQCDESj2pz99fa3EMobLjNAZLVjMU3qMbEpe9l5N
	 TAJKQ+EzAP1exjhQbB4Pd9/hjp2ZrPtqcQa2zpLJZHMDJ19x7TnmUxz9p1OZ5W8P6a
	 xU15yhw5x7kzq2Wr1KpyhdTcekJ+AtbSUBR8oe5k=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D6EF0F80115;
	Tue, 14 Apr 2020 18:14:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A824BF8013D; Tue, 14 Apr 2020 18:10:22 +0200 (CEST)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 72809F800B9
 for <alsa-devel@alsa-project.org>; Tue, 14 Apr 2020 18:10:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 72809F800B9
IronPort-SDR: 4AyJp23Tes+zMs9S+XvmoLoX1ZL7zDQP7SsbX1h/JsAuM3uXfUCOOmoN/+c5He7if1v9Xt32G4
 e8p2YqDrl5Mw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Apr 2020 09:10:01 -0700
IronPort-SDR: qo4/zH/QEgV/Qv1yO53AxEWKimIlX29FBoVItNGEubEb/Kr3rO2f+/v82BhBuM/lz0HcaBLHdb
 eFCxXhwk/smw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,382,1580803200"; d="scan'208";a="427109808"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by orsmga005.jf.intel.com with ESMTP; 14 Apr 2020 09:09:59 -0700
Date: Tue, 14 Apr 2020 19:09:58 +0300 (EEST)
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@eliteleevi.tm.intel.com
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH 03/13] ALSA: hda: Add ElkhartLake HDMI codec vid
In-Reply-To: <s5hd08emi2k.wl-tiwai@suse.de>
Message-ID: <alpine.DEB.2.21.2004141838300.2957@eliteleevi.tm.intel.com>
References: <20200409185827.16255-1-pierre-louis.bossart@linux.intel.com>
 <20200409185827.16255-4-pierre-louis.bossart@linux.intel.com>
 <s5hd08emi2k.wl-tiwai@suse.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 alsa-devel@alsa-project.org, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 broonie@kernel.org, Libin Yang <libin.yang@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>
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

Hey,

On Sat, 11 Apr 2020, Takashi Iwai wrote:

> On Thu, 09 Apr 2020 20:58:17 +0200, Pierre-Louis Bossart wrote:
>> Add HDMI codec vid for the Intel ElkhartLake platform
> 
> I suppose this can go through ASoC tree unless HDA legacy driver
> supports the device.

hmm, good point. In short, both DSP and non-DSP usage continue to be 
possible, so HDA legacy driver can be used as well. This is a (positive) 
new problem of SOF now using common codec driver for HDMI. The patch got 
merged already (and I think this is ok as we specifically enable and test 
HDMI with the ASoC stack), but maybe in the future we can send these codec 
driver patches directly, and not via ASoC.

Br, Kai
