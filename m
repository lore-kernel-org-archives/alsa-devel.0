Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97137C79F9E
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Sep 2026 00:54:56 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 87688601E0;
	Tue,  8 Sep 2026 02:54:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 87688601E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1788828893;
	bh=10Z9qDQvZd1hwBzqX2qRKElNjgu7PAq5CjR7KIo/5e8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=VO76I+7eluzEIYFTfN0F8Z1LjZ990HW8M5JAfwi0hep89yfFg+He4lEUUHVA4SuoD
	 kLXmTDaO90VrA3Mt6epuo79p6Py19Jp6VkTb3E8nbJgAggjCl9zE3s7zhE21uxTqwZ
	 /UlebozmQ+uQzX2e2iMY49MjS88PlmLORFHYc6s0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D8839F805FD; Tue,  8 Sep 2026 02:54:18 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 73210F80602;
	Tue,  8 Sep 2026 02:54:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2BB1AF80518; Tue,  8 Sep 2026 02:54:13 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1788828852;
	b=p/U9L95kzyUADaMQnedhCLenY/wgfq43wGsgvvo+0R8k4Q4uN0zkBoy038Ug1RQvFHe5
	 Q9ZP9tCTgej5P3q20zkLSN2hr/faOvsFsH/Sm7okNmOo2LSBkGrJkXnxgG9q7i5C36bHI
	 QR+1J4J83f68Cahr1xFnkXdrS0sqdH8JUVccxUBMgYpLWeS798Gm+Ejr5qbLooi+GDyKw
	 HUhelb69ekZIEdTGwiQArHke/2B1D1zHkTRRHrFLykImET/yfSCSpp1bERGXUyG+9ZWHk
	 IlYb4RRD8+ZO6GCXMFRSNmJJtu8c8p37NXOvOl6HfQrMD1/9/E5I/UfKAt4u6vaYK8A==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1788828852;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=10Z9qDQvZd1hwBzqX2qRKElNjgu7PAq5CjR7KIo/5e8=;
	b=caUALjWQmZC7qNsAEl5N9mgE/zl4uziCGY5nosJwRrl+W4I/8C3o5MPxRguPLUzph1uy
	 SLvJRmtZjgl6QPFI3WBNDHZTDb1gmM2pyV7Lq6BysjuvKPSInFstarl3Q0VENboP3Ue8P
	 tv5VBbNSN611aGe2lfxCJTrhHAtuTKC1ACOwS/vqP+I8j5S894bQY7ekivc40HSvAM1/T
	 xYlHgAEJ6kd05ExaZCA4dL9+S7XP+Sgm+KbrX0d6hvHmbmdQeMGZKETlKKi2WQiTiw0tb
	 Ql6EMOsptBujt/KXrYaIwP878PJa/icMF8oNv5UR/OGZHc0tt6/r8GzKTL13qOjf+yQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Cn5MA4VX;
	arc=none smtp.remote-ip=172.234.252.31
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 4F8C3F800FA
	for <alsa-devel@alsa-project.org>; Tue,  8 Sep 2026 02:54:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4F8C3F800FA
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Cn5MA4VX
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 0A4D644785;
	Tue,  8 Sep 2026 00:54:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C0C11F00A3D;
	Tue,  8 Sep 2026 00:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788828847;
	bh=iqA6aKbFfQjRdOHLLEq2u5yUmf5DtfodLB49uuF3nJI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Cn5MA4VXLWK4IhMnzgAwBeLNADkthtry0MEIBfMjQcEXOCmvbn08aLWbDdUzRefcs
	 THIcNR3j2XLoDFg99PWhc3CPoBQ9qHbEzn6o8NJLUWmm6/l7Ooy7g6pYABN33G+FMV
	 HMC7OEDEoMStyCYu7Si7emMXmdcPQhEC5ish3QpZK0NElCuuEnY5VsAvFge/ZZii86
	 No9xZuuoVxCWnyYUrPpqGQO+1MkwBVPXbU09q/K9GL1DpQyJuGgMlihZ3qvHAKwdre
	 Ftcef8UFEb3CmAf5G0/zlQW728RQyLGZokHt+vKEMX9eehrTQiqCnzeacDRRI7shfw
	 6j9wM6WNxcVNg==
From: Sasha Levin <sashal@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Sasha Levin <sashal@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	tzungbi@kernel.org,
	alsa-devel@alsa-project.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 5.15.y] ALSA: seq: Fix port lock leak in
 deliver_to_subscribers()
Date: Mon,  7 Sep 2026 20:53:43 -0400
Message-ID: <2026-09-07-daily-reply-0004-alsa-seq-5-15@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <87qzj4rhbo.wl-tiwai@suse.de>
References: <87qzj4rhbo.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: OK64N7Y36QE6VFGYEPADT3GOWDV6FMML
X-Message-ID-Hash: OK64N7Y36QE6VFGYEPADT3GOWDV6FMML
X-MailFrom: sashal@kernel.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/OK64N7Y36QE6VFGYEPADT3GOWDV6FMML/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

> Reviewed-by: Takashi Iwai <tiwai@suse.de>

Thanks for the ack. Queued for 5.15.

-- 
Thanks,
Sasha
