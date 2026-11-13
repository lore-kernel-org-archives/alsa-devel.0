Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E391F606A321
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Nov 2026 04:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=WGpLRfj6
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 97AB86020E;
	Fri, 13 Nov 2026 05:28:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 97AB86020E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1794544092;
	bh=+0kRX6E4wMfxx9cf4oPql7wtLF4IqeHQ3nVZHDyI5Tk=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=WGpLRfj6zNaCIC5tvFUYlhiEcA+Jjatwm5yNkGFGKpLwmM20NRb1CEs5eiEGpRlQK
	 xIrDDqY0NbP/2i8QK1nJIMjgcIMDxXrPvO0Ym9CYH49SQVqE90EJPCu8bLEuxvJlpK
	 w4+9MsDYHdfMBk6cHcNt3UHhh5ijNnMN6UZCvNB4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 36310F805FE; Fri, 13 Nov 2026 05:27:37 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 89B17F805FE;
	Fri, 13 Nov 2026 05:27:37 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 73FF2F80552; Fri, 13 Nov 2026 05:27:30 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1794544049;
	b=OndpqIpHgwgd2RdFryFpiwprAAYbnIXsKWDJKOxjjxFVjSCqC5rkiGtl90jMYyyKppY8
	 oJV0xM9E4ySvRfCxfhZ4iTc3iVMN7YKdLEkvHPrRZvVwhukSpk3DeiK4cbyAQYRr7Yzii
	 WlrK7V9qaa3bpHTq1x7XKn/MAnAVv8oPdISn4MC6BSihbuTgSK34Zv8YX51DCnoF4P+Fu
	 T3qUT6db3+jKj5dfWxRySA9frrRrvGOcAMXFCyxdlhGPrHXoGjufzLXAvtZIcZZFj+gFO
	 m4R7KohLA1me7lXX83J8+Sn/13V5BI2JJLHjiWiK8Aps7uR6z+X+pXuYQc3G/xdIBgw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1794544049;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=+0kRX6E4wMfxx9cf4oPql7wtLF4IqeHQ3nVZHDyI5Tk=;
	b=AMFpYbhXRR0Ke+d+hKix0puja06nRTgu7G1EkiHK9mCRc0T2VT9sEg/JoJDyHvti5OuJ
	 kBpJ3alaKyAJuu5aVKFYfgTihkCaFa8OZOruqsjd8rhWk/bpKagUOEHDrO7S9Kzq8T8gT
	 OoBVxwSXherHWbTtvkV686t2pQtWjEXyTbA/MRVoPo5nIjP6cHmbb74XsSUq1ZyO8hI6k
	 KDbfgy0/kZyXt6l3dpkxdjDn0O3yhAjkArQZjANKBcE+PRY32tMQh/m+hAyuhygwfNraf
	 6PqdFYw5ulnieWYpDlzfWgtcixpHDTUOv+FOlIvia2iH9J4nbb5rjrNPDtSnF8+9yCQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 82B97F8012B
	for <alsa-devel@alsa-project.org>; Fri, 13 Nov 2026 05:27:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 82B97F8012B
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18e7804daa1c4400-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/909@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/909@alsa-project.org>
Subject: ucm2: Qualcomm: x1e80100: add Acer Aspire 16 AI,
 ASUS ProArt PZ13 and Surface Laptop 13
Date: Fri, 13 Nov 2026 05:27:30 +0100 (CET)
Message-ID-Hash: N33VKYOPUECVD4F3EBKTNGGZKJV4RSS4
X-Message-ID-Hash: N33VKYOPUECVD4F3EBKTNGGZKJV4RSS4
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/N33VKYOPUECVD4F3EBKTNGGZKJV4RSS4/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #909 was opened from kleinbem:

This PR adds UCM2 profiles and DMI dispatchers for three Qualcomm Snapdragon X Elite (x1e80100) machines:

- **Acer Aspire 16 AI**: 2x WSA speakers, 2x microphones, 3x DP/HDMI, 1x WCD headset (`ACER-Aspire-16-AI.conf` + `Aspire-16-AI-HiFi.conf`)
- **ASUS ProArt PZ13**: tablet speakers and microphones (`ASUS-ProArt-PZ13.conf` + `ProArt-PZ13-HiFi.conf`)
- **Microsoft Surface Laptop 13-inch**: routes to the Surface Pro 12-inch profile via DMI match

Tested on hardware with Linux 7.2+.

Signed-off-by: Martin Kleinberger <martin.kleinberger@gmail.com>

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/909
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/909.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
