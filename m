Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33578C433F5
	for <alsa-devel@archiver.kernel.org>; Thu, 24 Mar 2022 00:58:34 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 735D016BD;
	Thu, 24 Mar 2022 01:57:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 735D016BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1648083512;
	bh=BQcVmEPhzCFk4v+8oWiaAxBOeilqbJFo+BuD++HaQxw=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=V7qTpNUJss1ElBr9R4lytstL0tcAeWI40UhqRZ6+cBdUy1gVO3SVio3S4AafO0HlW
	 19A6tevkZqBCVaD7eYbmsozO+GOGKeMgmhd/Rhzcg5SpQAbrxx0bDQOBnXkrv+QYvw
	 w5oqrxF3zN4/qhW6Ttg0pf/xdBtfrt6uQ7RHoYKw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 18FE0F8047C;
	Thu, 24 Mar 2022 01:57:42 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 12DA5F804BC; Thu, 24 Mar 2022 01:57:40 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0B4E1F80165
 for <alsa-devel@alsa-project.org>; Thu, 24 Mar 2022 01:57:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0B4E1F80165
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="HWW/KDkd"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 9E29EB821DA;
 Thu, 24 Mar 2022 00:57:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F423BC340E8;
 Thu, 24 Mar 2022 00:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1648083452;
 bh=BQcVmEPhzCFk4v+8oWiaAxBOeilqbJFo+BuD++HaQxw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HWW/KDkd19s8uyy1l/3SNXQ1tQ1cI+AYB4cdNiBLdE/7SA4jzyOWboKg7UBUp86b1
 CA1e6SQqbRUo8GpQTWCq3VVxmN51Bqe/c9CUoWBSP0SN9gB9HQ8cvqiCIdSgO8Z9Wo
 VR8ZXkSKGXxcRstv15O/2u9kw1MIno26CZw1Gsg2JIlVptGS7TrsupndhJ+4GN1KKd
 RFgRyK6Kn4uy9Nm5q112eq0hi86XTDU7TkCHNBnGxi/EV9ahUAtyY6msoLl0iipVWv
 YhI/ssY7WH2Lx5fGx1Dsc5fyE4QFDuh9yB/5b7vAHpkK/aL5lNA7ghi8bKeFHC2CI7
 yGnQgS7gFff7w==
Date: Thu, 24 Mar 2022 08:57:27 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Jiaxin Yu <jiaxin.yu@mediatek.com>
Subject: Re: [v6 3/4] ASoC: mediatek: mt8192: refactor for I2S8/I2S9 DAI
 links of headset
Message-ID: <YjvB96lI22tUs3ql@google.com>
References: <20220323164442.921-1-jiaxin.yu@mediatek.com>
 <20220323164442.921-4-jiaxin.yu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220323164442.921-4-jiaxin.yu@mediatek.com>
Cc: devicetree@vger.kernel.org, linmq006@gmail.com, alsa-devel@alsa-project.org,
 robh+dt@kernel.org, linux-kernel@vger.kernel.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com, broonie@kernel.org,
 linux-mediatek@lists.infradead.org, trevor.wu@mediatek.com,
 matthias.bgg@gmail.com, aaronyu@google.com,
 linux-arm-kernel@lists.infradead.org, angelogioacchino.delregno@collabora.com
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

On Thu, Mar 24, 2022 at 12:44:41AM +0800, Jiaxin Yu wrote:
> MT8192 platform use rt5682 codec, so through the snd_soc_of_get_dai_link_codes()
> to complete the configuration of I2S8/I2S9 dai_link's codecs.
> 
> Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
