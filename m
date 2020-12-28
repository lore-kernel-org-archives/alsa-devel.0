Return-Path: <SRS0=H50z=GA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E957C433E0
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Dec 2020 11:41:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E96C221F0
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Dec 2020 11:41:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E96C221F0
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 88C201706;
	Mon, 28 Dec 2020 12:40:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 88C201706
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1609155681;
	bh=kVmqgPs/wntwJXEtpqryoQLMyb3G+iWkUAaMVG2SVoc=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Kzi1/QzPKHn3gtQ3wgPqpwxn7UTkWg7+hk+TspSma2HSd3zA1Ti0Cl2d/LD6sCuNH
	 gsGaO1wH2nGu9tG85WN0V/8aLzenv70sb2tbPH65k3EOQXvTDhEvwkcB+JMQHJ1ViI
	 6Lh7ddVWkbsLWtv3G+rQ+Axt1fWwGUNHqV1Uhwkc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D6223F801ED;
	Mon, 28 Dec 2020 12:40:30 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 41892F801F5; Mon, 28 Dec 2020 12:40:29 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 1F3D7F80143
 for <alsa-devel@alsa-project.org>; Mon, 28 Dec 2020 12:40:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1F3D7F80143
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1609155621883091927-webhooks-bot@alsa-project.org>
References: <1609155621883091927-webhooks-bot@alsa-project.org>
Subject: pulse plugin crash when stream has a hole
Message-Id: <20201228114029.41892F801F5@alsa1.perex.cz>
Date: Mon, 28 Dec 2020 12:40:29 +0100 (CET)
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

alsa-project/alsa-plugins issue #16 was edited from i-garrison:

Following up on this debian bug report https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=824850

Looks like this crash is caused by missing stream hole handling in pulse plugin. Pulseaudio change was done just before `pulseaudio-v3.0` release and this issue should be reproducible with all current versions: https://gitlab.freedesktop.org/pulseaudio/pulseaudio/-/commit/dfd44036b54d65314664622ff93dfd18eee03c7b quoting from there:
```
... let the caller decide how the holes should be handled, so
in case of holes, pa_stream_peek() will return NULL data pointer and
the length of the hole in the nbytes argument
```

Here in pulse plugin, if there is a hole in stream `pa_stream_peek` would return NULL buffer pointer but non-zero `frag_length` and later memcpy is happily trying to copy from NULL source:
https://github.com/alsa-project/alsa-plugins/blob/7028580da1db9a2362dd9b0631d7f667b373c313/pulse/pcm_pulse.c#L517-L534

Instead, pulse plugin should detect there is a hole by checking if `src_buf` is still NULL while `frag_length` is not zero, and adjust transfer result accordingly.

Issue URL     : https://github.com/alsa-project/alsa-plugins/issues/16
Repository URL: https://github.com/alsa-project/alsa-plugins
