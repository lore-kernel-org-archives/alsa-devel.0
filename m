Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7ADEC433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Mar 2022 09:22:52 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C385016F5;
	Mon, 21 Mar 2022 10:22:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C385016F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1647854570;
	bh=js3Rr+dGBwxPT5O2sAogbnMjmIOd+kG1mAzBVLLRx5o=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZNGQz5OF31w9xjq16oW1QTkf5e/Xuk4FsPB26iKB22TXUPxjRhk3DItppArGeQMLV
	 ydF8koV1bq0+H3JBFfyKhn3KQxhWp67oiZJjB1TLiGZEGiy0ffKycUspUWmWPgnddr
	 04NgY7fe4kU4LxEQ0dTp2nsdBtJQcin7AqI3SUew=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 64AB7F80116;
	Mon, 21 Mar 2022 10:22:00 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8CEA8F80227; Mon, 21 Mar 2022 10:21:58 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 24EF0F80116
 for <alsa-devel@alsa-project.org>; Mon, 21 Mar 2022 10:21:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 24EF0F80116
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="njg8O/W4"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id CB0A5611E1;
 Mon, 21 Mar 2022 09:21:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE151C340E8;
 Mon, 21 Mar 2022 09:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1647854509;
 bh=js3Rr+dGBwxPT5O2sAogbnMjmIOd+kG1mAzBVLLRx5o=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=njg8O/W4Vv3IECCZJM2JewVvH2vhm/jUaAYsDEQCWqJEgtkAsUVGs4K/8FcdpyR71
 YjV1ksexpq42ejRKGzipRXOojPfkM/Q7xSNrXdq6JsKQWhkzJ7rOAC15x1NcxNerTU
 un6vKgzW5+68tp0PAizpMFw8QEXn9ec5oKQs4+546vK0dWR7HZ2kyk4ldf40i/Qe8r
 k1QnGilipJlO+hW0rVt0F1Aur7Wk9ZqXUiX5E9LZuEJ7i5vVUU3CQxVF3QT1LutpPz
 sIoozG+4fpjWdnp8YvNE/yHISY8DpgnYVsWpiG9oBKBUE/2Mw+q2mm/sQo6p12Go8A
 epZkZzxjmBvdA==
Date: Mon, 21 Mar 2022 17:21:44 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Jiaxin Yu <jiaxin.yu@mediatek.com>
Subject: Re: [v5 3/4] ASoC: mediatek: mt8192: refactor for I2S8/I2S9 DAI
 links of headset
Message-ID: <YjhDqKhtYastPhf0@google.com>
References: <20220319114111.11496-1-jiaxin.yu@mediatek.com>
 <20220319114111.11496-4-jiaxin.yu@mediatek.com>
 <Yjf4KjXpVJaNnvb8@google.com>
 <17e6e8895ebc1113911481c7e097b394005db123.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17e6e8895ebc1113911481c7e097b394005db123.camel@mediatek.com>
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

On Mon, Mar 21, 2022 at 05:14:08PM +0800, Jiaxin Yu wrote:
> On Mon, 2022-03-21 at 11:59 +0800, Tzung-Bi Shih wrote:
> > On Sat, Mar 19, 2022 at 07:41:10PM +0800, Jiaxin Yu wrote:
> > > @@ -1145,6 +1140,13 @@ static int mt8192_mt6359_dev_probe(struct
> > > platform_device *pdev)
> > >  		goto err_speaker_codec;
> > >  	}
> > >  
> > > +	headset_codec = of_get_child_by_name(pdev->dev.of_node,
> > > "mediatek,headset-codec");
> > > +	if (!headset_codec) {
> > > +		ret = -EINVAL;
> > > +		dev_err_probe(&pdev->dev, ret, "Property
> > > 'headset_codec' missing or invalid\n");
> > > +		goto err_headset_codec;
> > > +	}
> > 
> > (to be neat) Does it have any reason to prevent from using
> > of_parse_phandle()
> > but of_get_child_by_name()?
> 
> "mediatek,headset-codec" is a child node of pdev->dev.of_node, so I use
> of_get_child_by_name() to get and   pass it to
> snd_soc_of_get_dai_link_codecs().

"mediatek,platform" and "mediatek,hdmi-codec" are also children of
pdev->dev.of_node.  I guess my question is: why doesn't it also use
of_parse_phandle() for "mediatek,headset-codec"?  Did I misunderstand?
