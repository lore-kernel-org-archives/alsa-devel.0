Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52898C433EF
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Jan 2022 18:41:40 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 993072070;
	Thu, 13 Jan 2022 19:40:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 993072070
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1642099298;
	bh=qqcMZ1IZfmNOmWmFj956qQSZ+kRWR/NKW/CT4jJutuk=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=U56KdayEgKPx1s6qk0vLHj+KZ5xKOk7QPOPxjeMPCgHu+Tl9/VkmRTVGjY+1eOekQ
	 fHrZgbEvc5tsOoEu4WdJyeosnC3liy5dBPiVLTO4pKYxtLDjsCsZ2GlED0PnNRjU1x
	 R4l0dBE7C/RVJLgYHVrmOAw7LfjRPvfmiE96kUNg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 40510F8028D;
	Thu, 13 Jan 2022 19:40:48 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 92853F80088; Thu, 13 Jan 2022 19:40:46 +0100 (CET)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8B7D4F80088;
 Thu, 13 Jan 2022 19:40:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8B7D4F80088
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="eDmwDNar"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1642099240; x=1673635240;
 h=subject:to:cc:references:from:message-id:date:
 mime-version:in-reply-to:content-transfer-encoding;
 bh=qqcMZ1IZfmNOmWmFj956qQSZ+kRWR/NKW/CT4jJutuk=;
 b=eDmwDNar/3yrzX+pEIue0IOgMo1mZSFl53AtJ5VM7hgXJKk25VP7+kes
 EnEovrUny4Ti+R/YUG+RnEhIj/AEHaKk45navB2o1aOrh3ZRlaGLRMkxF
 k44YupmLKcq7WyRJopZQS1ICU6A7UW/Z1rCicfQYx4sr3hsKZM0OfONG7
 DsYE2JXPNDGU2W9u4ygzBPauTnXe0fHfyI3L0lv6bkazGm8CHvYvlIxYT
 a/v6vP/QT2lAmFUoCAt7jRwox4Ea3BlPk+jDxbfenPsuCkJzMymbTFGYS
 oFOe2hkqDeRPEhDKUkdgiFezmmgfGji4+YQL7zG0v2gENp5Axf9+ozffJ A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="242903160"
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; d="scan'208";a="242903160"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jan 2022 10:40:35 -0800
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; d="scan'208";a="620700515"
Received: from ypchen-mobl.amr.corp.intel.com (HELO [10.212.66.70])
 ([10.212.66.70])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jan 2022 10:40:34 -0800
Subject: Re: [PATCH v3 1/1] firmware: mediatek: add adsp ipc protocol interface
To: "allen-kh.cheng" <allen-kh.cheng@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Mark Brown <broonie@kernel.org>
References: <20220113082234.29013-1-allen-kh.cheng@mediatek.com>
 <20220113082234.29013-2-allen-kh.cheng@mediatek.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <32e116f5-7b71-2fe0-ad43-3fbc71a651a5@linux.intel.com>
Date: Thu, 13 Jan 2022 12:40:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220113082234.29013-2-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: devicetree@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>,
 linux-kernel@vger.kernel.org, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 cujomalainey@google.com, Kevin Hilman <khilman@baylibre.com>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Project_Global_Chrome_Upstream_Group@mediatek.com, tzungbi@google.com,
 linux-mediatek@lists.infradead.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Daniel Baluta <daniel.baluta@nxp.com>, linux-arm-kernel@lists.infradead.org,
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



On 1/13/22 2:22 AM, allen-kh.cheng wrote:
> From: Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>
> 
> Some of mediatek processors contain
> the Tensilica HiFix DSP for audio processing.
> 
> The communication between Host CPU and DSP firmware is
> taking place using a shared memory area for message passing.
> 
> ADSP IPC protocol offers (send/recv) interfaces using
> mediatek-mailbox APIs.
> 
> We use two mbox channels to implement a request-reply protocol.
> 
> Reviewed-by: Curtis Malainey <cujomalainey@chromium.org>
> Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>
> Signed-off-by: Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

