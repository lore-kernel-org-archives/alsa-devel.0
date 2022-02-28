Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FB2DC433EF
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Mar 2022 08:46:16 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C054D1EDD;
	Wed,  2 Mar 2022 09:45:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C054D1EDD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1646210774;
	bh=uSavGpk0ExFlsWEKDVZVzJWcPdfAeGmRGCCGsNDGZJI=;
	h=Date:From:To:Subject:In-Reply-To:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=drv5htq+Fmo8ArwFAsEbfxQ23dl83C2aj82P/DKjC9u1S0RDb5GY72o6tSNgL81jR
	 79g+uQr3RYS4pLZwNNAHfFVcmzAOUSMgp5q3Yjnhv5Nd/vPDSWKdisL1H5qc48ismp
	 LHQxewYvSvNHgHdcbJpyXKKNwGa4pczM1sp4NrCE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6F8A1F80616;
	Wed,  2 Mar 2022 09:34:04 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 28385F80125; Mon, 28 Feb 2022 21:06:20 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1BA07F80125
 for <alsa-devel@alsa-project.org>; Mon, 28 Feb 2022 21:06:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1BA07F80125
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Qb3B2kQ3"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 2C01AB8164E;
 Mon, 28 Feb 2022 20:06:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85E29C340F1;
 Mon, 28 Feb 2022 20:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1646078767;
 bh=uSavGpk0ExFlsWEKDVZVzJWcPdfAeGmRGCCGsNDGZJI=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=Qb3B2kQ3+f9XzXe4nmDRsU8fezmZ+/v8PAEwfxslUlmRBgDPXTSFx61nrA8w3HnnB
 jiO48/wBjY9ATJ1CiCs8pQbzqi+CPyMUD7VJzynEdGC7iEhWqi2wiMxXsSWYiUDIQt
 A3kKL2pQXkopi7jn30+fSIP85KMOScBqm+z9JZHWR2G9Pnhp71ylIv9Hk7UHqh5TFW
 vROrJiyF+MkB5CSUYjMTwfvPtGA4K1mbCgJkjG4HhaTUDUqd2aSATsYWThH1CNVAP/
 Q0tdc6VQmrdT+I+jgvtFLagljNriJV7jZByMhdj/HNW8K7kIBTiLovJvYIp5rkp81v
 RPoj3hmNJbrCA==
Date: Mon, 28 Feb 2022 14:06:06 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH v3 05/11] PCI: Use driver_set_override() instead of
 open-coding
Message-ID: <20220228200606.GA516338@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220227135214.145599-6-krzysztof.kozlowski@canonical.com>
X-Mailman-Approved-At: Wed, 02 Mar 2022 09:33:34 +0100
Cc: linux-hyperv@vger.kernel.org, Stuart Yoder <stuyoder@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-pci@vger.kernel.org,
 Jason Wang <jasowang@redhat.com>, linux-remoteproc@vger.kernel.org,
 alsa-devel@alsa-project.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Vineeth Vijayan <vneethv@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>, Fabio Estevam <festevam@gmail.com>,
 linux-clk@vger.kernel.org, linux-s390@vger.kernel.org,
 Wei Liu <wei.liu@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>,
 Abel Vesa <abel.vesa@nxp.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Dexuan Cui <decui@microsoft.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Andy Gross <agross@kernel.org>,
 NXP Linux Team <linux-imx@nxp.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 linux-arm-msm@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>,
 linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Bjorn Helgaas <bhelgaas@google.com>, virtualization@lists.linux-foundation.org,
 linux-arm-kernel@lists.infradead.org,
 Laurentiu Tudor <laurentiu.tudor@nxp.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Peter Oberparleiter <oberpar@linux.ibm.com>, linux-kernel@vger.kernel.org,
 Sven Schnelle <svens@linux.ibm.com>, Shawn Guo <shawnguo@kernel.org>
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

On Sun, Feb 27, 2022 at 02:52:08PM +0100, Krzysztof Kozlowski wrote:
> Use a helper for seting driver_override to reduce amount of duplicated
> code. Make the driver_override field const char, because it is not
> modified by the core and it matches other subsystems.

s/seting/setting/
or even better, s/for seting/to set/

> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> -	char		*driver_override; /* Driver name to force a match */
> +	/*
> +	 * Driver name to force a match.
> +	 * Do not set directly, because core frees it.
> +	 * Use driver_set_override() to set or clear it.

Wrap this comment to fill 78 columns or so.

> +	 */
> +	const char	*driver_override;
>  
>  	unsigned long	priv_flags;	/* Private flags for the PCI driver */
>  
> -- 
> 2.32.0
> 
