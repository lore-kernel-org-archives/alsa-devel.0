Return-Path: <SRS0=ofM/=CT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D0C9C433E2
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Sep 2020 16:35:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB30721582
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Sep 2020 16:35:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="S1MAYhTn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FhbQ6LDq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB30721582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D400016A0;
	Thu, 10 Sep 2020 18:34:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D400016A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599755727;
	bh=AVr+KGSCdzQ6xTrmfRGUpuSjtsa56NMukFTGjePtzIo=;
	h=Date:From:To:To:To:Subject:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=S1MAYhTn3GcSg3DvJNy1cKASCJugZ3pJifUfeERnQY6BLKkpocNx0jtfac7nPVOyY
	 zPRG4blGTCRnpO6+xdZFl9W72ctZOsroEZgZh3JgFrVxcW3n0ve34Ets5AZocHb03d
	 lhgAhewzc1xRH/uYJqdgrKl2hrwNMIMXU0SuDgi4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4555CF800D0;
	Thu, 10 Sep 2020 18:34:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9B708F80264; Thu, 10 Sep 2020 18:34:34 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A153CF800D0
 for <alsa-devel@alsa-project.org>; Thu, 10 Sep 2020 18:34:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A153CF800D0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="FhbQ6LDq"
Received: from localhost (unknown [70.37.104.77])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C2E45221E7;
 Thu, 10 Sep 2020 16:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599755662;
 bh=AVr+KGSCdzQ6xTrmfRGUpuSjtsa56NMukFTGjePtzIo=;
 h=Date:From:To:To:To:CC:Cc:Cc:Subject:In-Reply-To:References:From;
 b=FhbQ6LDq+orsxc51/ttPZOUzDgglwdDLQgg2NsVsK+KDnV640orkKGsqeQPeORaua
 HoPkGkDXV9Xn2yT334FlL7bxJCLLn+UcBoWoLTFMm98bzIOwSDCP95azaov8E01B+o
 61HQpO3Gmdiqlknm8bzmUnDv/0GPkNpr1UpYJt/A=
Date: Thu, 10 Sep 2020 16:34:21 +0000
From: Sasha Levin <sashal@kernel.org>
To: Sasha Levin <sashal@kernel.org>
To: Joakim Tjernlund <joakim.tjernlund@infinera.com>
To: <alsa-devel@alsa-project.org>
Subject: Re: [PATCH] ALSA: usb-audio: Add delay quirk for H570e USB headsets
In-Reply-To: <20200910085328.19188-1-joakim.tjernlund@infinera.com>
References: <20200910085328.19188-1-joakim.tjernlund@infinera.com>
Message-Id: <20200910163421.C2E45221E7@mail.kernel.org>
Cc: Joakim Tjernlund <joakim.tjernlund@infinera.com>, stable@vger.kernel.org
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

The bot has tested the following trees: v5.8.7, v5.4.63, v4.19.143, v4.14.196, v4.9.235, v4.4.235.

v5.8.7: Build OK!
v5.4.63: Build OK!
v4.19.143: Build OK!
v4.14.196: Build OK!
v4.9.235: Build OK!
v4.4.235: Failed to apply! Possible dependencies:
    71426535f49f ("ALSA: usb-audio: Add native DSD support for Luxman DA-06")
    74dc71f83e50 ("ALSA: usb-audio: FIX native DSD support for TEAC UD-501 DAC")
    79289e24194a ("ALSA: usb-audio: Refer to chip->usb_id for quirks and MIDI creation")
    7f38ca047b0c ("ALSA: usb-audio: Add native DSD support for TEAC 501/503 DAC")
    866f7ed7d679 ("ALSA: usb-audio: Add native DSD support for Esoteric D-05X")
    b00214865d65 ("ALSA: usb-audio: Add native DSD support for TEAC UD-301")
    df3f0347fd85 ("ALSA: usb-audio: quirks: Replace mdelay() with msleep() and usleep_range()")
    f3b906d720e4 ("ALSA: usb-audio: Integrate native DSD support for ITF-USB based DACs.")


NOTE: The patch will not be queued to stable trees until it is upstream.

How should we proceed with this patch?

-- 
Thanks
Sasha
