Return-Path: <SRS0=Vpzd=O3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F60C433EF
	for <alsa-devel@archiver.kernel.org>; Thu,  7 Oct 2021 02:46:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AE1F6113E
	for <alsa-devel@archiver.kernel.org>; Thu,  7 Oct 2021 02:46:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7AE1F6113E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dnyon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 224269F6;
	Thu,  7 Oct 2021 04:45:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 224269F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633574768;
	bh=yXdyabDfjZ+A/RncXyoHHMmlJkHBFE+VzZdU52kMq60=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HCiDzR+bBFf8xdPVe6JfivNlI/vUmmimEB0xg8SXSP0mLo81Yu3RKjGpKghI69B9x
	 x3r6zszV0NOQdSI89FLcxDeV98kS5k5Ra2N01R0mj6pwTes8D51ROlL9UJWRV/Rbv0
	 Xkmcez4/CCMN/EHyfYp33S73bIraWsEukGfgrkQk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A371DF8027D;
	Thu,  7 Oct 2021 04:45:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 688E9F80259; Thu,  7 Oct 2021 04:45:16 +0200 (CEST)
Received: from dnyon.com (dnyon.com [82.223.165.189])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C7A28F800FE
 for <alsa-devel@alsa-project.org>; Thu,  7 Oct 2021 04:45:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C7A28F800FE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=dnyon.com header.i=@dnyon.com
 header.b="FttTzjp5"
Received: from dnyon.com (55.red-81-39-194.dynamicip.rima-tde.net
 [81.39.194.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by dnyon.com (Postfix) with ESMTPSA id 067AE3FD76;
 Thu,  7 Oct 2021 02:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dnyon.com; s=mail;
 t=1633574695; bh=yXdyabDfjZ+A/RncXyoHHMmlJkHBFE+VzZdU52kMq60=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=FttTzjp5tZcPDEDtWtG8vxozXND13c9yZCVON+ZIGwbPu+sPC4kpChGIBva9TmLYG
 ayyCxQvmsEJF3zDOku9CLaFW3EsAUcz+o+jSR9m/81xybYWav66u5CPxGvJT0a4On4
 0N9zJfCoOtxjPOjxBURICf1qn33EKuviLFl6Lu5V795aa4LMI6AdI50Vq0GanAw6NL
 0CutSADQV3JcnMdNW/sRODXaDyTBZSJW/sKLe1xnM5fJ9jVX745EbXi4atP7a1y8FR
 0GKyhSQR2umIn40SBNETounjF5qRQEox5+ElRodwMlXyFtpdRvRyW+z2fg0nwE7Zzc
 2VKo5Z/pXYGRg==
From: Alejandro Tafalla <atafalla@dnyon.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@linux.intel.com>,
 ~postmarketos/upstreaming@lists.sr.ht, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] dt-bindings: sound: max98927: Add reset-gpios
 optional property
Date: Thu, 07 Oct 2021 04:44:49 +0200
Message-ID: <4682758.31r3eYUQgx@alexpc>
In-Reply-To: <5004d52da527bf1dd9e5b17e20b2ce50a0b57b5a.1633572679.git.atafalla@dnyon.com>
References: <cover.1633572679.git.atafalla@dnyon.com>
 <5004d52da527bf1dd9e5b17e20b2ce50a0b57b5a.1633572679.git.atafalla@dnyon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Cc: devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Takashi Iwai <tiwai@suse.com>
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

On 7/10/21 4:38 Alejandro Tafalla wrote:
> Signed-off-by: Alejandro Tafalla <atafalla@dnyon.com>
> ---
>  Documentation/devicetree/bindings/sound/max9892x.txt | 3 +++
>  1 file changed, 3 insertions(+)

Sorry, I forgot to add:  Acked-by: Rob Herring <robh@kernel.org>

-- 
Alejandro Tafalla


