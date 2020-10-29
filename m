Return-Path: <SRS0=XEtc=EE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 354ABC4363A
	for <alsa-devel@archiver.kernel.org>; Thu, 29 Oct 2020 06:23:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D7BE216C4
	for <alsa-devel@archiver.kernel.org>; Thu, 29 Oct 2020 06:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="PlwxeKff";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="RF1xouYa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D7BE216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 50E0F15DC;
	Thu, 29 Oct 2020 07:22:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 50E0F15DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603952598;
	bh=Sxw8n1rccAycho8PfwfHuREZ36JuZKl5o4ulBTQ6XQk=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PlwxeKffcOYLMAnr3wNOtDDw/NohwLXeOwYmzrgaaWiPHuDigUxNq+x0HlC/fx+iG
	 spWNyrcM71uhHP2wnln4CC4TFVQDbx5GeHXmID0MqP8hHvhLkxpwElscr+Fdh45K19
	 I2fb9nxCv3erBWfu7dfYAtJJUbCI4CFQ5RYEEfsA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B22F5F800D8;
	Thu, 29 Oct 2020 07:22:27 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EFB77F8020D; Thu, 29 Oct 2020 07:22:25 +0100 (CET)
Received: from hqnvemgate25.nvidia.com (hqnvemgate25.nvidia.com
 [216.228.121.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 92365F800FF
 for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2020 07:22:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 92365F800FF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com
 header.b="RF1xouYa"
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5f9a5f9a0000>; Wed, 28 Oct 2020 23:22:18 -0700
Received: from [10.25.99.37] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 29 Oct
 2020 06:22:13 +0000
Subject: Re: [PATCH v5 1/3] dt-bindings: ASoC: audio-graph-card: switch to
 yaml base Documentation
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Rob Herring
 <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>
References: <87zh45d0zp.wl-kuninori.morimoto.gx@renesas.com>
 <87y2jpd0yt.wl-kuninori.morimoto.gx@renesas.com>
From: Sameer Pujar <spujar@nvidia.com>
Message-ID: <a3c05c0a-fc34-fc3f-e0bd-65c757ea6a76@nvidia.com>
Date: Thu, 29 Oct 2020 11:52:10 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87y2jpd0yt.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1603952538; bh=Sxw8n1rccAycho8PfwfHuREZ36JuZKl5o4ulBTQ6XQk=;
 h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
 MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 Content-Language:X-Originating-IP:X-ClientProxiedBy;
 b=RF1xouYawKeI6B6lmFKpZfzzxWUhnwkkJ6DUotWBW/l9iavRQkRK1VnWbCI4xFOSb
 xhVGUP0ckUw4EI2mTfaPTfxnsL/LfxWKpRXUVzbPYDiOuLvk926+NmSJSlO16cMz+p
 eHKBOxj9uwoIiNUzSmtf9JwtVy4rjrUFbCmCM2HitoP9SYkCzkOaHUty+IIDN7jMwA
 2TgCIin1a2l553Q3qutML04OXMGy09bQIynO1/PoG7QDMpn4lhk3PcW17cOCDWbatV
 g+SJdwcvze1uag8dvg7TPrFqYgQX/u3RJXVuu/rH8LhGytbbpE4f1rwpxBwVDdD36V
 3AoF0sKEkYbSA==
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org
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


> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> This patch switches from .txt base to .yaml base Document.
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Acked-by: Sameer Pujar <spujar@nvidia.com>
