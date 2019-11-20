Return-Path: <SRS0=+StP=ZM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C2B7C432C0
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Nov 2019 17:03:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7027D20672
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Nov 2019 17:03:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="qPSrVyRr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7027D20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 89BCB16F9;
	Wed, 20 Nov 2019 18:02:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 89BCB16F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1574269427;
	bh=gQvf4Ge+1qrOagQHnXOwlWlHASH3AlB14yFVwkZYTcI=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qPSrVyRrdUXCdUQkQc41vZqP95zmNpzbqgs6qokmYpHNsQJNlHw3AzbqSiWXWa52u
	 LrrAicYhuh3C3ksdhGUAtANtM6ubuJ4leoClkX0MXaK4v88nXBohLpNsIRnkvr5CqV
	 APSTsEUcoqZaSBH3IScIEJug3ZK1QBbTrBtejMSU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F3893F8013C;
	Wed, 20 Nov 2019 18:02:56 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 190A8F8013D; Wed, 20 Nov 2019 18:02:55 +0100 (CET)
Received: from smtprelay.hostedemail.com (smtprelay0120.hostedemail.com
 [216.40.44.120])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 48695F800FF
 for <alsa-devel@alsa-project.org>; Wed, 20 Nov 2019 18:02:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 48695F800FF
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay08.hostedemail.com (Postfix) with ESMTP id A23C6182CED5B;
 Wed, 20 Nov 2019 17:02:46 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: dolls67_351a93e0e3454
X-Filterd-Recvd-Size: 1742
Received: from XPS-9350.home (unknown [47.151.135.224])
 (Authenticated sender: joe@perches.com)
 by omf18.hostedemail.com (Postfix) with ESMTPA;
 Wed, 20 Nov 2019 17:02:44 +0000 (UTC)
Message-ID: <ce1787fcb5fcb8f2aba8fbc6ab95dec7e43c98ba.camel@perches.com>
From: Joe Perches <joe@perches.com>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Krzysztof
 Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org
Date: Wed, 20 Nov 2019 09:02:22 -0800
In-Reply-To: <c58df5a9-216f-2f4c-5afe-23866875a168@linux.intel.com>
References: <20191120133252.6365-1-krzk@kernel.org>
 <c58df5a9-216f-2f4c-5afe-23866875a168@linux.intel.com>
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, alsa-devel@alsa-project.org,
 Jie Yang <yang.jie@linux.intel.com>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: Fix Kconfig indentation
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

On Wed, 2019-11-20 at 09:02 -0600, Pierre-Louis Bossart wrote:
> 
> On 11/20/19 7:32 AM, Krzysztof Kozlowski wrote:
> > Adjust indentation from spaces to tab (+optional two spaces) as in
> > coding style with command like:
> > 	$ sed -e 's/^        /\t/' -i */Kconfig
> Thanks for the changes, is there a way for checkpatch.pl or some tool to 
> detect this?

Sure, if you want to stick a Kconfig grammar parser into
checkpatch and validate any Kconfig file content.

Otherwise, maybe improve scripts/kconfig/lexer.l and
(optionally?) emit a message whenever the line's content
doesn't fit some preferred style.


_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
