Return-Path: <SRS0=rARa=DB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11695C4363D
	for <alsa-devel@archiver.kernel.org>; Thu, 24 Sep 2020 16:23:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 850C1238E3
	for <alsa-devel@archiver.kernel.org>; Thu, 24 Sep 2020 16:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="OkHiqCyd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 850C1238E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E958817FD;
	Thu, 24 Sep 2020 18:23:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E958817FD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600964634;
	bh=0HjBl1RQMO6iTptX09f5l+XpZ/GYPlLOcCYP7rTULG0=;
	h=Subject:From:To:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OkHiqCydEJ4lrkTV4vSsC0Mt+TK66Gkw0sGIRRJUmYcpPwuZJ12NDmMauo5bKNPKZ
	 7pcGB6KeiGXIcNTmb+bPmzrnpGe1w8Pbdx27zbD9Z0PALgXV/teljb+qHVse8Vl2Gn
	 2DwcTmtgaR/RAqPWjAoH+36opWvW4lhLayIxZv7s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 683B1F800DA;
	Thu, 24 Sep 2020 18:23:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4E4CAF80229; Thu, 24 Sep 2020 18:23:02 +0200 (CEST)
Received: from smtprelay.hostedemail.com (smtprelay0138.hostedemail.com
 [216.40.44.138])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4E55AF800DA
 for <alsa-devel@alsa-project.org>; Thu, 24 Sep 2020 18:22:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4E55AF800DA
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay03.hostedemail.com (Postfix) with ESMTP id B7B91837F24A;
 Thu, 24 Sep 2020 16:22:49 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: light80_3401d5827160
X-Filterd-Recvd-Size: 1814
Received: from XPS-9350.home (unknown [47.151.133.149])
 (Authenticated sender: joe@perches.com)
 by omf11.hostedemail.com (Postfix) with ESMTPA;
 Thu, 24 Sep 2020 16:22:48 +0000 (UTC)
Message-ID: <0029e913324f9a8cfc7f90c8798cad6373d02d30.camel@perches.com>
Subject: Re: [PATCH] sound/soc/codecs: fix spelling typo in comments
From: Joe Perches <joe@perches.com>
To: Mark Brown <broonie@kernel.org>
Date: Thu, 24 Sep 2020 09:22:47 -0700
In-Reply-To: <20200924161249.GG4754@sirena.org.uk>
References: <1600929860-28862-1-git-send-email-wangqing@vivo.com>
 <20200924123346.GE4754@sirena.org.uk>
 <062568971307793dcc80337f85545c4765241933.camel@perches.com>
 <20200924161249.GG4754@sirena.org.uk>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 Wang Qing <wangqing@vivo.com>
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

On Thu, 2020-09-24 at 17:12 +0100, Mark Brown wrote:
> On Thu, Sep 24, 2020 at 09:01:21AM -0700, Joe Perches wrote:
> > On Thu, 2020-09-24 at 13:33 +0100, Mark Brown wrote:
> > > and compliment appears to be the one that
> > > is used in the datasheet for this part... 
> > It's difficult to fix datasheet typos.
> 
> Right, and if we search for the thing in the datasheet we should find
> the thing in the datasheet so it's best to follow the datsheet even if
> we don't think it's correct.

That's one opinion.

Another would be to use the correct word and
if necessary add some comment showing that the
datasheet writer didn't open a dictionary.

	complement (sic: compliment)

I don't believe that's necessary, but opinions
vary.


