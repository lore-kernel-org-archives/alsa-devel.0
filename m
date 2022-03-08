Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FDF6C433EF
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Mar 2022 02:08:18 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8A47E1785;
	Tue,  8 Mar 2022 03:07:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8A47E1785
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1646705296;
	bh=FO6In/hNNc4+xoPxbiFoiYv5P+ui3FmIN6FYKohezhQ=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PIuCLtEanOfESDnjfox9/n6ba296bHIoyKiAHAVHH/u4+mhi2AxS/zMCe12esDjF/
	 DNyyQ4XSmxRUbgQSXPJ8aXWHxJ/oeyy1byvrKpmytSTF9l00aPegX0vWkerdQTMuSZ
	 scyuhklMY7InQvNwFek0OCBZZuD/bJd4LmJXEJVc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2EFEFF800E9;
	Tue,  8 Mar 2022 03:07:26 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9278FF8013F; Tue,  8 Mar 2022 03:07:24 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4CA5AF800E9
 for <alsa-devel@alsa-project.org>; Tue,  8 Mar 2022 03:07:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4CA5AF800E9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="uWEhtOmJ"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id C75A7614DB;
 Tue,  8 Mar 2022 02:07:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AC39C340F3;
 Tue,  8 Mar 2022 02:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1646705237;
 bh=FO6In/hNNc4+xoPxbiFoiYv5P+ui3FmIN6FYKohezhQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=uWEhtOmJW/pKK74Snzk7xTRhXgv+PfECzwVqS27gC2uv+FBBOo2AXWAgabYKNVt+d
 BIpJ7iZ3Po4HwcDzJ2hpIyY9slGkOFUek3mSOweWaJP0o/zgPHniPfXS6Xyl3xMy1W
 /Rz66R1l94kASKpyuLrtXi4v3LP3KIXK83RPsRNHnYK8H37abZa9gw0YDgOf+fJ5mT
 6wlZKEO4BNF+nJDa24rlmgPk8Ol+VRhvkNLmeyoJZTOsORSomSuhi/Zxur3dS3afTk
 gHtmjt9unkJHUiRS3XFhwxJiPq9vqDYTFwB5u5Orq1KvIua33EI8lHPbz9O6CKRza3
 0tw+AZSYQ7mmg==
Date: Tue, 8 Mar 2022 10:07:12 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Miaoqian Lin <linmq006@gmail.com>
Subject: Re: [PATCH] ASoC: mediatek: mt8192-mt6359: Fix error handling in
 mt8192_mt6359_dev_probe
Message-ID: <Yia6UG1fMZGSYzcs@google.com>
References: <20220308015224.23585-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308015224.23585-1-linmq006@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Jiaxin Yu <jiaxin.yu@mediatek.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org
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

On Tue, Mar 08, 2022 at 01:52:22AM +0000, Miaoqian Lin wrote:
> The device_node pointer is returned by of_parse_phandle()  with refcount
> incremented. We should use of_node_put() on it when done.
> 
> This function only calls of_node_put() in the regular path.
> And it will cause refcount leak in error paths.
> Fix this by calling of_node_put() in error handling too.
> 
> Fixes: 4e28491a7a19 ("ASoC: mediatek: mt8192-mt6359: fix device_node leak")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
