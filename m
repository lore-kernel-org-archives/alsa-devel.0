Return-Path: <SRS0=x+il=FL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27AF3C433FE
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Dec 2020 04:48:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B44221734
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Dec 2020 04:48:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B44221734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 68D911738;
	Mon,  7 Dec 2020 05:48:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 68D911738
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607316530;
	bh=5otoU6/da4hgylLuMnGsUNNL1B0DYmpjUcWY8/EgrDc=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YGZNGeyFTbKR6VjpJqNUOZV/agC22EnNE8EluVxCBTegDVL87bjGrq9h56RBagVZL
	 47Lplo2tyDQl3iSlaoWL65NIRds9QlNfmh6wmTFk2NT1roaVYBGHP34/cQxYs48aWq
	 hgzBl2A0DFW1G/XDEf6aB6SG/+flD49OaD3WK9nE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E8BDCF8010A;
	Mon,  7 Dec 2020 05:47:59 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C832EF8020D; Mon,  7 Dec 2020 05:47:58 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 40136F8010A
 for <alsa-devel@alsa-project.org>; Mon,  7 Dec 2020 05:47:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 40136F8010A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="vPqiunth"
Date: Mon, 7 Dec 2020 10:17:49 +0530
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1607316474;
 bh=5otoU6/da4hgylLuMnGsUNNL1B0DYmpjUcWY8/EgrDc=;
 h=From:To:Cc:Subject:References:In-Reply-To:From;
 b=vPqiunthY0LQw3w1KvSIVuc8zsJ1S4nrixVfmV83/bVVME1pS3lMrVn92PtZPmlax
 RA/tdKEuJK5+iUXLN5SW18yyDBmflxyliyqGNndcJKo0ZO5Y1v0exWDF7Um8Ruw8ZX
 YG1ZY37BT5Qzlu3HEAXpHJCQQo55Xni2Y67t3YxtF3k06pK1TUmVcUl3QHt9jpi0u9
 M0p5iXpeqG4JpDdPDD//QbkiL5gyKnfSVGz00RC55FywtLcex/tW/kIF+fG/+8y63K
 Ev0myUc4n0Qgp5VV5wPoqQ/zIzSyY7UyCP937XCSKHvS0fUNZdGsIZfh07ouJ+MaSm
 Ou3o+73FxE92Q==
From: Vinod Koul <vkoul@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 5/7] regmap: sdw: use no_pm routines for SoundWire 1.2 MBQ
Message-ID: <20201207044749.GB8403@vkoul-mobl>
References: <20201202204645.23891-1-yung-chuan.liao@linux.intel.com>
 <20201202204645.23891-6-yung-chuan.liao@linux.intel.com>
 <20201205074630.GS8403@vkoul-mobl>
 <e4e3d7ea-0825-2c8c-4182-6d1b578200a3@linux.intel.com>
 <X8u147aZbdrj6qN7@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <X8u147aZbdrj6qN7@kroah.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, linux-kernel@vger.kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 ranjani.sridharan@linux.intel.com, hui.wang@canonical.com, broonie@kernel.org,
 srinivas.kandagatla@linaro.org, jank@cadence.com, sanyog.r.kale@intel.com,
 Bard Liao <yung-chuan.liao@linux.intel.com>, rander.wang@linux.intel.com,
 bard.liao@intel.com
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

On 05-12-20, 17:31, Greg KH wrote:
> On Sat, Dec 05, 2020 at 08:52:50AM -0600, Pierre-Louis Bossart wrote:
> > 
> > > >   MODULE_DESCRIPTION("Regmap SoundWire MBQ Module");
> > > > -MODULE_LICENSE("GPL v2");
> > > > +MODULE_LICENSE("GPL");
> > > 
> > > Why do you want to change this ?
> > 
> > We only use MODULE_LICENSE("GPL") for new contributions since 'GPL v2' does
> > not bring any information on the license, is equivalent to 'GPL' and only
> > exists for 'historical reasons', see
> > 
> > https://www.kernel.org/doc/html/latest/process/license-rules.html
> > 
> > 
> > “GPL”	Module is licensed under GPL version 2. This does not express any
> > distinction between GPL-2.0-only or GPL-2.0-or-later. The exact license
> > information can only be determined via the license information in the
> > corresponding source files.
> > 
> > “GPL v2”	Same as “GPL”. It exists for historic reasons.
> > 
> > We should have used 'GPL' in the initial regmap MBQ patch but didn't for
> > some reason, this change just realigns with what we intended.
> > 
> > That said, this is unrelated to this no_pm patch so could be in a separate
> > one if you preferred it that way.
> 
> It should be separate as it does not have anything to do with the real
> reason this patch was submitted.

Precisely, this should be a separate patch explaining the motivation
behind this change.

-- 
~Vinod
