Return-Path: <SRS0=Jk6f=YA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB7B5C47404
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Oct 2019 13:48:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA2C621655
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Oct 2019 13:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="HngIX/FD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA2C621655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6AA9785D;
	Mon,  7 Oct 2019 15:47:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6AA9785D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1570456110;
	bh=ateoMy5htBcY4630iKrkcgU+EosQXeD84EYT+Ar+COg=;
	h=Date:From:To:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HngIX/FD9M9iLZiFNsWJJcm0pQc9Ktt5yjniTBfpKixAVXj9YOkwICAd2BoB/ZklP
	 cIdsqWOH4R/vHkJxFVoFw2H954tZeWjvAYJJPrdaV2/rKKSJ8h1+FPJn0Ad8l1ZGeL
	 hgEi9kiSe+i4h/geV50jfNP4Sie+ws4NAChpO/p0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D75A4F802BD;
	Mon,  7 Oct 2019 15:47:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 831DBF802BE; Mon,  7 Oct 2019 15:47:38 +0200 (CEST)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D54DAF80273
 for <alsa-devel@alsa-project.org>; Mon,  7 Oct 2019 15:47:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D54DAF80273
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 07 Oct 2019 06:47:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,268,1566889200"; d="scan'208";a="368121100"
Received: from zeliteleevi.tm.intel.com ([10.237.55.130])
 by orsmga005.jf.intel.com with ESMTP; 07 Oct 2019 06:47:30 -0700
Date: Mon, 7 Oct 2019 16:47:29 +0300 (EEST)
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@zeliteleevi
To: Takashi Iwai <tiwai@suse.de>
In-Reply-To: <s5h36g5jp2q.wl-tiwai@suse.de>
Message-ID: <alpine.DEB.2.21.1910071636530.16459@zeliteleevi>
References: <20191004143527.5575-1-kai.vehmanen@linux.intel.com>
 <s5h36g5jp2q.wl-tiwai@suse.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Cc: alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com
Subject: Re: [alsa-devel] [PATCH 0/1] ALSA: hda: add fallback to polling to
 hdac_bus_get_response()
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

Hi,

On Mon, 7 Oct 2019, Takashi Iwai wrote:

> > I found a discrepancy in behaviour between snd-hda-intel and SOF, despite
> > using the same snd-hda-codec-hdmi as the codec driver.
[...]
> 
> While it's OK to add the polling support in the core code, I suspect
> that the main problem gets solved by setting the write_sync flag as
> the commit 2756d9143aa5.  For SOF/SST, you may set the flag
> unconditionally since they support only the new chipsets.

I've been meaning to try that out, and indeed, if I set write-sync 
on SOF side, it helps in this specific ICL case as well. I'll push a patch 
via Pierre's SOF tree:
 https://github.com/thesofproject/linux/pull/1281 

... this makes the polling fallback patch less urgent, but probably better 
to apply that as well, just to align behaviour between different HDAC 
users.

I'll also check whether we could remove the older workaround for CFL and 
CNL that force polling mode on these platforms. It is highly likely these 
workarounds are no longer needed with sync-write set.

> I've been traveling (still for the next week), so the further reply
> may be delayed.

Ack, thanks. I'll do some more testing around these flows during 
the week.

Br, Kai 
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
