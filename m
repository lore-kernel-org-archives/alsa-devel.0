Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 501CDCD6E4A
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Jun 2026 13:33:48 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3558360231;
	Tue,  2 Jun 2026 15:33:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3558360231
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1780407227;
	bh=d1BWM3wEDLqexJgCoOp0iqFq5SL/QO7DtJo1vsVBRM4=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=haeG6qnj07SaM+aMAd3/qdtv3EeD405Kg3nAquz8Otu/HH6Xl/NtF4oprISAh23bk
	 YnpY57Fb/hKwh7xNDzi+vsi0c9EL9DacPM/+a2Qj/GV7zoQGO2iBDdEag0qJsquNOP
	 nd5tyzg1TvfQP4LzelBOCFrmgtt8I3HFQTjrFUhs=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F4089F805F8; Tue,  2 Jun 2026 15:33:09 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D5E0CF805ED;
	Tue,  2 Jun 2026 15:33:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B6618F80553; Tue,  2 Jun 2026 15:33:03 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 6EB0EF8016E
	for <alsa-devel@alsa-project.org>; Tue,  2 Jun 2026 15:33:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6EB0EF8016E
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18b546e5e9158500-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/tinycompress/pr/36@alsa-project.org>
References: <alsa-project/tinycompress/pr/36@alsa-project.org>
Subject: fcplay/cplay: Improve information printout regarding to buffer
 configuration and track playback progression
Date: Tue,  2 Jun 2026 15:33:03 +0200 (CEST)
Message-ID-Hash: RUZEUIY7P5ECFMN7MECATEZ7ZKREIEEC
X-Message-ID-Hash: RUZEUIY7P5ECFMN7MECATEZ7ZKREIEEC
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/RUZEUIY7P5ECFMN7MECATEZ7ZKREIEEC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/tinycompress pull request #36 was opened from ujfalusi:

Fix fcplay to take the buffer and fragments parameter into account (it is ignored currently)
Make the prints about buffer configuration more informative and common between cplay and fcplay
During multiple file playback with fcplay print out the new file when the changeover happens.

Request URL   : https://github.com/alsa-project/tinycompress/pull/36
Patch URL     : https://github.com/alsa-project/tinycompress/pull/36.patch
Repository URL: https://github.com/alsa-project/tinycompress
