Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A17E0C44507
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Jul 2026 09:26:10 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 08657601F0;
	Fri, 17 Jul 2026 11:25:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 08657601F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1784280368;
	bh=cJuFvwGktBw6XaPK4f6hX5YdSgKoRQ2MfVX5cjKQ6LY=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=TYqhRPfvM9wID7Yzd3GzYLpUNr05HXH8EKy8Cj2eOhbT2yw3RGUzjKyy3RvqEKEGl
	 ZzUsUlu7OaziHYzJJo43zZJ3U0MVb73C/9kV4Km6G+KuQ02QTdwAkx7yK0BKTw1/8g
	 S1SkvGHXixGmDPlCygv8Jm6gj7jEYajW1sRw7ZVw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E6D60F805F7; Fri, 17 Jul 2026 11:25:33 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8C656F805FB;
	Fri, 17 Jul 2026 11:25:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 83EEFF80526; Fri, 17 Jul 2026 11:25:28 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1784280328;
	b=I2Dw3fInENVI+GnfwC9Vk4SiFBYy5xkv8E2m5Tdma754YJ7a0ILMVdrLRkp68s0CBZvT
	 BlSdTcnTOoHLuWS5ktMF6jZ9PTeer69ApN4AEumgCysNuJi/Y9l88Kxex9o3qMyK5/XbH
	 /2NAMvGG0ahtRYmnLNbVKn0Lj/5UGW5XcS87zR64473mOKHpWYS30Pdc9v7Tpc5yBB3YS
	 LqBajfY0eBKaWfpxkOjU/h3i8UK6bNUgkWq+558Y8OvCI2YnpflDaFZhZB55qm8AGe6MS
	 oRSJ++RvUm4LbjtLfmsSLznRPxGFmvAHaBtrv7+Ug7wqULGPQPqzAU0Urhgs+mL6Ceg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1784280328;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=cJuFvwGktBw6XaPK4f6hX5YdSgKoRQ2MfVX5cjKQ6LY=;
	b=HsdNSLyqV5YZbf4DCte5TKsG42kTS6Eu/GF5ZINvbGMOHVKrr3hjnBYWePHHVqLecAUe
	 KTvU5B6BJEWmKGoGMTf4EVu9caxG0ZmYpxG1H+OVu4NJmF1whBjpoXQ1+B/WtWD5LUXff
	 1MWPiJORvR/SqSKWAH81PLFrqEbVHLRrObo3EofZenKHxKyeTLpn9VTy7Q2PJXyxWZXFB
	 siHnVwHroezcutf95cOjjaYXSU3FfnhSJCw4bzMUPcCevXHTf29tsmWA7s6mjBon69MQo
	 hU2gkzpU6Y/QtWiomVWDr6Hywpiz06ZQNSN5vPfsVGgOMe9hcYashQjWh+Ocv9s0M3Q==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id E2F50F8047D
	for <alsa-devel@alsa-project.org>; Fri, 17 Jul 2026 11:25:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E2F50F8047D
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18c30980b8f92a00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/812@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/812@alsa-project.org>
Subject: ucm2: sof-soundwire: Add tas2783 support
Date: Fri, 17 Jul 2026 11:25:28 +0200 (CEST)
Message-ID-Hash: W5CDBCZ7FXIIIZBNBWI5HGYZLKDMXRC2
X-Message-ID-Hash: W5CDBCZ7FXIIIZBNBWI5HGYZLKDMXRC2
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/W5CDBCZ7FXIIIZBNBWI5HGYZLKDMXRC2/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #812 was opened from jimxbj-dot:

The update was tested on B5406 (0x35E1) and CashmereXI.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/812
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/812.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
