Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3155CA0FEC
	for <alsa-devel@archiver.kernel.org>; Fri,  1 Sep 2023 19:32:51 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BFF5C1E4;
	Fri,  1 Sep 2023 21:31:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BFF5C1E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1693596768;
	bh=LCLkLjZ1C2k5UJk+dwcXvcBupyIEoOofBerbXqO7vKM=;
	h=Date:Subject:References:To:From:In-Reply-To:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=c/vqBOHeZz7y9m/5izXK40MG59F/2ww+E96M+6ZOKv/2mHjAeRSKlcCj3Lk80IvDr
	 SRcX0gSh5DPM43L7BEdlQ9+I6ztni2SHsz/DfrVLAJPUBpY/MYFK8eO5FiMyzNF9kx
	 LfW9oQ9WMTDgyMmyDGhjqDQn+030zPt03okJL4o4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 72EC4F80249; Fri,  1 Sep 2023 21:31:32 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 03971F8032D;
	Fri,  1 Sep 2023 21:31:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 19DA8F8032D; Fri,  1 Sep 2023 21:31:28 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id EE4F2F80249
	for <alsa-devel@alsa-project.org>; Fri,  1 Sep 2023 21:31:20 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
	by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 7F02811D4
	for <alsa-devel@alsa-project.org>; Fri,  1 Sep 2023 21:31:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 7F02811D4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
	t=1693596679; bh=JtB7bEyDJg+WSwnFRtGTooCJxX4BfJjHekcPqfrnisY=;
	h=Date:Subject:References:To:From:In-Reply-To:From;
	b=H92YHSdUqcVKdFPMcKGwN1b4cTf0v6K5VHBku+BHyMIu2pk44GeUeZGtbUUY6SpZO
	 /Yj2IrAhGpUCNngutpVoLr9rMgi7y3rHIZUEZVGjnXGRCO9dfLlfPaPZem2PGD7SEe
	 X23phR9sAw0RLoTHusEWzIbLCl/kyVUjt4jpoXuc=
Received: from [192.168.100.98] (unknown [192.168.100.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	(Authenticated sender: perex)
	by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA
	for <alsa-devel@alsa-project.org>; Fri,  1 Sep 2023 21:31:18 +0200 (CEST)
Message-ID: <d6c5c5c2-ddbc-2646-280f-ed88e45af4c0@perex.cz>
Date: Fri, 1 Sep 2023 21:31:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: ALSA 1.2.10 release
Content-Language: en-US
References: <b1971278-d469-3d34-ac9e-ada01e9b734e@perex.cz>
To: ALSA development <alsa-devel@alsa-project.org>
From: Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <b1971278-d469-3d34-ac9e-ada01e9b734e@perex.cz>
X-Forwarded-Message-Id: <b1971278-d469-3d34-ac9e-ada01e9b734e@perex.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-ID-Hash: FNH2TEUXRIK5PM6MFWMWB7BVAGGI2HNF
X-Message-ID-Hash: FNH2TEUXRIK5PM6MFWMWB7BVAGGI2HNF
X-MailFrom: perex@perex.cz
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/FNH2TEUXRIK5PM6MFWMWB7BVAGGI2HNF/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hello all,

	new ALSA userspace packages were released. You may download them from
the ALSA website http://www.alsa-project.org or directly:

	HTTP: https://www.alsa-project.org/files/pub
	FTP:  ftp://ftp.alsa-project.org/pub

Released packages:

	alsa-lib
	alsa-utils
	alsa-ucm-conf

Full list of changes:

	https://www.alsa-project.org/wiki/Changes_v1.2.9_v1.2.10

The fingerprint of the public signing key is:

	F04D F507 37AC 1A88 4C4B 3D71 8380 596D A6E5 9C91

				Have fun,
					Jaroslav
-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
