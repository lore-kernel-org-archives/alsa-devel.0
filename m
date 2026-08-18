Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5692AC5DF7E
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Aug 2026 12:50:25 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 837BE60258;
	Tue, 18 Aug 2026 14:50:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 837BE60258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1787057423;
	bh=s8+rmROQJB9uVbPzRosCFEYKpNi1l+oFIhFq+u/236w=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=dzFdf4LyoX1+CbYmCWw8l3pYAK5BbNRguXrnQSSTEihCzMdF3UBdcdoHMyejtFITs
	 V74bAnVA8bFKdYBq3t9QjtSGxd3T/t4MTxdU22UfIm8sNelE9i8boHhkb1JZRmloQ5
	 NVkeny9wI23GkzQsZq8u/nDnNpiEp/ppU6boNgBY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 98C88F805F9; Tue, 18 Aug 2026 14:49:49 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D63B4F805F4;
	Tue, 18 Aug 2026 14:49:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5B55FF8055C; Tue, 18 Aug 2026 14:49:41 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1787057380;
	b=KZSVEa3WZ10CkPlCsZGeV1Oz4wSUcA6xS93cN0OvUNQW+Gjrjg9HL23F/4anwsrJRu1W
	 Z6jg85RfDz4hnQzZJniHRn8KgbkKt3xulH+GfrblJj9hmHOBt1EuXlszMQQ1jQilH4MTg
	 F38RYXQ85ZDK5EcNm4bE0h9XIChi2hMd5qrHe6hnRw5fsDWJAVokQAZDWsZnQXRt1rIed
	 kZbF7yWhj6/4SyxyWxhA5rXDGEVtc1CzwZmR8bao+8w/tIYm7CTkLXT4YvjWi/32f9k/9
	 kR1W8GsXujoni4qDidtNJRD7zMw0EcaPKtpZKGwFSlhmQkxpBSmmkutZVZ92rf1d5Kg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1787057380;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=s8+rmROQJB9uVbPzRosCFEYKpNi1l+oFIhFq+u/236w=;
	b=G4tgfa9Liq3KUNF3hH/eqmSJyaJ7kDIOYM2oVpUjQ/y1tBsHu892pdSI9SokNMG/QaPi
	 /eqVE26ymYkfYQT9TKvfC9u4kSm6kH5sWzdeXmhOj09C9oR35SMO7Rv+iBvCuAkqoH8kz
	 IO/hTIQemh+B16HvWkofB1+xrl9ZPWnLfoULUFjmIDvwKAmdTuP6FNygf+zmd7EhE1iiP
	 ExbgtJb3FrIBvihxn24fIDB/E1DA1tOoD/zBDNPQkOvK9vtBNn259ijSbz/kR+Sh6fk63
	 HSUOXzzUSjtix/HAM6vZxpifalWEsNa08D0c48dRwv/TmH3yGJyE481TLmoVebdcyvw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 9B42BF800AC
	for <alsa-devel@alsa-project.org>; Tue, 18 Aug 2026 14:49:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9B42BF800AC
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18cce737d5689100-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-tools/pr/47@alsa-project.org>
References: <alsa-project/alsa-tools/pr/47@alsa-project.org>
Subject: Migrate to Gtk+ 3 for echomixer and rmedigicontrol
Date: Tue, 18 Aug 2026 14:49:41 +0200 (CEST)
Message-ID-Hash: TR5Y36VWRMQB4YAZMXP4W2AYFBN35RN2
X-Message-ID-Hash: TR5Y36VWRMQB4YAZMXP4W2AYFBN35RN2
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/TR5Y36VWRMQB4YAZMXP4W2AYFBN35RN2/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-tools pull request #47 was opened from tiwai:

Conversions of the remaining old Gtk+-2 code got Gtk+-3.

Request URL   : https://github.com/alsa-project/alsa-tools/pull/47
Patch URL     : https://github.com/alsa-project/alsa-tools/pull/47.patch
Repository URL: https://github.com/alsa-project/alsa-tools
