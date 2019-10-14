Return-Path: <SRS0=QzCZ=YH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD6BECE58C
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Oct 2019 19:48:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BE7C217D9
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Oct 2019 19:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="i5RqZ065"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BE7C217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3E4FE84C;
	Mon, 14 Oct 2019 21:47:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3E4FE84C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571082492;
	bh=IHW0LW4BZlzc7wTqWcPtyTisS+APRLd/0u5efucVrrQ=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=i5RqZ065nTBmCJzlak+rpKH/bHULBgVBqizL5/WMycjoKzgD9HoQidr+xmL7tbAyq
	 abfewsX6VUzi8cNzPNFHU0KLfFefG911aDBKMyFLVV/Fu4sySuUverIPrgXk285Uzt
	 rFmsoARURoCfCPCCpU8d249lL6F0+Wtn9V5rTU30=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B3DCAF80322;
	Mon, 14 Oct 2019 21:47:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4809DF8011D; Mon, 14 Oct 2019 21:47:20 +0200 (CEST)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EFF89F8011D
 for <alsa-devel@alsa-project.org>; Mon, 14 Oct 2019 21:47:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EFF89F8011D
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 14 Oct 2019 12:47:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,296,1566889200"; d="scan'208";a="194309101"
Received: from dmccormi-mobl1.ger.corp.intel.com ([10.251.80.150])
 by fmsmga008.fm.intel.com with ESMTP; 14 Oct 2019 12:47:09 -0700
Message-ID: <3811afd6d83c491077dd30089bcf836f56f146c3.camel@linux.intel.com>
From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
To: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Date: Mon, 14 Oct 2019 20:47:07 +0100
In-Reply-To: <20191009181356.GO2036@sirena.org.uk>
References: <20191009181356.GO2036@sirena.org.uk>
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Cc: Takashi Iwai <tiwai@suse.de>, Curtis Malainey <cujomalainey@google.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [ANNOUNCE] 2019 Linux Audio miniconference
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Wed, 2019-10-09 at 19:13 +0100, Mark Brown wrote:
> Hi,
> 
> As in previous years we're going to have an audio miniconference so
> we can
> get together and talk through issues, especially design decisions,
> face to
> face.  This year's event will be held on October 31st in Lyon,
> France,
> the day after ELC-E.  This will be held at the Lyon Convention Center
> (the
> ELC-E venue) and will be free of charge to attend, generously
> sponsored by Intel.
> 
> Thus far for the agenda we have:
> 
>  - Use case management enhancements (Curtis)
>  - DSP framework integration (Liam?)
>  - Soundwire status (Pierre?)
>  - Componentisation status/plans (Me)

Audio Virtualisation. (Me).

Liam


_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
