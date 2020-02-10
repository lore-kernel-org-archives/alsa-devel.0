Return-Path: <SRS0=5/4N=36=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F45C352A4
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Feb 2020 07:59:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A95E20733
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Feb 2020 07:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="XCJrzAse";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ivitera.com header.i=@ivitera.com header.b="nCkMf2Uo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ivitera.com header.i=@ivitera.com header.b="nCkMf2Uo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A95E20733
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ivitera.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CBD0A15F9;
	Mon, 10 Feb 2020 08:58:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CBD0A15F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581321564;
	bh=czcBQEdrRZstN3v2no4cgrwzFxD4pcTydMD1bRu9v9M=;
	h=To:From:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=XCJrzAsejGQGlHfdVbjJJ5mk7utNuZUM7UV9oskcxPwZthXGK+o/lsyDwMwadi6el
	 egjgkQZMqylJxSKwj4wcXS1FL59+LFXlsA6U1c8iGO8eKCk6V4PGBJORCIopASNYJT
	 qVmZh+2b2gAdrC+v06nBJRGtysTXsR36F1Tc6mdE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 44D45F8014F;
	Mon, 10 Feb 2020 08:58:33 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5075DF80157; Mon, 10 Feb 2020 08:58:31 +0100 (CET)
Received: from cable.insite.cz (cable.insite.cz [84.242.75.189])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F0A64F800E7
 for <alsa-devel@alsa-project.org>; Mon, 10 Feb 2020 08:58:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F0A64F800E7
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=ivitera.com header.i=@ivitera.com
 header.b="nCkMf2Uo"; 
 dkim=pass (1024-bit key) header.d=ivitera.com header.i=@ivitera.com
 header.b="nCkMf2Uo"
Received: from localhost (localhost [127.0.0.1])
 by cable.insite.cz (Postfix) with ESMTP id CFDA4A1A40B0A
 for <alsa-devel@alsa-project.org>; Mon, 10 Feb 2020 08:58:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ivitera.com; s=mail;
 t=1581321506; bh=XgIuesuTI+GMvop1+rJWuP4exK0rC+2UCkNPmzaLAdo=;
 h=To:From:Subject:Date:From;
 b=nCkMf2UoQe8j7Tw5lNRtUMvk9AYlBzosNTSafHLtOBKyzGwQlkAAyYAS+IxI7/bLu
 ntwMDSRenMY0th+JpUIs2PRlAJhLr3483rmQ9XG0y7YSZfO2RzXIv2YK0M4F+TNnXl
 7jmRQDejA+SQGzDVxNb0DxJBf/K+GwMuYGgLl9AQ=
Received: from cable.insite.cz ([84.242.75.189])
 by localhost (server.insite.cz [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EqMjsa4bF7DP for <alsa-devel@alsa-project.org>;
 Mon, 10 Feb 2020 08:58:26 +0100 (CET)
Received: from [192.168.100.32] (unknown [192.168.100.32])
 (Authenticated sender: pavel)
 by cable.insite.cz (Postfix) with ESMTPSA id A9DA9A1A40B09
 for <alsa-devel@alsa-project.org>; Mon, 10 Feb 2020 08:58:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ivitera.com; s=mail;
 t=1581321506; bh=XgIuesuTI+GMvop1+rJWuP4exK0rC+2UCkNPmzaLAdo=;
 h=To:From:Subject:Date:From;
 b=nCkMf2UoQe8j7Tw5lNRtUMvk9AYlBzosNTSafHLtOBKyzGwQlkAAyYAS+IxI7/bLu
 ntwMDSRenMY0th+JpUIs2PRlAJhLr3483rmQ9XG0y7YSZfO2RzXIv2YK0M4F+TNnXl
 7jmRQDejA+SQGzDVxNb0DxJBf/K+GwMuYGgLl9AQ=
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
From: Pavel Hofman <pavel.hofman@ivitera.com>
Message-ID: <cd5ca9c8-0714-3dac-e91e-b45b1008b350@ivitera.com>
Date: Mon, 10 Feb 2020 08:58:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Language: en-US
Subject: [alsa-devel] Options for u_audio.c behavior when UAC2 host is
	disconnected/idle
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Hi,

I would like to discuss options to make the g_audio device more usable.
Currently if the USB UAC2 function does not supply/consume any audio
data (USB disconnected or the host side is not using the UAC2 gadget,
the g_audio devices (both capture and playback) are waiting, leading
eventually to an error. This makes using the feature rather inconvenient.

Possible options (certainly more are available)

1) The alsa devices will be openable at any time and when the UAC2 is
not producing/consuming, the alsa devices will be generating
zeros/dropping samples. Dropping samples would be similar to the
snd-aloop behavior.

2) Opening the alsa devices will fail when the UAC2 is not actively
running, and the pcm stream will be closed when UAC2 stops being active.
This is similar to how SPDIF receivers are coded in alsa drivers - if
change in the incoming SPDIF stream is detected (no samples, different
sample rate), the pcm stream is closed
https://github.com/torvalds/linux/blob/master/sound/i2c/other/ak4117.c#L504
It is up to the application to handle the error/close.

The behavior could be configurable via some params, if needed.

Thanks a lot for any suggestions and recommendations.

Best regards,


Pavel.

P.S.: I posted the same message to linux-usb mailing list, with no
response. I think this issue is more alsa-related, hence re-posting to
alsa-devel. Or should I keep both mailing lists posted? Thanks for
understanding.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
