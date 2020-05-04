Return-Path: <SRS0=TVyu=6S=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF51C3A5A9
	for <alsa-devel@archiver.kernel.org>; Mon,  4 May 2020 19:05:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F7AA206B8
	for <alsa-devel@archiver.kernel.org>; Mon,  4 May 2020 19:05:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="CeEmLvUL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F7AA206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E04A416FA;
	Mon,  4 May 2020 21:04:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E04A416FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588619110;
	bh=sKBwGBcV8JA5jqGAFtFSzvoZzOqGgwoZY5FaGA1AMPU=;
	h=Subject:From:To:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CeEmLvULHt7uPFE7tZeaJ+FQvWz8g3RaN18NlRlhvDqvfToETlxXElhwdyfXk0z+W
	 sSHAA0RBAG9ew2RJuZy/nBoHa26gA4X2nrPZEm+AB/NHKUEBJX7eeKyvcIoB239hob
	 3asQtV2PIfO6/s3Qz1u/sU0/3nrLK2eW8BwhtzE8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4299DF80234;
	Mon,  4 May 2020 21:04:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2932BF80249; Mon,  4 May 2020 21:04:17 +0200 (CEST)
Received: from smtprelay.hostedemail.com (smtprelay0072.hostedemail.com
 [216.40.44.72])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2126EF800DE
 for <alsa-devel@alsa-project.org>; Mon,  4 May 2020 21:04:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2126EF800DE
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay06.hostedemail.com (Postfix) with ESMTP id 90A1018022F46;
 Mon,  4 May 2020 19:04:05 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: scarf42_6021543c5600
X-Filterd-Recvd-Size: 2806
Received: from XPS-9350.home (unknown [47.151.136.130])
 (Authenticated sender: joe@perches.com)
 by omf07.hostedemail.com (Postfix) with ESMTPA;
 Mon,  4 May 2020 19:04:01 +0000 (UTC)
Message-ID: <7af4a2979fb5c060af769a996d3e5917b4d265d0.camel@perches.com>
Subject: Re: [PATCH] docs: dt: fix broken links due to txt->yaml renames
From: Joe Perches <joe@perches.com>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, 
 Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 04 May 2020 12:04:00 -0700
In-Reply-To: <20200504175553.jdm7a7aabloevxba@pengutronix.de>
References: <967df5c3303b478b76199d4379fe40f5094f3f9b.1588584538.git.mchehab+huawei@kernel.org>
 <20200504174522.GA3383@ravnborg.org>
 <20200504175553.jdm7a7aabloevxba@pengutronix.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Olivier Moysan <olivier.moysan@st.com>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
 Liam Girdwood <lgirdwood@gmail.com>, Andrzej Hajda <a.hajda@samsung.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-rockchip@lists.infradead.org, Sandy Huang <hjc@rock-chips.com>,
 devicetree@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>,
 Jyri Sarha <jsarha@ti.com>, Mark Brown <broonie@kernel.org>,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arnaud Pouliquen <arnaud.pouliquen@st.com>, linux-mips@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>
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

On Mon, 2020-05-04 at 19:55 +0200, Uwe Kleine-König wrote:
> Hi Sam,
> 
> On Mon, May 04, 2020 at 07:45:22PM +0200, Sam Ravnborg wrote:
> > On Mon, May 04, 2020 at 11:30:20AM +0200, Mauro Carvalho Chehab wrote:
> > > There are some new broken doc links due to yaml renames
> > > at DT. Developers should really run:
> > > 
> > > 	./scripts/documentation-file-ref-check
> > > 
> > > in order to solve those issues while submitting patches.
> > Would love if some bot could do this for me on any patches that creates
> > .yaml files or so.
> > I know I will forget this and it can be automated.
> > If I get a bot mail that my patch would broke a link I would
> > have it fixed before it hits any tree.
> 
> What about adding a check to check_patch?

There's already a checkpatch warning when a patch renames
a file without a MAINTAINERS update.

