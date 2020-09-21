Return-Path: <SRS0=AR4N=C6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA20FC43463
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Sep 2020 13:04:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5021C21789
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Sep 2020 13:04:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="bvQwPkaH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="d4u1TtRO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5021C21789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CB0801655;
	Mon, 21 Sep 2020 15:03:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CB0801655
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600693440;
	bh=25JAxxqSTsaNbnl3X6hlJGl1s8vxFGKsi3MfQNYzqQQ=;
	h=To:From:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=bvQwPkaHCTGphldI73XPWfmIH8jV6tvPdwzFqBdzKU/krXxFKqhiZEFLXssyPzZ4m
	 VCfZXAsw3waLJZwxKykry2SQd5psg0jypjDqMYe2/RVaajU8cwptoK9PCT75idpyMc
	 exVJoA484MNF7QWPT+2uwe6/3mBpd/4gvjBuVorw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 67322F8015F;
	Mon, 21 Sep 2020 15:03:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8E822F80161; Mon, 21 Sep 2020 15:03:09 +0200 (CEST)
Received: from hqnvemgate25.nvidia.com (hqnvemgate25.nvidia.com
 [216.228.121.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CEC12F80161
 for <alsa-devel@alsa-project.org>; Mon, 21 Sep 2020 15:02:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CEC12F80161
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com
 header.b="d4u1TtRO"
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5f68a44f0002>; Mon, 21 Sep 2020 06:02:07 -0700
Received: from [10.25.98.1] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 21 Sep
 2020 13:02:51 +0000
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
From: Sameer Pujar <spujar@nvidia.com>
Subject: No ack() calback in component driver
Message-ID: <fb148b74-a452-7dc0-649f-84553df6921c@nvidia.com>
Date: Mon, 21 Sep 2020 18:32:48 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1600693328; bh=1BAG6lNv+ifozdjij8AQ9Pwba3282EQV8YF4n6SXF9Y=;
 h=To:CC:From:Subject:Message-ID:Date:User-Agent:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Content-Language:
 X-Originating-IP:X-ClientProxiedBy;
 b=d4u1TtRO2/986xrysL2gjzhu8L8dRLosGavY0B/+W/I5WZl7EaXQDNiMEx7mnHmj4
 /a5Rgj7FXjMWg4Ae4OwbTz9zw1OxcdayVjQi/i8EG2tFT9lFM6Mi13KIj7tbzPCSmv
 rgwonbx0wKVsjibrPGgEcXfhCwF+AGE8969kELoztb2e2fkGQ9IIyqejmBviUqRMl8
 FOxA8GeEtWvRc4UH7drCeXrKt9A12Qaft4Aebfyl1peD7Zdv/fH3vMJzz0sQeDASkF
 L5nBi7x4pSTebsDFouabAMb8JjQn4saigUGFKH0HZcT+kr6sQ40Y0Or8OUsE54nlb4
 24zzRGbbvk8tQ==
Cc: sharadg@nvidia.com, Linux-ALSA <alsa-devel@alsa-project.org>,
 Mark Brown <broonie@kernel.org>, atalambedu@nvidia.com,
 Sameer Pujar <spujar@nvidia.com>
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

Hi Morimoto-san,

With your commit e2cb4a14541d ("ASoC: soc-core: merge snd_pcm_ops member 
to component driver") snd_pcm_ops is replaced with callback functions in 
component driver. In doing so, ack() callback was not retained in 
component driver.

Was this intentional because there were no users of ack() or if there 
were other reasons?

Thanks,
Sameer.
