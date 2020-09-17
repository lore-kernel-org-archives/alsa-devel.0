Return-Path: <SRS0=Aorx=C2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F021CC43461
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Sep 2020 15:54:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01EAC221F1
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Sep 2020 15:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="t9MeV/hX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PVIoDK0y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01EAC221F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1EB2516C3;
	Thu, 17 Sep 2020 17:53:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1EB2516C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600358076;
	bh=xLgjMm7ateerqRvOW/ACV+xUBV1vmhn39rf9uYU/foI=;
	h=Date:From:To:To:To:Subject:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=t9MeV/hXB7dChI8fwFQiovWv+YBMyJVdK6Gzad6/VMqM0HoLJVQRkjoa6gxO33i59
	 ZHtW1L9CfhSE7ybyAfEtDyRK2jsVZUgPq/c/mr/p/avjbtIHm7squZnaLjOQdUT85l
	 jrpmTs+yAaOZ/2z0O5XXwy+/3e+/d1VCyfyCxOVk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9F76DF801EC;
	Thu, 17 Sep 2020 17:53:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F26EDF80276; Thu, 17 Sep 2020 17:53:43 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8ED46F80212
 for <alsa-devel@alsa-project.org>; Thu, 17 Sep 2020 17:53:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8ED46F80212
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="PVIoDK0y"
Received: from localhost (unknown [70.37.104.77])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id AE0602078D;
 Thu, 17 Sep 2020 15:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600358010;
 bh=xLgjMm7ateerqRvOW/ACV+xUBV1vmhn39rf9uYU/foI=;
 h=Date:From:To:To:To:Cc:Cc:Cc:Cc:Subject:In-Reply-To:References:
 From;
 b=PVIoDK0ynVeiPKncmAE/r00LLMAmT93ur5TuqzR5gqcQqdoumd61XJEJKCNDUBc09
 Q2L0POyfd4dPsIqaye1scjTkNzc8LBoKXxWkuja/auEa9DwTHk3dzuL6iocjG9gi+r
 KIyk7uTnOR1rH1ElQjoHXruDS56CBsPaEJrPV9iw=
Date: Thu, 17 Sep 2020 15:53:30 +0000
From: Sasha Levin <sashal@kernel.org>
To: Sasha Levin <sashal@kernel.org>
To: Hui Wang <hui.wang@canonical.com>
To: alsa-devel@alsa-project.org, tiwai@suse.de, kailang@realtek.com
Subject: Re: [PATCH] ALSA: hda/realtek - Couldn't detect Mic if booting with
 headset plugged
In-Reply-To: <20200914065118.19238-1-hui.wang@canonical.com>
References: <20200914065118.19238-1-hui.wang@canonical.com>
Message-Id: <20200917155330.AE0602078D@mail.kernel.org>
Cc: Kailang Yang <kailang@realtek.com>, stable@vger.kernel.org
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

Hi

[This is an automated email]

This commit has been processed because it contains a -stable tag.
The stable tag indicates that it's relevant for the following trees: all

The bot has tested the following trees: v5.8.9, v5.4.65, v4.19.145, v4.14.198, v4.9.236, v4.4.236.

v5.8.9: Build OK!
v5.4.65: Build OK!
v4.19.145: Build OK!
v4.14.198: Build OK!
v4.9.236: Failed to apply! Possible dependencies:
    0a6f0600efc3 ("ALSA: hda/realtek - New codecs support for ALC215/ALC285/ALC289")
    1078bef0cd92 ("ALSA: hda/realtek - Support ALC300")
    1c9609e3a8cf ("ALSA: hda - Reduce the suspend time consumption for ALC256")
    3aabf94c2d95 ("ALSA: hda/realtek - Fix ALC275 no sound issue")
    4a219ef8f370 ("ALSA: hda/realtek - Add ALC256 HP depop function")
    532a7784c376 ("ALSA: hda/realtek - There is no loopback mixer in the ALC234/274/294")
    693abe11aa6b ("ALSA: hda/realtek - Fixed hp_pin no value")
    71683c32dee6 ("ALSA: hda/realtek - Support headset mode for ALC234/ALC274/ALC294")
    bde1a7459623 ("ALSA: hda/realtek - Fixed headphone issue for ALC700")
    c0ca5eced222 ("ALSA: hda/realtek - Reduce click noise on Dell Precision 5820 headphone")
    c2d6af53a43f ("ALSA: hda/realtek - Add default procedure for suspend and resume state")

v4.4.236: Failed to apply! Possible dependencies:
    0a6f0600efc3 ("ALSA: hda/realtek - New codecs support for ALC215/ALC285/ALC289")
    1078bef0cd92 ("ALSA: hda/realtek - Support ALC300")
    1c9609e3a8cf ("ALSA: hda - Reduce the suspend time consumption for ALC256")
    3aabf94c2d95 ("ALSA: hda/realtek - Fix ALC275 no sound issue")
    4a219ef8f370 ("ALSA: hda/realtek - Add ALC256 HP depop function")
    532a7784c376 ("ALSA: hda/realtek - There is no loopback mixer in the ALC234/274/294")
    693abe11aa6b ("ALSA: hda/realtek - Fixed hp_pin no value")
    71683c32dee6 ("ALSA: hda/realtek - Support headset mode for ALC234/ALC274/ALC294")
    bde1a7459623 ("ALSA: hda/realtek - Fixed headphone issue for ALC700")
    c0ca5eced222 ("ALSA: hda/realtek - Reduce click noise on Dell Precision 5820 headphone")
    c2d6af53a43f ("ALSA: hda/realtek - Add default procedure for suspend and resume state")


NOTE: The patch will not be queued to stable trees until it is upstream.

How should we proceed with this patch?

-- 
Thanks
Sasha
