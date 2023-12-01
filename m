Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A46C6C4167B
	for <alsa-devel@archiver.kernel.org>; Fri,  1 Dec 2023 10:00:41 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 88F7DDF3;
	Fri,  1 Dec 2023 11:00:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 88F7DDF3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1701424838;
	bh=ccXiUANYmPCB8NhMfkOx6I/A0dGnOoIhG/1n4IleSEM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=bJx2Gc+qDhyEc7cEvjHeL2TejcK2JkgWC8wlFL3zEdq3risn4AGW3V77o3gvshp1L
	 E1iVt/xBswTn0LhUZVjz3fAt7BoALds4ZCrfaUjxKzEz9/1rYgXzy/XuGLScMtRUeK
	 EqxB67Zb9OuRfRwvYYm75MnY+rUEmMLBmtzKK8J4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AD03FF8057F; Fri,  1 Dec 2023 11:00:07 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 1AF50F80587;
	Fri,  1 Dec 2023 11:00:07 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 17380F8016E; Fri,  1 Dec 2023 10:57:49 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D9266F80114
	for <alsa-devel@alsa-project.org>; Fri,  1 Dec 2023 10:57:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D9266F80114
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=nN6G/Cmk
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 87921B84776;
	Fri,  1 Dec 2023 09:57:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D37BAC433C9;
	Fri,  1 Dec 2023 09:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701424661;
	bh=ccXiUANYmPCB8NhMfkOx6I/A0dGnOoIhG/1n4IleSEM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=nN6G/CmkDMIyNYHBFUEVMe6YyKjeJeDlcTkISZVgbTI/pqNUsFklKLjjSBgAOK7ww
	 F+Z2KwQWVong0wXXQ8+V0ZSGFvWiaDZ5h4sS4XJxLIbZ2fFZIxPTaoxOuGtDiqqk2p
	 5POm7Fu6D+GW5UvL7JwKYwMpdLwg7Fk9VuapkM9/kKP1TSnKEolwx2DF7Si7mSRIrd
	 sOsKsJcq3KHr3/WfnhQjoqUbxvkfzKhwu5tV0eQub0nvw/FciJHAai10aBfmejDR80
	 AtrxvFKdZX8LBzEx5XRqDkXsRxFcCYz4AbrgoAwnqroScmdHvFihxmVOAjnqug+A/B
	 0tyQAf6oAtP6g==
From: Lee Jones <lee@kernel.org>
To: broonie@kernel.org, tudor.ambarus@linaro.org, pratyush@kernel.org,
 miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
 sbinding@opensource.cirrus.com, lee@kernel.org, james.schulman@cirrus.com,
 david.rhodes@cirrus.com, rf@opensource.cirrus.com, perex@perex.cz,
 tiwai@suse.com, Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 michael@walle.cc, linux-mtd@lists.infradead.org,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
 claudiu.beznea@tuxon.dev, michal.simek@amd.com,
 linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
 patches@opensource.cirrus.com, linux-sound@vger.kernel.org, git@amd.com,
 amitrkcian2002@gmail.com
In-Reply-To: <20231125092137.2948-2-amit.kumar-mahapatra@amd.com>
References: <20231125092137.2948-1-amit.kumar-mahapatra@amd.com>
 <20231125092137.2948-2-amit.kumar-mahapatra@amd.com>
Subject: Re: (subset) [PATCH v11 01/10] mfd: tps6594: Use set/get APIs to
 access spi->chip_select
Message-Id: <170142465659.3329910.8527538140063947758.b4-ty@kernel.org>
Date: Fri, 01 Dec 2023 09:57:36 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3
Message-ID-Hash: 3U6BHRJAQ7ZG6PMZK5CGFDX42WFH54GH
X-Message-ID-Hash: 3U6BHRJAQ7ZG6PMZK5CGFDX42WFH54GH
X-MailFrom: lee@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/3U6BHRJAQ7ZG6PMZK5CGFDX42WFH54GH/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Sat, 25 Nov 2023 14:51:28 +0530, Amit Kumar Mahapatra wrote:
> In preparation for adding multiple CS support for a device, set/get
> functions were introduces accessing spi->chip_select in
> 'commit 303feb3cc06a ("spi: Add APIs in spi core to set/get
> spi->chip_select and spi->cs_gpiod")'.
> Replace spi->chip_select with spi_get_chipselect() API.
> 
> 
> [...]

Applied, thanks!

[01/10] mfd: tps6594: Use set/get APIs to access spi->chip_select
        commit: dd636638446c87c95c5beddcd367d95ac6764c6c

--
Lee Jones [李琼斯]

