Return-Path: <SRS0=zQEr=Y6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A096C5DF62
	for <alsa-devel@archiver.kernel.org>; Wed,  6 Nov 2019 11:51:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CA522173E
	for <alsa-devel@archiver.kernel.org>; Wed,  6 Nov 2019 11:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="P3Vv6BsO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CA522173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B17D316B1;
	Wed,  6 Nov 2019 12:50:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B17D316B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573041090;
	bh=O3UW0xYYd7LEiLsTnyubpNgDT2qtW6cuUAFw6pS+Ap4=;
	h=Date:From:To:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=P3Vv6BsO0F+youDw8BuVUF9zqSDpHMmzbXJ64oRx1I0+x/5oya1CqkYrKSsMW022p
	 UwlVzKlr1WyxvFM/MuvT8tVbUb60V1TmK7YaveDTBpo3osLe0spOKUuBpgVecMCgHc
	 R3Bmzh4vDOy6vcugLKvW3xTyy3yhw81NW32vtSYk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2D783F80321;
	Wed,  6 Nov 2019 12:50:40 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CAACCF803D0; Wed,  6 Nov 2019 12:50:38 +0100 (CET)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B06E9F8015B
 for <alsa-devel@alsa-project.org>; Wed,  6 Nov 2019 12:50:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B06E9F8015B
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 06 Nov 2019 03:50:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,274,1569308400"; d="scan'208";a="232845891"
Received: from zeliteleevi.tm.intel.com ([10.237.55.130])
 by fmsmga002.fm.intel.com with ESMTP; 06 Nov 2019 03:50:31 -0800
Date: Wed, 6 Nov 2019 13:50:30 +0200 (EET)
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@zeliteleevi
To: Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <6dcc3e0d-0df5-90cf-220f-59253d3b5c7c@perex.cz>
Message-ID: <alpine.DEB.2.21.1911061327470.16459@zeliteleevi>
References: <6dcc3e0d-0df5-90cf-220f-59253d3b5c7c@perex.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Cc: Takashi Iwai <tiwai@suse.de>,
 ALSA development <alsa-devel@alsa-project.org>,
 Mark Brown <broonie@kernel.org>, Kai Vehmanen <kai.vehmanen@linux.intel.com>
Subject: Re: [alsa-devel] UCM extensions
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

Hi Jaroslav,

On Tue, 5 Nov 2019, Jaroslav Kysela wrote:

> 	I make some internal ucm code cleanups in alsa-lib and added three
> major extensions to allow more complex configurations which we require for the
> SOF kernel driver.

looks very good and pragmatic way to tackle some of the issues you hit 
with current UCM.

E.g. the If block would be also sufficient to tackle the recent HDMI codec 
driver change (with a single UCM file) -- i.e. use existence of the 
hdac-hdmi driver controls to select which enable-sequences to run. Hmm, I 
like this better than trying to select a whole different UCM file based on 
which drivers are used.

And same usage pattern can be applied to other mixer control name changes
(like you already did for the HDA mic control).

That of course leads to the question do we soon need mechanisms to 
choose between more than two conditions (e.g. if mixer controls have 
changed multiple times in recent kernels, so covering for this 
in UCM would need a Switch, If-Else, or similar). But yeah, one can
always define another UCM, so keeping-it-simple might be the right 
choice here.

> 	I added everything to keep the interface backward compatible, so the
> current applications should not observe any different behavior. The
> applications like pulseaudio should use the 'hw:CARD_INDEX' specifier for the
> open call in the future and snd_use_case_parse_ctl_elem_id() helper for the
> element control names.

This sounds good as well. Some testing with common versions of 
e.g. Pulseaudio is probably in order to sanity check how this 
works.

Br, Kai
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
