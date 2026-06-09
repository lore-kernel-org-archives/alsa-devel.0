Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A34D8CD8CA8
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Jun 2026 10:40:56 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 991FB601C4;
	Tue,  9 Jun 2026 12:40:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 991FB601C4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1781001654;
	bh=uzTKULrWfKofWz58A643OEuDUAhOaiavL3zbOMaNgAc=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=dunvV5UoJcd1emVFy2sgM7a5REF9NxnIJ3p+9AqpLHjeTJbMb7mw3/wcQg7Xw8w/c
	 eq99vYOHYmWAGynXG1YCEaMoqT5edELzMZzzpCRekVYFg/cxLgzbjk86AmQPVDF49V
	 YAusY25qVaIMb/mVzCdLjXaVqVrMhohG2cBHE4qI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EB022F80600; Tue,  9 Jun 2026 12:40:18 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8A152F805FE;
	Tue,  9 Jun 2026 12:40:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 48F64F80496; Tue,  9 Jun 2026 12:40:13 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1781001612;
	b=fXlX2KaucJ95aHUz1p4gbm9HFonvLBXGs6pRI03vDM4uCPz3Mk1BKft7nS1gG7m9LrCw
	 eJnBaY0j45gsgufujhSBYbxCc03tJyD5m1WGz1swG+CRXvHjVJQwz2JSVHRoEGXUjpvA7
	 /8ckHyuVP09H10syr4XHoHqwRzbCJ2F22aqa98Y7yKBxDUg6QHyhL7/HMM9hdthUNjGD6
	 eIhIgwq/25lm5qgFfLE7Jfioj7UhMSF8kfkzkA5+RpEbDV0iLGGoZ3vhyXM+SBJf22yDj
	 fa10htIlftfYLj4UrNNIVmq5F57Ldtwo6CqZNoxjBtJmWWUZ18p71Rvt5/BbJtzU1pw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1781001612;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=uzTKULrWfKofWz58A643OEuDUAhOaiavL3zbOMaNgAc=;
	b=ZdWsbFVhuwYr5Gx3eV3ki8ddoUjPpwkKnUspvh/Ug3b+27jjPkGJNdk1ok9azS/B3GJm
	 pl9DBhdIyIPLhPS2RCeICafDgX21w0Co8Y/zVhnt7pkmRdlNUkwO5fD0wj9vU9y/uU75A
	 16sc0wDFjPYKbZJq/HTU1cHGDBbiGak2x7sKk7LRA2HgXA8QMasmHUgfruVhTb+b0rx3b
	 bXVVr+rsUUhvS9teeXwl5JVhSvygu0Asz0rw/8kyJ3KULkDIaLITBhstgG3dgVTRFc/aQ
	 98hFuZYfz6KYbNA8RnMH37UHOW29yUMRmcufbbYywyMhjvDGqdlJZL9rKh5B5IttPvQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 9FF9AF8003C
	for <alsa-devel@alsa-project.org>; Tue,  9 Jun 2026 12:40:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9FF9AF8003C
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18b7638771d46400-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/783@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/783@alsa-project.org>
Subject: USB-Audio: M-Audio Fast Track Ultra pcm split fix
Date: Tue,  9 Jun 2026 12:40:13 +0200 (CEST)
Message-ID-Hash: G5VABYLAOSPLHSKIH2VBY3HKXMMGM7AQ
X-Message-ID-Hash: G5VABYLAOSPLHSKIH2VBY3HKXMMGM7AQ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/G5VABYLAOSPLHSKIH2VBY3HKXMMGM7AQ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #783 was opened from perexg:

The defined mono/stereo devices must contain correct number of channels.

Link: https://github.com/alsa-project/alsa-ucm-conf/issues/781
Fixes: 27d3b45 ("Add UCM2 configuration for M-Audio Fast Track Ultra")

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/783
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/783.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
