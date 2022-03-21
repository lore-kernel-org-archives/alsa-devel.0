Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33AA5C433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Mar 2022 15:13:44 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 656321733;
	Mon, 21 Mar 2022 16:12:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 656321733
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1647875622;
	bh=9Y12UFEf0Mf9nHunCW2p4Tl8F6I/gFgWOZD/wYfYOMU=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=By7ZEqQy6NQ2FVC8KtBveHFjoG1NMAUX5eaHQjwdPYinup/Z7rdFWVb8FT7YzZPBn
	 20XvBUTwYuAOavGhXTUfXEfFUxq1mEFF4knJIvbtS/A79A5q6upSuNzc9Z7VNpu9+l
	 gAhEfYh5hSn9L7WOEziOUiCUPZAYHzpkSx2/hF78=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 91541F802D2;
	Mon, 21 Mar 2022 16:12:37 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BBD4EF80227; Mon, 21 Mar 2022 16:12:35 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9A6CFF80227
 for <alsa-devel@alsa-project.org>; Mon, 21 Mar 2022 16:12:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9A6CFF80227
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="RiriLh88"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 340F7B8170A;
 Mon, 21 Mar 2022 15:12:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B19D8C340E8;
 Mon, 21 Mar 2022 15:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1647875547;
 bh=9Y12UFEf0Mf9nHunCW2p4Tl8F6I/gFgWOZD/wYfYOMU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=RiriLh88bvOpCG0mZJ+XfNYOghNqemH6z0HFKHjpn01CIZL/8uy+fBu3RL2yZ/DeF
 eTvaFEST5+o9GuwG+/3fLNQMcCBLr0QnRiknPKr6YO6N/KUFRqGcuEmD2G3AFDLFXb
 b1A+5kJX6i2qDaa/J6EsuhGCfiWarZKgshXRXuZAzbioZMKnhryUdH14Kd8Sekcoqf
 wpJoFWDsQKMOmn0qTiSBbBHUTp3CHAQS7pBwsy/it0aq3Hwh/of1ahxnzo/+8jDEzq
 mOFsqnVuGbkbc6bT6JmC5XNEYsNSmuiVx0e6ypoJsd9ZaNQZkNw2V+UrJd8T8tT1qA
 35UMMnX5ChagA==
Date: Mon, 21 Mar 2022 23:12:23 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Trevor Wu <trevor.wu@mediatek.com>
Subject: Re: [PATCH v3 4/6] ASoC: mediatek: mt8195: rename card controls
Message-ID: <YjiV18IjpPMZrwvB@google.com>
References: <20220321072312.14972-1-trevor.wu@mediatek.com>
 <20220321072312.14972-5-trevor.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220321072312.14972-5-trevor.wu@mediatek.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, tiwai@suse.com,
 robh+dt@kernel.org, linux-kernel@vger.kernel.org, broonie@kernel.org,
 linux-mediatek@lists.infradead.org, yc.hung@mediatek.com,
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

On Mon, Mar 21, 2022 at 03:23:10PM +0800, Trevor Wu wrote:
> In order to be able to reuse the same configurations in user space,
> rename the controls to generic names.
> 
> "Headphone Jack" -> "Headphone"
> "Speakers" -> "Ext Spk"
> "Left Speaker" -> "Left Spk"
> "Right Speaker" -> "Right SPk"
> 
> Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
