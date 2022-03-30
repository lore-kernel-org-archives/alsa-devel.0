Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C316AC433EF
	for <alsa-devel@archiver.kernel.org>; Wed, 30 Mar 2022 15:49:15 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 61E0D192B;
	Wed, 30 Mar 2022 17:48:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 61E0D192B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1648655353;
	bh=oedDkEm4sa+Mo84vh6B/CgW6pQ6r5p1ZC6F2P+kiWWY=;
	h=Subject:From:To:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QLuOaBpjxLsp3IxcZWUau7X/2Okw6gP36GFM7znSvlby0ikqV5+4fPvWwPVeZ43GW
	 in8vkuHglW5LRyu9rqls2n9+0EJENrDZEqZoGv1gLwbexzULNDU2F+2WgCZmoBaXKz
	 76ikHvd8YWwih9gqtOyc8hraidhbYuvhlFSZfP3o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CABDBF80253;
	Wed, 30 Mar 2022 17:48:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BC517F80155; Wed, 30 Mar 2022 17:48:20 +0200 (CEST)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F2D5AF80155
 for <alsa-devel@alsa-project.org>; Wed, 30 Mar 2022 17:48:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F2D5AF80155
X-UUID: 3b656cbffa5f4f99900f5d676e1ba9e7-20220330
X-UUID: 3b656cbffa5f4f99900f5d676e1ba9e7-20220330
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by
 mailgw01.mediatek.com (envelope-from <jiaxin.yu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1049488280; Wed, 30 Mar 2022 23:48:03 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3; 
 Wed, 30 Mar 2022 23:48:02 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 30 Mar 2022 23:48:01 +0800
Message-ID: <734fbf254c64668856e987aafe9d7dfd3ec86941.camel@mediatek.com>
Subject: Re: [v7 2/4] ASoC: mediatek: mt8192: refactor for I2S3 DAI link of
 speaker
From: Jiaxin Yu <jiaxin.yu@mediatek.com>
To: Mark Brown <broonie@kernel.org>
Date: Wed, 30 Mar 2022 23:48:01 +0800
In-Reply-To: <YkRoC30JLDMeVi1B@sirena.org.uk>
References: <20220324064511.10665-1-jiaxin.yu@mediatek.com>
 <20220324064511.10665-3-jiaxin.yu@mediatek.com>
 <20220329223002.uo7kiemopkh7ak4x@notapiano>
 <dee3fbb7c9f0c3e1f11143db1d6fc4381cab827f.camel@mediatek.com>
 <YkRNSoBKFvYYyZLu@sirena.org.uk>
 <61e9fb59448837cfc8e3ec862b711294bcb68872.camel@mediatek.com>
 <YkRoC30JLDMeVi1B@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK: N
Cc: devicetree@vger.kernel.org, linmq006@gmail.com,
 "=?ISO-8859-1?Q?N=EDcolas?= F. R. A. Prado" <nfraprado@collabora.com>,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com, tzungbi@google.com,
 robh+dt@kernel.org, linux-mediatek@lists.infradead.org, trevor.wu@mediatek.com,
 Tzung-Bi Shih <tzungbi@kernel.org>, matthias.bgg@gmail.com, aaronyu@google.com,
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

On Wed, 2022-03-30 at 15:24 +0100, Mark Brown wrote:
> On Wed, Mar 30, 2022 at 10:06:24PM +0800, Jiaxin Yu wrote:
> > On Wed, 2022-03-30 at 13:30 +0100, Mark Brown wrote:
> > > Making a previously optional property required means that systems
> > > that
> > > previously worked may stop working unless they update their DT,
> > > DTs
> > > may
> > > be distributed separately to the kernel and perhaps even baked
> > > into
> > > firmware or similar.
> > Thank you for your detailed answer. I should keep the driver's
> > behavior
> > consistent with the description of dt-bindings. The "mediatek,hdmi-
> > codec" needs to be set as the required property. Is my
> > understanding
> > right?
> 
> The binding document and code should match so if one is changed the
> other needs to be changed too.
> 
> In theory we should never change a previously optional property to
> required which would mean that the code should be updated to reflect
> the
> binding document, however sometimes the DT isn't actually used as a
> stable intereface by anything for a given property or device type so
> we
> can get away with changing things.

"however sometimes the DT isn't actually used as a stable intereface by
anything for a given property or device type so we can get away with
changing things."

Sorry, I don't understand the real idea of this description. Does it
mean that dt-bindings in this series don't need to be updated, but the
driver?

