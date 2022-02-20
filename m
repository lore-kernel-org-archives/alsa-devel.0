Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EF13C43217
	for <alsa-devel@archiver.kernel.org>; Sun, 20 Feb 2022 00:17:35 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A031416E5;
	Sun, 20 Feb 2022 01:16:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A031416E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1645316253;
	bh=IU28QsaMIkxcDwl3cyaPfy6CRbWXnb9JhHPk9D3DRUo=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hojVOHrTrvL84TyAMwn7zMqmwooMAuChMOM5YkWv/838bpTkhGRWr/pRWQD4gu3K0
	 vQQMWT9q2UgMvT4E/6Uc+JA0ptYR70J1wzcNiZKUl7NNq++DDFXnHUCPBKKFxT5T8R
	 ofGqwHk854sRAMLhhIKFY6eG1Zy8gkE52ccgwmKw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7ACC6F804AA;
	Sun, 20 Feb 2022 01:16:18 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 03114F80518; Sun, 20 Feb 2022 01:16:15 +0100 (CET)
Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu
 [31.186.226.237])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E3BB4F8016B
 for <alsa-devel@alsa-project.org>; Sun, 20 Feb 2022 01:16:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E3BB4F8016B
ARC-Seal: i=1; a=rsa-sha256; t=1645316158; cv=none; d=zohomail.eu; s=zohoarc; 
 b=Qm9ch1yHQj3yxDMlDqq2ax1BNDurgJxxHYj+S1SiVfFDkusFH8GwR5lmvZcIEgpQOfh+TIDovivsOWdzYN122UCnqWpjIQG5xlbKUVtZR/jZk9IX/OjTd2zpbGjFFL4yzNGNa5fBpAxeJ/2jRPJzdotECweyPeSY/OF1B0o668o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu;
 s=zohoarc; t=1645316158;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To;
 bh=x5SfbTzdik9CpSSycXOEm5eGKOZ6Os8AY+52HpwRyfY=; 
 b=fXcA/Uc4VwLr2li9GTmi8R7xvUibQ58oscldwHe4S1q6BrN/ONA9WR2aI7wGx4UFrBKjDWNQd8dBOB2yk8bZu3q/rOqGjpjRjYszInELxNAGXlqkh9iq6dCYvRz/CxotOYx25bvnd0zR0Q5VQrPcapMhqqFm0E9oHbZSysqd4uY=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
 spf=pass  smtp.mailfrom=philipp@uvos.xyz;
 dmarc=pass header.from=<philipp@uvos.xyz>
Received: from UVOSLinux (ip-037-201-192-120.um10.pools.vodafone-ip.de
 [37.201.192.120]) by mx.zoho.eu
 with SMTPS id 1645316157038946.724983320766;
 Sun, 20 Feb 2022 01:15:57 +0100 (CET)
Date: Sun, 20 Feb 2022 01:15:55 +0100
From: Carl Philipp Klemm <philipp@uvos.xyz>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 4/6] ARM: dts: motorola-mapphone: add interrupt for
 headphone detection
Message-Id: <20220220011555.2d0ab3e23a6e4012b7b3b711@uvos.xyz>
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
 arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi b/arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi
index 0aff0d306d06..e164169bf820 100644
--- a/arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi
+++ b/arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi
@@ -72,6 +72,9 @@ cpcap_audio: audio-codec {
 			#address-cells = <1>;
 			#size-cells = <0>;
 
+			interrupts-extended = <&cpcap 9 0>;
+			interrupt-names = "hpplugged";
+
 			port@0 {
 				reg = <0>;
 				cpcap_audio_codec0: endpoint {
-- 
2.35.1
