Return-Path: <SRS0=Cvq+=2H=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D95C43603
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Dec 2019 16:42:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB6C024655
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Dec 2019 16:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="C96dnzGz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB6C024655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E4609850;
	Tue, 17 Dec 2019 17:41:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E4609850
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576600970;
	bh=F86/NmMBAmsf/CMSsDzx8Df9v8ZzMEIAbDVBvis4GbY=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=C96dnzGzbHdd2XPz6mf4UiEn90+4GAlrR8xjBO+XY2r9wKC8n95orXBF+G3qCJ7UQ
	 SibKmO+a6QQmtSSYKBnIuCKqrKFPlIlJl1aHLfb8THeMH9WvN5XYOtg6xW4rSKgCKP
	 Yd1pd8AwF5NB29yoQGRHt3QFOIPyMuJ9nFleNvw4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 610F3F80218;
	Tue, 17 Dec 2019 17:41:59 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7E68AF80234; Tue, 17 Dec 2019 17:41:57 +0100 (CET)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9831EF80100
 for <alsa-devel@alsa-project.org>; Tue, 17 Dec 2019 17:41:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9831EF80100
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 17 Dec 2019 08:41:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,326,1571727600"; d="scan'208";a="240483278"
Received: from krose-mobl.amr.corp.intel.com (HELO [10.254.184.73])
 ([10.254.184.73])
 by fmsmga004.fm.intel.com with ESMTP; 17 Dec 2019 08:41:45 -0800
To: Randy Dunlap <rdunlap@infradead.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20191217130829.6a66b404@canb.auug.org.au>
 <c4fd86fb-586a-0fbc-74b0-97e6b99ef2ca@infradead.org>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <94745c3a-33aa-b307-06d6-ba0c8dddc9d2@linux.intel.com>
Date: Tue, 17 Dec 2019 10:41:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <c4fd86fb-586a-0fbc-74b0-97e6b99ef2ca@infradead.org>
Content-Language: en-US
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
 Jie Yang <yang.jie@linux.intel.com>,
 moderated for non-subscribers <alsa-devel@alsa-project.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] linux-next: Tree for Dec 17
 (sound/soc/intel/boards/cml_rt1011_rt5682.o)
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
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>




> on x86_64:
> =

>    CC      sound/soc/intel/boards/cml_rt1011_rt5682.o
> ../sound/soc/intel/boards/cml_rt1011_rt5682.c:409:4: error: =91struct snd=
_soc_codec_conf=92 has no member named =91dev_name=92
>     .dev_name =3D "i2c-10EC1011:00",

ACK, thanks for reporting this conflict with ee8f537fd8b71c ('ASoC: =

soc-core: remove legacy style of codec_conf')

Will send a patch in the next 30mn.


_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
