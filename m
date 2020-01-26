Return-Path: <SRS0=YQED=3P=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9524DC35242
	for <alsa-devel@archiver.kernel.org>; Sun, 26 Jan 2020 01:39:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C9E120709
	for <alsa-devel@archiver.kernel.org>; Sun, 26 Jan 2020 01:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="nzkdBOjQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gWIBpGW1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C9E120709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 721341660;
	Sun, 26 Jan 2020 02:38:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 721341660
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1580002774;
	bh=7eC6uyBBXa3hBHKiuGOl7RRrJqryifTWdBO6eOs9wDk=;
	h=Date:From:To:To:To:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nzkdBOjQUc1hp3MeQgPhDDyhYT923dTsH7In9ojAy/E6c9G3kojZCLn7VCEzOCO7o
	 i3hO3GbzncdFzyfG2RKdtnFqT2PzuLekqVxifFsBmAwi7AC7vCu1yBThsqBaxJo1We
	 2c7YaXh51RGfW8Vc9pXf/6LqeTU+5th8xaTQQo2Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F2E5FF801D9;
	Sun, 26 Jan 2020 02:38:43 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3516BF801EC; Sun, 26 Jan 2020 02:38:37 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CBFBBF800BA
 for <alsa-devel@alsa-project.org>; Sun, 26 Jan 2020 02:38:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CBFBBF800BA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="gWIBpGW1"
Received: from localhost (unknown [40.117.208.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 72B4D20709;
 Sun, 26 Jan 2020 01:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1580002707;
 bh=VUMnZTE3++sXHuN1mMO1cTsIJObtD4Up1q3F6LlHhCg=;
 h=Date:From:To:To:To:Cc:Cc:Cc:Subject:In-Reply-To:References:From;
 b=gWIBpGW1jFQ3lVYUsFZiMhfaUyDMOoPaayiz6J14yoIdCFHo5/iUXN9FgtQsPqZlc
 isdB4I1UhDaBjzERrkm20yuWtjaSCpueWdoPWHaOeJZ4WqPym+iqO20VTMAuK9vlNd
 8Dlfc8c/G4Vnpn4/ecSJF3DOgItnJ1/zttVEu5A8=
Date: Sun, 26 Jan 2020 01:38:26 +0000
From: Sasha Levin <sashal@kernel.org>
To: Sasha Levin <sashal@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
To: Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <20200125181021.70446-1-hdegoede@redhat.com>
References: <20200125181021.70446-1-hdegoede@redhat.com>
Message-Id: <20200126013827.72B4D20709@mail.kernel.org>
Cc: , Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org,
 stable@vger.kernel.org
Subject: Re: [alsa-devel] [PATCH] ALSA: hda: Add Clevo W65_67SB the
	power_save blacklist
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Hi,

[This is an automated email]

This commit has been processed because it contains a -stable tag.
The stable tag indicates that it's relevant for the following trees: all

The bot has tested the following trees: v5.4.14, v4.19.98, v4.14.167, v4.9.211, v4.4.211.

v5.4.14: Build OK!
v4.19.98: Build OK!
v4.14.167: Failed to apply! Possible dependencies:
    38d9c12c0a6d ("ALSA: hda: Add Gigabyte P55A-UD3 and Z87-D3HP to the power_save blacklist")
    5cb6b5fc013e ("ALSA: hda: Add 2 more models to the power_save blacklist")
    b529ef2464ad ("ALSA: hda: Add Clevo W35xSS_370SS to the power_save blacklist")
    dd6dd5365404 ("ALSA: hda: Add Intel NUC7i3BNB to the power_save blacklist")
    f91f1806530d ("ALSA: hda: Add Intel NUC5i7RY to the power_save blacklist")

v4.9.211: Failed to apply! Possible dependencies:
    38d9c12c0a6d ("ALSA: hda: Add Gigabyte P55A-UD3 and Z87-D3HP to the power_save blacklist")
    5cb6b5fc013e ("ALSA: hda: Add 2 more models to the power_save blacklist")
    b529ef2464ad ("ALSA: hda: Add Clevo W35xSS_370SS to the power_save blacklist")
    dd6dd5365404 ("ALSA: hda: Add Intel NUC7i3BNB to the power_save blacklist")
    f91f1806530d ("ALSA: hda: Add Intel NUC5i7RY to the power_save blacklist")

v4.4.211: Failed to apply! Possible dependencies:
    38d9c12c0a6d ("ALSA: hda: Add Gigabyte P55A-UD3 and Z87-D3HP to the power_save blacklist")
    5cb6b5fc013e ("ALSA: hda: Add 2 more models to the power_save blacklist")
    b529ef2464ad ("ALSA: hda: Add Clevo W35xSS_370SS to the power_save blacklist")
    dd6dd5365404 ("ALSA: hda: Add Intel NUC7i3BNB to the power_save blacklist")
    f91f1806530d ("ALSA: hda: Add Intel NUC5i7RY to the power_save blacklist")


NOTE: The patch will not be queued to stable trees until it is upstream.

How should we proceed with this patch?

-- 
Thanks,
Sasha
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
