Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B87A9CD98C5
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Jun 2026 17:10:31 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 87C4460200;
	Mon, 15 Jun 2026 19:10:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 87C4460200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1781543426;
	bh=DLcbA6IvAaKX9MF+7SaiMo67u4WVLl3OosZDmePwDRI=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=mJRPlXmHNWU/okezm9bom4dMnyuJfFfu//eyG4GbGBFZqIl4t4FQLzOtIQ7h42nCD
	 T+PqvnjFDZLwT5OzUMHjiEbbnVZapUE/8jhAaQkTTIENqjsuoVntC2mOmYkkvM+beo
	 l32xkQ8flhJ5LXX/DgHufdIweujkfVak1aO0KJ3E=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A102DF805F1; Mon, 15 Jun 2026 19:09:53 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5C6DEF805F7;
	Mon, 15 Jun 2026 19:09:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AC32FF8047D; Mon, 15 Jun 2026 19:09:48 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1781543388;
	b=WCklbH2bI5XvXGWAW9zK1hEawDRm40DD7k8Un5wlZ/IhRzYp/FpuNYv4NhsQ9kfZ6NOD
	 wNbmmWkOKPdAKYsiolrw66kIET+vI3Q38AUR0s4wzfJB5iT+ytSnsg3IuWcpg2arq8TMd
	 XgRyOBfqVJmWiF+rXNCT7os75uj019w+jAio23U3la6v8C4kasBhUrDiRteqWPZ0Ui4Vl
	 Uhra59DBDN7vmQvhzY85Jd4bAUATrSfn/uzMvEAw1d52oGV8+4Tv8HA+jI4SHsAKTZ5hb
	 uN9qcFuqkcjsPWlfal/2aBH2Vm00NcTViZvgO7OyenjQQysTgS2fkpyUtokeWgNcDaQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1781543388;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=DLcbA6IvAaKX9MF+7SaiMo67u4WVLl3OosZDmePwDRI=;
	b=MV+RRYQ7Pg5P3x8UQMSTeSf3fbuq4As1UeGo/05FtZQdHoqhV8HRC6EIZiPqG0jiURLH
	 93Bhon8wciDFjqZqQOPA5aYXgqMShFLEqxG6LC4bhWxMPgt5bFO+3oGGsCln7iHu30EdI
	 okWHs+1rEvd6a17rCJc4MUW3l9YsImndGPMW2GFHtdTX+SzdS9dP9Zyxj/sF3FRXRhh4u
	 /NoRCUFUDZFArS46QeMdOuHma3BWwjSlYuqAjkmgbh8Acf9dgkaCvJ3E9IlXzr80qM5dx
	 4U9VFAv/XWkKJCy5HtF7lAhKUS8wYZmxauksE5j7O6+rHyZPN3kyeT58gdGR21noULg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 286C8F80038
	for <alsa-devel@alsa-project.org>; Mon, 15 Jun 2026 19:09:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 286C8F80038
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18b950456787cd00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/791@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/791@alsa-project.org>
Subject: Qualcomm: qcs615/sa8775p/qcs6490: Add uboot TALOS EVK / Lemans EVK &
 QCS6490 HiFi config
Date: Mon, 15 Jun 2026 19:09:48 +0200 (CEST)
Message-ID-Hash: 2SHZ7GAUFA5ZPGBPJRKTUGBYYONGECKR
X-Message-ID-Hash: 2SHZ7GAUFA5ZPGBPJRKTUGBYYONGECKR
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/2SHZ7GAUFA5ZPGBPJRKTUGBYYONGECKR/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #791 was opened from kumarsingh-art:

Add UCM2 configs for uboot variant of the Qualcomm variant Talos/ Lemans & QCS6490.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/791
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/791.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
