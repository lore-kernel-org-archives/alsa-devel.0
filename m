Return-Path: <SRS0=gpx6=EC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E0F3C4363A
	for <alsa-devel@archiver.kernel.org>; Tue, 27 Oct 2020 22:08:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF68D20878
	for <alsa-devel@archiver.kernel.org>; Tue, 27 Oct 2020 22:08:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Elm9yBI3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF68D20878
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 140E91682;
	Tue, 27 Oct 2020 23:07:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 140E91682
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603836511;
	bh=0s8eorO0+5cCBd055VZ9u3z+zUkBtU/jHQ8xdAMXy1Y=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Elm9yBI3fmZaprJDGb5X8GYz7ieeJ2h6GHA2cxz81bTHY7crrMuTgD8wZrwKDbPAs
	 hOOmLw2IdRsgxhzY3O46OeDI1nrO6K0qAjO6P1YZyPMyTQeNuGvHfVl2Htmff0qnA8
	 uv0gyDBjALhvcMd8J2DbXgjmS6kGd1X6lKM/+mr4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8F49AF801D8;
	Tue, 27 Oct 2020 23:07:40 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 30D8BF8020D; Tue, 27 Oct 2020 23:07:39 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 5C649F80086
 for <alsa-devel@alsa-project.org>; Tue, 27 Oct 2020 23:07:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5C649F80086
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1603836453642128944-webhooks-bot@alsa-project.org>
References: <1603836453642128944-webhooks-bot@alsa-project.org>
Subject: Out of bounds array reference aplay.c playbackv_go function
Message-Id: <20201027220739.30D8BF8020D@alsa1.perex.cz>
Date: Tue, 27 Oct 2020 23:07:39 +0100 (CET)
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

alsa-project/alsa-utils issue #70 was opened from ygator:

I was looking through the aplay source file and came across an out of bounds reference.  The reason I was looking through the code is that I am using an i2s amp and there is this code:
`/usr/bin/aplay -D default -t raw -r 44100 -c 2 -f S16_LE /dev/zero /dev/zero`
The reason for it is:
> We've added an extra helper systemd script that will play quiet audio when the I2S peripheral isn't in use. This removes popping when playback starts or stops. It uses a tiny amount of CPU time (on a Pi Zero, 5%, on a Pi 2 or 3 its negligible). 

I thought there must be a way to just open the device and not have to use any CPU time actually playing nothing.
If anyone knows if this is possible then let me know.  Thanks.

Any way back to the out of bounds.

In the function playbackv_go function of aplay.c there is a call to perror(names[channel]).  However, instead of channel being equal to zero it is equal to channels which is 1 + the number of names being passed to the function.

> 	while (count > 0 && !in_aborting) {
		size_t c = 0;
		size_t expected = count / channels;
		if (expected > vsize)
			expected = vsize;
		do {
			**channel = 0;  // Code to fix out of bound**
			r = safe_read(fds[0], bufs[0], expected);
			if (r < 0) {
				**perror(names[channel]);  // Out of bounds reference**
				prg_exit(EXIT_FAILURE);
			}
			for (channel = 1; channel < channels; ++channel) {
				if (safe_read(fds[channel], bufs[channel], r) != r) {
					perror(names[channel]);
					prg_exit(EXIT_FAILURE);
				}
			}
			if (r == 0)
				break;
			c += r;
		} while (c < expected);

Issue URL     : https://github.com/alsa-project/alsa-utils/issues/70
Repository URL: https://github.com/alsa-project/alsa-utils
