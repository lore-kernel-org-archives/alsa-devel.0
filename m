Return-Path: <SRS0=YhdC=HD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E18FC433E0
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Feb 2021 08:27:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3EC364E33
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Feb 2021 08:27:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3EC364E33
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A3EC91768;
	Mon,  1 Feb 2021 09:26:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A3EC91768
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612168067;
	bh=JJ5YYYPOXjNZcCA6V/DnC/BmPE3ayFG335S0q9zKmu0=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BHzUXBQjE8tqIRHmor6iPF+hEFc01N7rpUo8ph1rzHA+rUhssj9J+I0K+FLnEiIKB
	 GaikWXJq6QTgV+VA7h/jiHoehKOJPT8UywsJJ0DdiFLwkcW2fcEGK3Y/Nqfcks/gi0
	 W15voZ3UabtvNXNAWQoyH/uXBWbcuwPnoqr4lRUI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3B8A7F8021D;
	Mon,  1 Feb 2021 09:26:57 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 73A59F80224; Mon,  1 Feb 2021 09:26:54 +0100 (CET)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EEF3FF800E2
 for <alsa-devel@alsa-project.org>; Mon,  1 Feb 2021 09:26:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EEF3FF800E2
IronPort-SDR: 1TbyRsMwnIKGeMRJIpiDvYMLG35xdebZRxxlqTlrZ/HFoNwb3AaIjrLAemboq1y+iI4XoXIUZv
 5R2GM5X448VQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9881"; a="242169452"
X-IronPort-AV: E=Sophos;i="5.79,391,1602572400"; d="scan'208";a="242169452"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Feb 2021 00:26:43 -0800
IronPort-SDR: fAA3pQeOd4JosL2x/yKJXbQxifrJW4yplqhjwQO3AujyJFS4sp/S9jONc6xnT4utUXZ/iAX0cl
 YfbOt9guAESg==
X-IronPort-AV: E=Sophos;i="5.79,391,1602572400"; d="scan'208";a="390804592"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Feb 2021 00:26:42 -0800
Date: Mon, 1 Feb 2021 10:23:22 +0200 (EET)
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@eliteleevi.tm.intel.com
To: Mert Can Demir <validatedev@gmail.com>
Subject: Re: jack doesn't detected plugged after suspend
In-Reply-To: <CAH4rLk2uUbyFEWuvfZ2AFim35NDOcAGL2tUD0KDfN7OeZu0Vnw@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2102010959560.864696@eliteleevi.tm.intel.com>
References: <CAH4rLk2uUbyFEWuvfZ2AFim35NDOcAGL2tUD0KDfN7OeZu0Vnw@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: alsa-devel@alsa-project.org
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

On Mon, 1 Feb 2021, Mert Can Demir wrote:

> https://gitlab.freedesktop.org/pulseaudio/pulseaudio/-/issues/1125#note_784979.
> The related outputs and logs are baked into the issue, and seems that the
> outputs tells that alsa driver did not reported jack as plugged after
> suspend.

codec seems to be ALC256 with snd-hda-intel, kernel 
5.10.10-200.fc33.x86_64.

Can you say when this started to happen? There has been some recent
patches in this area, and I wonder if this is a regression or something
related to specific system configuration.

Some recent patches that are already included in 5.10.10:

9fc149c3bce7bdbb94948a8e6bd025e3b3538603 ALSA: hda: Reinstate runtime_allow() for all hda controllers
f5dac54d9d93826a776dffc848df76746f7135bb ALSA: hda: Separate runtime and system suspend
a6e7d0a4bdb02a7a3ffe0b44aaa8842b7efdd056 ALSA: hda: fix jack detection with Realtek codecs when in D3

You could also try disable power_save and see whether that has an effect.
I.e. add to /etc/modprobe.d/alsa-debug.conf (or some other conf file):

options snd_hda_intel power_save=0

More troubleshooting tips at:
https://wiki.archlinux.org/index.php/Advanced_Linux_Sound_Architecture/Troubleshooting

Br, Kai
