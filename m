Return-Path: <SRS0=wMTJ=I5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C47C433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 31 Mar 2021 09:17:47 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DE51619D8
	for <alsa-devel@archiver.kernel.org>; Wed, 31 Mar 2021 09:17:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DE51619D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ADF461675;
	Wed, 31 Mar 2021 11:16:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ADF461675
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617182262;
	bh=QnyBzxTk8l8rBNsAx/w3kk+Lgn5rzvIEJR/Skutadrc=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ajtGi2chLitjgdlfmgJAWxN3JCFAU5sHzEO2yWxI0EsIzS0ob5A2Hhd5BIctd1Ggw
	 7TA+3bXK9yfchTLcFEg6Tx//J+LjmdnzHvNb5wxJ7U1fci4QWYzTZq2EkRdTN+LXWz
	 S2uzF/hBEigxOkbWwz5y4lTPEF7otEdJU0jebDQo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1928BF8016E;
	Wed, 31 Mar 2021 11:16:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 52E25F801DB; Wed, 31 Mar 2021 11:16:50 +0200 (CEST)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E15BDF8015A
 for <alsa-devel@alsa-project.org>; Wed, 31 Mar 2021 11:16:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E15BDF8015A
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F9LHB4my0zyNLP;
 Wed, 31 Mar 2021 17:14:30 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.179.202) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Wed, 31 Mar 2021 17:16:25 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 "Rob Herring" <robh+dt@kernel.org>, alsa-devel <alsa-devel@alsa-project.org>, 
 devicetree <devicetree@vger.kernel.org>, linux-kernel
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/2] clean up dt_binding_check and dtbs_check warnings of
 renesas, rsnd.yaml
Date: Wed, 31 Mar 2021 17:16:14 +0800
Message-ID: <20210331091616.2306-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.174.179.202]
X-CFilter-Loop: Reflected
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Zhen Lei <thunder.leizhen@huawei.com>
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

It was then adjusted based on the following patch series:
[1] https://lore.kernel.org/r/20210323163634.877511-1-robh@kernel.org/


v1:
When I do dt_binding_check for all YAML files, below warning is reported:
/root/mainline/Documentation/devicetree/bindings/sound/renesas,rsnd.example.dt.yaml: sound@ec500000: 'dais' is a required property
        From schema: /root/mainline/Documentation/devicetree/bindings/sound/renesas,rsnd.yaml


make dt_binding_check -j24 2>err.txt
Before:
cat err.txt | wc -l
2

After:
cat err.txt | wc -l
0

make dtbs_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/sound/renesas,rsnd.yaml -j24 2>err.txt
Before:
cat err.txt | wc -l
130

After:
cat err.txt | wc -l
0

Zhen Lei (2):
  ASoC: dt-bindings: renesas, rsnd: Clear warning 'dais' is a required
    property
  ASoC: dt-bindings: renesas, rsnd: Clear warning 'ports' does not match
    any of the regexes

 Documentation/devicetree/bindings/sound/renesas,rsnd.yaml | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

-- 
1.8.3


