Return-Path: <SRS0=NmsS=EY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B158C5519F
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Nov 2020 05:45:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 260952468F
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Nov 2020 05:45:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="jfU9oi7L";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="gJxg4XPi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 260952468F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 75EAE16C8;
	Wed, 18 Nov 2020 06:44:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 75EAE16C8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605678335;
	bh=Ob+rum7wsEe9z0idtPYXc6i57BLT7E6bWmqICvIDrE4=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jfU9oi7LhzxHHFZQiJ3kAeOLIuhC5Mj+cZRrT5+35zEAPEYqZ26NBnh9dQEyL9ZrL
	 oHxUmqLv5fd1h+leFZD/Cmensc4EuOapokurcPEXZbK3hCKJOriL+REqER/Ie3ntGe
	 i1DFcekiKMfevMltGPkMtd8yjgupTtLBocrGMVW0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0D6ACF80168;
	Wed, 18 Nov 2020 06:44:45 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0C2AEF8016C; Wed, 18 Nov 2020 06:44:43 +0100 (CET)
Received: from hqnvemgate26.nvidia.com (hqnvemgate26.nvidia.com
 [216.228.121.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 30073F80158
 for <alsa-devel@alsa-project.org>; Wed, 18 Nov 2020 06:44:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 30073F80158
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com
 header.b="gJxg4XPi"
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5fb4b4c20000>; Tue, 17 Nov 2020 21:44:34 -0800
Received: from [10.25.102.221] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 18 Nov
 2020 05:44:27 +0000
Subject: Re: [PATCH 1/4] ASoC: audio-graph-card: Refactor schema
To: Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>
References: <20201117013349.2458416-1-robh@kernel.org>
 <20201117013349.2458416-2-robh@kernel.org>
From: Sameer Pujar <spujar@nvidia.com>
Message-ID: <f56ff2bf-df85-dbf9-23ce-62d2682bef99@nvidia.com>
Date: Wed, 18 Nov 2020 11:14:24 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201117013349.2458416-2-robh@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1605678274; bh=ASlF1JPd3ZLrsdCntZ++jHI66rp+SI2UXQnZFIYwjao=;
 h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
 MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 Content-Language:X-Originating-IP:X-ClientProxiedBy;
 b=gJxg4XPilhU+olJ8aW0aJcN7PhULezLQmntRrmPV/XvJIuARN/DQJRAqdgWsbLVtr
 CbzvkA/QwG71RcE45bpDhPgpS26VwAKlbGyGPtMHo8GmvPQabBOAmoHeSjxKgPvPXL
 GibdfFCrhjg8mlGWg1sVBOU6/p9Knh72yAngk2KewvAc6rsGdw0hFiVqy4GJc3LUNr
 NJW/mwminiLzcXEyC6HSCv1p4bbDHOiVWa0bpwNIP6GQkeRz/zsbarsm5vek21+mF8
 kE/Io3hDvCm4WZQCjpooVrS3u9NCK5orayCXGzUpIxhSn8XjtufdNpJXqEeI13nMR9
 BelRzSGih1Elw==
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Liam Girdwood <lgirdwood@gmail.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Lubomir Rintel <lkundrak@v3.sk>
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

Hi Rob,

> From: Sameer Pujar <spujar@nvidia.com>
>
> There can be customized sound cards which are based on generic audio
> graph. In such cases most of the stuff is reused from generic audio
> graph. To facilitate this, refactor audio graph schema into multiple
> files and the base schema can be reused for specific sound cards.
>
> The graph card nodes and port nodes are separate entities, so they
> should be separate schemas.
>
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> [robh: Split out port schema. Add graph.yaml in subsequent commit]
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>   .../bindings/sound/audio-graph-card.yaml      | 106 +-----------------
>   .../bindings/sound/audio-graph-port.yaml      |  86 ++++++++++++++
>   .../bindings/sound/audio-graph.yaml           |  45 ++++++++
>   .../bindings/sound/renesas,rsnd.yaml          |  12 +-
>   4 files changed, 141 insertions(+), 108 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/sound/audio-graph-port.yaml
>   create mode 100644 Documentation/devicetree/bindings/sound/audio-graph.yaml

Thanks for the update.

Acked-by: Sameer Pujar <spujar@nvidia.com>
