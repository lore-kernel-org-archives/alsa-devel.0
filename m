Return-Path: <SRS0=aYR+=FB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81551C2D0E4
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Nov 2020 04:00:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E01E208CA
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Nov 2020 04:00:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="qsd7XyQj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yA6m9DqU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E01E208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 13F9617F5;
	Fri, 27 Nov 2020 04:59:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 13F9617F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1606449635;
	bh=ZJ78V0PijUfjQxK3vM8X3DhLoT/DW3aRWhd1al1rJc8=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qsd7XyQjG3JQZbVEdbYKM0j2lPOg23KK6jS/1pMOMZ7I3L7tcy3fSVNHEAAWUewGn
	 zONrX4Zx7iPCgDGE1ty1KPzIqyUymq4iJQbMu/bYU51dL/vvWSmi5TCmalnolYGghy
	 mb25WtHO3L8uOqfAo2NyOIKEGi38JI34+LoJTWBg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 80D56F800EA;
	Fri, 27 Nov 2020 04:59:44 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E3BEAF8019D; Fri, 27 Nov 2020 04:59:41 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DE56CF800EA
 for <alsa-devel@alsa-project.org>; Fri, 27 Nov 2020 04:59:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DE56CF800EA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="yA6m9DqU"
Received: from localhost (unknown [122.167.146.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id BD154208CA;
 Fri, 27 Nov 2020 03:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1606449575;
 bh=ZJ78V0PijUfjQxK3vM8X3DhLoT/DW3aRWhd1al1rJc8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=yA6m9DqU+mV5bnkW0jUqxiHr7/4b0QmZvoCbLIoxWSklCdrzLE1/4rOebH9YZHFm9
 LG3PVbWZV925b7KO9VCaOAJGS2CQNdIcYgOsC/zULnV5g2mlXbj8e1BV/XcctD9tK0
 +vmYAeRwE7+5d3txZZR6nNVE2lJf9mNMcX9Qg+JU=
Date: Fri, 27 Nov 2020 09:29:26 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Gyeongtaek Lee <gt82.lee@samsung.com>
Subject: Re: [PATCH v3 1/1] ALSA: compress: allow pause and resume during
 draining
Message-ID: <20201127035926.GJ8403@vkoul-mobl>
References: <CGME20201126123452epcas2p2638c08262ef400cc0ad99fc2d1bd7b2a@epcas2p2.samsung.com>
 <000101d6c3f0$89b312b0$9d193810$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000101d6c3f0$89b312b0$9d193810$@samsung.com>
Cc: alsa-devel@alsa-project.org, khw0178.kim@samsung.com, lgirdwood@gmail.com,
 'Takashi Iwai' <tiwai@suse.de>,
 'Pierre-Louis Bossart' <pierre-louis.bossart@linux.intel.com>, tiwai@suse.com,
 kimty@samsung.com, donggyun.ko@samsung.com, hmseo@samsung.com,
 s47.kang@samsung.com, pilsun.jang@samsung.com, tkjung@samsung.com
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On 26-11-20, 21:34, Gyeongtaek Lee wrote:
> With a stream with low bitrate, user can't pause or resume the stream
> near the end of the stream because current ALSA doesn't allow it.
> If the stream has very low bitrate enough to store whole stream into
> the buffer, user can't do anything except stop the stream and then
> restart it from the first because most of applications call draining
> after sending last frame to the kernel.
> If pause, resume are allowed during draining, user experience can be
> enhanced.
> To prevent malfunction in HW drivers which don't support pause
> during draining, pause during draining will only work if HW driver
> enable this feature explicitly by calling
> snd_compr_use_pause_in_draining().

I cant think of a better solution so:

Acked-By: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
