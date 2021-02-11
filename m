Return-Path: <SRS0=wAKr=HN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C01BC433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 11 Feb 2021 10:43:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A58A64E23
	for <alsa-devel@archiver.kernel.org>; Thu, 11 Feb 2021 10:42:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A58A64E23
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EE60116DD;
	Thu, 11 Feb 2021 11:42:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EE60116DD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1613040177;
	bh=xKEXst7yNke3blx0NSoTP5V2gm+gvAkxk0VjuCWfpcU=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AUCxKtHY9ZI86yli1qwVuQCdpGdcFkCRWry0cGspeqM8jPbvjgHfCMd4CT1mcUe34
	 6v5rteHMJpO/pDsSqg0AUR5d6QUBlKbyEpWbrkYFlEA+qUK0I/A/mO+Ys5UOKmro/T
	 VetyI62nDLze1gWSNLZD421RHOwskLBWEtBujtgs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0AD06F8016B;
	Thu, 11 Feb 2021 11:42:06 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9FA01F801D5; Thu, 11 Feb 2021 11:42:04 +0100 (CET)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6FD89F80165
 for <alsa-devel@alsa-project.org>; Thu, 11 Feb 2021 11:41:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6FD89F80165
IronPort-SDR: IxHC3X+UKlq4bGKRbAW9SyeXv7nZ3+3cEXT2fl83djE5MNqii0vqtxdt6E1aC0ozbv0otxdze2
 pxBtCEd56WQw==
X-IronPort-AV: E=McAfee;i="6000,8403,9891"; a="179663633"
X-IronPort-AV: E=Sophos;i="5.81,170,1610438400"; d="scan'208";a="179663633"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2021 02:41:45 -0800
IronPort-SDR: lUeFT7GBocVUcol4Oj6iB1Qn++2CJ7GGkZ9L9COjoXOd3iV7PORLZGYoO1x38RFE4059uk2J4q
 vv3aOSnGoKIQ==
X-IronPort-AV: E=Sophos;i="5.81,170,1610438400"; d="scan'208";a="437073892"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2021 02:41:43 -0800
Date: Thu, 11 Feb 2021 12:38:16 +0200 (EET)
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@eliteleevi.tm.intel.com
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH] ALSA: hda/hdmi: Drop bogus check at closing a stream
In-Reply-To: <20210211083139.29531-1-tiwai@suse.de>
Message-ID: <alpine.DEB.2.22.394.2102111236310.864696@eliteleevi.tm.intel.com>
References: <20210211083139.29531-1-tiwai@suse.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: alsa-devel@alsa-project.org, Kai Vehmanen <kai.vehmanen@linux.intel.com>
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

On Thu, 11 Feb 2021, Takashi Iwai wrote:

> Some users reported the kernel WARNING with stack traces from
> hdmi_pcm_close(), and it's the line checking the per_cvt->assigned
> flag.  This used to be a valid check in the past because the flag was
> turned on/off only at opening and closing a PCM stream.  Meanwhile,
> since the introduction of the silent-stream mode, this flag may be
> turned on/off at the monitor connection/disconnection time, which

ack, this needs to be removed:

Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>

Br, Kai

