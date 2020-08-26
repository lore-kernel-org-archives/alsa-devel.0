Return-Path: <SRS0=TbbB=CE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D300AC433DF
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Aug 2020 18:09:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50C6B207DF
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Aug 2020 18:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="t/gzaAD/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50C6B207DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B1F1E1782;
	Wed, 26 Aug 2020 20:08:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B1F1E1782
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598465350;
	bh=1l8e8lsMxps1j+E8/omeo/Rw9Coc9cmQV1bH23Hrq/c=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=t/gzaAD/EG8+nBUqgWliv3MUJVBSI1GEduBn269dhTgtq75IK0Ulyea0njRKEpH2p
	 4L4XWWvJMA6gMRGJwKT4p2HibtJf50AD8PCQQHufU2MYygP6n6qNZie3diu1ghIF9w
	 XYLYe2OjpPvFzT30trH9i4IseoCz1twsIhV1BT0c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3F8C2F8016F;
	Wed, 26 Aug 2020 20:08:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B836CF801D9; Wed, 26 Aug 2020 20:08:18 +0200 (CEST)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E7EF7F80105
 for <alsa-devel@alsa-project.org>; Wed, 26 Aug 2020 20:08:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E7EF7F80105
IronPort-SDR: 6PRFv/RwTvKUBMglKqKmOyHUeoiSuYxVTX2OCUDTvHiESOfpBMezyAMrvOxvvZAwlRjXWSQAVa
 w02g67aNvI7Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9725"; a="157393115"
X-IronPort-AV: E=Sophos;i="5.76,356,1592895600"; d="scan'208";a="157393115"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2020 11:08:07 -0700
IronPort-SDR: WnoKohTSORAaoQWpjm9J7NKJnYjWHGpP4vrufmIGKIqaZtx61Svn02Fg9DHpgwNIe1yK9ZH07L
 lyuxfaYGgsHQ==
X-IronPort-AV: E=Sophos;i="5.76,356,1592895600"; d="scan'208";a="474865887"
Received: from sjweber-mobl.amr.corp.intel.com (HELO [10.209.187.249])
 ([10.209.187.249])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2020 11:08:05 -0700
Subject: Re: [PATCH 1/4] regmap: sdw: move to -EOPNOTSUPP
To: Mark Brown <broonie@kernel.org>
References: <20200825171656.75836-2-pierre-louis.bossart@linux.intel.com>
 <20200825214858.GK5379@sirena.org.uk>
 <6f7e5830-4dd8-1ecc-20c3-df75bc9ef265@linux.intel.com>
 <20200826095600.GA4965@sirena.org.uk> <s5ha6yhu3af.wl-tiwai@suse.de>
 <20200826101301.GB4965@sirena.org.uk> <s5h8se1u2or.wl-tiwai@suse.de>
 <927c93bc-9ad8-7e5d-a5ea-d566e5f543df@linux.intel.com>
 <20200826172516.GM4965@sirena.org.uk>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <9eb82812-436a-e94e-e7d0-28c9300e13f6@linux.intel.com>
Date: Wed, 26 Aug 2020 13:08:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200826172516.GM4965@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 alsa-devel@alsa-project.org, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Takashi Iwai <tiwai@suse.de>,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Hui Wang <hui.wang@canonical.com>, vkoul@kernel.org,
 srinivas.kandagatla@linaro.org, jank@cadence.com, slawomir.blauciak@intel.com,
 Bard liao <yung-chuan.liao@linux.intel.com>,
 Rander Wang <rander.wang@linux.intel.com>
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



> If you want to change this you'd need to change it over the whole
> subsystem (if not other subsystems), including the places where the
> value is used.

ok, I'll drop this patch for now, keep -ENOTSUPP and deal with this 
later. The only thing I really care about for now is SoundWire MBQ 
support, this is the only thing gating SDCA contributions.

