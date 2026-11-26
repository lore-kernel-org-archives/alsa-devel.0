Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DAD606A31E
	for <alsa-devel@archiver.kernel.org>; Thu, 26 Nov 2026 18:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=pI6hPlZ6
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9C74160218;
	Thu, 26 Nov 2026 19:41:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9C74160218
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1795718480;
	bh=f/1L5rVGuCdHebVbe3zkxT9uk+SwgjQpOfd8EMpWF0A=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=pI6hPlZ65X0cwM9BIEeNNaHiEsNivgX+MM2mFb6RKkfPXmpBrgAiBVg7xFcJyCu5y
	 9H4O1PcBAsYU26OOUNeeQFx+U21xReAo801/vYnmIC4r6ymYs++3by1JC2HtJOWT/v
	 eqwWasKuATZGwEJthZz6h8fN87Rm5OLV1Op1966g=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 90C99F805FD; Thu, 26 Nov 2026 19:40:45 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C2A44F805FF;
	Thu, 26 Nov 2026 19:40:45 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 991B4F8051E; Thu, 26 Nov 2026 19:40:38 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1795718437;
	b=gi0VWGMFpCS3Le8PyawWsbSEVXQdFOJ/zQvMyvXWV761vREeLldSi3P9IDhA+87Tw7Ri
	 Zvp2J78fgHjz3LrN2o7owo0w3ULeMhudAYTzgn0QRAfU/8B8TJ/c8I38XqiVItH7LdzHz
	 hbkJgdm5QfC3TTX/iGmKl79T8jcwuSG7ifdLJ+Kos5UkF6annnONh25FMgR7csKqdGkxa
	 kr6xf1A43Fsu9otyaFWJm726DsOYdZDsPmx7gDN2qR8jQIyK98rPRMHZoAJzNvI41FjMs
	 N8HjaMZPeLuFNNSNA5VdhSrz0yGzUJf/dRNIl9RVnHlBVzEePVtF+u7UtOpP0xRR7Ug==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1795718437;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=f/1L5rVGuCdHebVbe3zkxT9uk+SwgjQpOfd8EMpWF0A=;
	b=ClIoNqJ0F56iVJMvylL/S6D/7Y2UWlxeJ/zQTLw3JOt7IKHebbMPpnO5p9Qo0b76l5Vz
	 1KNQudgEA5CxcRo3PYYHIAkHVlBKUC713j0bIdLe8n9/OTt6eqxPZ8q+ZvfZM5nDNzJf1
	 N6RQD3528I/y7pI4WIjtRm1CaxzJcadTOnHdaiPn6FO8S/aXOLNySdeqSVp5e46nY4ZHt
	 ft5Xl3IeGgeN4PamvUNTyVKbhZqBH6KvRqjr/QOv+yq4r+5jjULrdeBk460ArSHhJuKnH
	 oa5dSkkPHKylsMLf96sgKS7bxTiHXP7bF1K+B8cZTFw5n6xE596rd2MlS7F+EL0NE6g==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id F2BAFF800AE
	for <alsa-devel@alsa-project.org>; Thu, 26 Nov 2026 19:40:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F2BAFF800AE
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18ebac671bfc1c00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/930@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/930@alsa-project.org>
Subject: Glymur rebase
Date: Thu, 26 Nov 2026 19:40:38 +0100 (CET)
Message-ID-Hash: PKEVJPJOIQ73I5BCSOLYOOXCWRG26NN7
X-Message-ID-Hash: PKEVJPJOIQ73I5BCSOLYOOXCWRG26NN7
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/PKEVJPJOIQ73I5BCSOLYOOXCWRG26NN7/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #930 was opened from Srinivas-Kandagatla:

This series adds support for Display port and Headset Audio support for T14s, Glymur CRD and A16, I have included https://github.com/alsa-project/alsa-ucm-conf/pull/881 from [lmacken](https://github.com/lmacken) so that its easy to merge the series, tplg related to this are alredy merged.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/930
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/930.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
