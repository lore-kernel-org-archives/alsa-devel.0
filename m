Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FE8BC433EF
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Jun 2022 03:25:25 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 124B8112;
	Mon,  6 Jun 2022 05:24:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 124B8112
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1654485924;
	bh=27QfA0HUowPRHp50PZrytVJKom6NrSAJVHItu8R3jHk=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Y2290GwwwMvOEqCsDQAFRd34pMHu60fZAIrgKCjQ5G2CVt2MbA2x3HRWTOhaFGWLV
	 855ZIBzK6scE8AZN8qvAT4wsu3g53X0We7S2NDjkvjz9Ns5meF9vptxcCqQUdGDtbD
	 w+CVPvLKeqhNDLlGU7oH9n8nLhUqbQNbKqw7cEPY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 98241F80116;
	Mon,  6 Jun 2022 05:24:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3EB0BF801D8; Mon,  6 Jun 2022 05:24:31 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CB838F80116
 for <alsa-devel@alsa-project.org>; Mon,  6 Jun 2022 05:24:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CB838F80116
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="lvcFToTH"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 76F12B80E66;
 Mon,  6 Jun 2022 03:24:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EEB0C34119;
 Mon,  6 Jun 2022 03:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1654485864;
 bh=27QfA0HUowPRHp50PZrytVJKom6NrSAJVHItu8R3jHk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lvcFToTHkstRhWpP8zzRAtwT4O09ePpK8HGekpw3LbbkO31qHgbzt6f+XtyUX0wyA
 Upkatwg5nauh8UM2QzesBlVcMsGR/vOtWBVpC8AQ7EE08dURfEzfG2PAQfmyn3Wsev
 fbiAi3oV74RKwRDQyTv0Ao+mF7On+YoFOu+v3y2rwJR3RNstABANHp1SN/96ILPiON
 E8aoRDtBzGZ9BnEuJp+MH983c3K/e7h5ieOGtIgCU0lq7G+SWBxJyWELlENqgeq8qP
 Yiu9caGxHd3WDJsM/emwZ+t53/hVArkLUxciUrdm/uTeV5OPOQTfX2fckcYnno1Mrm
 YoUygv94h4p3Q==
Date: Mon, 6 Jun 2022 03:24:19 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Miaoqian Lin <linmq006@gmail.com>
Subject: Re: [PATCH v2] ASoC: cros_ec_codec: Fix refcount leak in
 cros_ec_codec_platform_probe
Message-ID: <Yp1zY39dZDzquBE7@google.com>
References: <20220603131043.38907-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220603131043.38907-1-linmq006@gmail.com>
Cc: chrome-platform@lists.linux.dev, alsa-devel@alsa-project.org,
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>,
 Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 Mark Brown <broonie@kernel.org>, Guenter Roeck <groeck@chromium.org>,
 Benson Leung <bleung@chromium.org>, Cheng-Yi Chiang <cychiang@chromium.org>
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

On Fri, Jun 03, 2022 at 05:10:43PM +0400, Miaoqian Lin wrote:
> of_parse_phandle() returns a node pointer with refcount
> incremented, we should use of_node_put() on it when not need anymore.
> Add missing of_node_put() to avoid refcount leak.
> 
> Fixes: b6bc07d4360d ("ASoC: cros_ec_codec: support WoV")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
