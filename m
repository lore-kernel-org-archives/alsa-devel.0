Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EEBBCA5FD4
	for <alsa-devel@archiver.kernel.org>; Fri,  2 Oct 2026 06:05:35 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 83F6160277;
	Fri,  2 Oct 2026 08:05:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 83F6160277
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1790921132;
	bh=Lzol4rLraQ2mlh/4tsFt6Eu+EWdh5Llahs12lFn0Rnw=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=Dg/CSUcrwb7w6HbXnxCckbcONN7DEsPB3ZTulSZo3PtYIQu+y5G4Ay7JzCtNb/M8e
	 t94Fdxm38doWkxkvqVwfPUUMIYGVleDDsyKpquUFVrOoW+ohxgVOCGOHNLKJQg3wEV
	 4BIRnLs32/SUR49vU05BBU6o9d3nYc6MNAFirKbo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E609EF805F7; Fri,  2 Oct 2026 08:04:58 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 43D79F80600;
	Fri,  2 Oct 2026 08:04:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D3420F805BA; Fri,  2 Oct 2026 08:04:50 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1790921089;
	b=JHYZPLixXSeqFgA01DLWEtzFsfmS8svaKgBkyvwZ8nThgUy3S9IG79NGofGqIhtS+4Fa
	 7TjuTXDeluApGoyvDSaW0KEzChN5MhtNurCfo8L78+DAIbxiaqHydV5MD0pd4iLXlvh6P
	 dypahY5e7UKqFPqqkw05V79TJOMIw0pQ7QcjIeR/G3kVtepRgyvZsfq0PmBd3Zr9IY9YO
	 BdZt8N2mnTT82cZBPScUkwai3sktmQkMuG8FhmzPOs8MwL1WLlb35OPG32Uk2fiPtyD4j
	 JCsRXDNW4BH902czVY1vfB732T7PtaEz/eLB1CX9eaEbYZW4w9fNaceV0xq1uzATCxg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1790921089;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=Lzol4rLraQ2mlh/4tsFt6Eu+EWdh5Llahs12lFn0Rnw=;
	b=G3gUPQsK5+5qk1JyMQIxOR3UHhV6ZuD7D5nFpNuqVXUMc6pKlL4bJzoGlQcgGTo6EOag
	 u+geTeX2Kj7wogQb9+UcMePsPyhyB1w5R4g8B/ysdFJcziDeRc1mjhp1Y120Rv98pfC4W
	 wFSlspfyb5WH+Yosm+RHVXa8EIe658Ep6jaVz8KhJAmnAIpEC/eNx32U0rrA9MSXdPzq7
	 SNxh4kN+2p4MpsRc33M8OdFCiNvZQp6LyxmbGMgrOELkBzPpwt8H1YOOLJVByTw/QiWFd
	 pMphxj7co6Jdpl2CGGlWXMAyAE00jHkKr80Q+akgA7EQbRiU5xRbEvGNDV3NwguhGJw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id BE1ADF80424
	for <alsa-devel@alsa-project.org>; Fri,  2 Oct 2026 08:04:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BE1ADF80424
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18daa13dbd829900-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/864@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/864@alsa-project.org>
Subject: ucm2: rt712: add mic led support
Date: Fri,  2 Oct 2026 08:04:50 +0200 (CEST)
Message-ID-Hash: 2WLRNAN3TP76ADAC7B6LOBB5ZQATFEI5
X-Message-ID-Hash: 2WLRNAN3TP76ADAC7B6LOBB5ZQATFEI5
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/2WLRNAN3TP76ADAC7B6LOBB5ZQATFEI5/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #864 was opened from shumingfan:

ucm2: rt712: add mic led support

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/864
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/864.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
