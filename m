Return-Path: <SRS0=kZkJ=FP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4770C4361B
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Dec 2020 13:49:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4593823EB1
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Dec 2020 13:49:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4593823EB1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6EA001765;
	Fri, 11 Dec 2020 14:48:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6EA001765
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607694589;
	bh=fP7KxEKrqqulM5pXmy7W+fB2fkXM0JLGiRP3cJ1kOcc=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=k2Izj68SN/y97zkYV/WdFgmtCdsj2qkSr89/j5/aK2IERswJdPkVh+l3m46N+nd6h
	 YIQZE3GU1m00KhqaDjmtamqtscVJPQM+dgaMm8ZDHtJCmhvzC2vElS881IosV5Ghi5
	 rJNyAMt3VcjDR8EFQuBIie3D8y24USk6hdXJLgxw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E27F1F801D8;
	Fri, 11 Dec 2020 14:48:58 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3336EF8020D; Fri, 11 Dec 2020 14:48:58 +0100 (CET)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 91F06F8011F
 for <alsa-devel@alsa-project.org>; Fri, 11 Dec 2020 14:48:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 91F06F8011F
IronPort-SDR: O0X1gJ17bKOMq5CfXsCNxVBfrTcT1+k2emuwFSAbeu2ULNf2bh9F96jExe5nmjBM9yC9rl+5bT
 jgHKsdrdUd5A==
X-IronPort-AV: E=McAfee;i="6000,8403,9831"; a="154240708"
X-IronPort-AV: E=Sophos;i="5.78,411,1599548400"; d="scan'208";a="154240708"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2020 05:48:52 -0800
IronPort-SDR: 7VtTeG5GtS+8eLLyODiDhRd1Nukgpmo1KudpD+2+hNDWrkxJqPVAnoa6fnuvlUyxfINgqhPvQh
 x2LDVVMHIhqw==
X-IronPort-AV: E=Sophos;i="5.78,411,1599548400"; d="scan'208";a="409226450"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2020 05:48:50 -0800
Date: Fri, 11 Dec 2020 15:46:14 +0200 (EET)
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@eliteleevi.tm.intel.com
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH] ALSA: hda/hdmi: packet buffer index must be set before
 reading value
In-Reply-To: <s5hy2i4o4le.wl-tiwai@suse.de>
Message-ID: <alpine.DEB.2.22.394.2012111537070.864696@eliteleevi.tm.intel.com>
References: <20201211131613.3271407-1-kai.vehmanen@linux.intel.com>
 <s5hy2i4o4le.wl-tiwai@suse.de>
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

On Fri, 11 Dec 2020, Takashi Iwai wrote:

> On Fri, 11 Dec 2020 14:16:13 +0100, Kai Vehmanen wrote:
> > 
> > The check for infoframe transmit status in hdmi_infoframe_uptodate()
> > makes the assumption that packet buffer index is set to zero.
> 
> Currently there is no other place to change DIP index, i.e. it's
> always zero, and the bug wouldn't hit, but it's better to be addressed
> beforehand, indeed.

indeed, agreed on that. Most likely scenario where this could actually 
cause harm if someone later adds new functionality to this driver that 
uses other DIP indices for something. That's pretty unlikely as well, but 
yeah, better align with the spec.

Br, Kai
