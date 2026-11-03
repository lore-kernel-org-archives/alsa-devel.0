Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2690A606A324
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Nov 2026 04:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=fbsmgioy
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E914560220;
	Tue,  3 Nov 2026 05:56:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E914560220
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1793681779;
	bh=50RATmQ1/10Jg4KtpwJv0vX2IsO+/cHhJcIBS/DL354=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=fbsmgioy1Prf+f/8Q/e2Y0jJRWj915FwQvVR+hzZXwIbOD2Ay3gGVBKpaTKWxkPy7
	 8w9eSLNYq9Jy8GkOupaBGBXC/COZZGavvHD3GeLuTApuLEg6imLaapTlptIhSVKNMQ
	 huR86YodAYqbNbwlEhIkyblxg8cYfhG8wrgLgzDY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7AF4EF805F5; Tue,  3 Nov 2026 05:55:45 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C1045F805FF;
	Tue,  3 Nov 2026 05:55:44 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C3EBFF804CF; Tue,  3 Nov 2026 05:55:37 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1793681735;
	b=MLBLcpQMWJZOmyFrAWndF1tnRy94Y00uDDnxfLhgORIy/w2juiJ2DBwyJTXgi3bvn+Xu
	 cKQY3T7lO4jmqo0h+iJ1nv+8PXXWMVKDgrgbf8LyB0nloOgL270Mgjv88r+WUhB/VfTJz
	 QJApUIFgFDsOi2h1FlG/GQOd6I+vNYrY3v2lp3y7c48yBhhlahZX+wi7osnWAATcatG0D
	 N77ms9FHk0aA+b6hFxJ6si/L6jTjoW6GWqCSGf3MCIgwK5sYNKlK7OLZSI03kGgyiJOG3
	 EiHtumWeYbUliKsa4FKnamtcol9+CM9vhkoLcepPEdIuVZz6cTCvlGdB/s/L57z8AaQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1793681735;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=50RATmQ1/10Jg4KtpwJv0vX2IsO+/cHhJcIBS/DL354=;
	b=OMzm6Vi2q6Mml4OnVXjG2jLpUg8pw/6MytJq7yjmbYd7t28NyTMMzayIUC1JTOoi6DAa
	 ye87GZKDBVrqZ67bShs6utyKu1xd7bvBdXCsVREjo6ozzhxFMZem8S+qA8RV/DwZsszyS
	 5lfTstjZFQag76OVeiTaxJTjGLIg16iCVttBuSLQhzm5VbH6hSjBOppdCmQYH0dx2pOAY
	 Vn5L4u5IelZYZCuaPTuOL9k1sx9O6EXHO69wW4qlqc2DBI4YUMvtQp9Zddjmxx8jGWmNj
	 h0hQlSRsI4nLE2KP34yqm+lf5z/Wl2zHS6MO06wAnNo2+IYEDAyzOj0l9i70zmi4GsA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 2D418F80100
	for <alsa-devel@alsa-project.org>; Tue,  3 Nov 2026 05:55:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2D418F80100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18e470088db49f00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/902@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/902@alsa-project.org>
Subject: ucm2: MediaTek: mt8391-evk: Set the DP audio muxes in the verb
Date: Tue,  3 Nov 2026 05:55:37 +0100 (CET)
Message-ID-Hash: BZMUKX24GFQ6H65IULZ5AHAO5ZXEQ4PD
X-Message-ID-Hash: BZMUKX24GFQ6H65IULZ5AHAO5ZXEQ4PD
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/BZMUKX24GFQ6H65IULZ5AHAO5ZXEQ4PD/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #902 was opened from tzuhsien-kao:

The DP output device added in 8048d93 needs DPTX_OUT_MUX at Connect and HDMI_CH1_MUX at CH1, but these controls are only set in the BootSequence. The BootSequence runs from alsactl init and its values are saved in the ALSA state file. On later boots alsa-restore replays the saved state, so the controls keep their stale values.

A stale DPTX_OUT_MUX (Disconnect) makes the PCM hw:CardId,5 fail to open. The whole HiFi profile then fails to probe and PipeWire exposes only a dummy output and no inputs. A stale HDMI_CH1_MUX (CH0) makes the right DP channel take its data from CH0, so Front Right is silent.

Set HDMI_CH0_MUX, HDMI_CH1_MUX and DPTX_OUT_MUX from the verb EnableSequence so they are applied each time the profile is activated, as mt8195_demo does since 445c079.

Fixes: 8048d93 ("ucm2: MediaTek: mt8391-evk: Add DisplayPort output audio support")

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/902
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/902.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
