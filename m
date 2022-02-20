Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FBD3C433EF
	for <alsa-devel@archiver.kernel.org>; Sun, 20 Feb 2022 00:17:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 92B2116DC;
	Sun, 20 Feb 2022 01:16:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 92B2116DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1645316267;
	bh=l0xCggp3Yorfo51MhNJ5eHrZulTF5l9FLnm8udQmpJU=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Qsao5D6HrJDs+c78n3/ao8k55+umz60ZRBbt4Xl+fDHWS3p+bAhwGHqkKXjX+88eB
	 SY8MmQehdSPAejTfLcaFt4azkH9nA2U/EWP0GcD3e0ZIUeOZ0ce/BVcHQDODTqGVON
	 EYcX56YbNGnastt7gK3WT6rmanccljg6DgRsxb00=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 25E31F8051D;
	Sun, 20 Feb 2022 01:16:20 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 254B1F80518; Sun, 20 Feb 2022 01:16:18 +0100 (CET)
Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu
 [31.186.226.237])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0F69CF804AA
 for <alsa-devel@alsa-project.org>; Sun, 20 Feb 2022 01:16:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0F69CF804AA
ARC-Seal: i=1; a=rsa-sha256; t=1645316162; cv=none; d=zohomail.eu; s=zohoarc; 
 b=BpN+CjmxVbFd5iL6o3ttWjd6VLBrUp8QsteaPHo/XeNSDzCisLhxM/VT0d4J2x74fNOYf/G6iYJTBJmsD2YLlCrTBj2b0uIs6ePznBpuMXGWzbPzAXnVGjJ33jV2sdtyygCpaPScMpaIkPcplCpp8Dzd+H0BfJN21cmulH6DHco=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu;
 s=zohoarc; t=1645316162;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To;
 bh=SS8zOxqh5kA3jFU2G4euNrkYb3yGEgk+OrxXHHhdCYg=; 
 b=Fh+YYavSUi7RcaBNxvCmYl5ppYu3aSYMZVQ8olmOqNaEkb5iiskpTwCbrtAC9ApXabQYNdaa2JZ6ttYbWkrdHoRL40HTv8cBpCHYd1wE/2/cU6NeqX776otHh8o8dhKPBKH/+AIOoBI5HZyj2p+77bPWo7S0VSZL6LtIdAgIfao=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
 spf=pass  smtp.mailfrom=philipp@uvos.xyz;
 dmarc=pass header.from=<philipp@uvos.xyz>
Received: from UVOSLinux (ip-037-201-192-120.um10.pools.vodafone-ip.de
 [37.201.192.120]) by mx.zoho.eu
 with SMTPS id 16453161602811012.2654051731125;
 Sun, 20 Feb 2022 01:16:00 +0100 (CET)
Date: Sun, 20 Feb 2022 01:15:59 +0100
From: Carl Philipp Klemm <philipp@uvos.xyz>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 5/6] ARM: dts: motorola-mapphone: add has-hp-jack for
 audio-graph-card
Message-Id: <20220220011559.474b4f7cacdef2865a6780f3@uvos.xyz>
In-Reply-To: <OS3PR01MB8426FD3FD1B45BB31C971A56D4509@OS3PR01MB8426.jpnprd01.prod.outlook.com>
References: <20211228190931.df5d518220080a734532ebfd@uvos.xyz>
 <87a6gawxpe.wl-kuninori.morimoto.gx@gmail.com>
 <20220105101028.620b7f2cb7727eedfccd933e@uvos.xyz>
 <87r19ld48v.wl-kuninori.morimoto.gx@gmail.com>
 <20220108145749.f55500222b049f344415a5c3@uvos.xyz>
 <OS3PR01MB8426FD3FD1B45BB31C971A56D4509@OS3PR01MB8426.jpnprd01.prod.outlook.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "tony@atomide.com" <tony@atomide.com>,
 "merlijn@wizzup.org" <merlijn@wizzup.org>, "sre@kernel.org" <sre@kernel.org>,
 "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
 "kuninori.morimoto.gx@gmail.com" <kuninori.morimoto.gx@gmail.com>
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

Signed-off-by: Carl Philipp Klemm <philipp@uvos.xyz>
---
 arch/arm/boot/dts/motorola-mapphone-common.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/motorola-mapphone-common.dtsi b/arch/arm/boot/dts/motorola-mapphone-common.dtsi
index e26950d8ca85..800017ce096f 100644
--- a/arch/arm/boot/dts/motorola-mapphone-common.dtsi
+++ b/arch/arm/boot/dts/motorola-mapphone-common.dtsi
@@ -150,6 +150,8 @@ soundcard {
 			"Headphone Jack", "HSR",
 			"MICR", "Internal Mic";
 
+		has-hp-jack;
+
 		dais = <&mcbsp2_port>, <&mcbsp3_port>;
 	};
 
-- 
2.35.1
