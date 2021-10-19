Return-Path: <SRS0=Jips=PI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F225C433F5
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Oct 2021 14:43:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C905F60FD8
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Oct 2021 14:43:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C905F60FD8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5F54D165D;
	Wed, 20 Oct 2021 16:42:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5F54D165D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1634741002;
	bh=IRx1sxgmASwWGe8Yfuq/PvJt4Tzvx+JuN/mLzf3iakI=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FY+7WCq0yQHWSNzBSh2X4lmM8DnIw5sS6Xk1H52b9ACkca5HvdlE2PD53Ykojy/Cb
	 kFJvU9sxzqshnJLm1VNGabDPIoB2Kzv27rzPPhX//SsUWDOTeUk/BZzzGvZ6v+5lmn
	 aLoRr7rIbJmfpLEBQa1G+39QL2tsEcNfGllM3Oqo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7A3A7F80155;
	Wed, 20 Oct 2021 16:42:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AEE11F80229; Wed, 20 Oct 2021 16:42:29 +0200 (CEST)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9210CF80082
 for <alsa-devel@alsa-project.org>; Wed, 20 Oct 2021 16:42:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9210CF80082
X-IronPort-AV: E=McAfee;i="6200,9189,10143"; a="314998704"
X-IronPort-AV: E=Sophos;i="5.87,167,1631602800"; d="scan'208";a="314998704"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2021 07:42:18 -0700
X-IronPort-AV: E=Sophos;i="5.87,167,1631602800"; d="scan'208";a="551666677"
Received: from lemanzan-mobl.amr.corp.intel.com (HELO [10.212.115.167])
 ([10.212.115.167])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2021 07:42:13 -0700
Subject: Re: [PATCH v3 4/6] ASoC: Intel: soc-acpi-byt: shrink tables using
 compatible IDs
To: Brent Lu <brent.lu@intel.com>, alsa-devel@alsa-project.org
References: <20211019075941.2037787-1-brent.lu@intel.com>
 <20211019075941.2037787-5-brent.lu@intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <d432bf1b-5922-f3b8-4ab2-f82aa6bcc3e0@linux.intel.com>
Date: Tue, 19 Oct 2021 11:40:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211019075941.2037787-5-brent.lu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Rander Wang <rander.wang@intel.com>, Jie Yang <yang.jie@linux.intel.com>,
 linux-kernel@vger.kernel.org, Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Mac Chiang <mac.chiang@intel.com>, Gongjun Song <gongjun.song@intel.com>,
 Bard Liao <bard.liao@intel.com>, Takashi Iwai <tiwai@suse.com>,
 Vamshi Krishna Gopal <vamshi.krishna.gopal@intel.com>,
 Rander Wang <rander.wang@linux.intel.com>, Yong Zhi <yong.zhi@intel.com>,
 Hans de Goede <hdegoede@redhat.com>, Mark Brown <broonie@kernel.org>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Paul Olaru <paul.olaru@oss.nxp.com>, Libin Yang <libin.yang@intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Curtis Malainey <cujomalainey@chromium.org>
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



On 10/19/21 2:59 AM, Brent Lu wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> We have multiple entries for the same codecs, use the new compatible
> IDs to have a single entry.
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

You need to add your Signed-off-by tag below mine, that's a requirement
when sending patches "from" someone else

https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html#developer-s-certificate-of-origin-1-1

Can you re-send a v4 with patches 4,5,6 modified?
Thanks!

