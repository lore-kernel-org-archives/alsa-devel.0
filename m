Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 326E6C531C7
	for <alsa-devel@archiver.kernel.org>; Thu, 23 Jul 2026 06:32:30 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2A15860203;
	Thu, 23 Jul 2026 08:32:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2A15860203
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1784788348;
	bh=AoyEWUxPSBfI+0oOjVLgND4cD7G3YgSSedWcVzAZMrY=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=pemU9aWqmW4B6uS2CYSecGu/ZIqh6iCkW+m14RnuP7348bQYAamkGLh8O+9WjNjLK
	 LxDA4gnWYJ/ecu3j8a3KOX0Ihrl5paKnBS2CEm3yQEwl+Dv0lJtnCgLjrThb3RcxSm
	 wZhZRFx9CbXYfSJ8dItZBxWJRY9UetitxKCLjQ48=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EEAE0F805F2; Thu, 23 Jul 2026 08:31:51 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 71188F805FD;
	Thu, 23 Jul 2026 08:31:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A3F37F8056F; Thu, 23 Jul 2026 08:31:43 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1784788302;
	b=XleMPVh8NZCq9SshxCbxGHhV01DDCGfUNsIcuKyO98Th8yYy+6lMHSkfPGOhGeBTCFPH
	 eMq7s62BFDXLNQClzQ3/xGv3JV5qVLR31EH/VsR4g6JnP6Nc8B8Whnmjhs7PlCuGAqS6C
	 mb/O1E3vE+PMm0tcwTNn3TwfJB7zTNOSbZQRIl0olbugA/8KLcGgaH+/d+xzv69CAbKUQ
	 S3PqSWM/jeLvGOG61kLXISaWkvCti3Bn2XIZzkZJ6opBft0S2Qe+1dIicvl/fOTfeX2kX
	 gOR0B8xxLxhgmj90wY804qkI+ZyvEePPWi2tmsfU/+HNiZyzKbL6J1l4r1bnZbWPqsw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1784788302;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=AoyEWUxPSBfI+0oOjVLgND4cD7G3YgSSedWcVzAZMrY=;
	b=Cw0H5h2B+1C0kJoC5ECPr9CI7ZJnSlrJg64HPROuU6bzrjWn9m8Fw2QlsVLlG4M3DdC1
	 RfMM3QLC/+bQKhshIFli6VuJHI7KrIy/wRp/fpOkshpaVnuLelGZfZM+4wKHNyX3Fn6Lb
	 +nHLDgker+wYcpccCWZgDxWH78kkXDnWerwuLtFqHM7cZOt52L+rAL4B2v+Ry5NuMFrvV
	 PVn4E9Noa5N3xYoVEFAkQWGkTwsqoEjEZHhSu3PKbjH++2D3X9BeMzQ3guatQUWZDnfnj
	 9m8JzPT8t34xRPpEsZBST+ptR2HUKPRkPKeD8NiPAN6yOJM5Seg4/iGE/m1TBLcEO5w==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 89379F80152
	for <alsa-devel@alsa-project.org>; Thu, 23 Jul 2026 08:31:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 89379F80152
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18c4d780de7a6e00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/817@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/817@alsa-project.org>
Subject: ucm2: Qualcomm: shikra: Add Shikra EVK HiFi conf
Date: Thu, 23 Jul 2026 08:31:43 +0200 (CEST)
Message-ID-Hash: BFU6SWAQMZIGKGRHLCMSKQANQULE7CRL
X-Message-ID-Hash: BFU6SWAQMZIGKGRHLCMSKQANQULE7CRL
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/BFU6SWAQMZIGKGRHLCMSKQANQULE7CRL/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #817 was opened from mohsRafi:

Add UCM2 configs for the Shikra EVK boards.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/817
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/817.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
