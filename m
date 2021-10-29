Return-Path: <SRS0=puNT=PR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D94DC433EF
	for <alsa-devel@archiver.kernel.org>; Fri, 29 Oct 2021 15:32:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FA6B60F23
	for <alsa-devel@archiver.kernel.org>; Fri, 29 Oct 2021 15:32:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4FA6B60F23
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C0B9C1699;
	Fri, 29 Oct 2021 17:31:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C0B9C1699
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1635521549;
	bh=BXG537wqrGNZd4+V6N9xSsYyuJsklOKVvqlpZNd5MTY=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tgukgz/h4LyC+oYyTuLvMAPLnguXgMd3b9O0+wowP062lm4z5vVO/4QIz3vJUBiL2
	 IHUY3kPv57MtKa7vkZ5fxgNzWfryF4cNPJATDsAfgYhmJ2C1iEPEp1YGN7aEw2MRFL
	 Al05f72Fdvt8POZBLezx0i2vEvUtFWEScuKcr9Ds=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5F97DF801EC;
	Fri, 29 Oct 2021 17:31:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B9152F8025A; Fri, 29 Oct 2021 17:31:37 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 596FFF8010A
 for <alsa-devel@alsa-project.org>; Fri, 29 Oct 2021 17:31:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 596FFF8010A
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1635521494551841974-webhooks-bot@alsa-project.org>
References: <1635521494551841974-webhooks-bot@alsa-project.org>
Subject: AM_PATH_ALSA. error
Message-Id: <20211029153137.B9152F8025A@alsa1.perex.cz>
Date: Fri, 29 Oct 2021 17:31:37 +0200 (CEST)
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

alsa-project/alsa-utils issue #116 was edited from steeley:

Hi,
I'm installing on latest raspios buster lite 32bit:
(Linux cm432 5.10.63-v7l+ #1459 SMP Wed Oct 6 16:41:57 BST 2021 armv7l GNU/Linux)

my build process is:

`git clone https://github.com/alsa-project/alsa-utils.git
cd alsa-utils/
git checkout v1.1.9
autoreconf -i
./configure --prefix=/usr/local
make
sudo make install`

I have built and installed alsa-libs, and alia-plugins  correctly, but get this error with alsa-utils when I autoreconf:

`configure.ac:22: warning: macro 'AM_PATH_ALSA' not found in library
configure.ac:22: error: possibly undefined macro: AM_PATH_ALSA
      If this token and others are legitimate, please use m4_pattern_allow.
      See the Autoconf documentation.
autoreconf: /usr/bin/autoconf failed with exit status: 1`

How to resolve?
TIA

Issue URL     : https://github.com/alsa-project/alsa-utils/issues/116
Repository URL: https://github.com/alsa-project/alsa-utils
