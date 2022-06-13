Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BE3AC43334
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Jun 2022 09:48:57 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 18CB61749;
	Mon, 13 Jun 2022 11:48:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 18CB61749
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1655113735;
	bh=lWy1OIfhGmYslVWutuLhOJaoYa1YMjoJfP8ditaMs/U=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Q529Bno3LDI3XUeWxlTNgJQJxdKyfRlzECcxZlwLhgK0+JyJJWJuj7SuTrXBvRGUf
	 OnN4w8WkAf0W8WC2vIK8udZZUBhNnOd4Wc75g2PilhAoXbv0lNt7FGjv4LwNbM83sN
	 5C1zdQyqynfY8oT4O9rPT9sPHRqRAQLg4REikA2k=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AB89CF80107;
	Mon, 13 Jun 2022 11:48:04 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 563BAF804C1; Mon, 13 Jun 2022 11:48:02 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3ECCBF80107
 for <alsa-devel@alsa-project.org>; Mon, 13 Jun 2022 11:47:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3ECCBF80107
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="AB1boW9d"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
 by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25D7bRpY017595;
 Mon, 13 Jun 2022 04:47:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=CRTviHcnTGYQGc17bUWtHNOWPL7Dy+tsuuEXIupdrr4=;
 b=AB1boW9dAs+Yf9LKm3cYDlA9u3I06+BGsMJFLbKaexcHZujzQyhBBE0tsMWZHWJ5/pk2
 Yyag1HGoBElpx5OnHF30JfOUa9g36GGrRtvJf8H1/Q9BY+yz/u9t+aL9XqxYrei5xnOs
 giKpcS9xQ70DzbDl2kRUxUopnvLFhKniuHn4fsycKcT7PipsEbs4vt1wJJx5iiSv9F0l
 nyIFrdF/LwwXcQTKm7V6Uzs8RHe+wlqHdVRKEyziQ/2tfUXJHhHmO02NGjhNqwYPGa25
 Q3TAabCTfGg/TVXobLSQVDwCqtFmMjvQA9oYzM0olaJ+nAbQHd7SjQvCcZr2zAy3HGn+ yg== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
 by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3gmrf31psy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Mon, 13 Jun 2022 04:47:53 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 13 Jun
 2022 10:47:51 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.28 via
 Frontend Transport; Mon, 13 Jun 2022 10:47:51 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 7915B46C;
 Mon, 13 Jun 2022 09:47:51 +0000 (UTC)
Date: Mon, 13 Jun 2022 09:47:51 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH 22/23] ASoC: wm8731: update wlf,wm8731.yaml reference
Message-ID: <20220613094751.GZ38351@ediswmail.ad.cirrus.com>
References: <cover.1654529011.git.mchehab@kernel.org>
 <e56e54fe0ebb1b6e8dd2e245c398190016eb0a34.1654529011.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e56e54fe0ebb1b6e8dd2e245c398190016eb0a34.1654529011.git.mchehab@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: xy_jBaiF63BsDcKqeMRnyVUazqatw_C5
X-Proofpoint-ORIG-GUID: xy_jBaiF63BsDcKqeMRnyVUazqatw_C5
X-Proofpoint-Spam-Reason: safe
Cc: devicetree@vger.kernel.org,
 Alexandre Belloni <alexandre.belloni@bootlin.com>, alsa-devel@alsa-project.org,
 Jonathan Corbet <corbet@lwn.net>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-kernel@vger.kernel.org,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Nicolas Ferre <nicolas.ferre@microchip.com>, Mark Brown <broonie@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Claudiu Beznea <claudiu.beznea@microchip.com>,
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

On Mon, Jun 06, 2022 at 04:25:44PM +0100, Mauro Carvalho Chehab wrote:
> Changeset 0e336eeaf467 ("ASoC: wm8731: Convert DT bindings to YAML format")
> renamed: Documentation/devicetree/bindings/sound/wm8731.txt
> to: Documentation/devicetree/bindings/sound/wlf,wm8731.yaml.
> 
> Update its cross-reference accordingly.
> 
> Fixes: 0e336eeaf467 ("ASoC: wm8731: Convert DT bindings to YAML format")
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
