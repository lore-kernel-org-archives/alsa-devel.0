Return-Path: <SRS0=9Cbg=PC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79764C433EF
	for <alsa-devel@archiver.kernel.org>; Thu, 14 Oct 2021 13:07:56 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96E7560EDF
	for <alsa-devel@archiver.kernel.org>; Thu, 14 Oct 2021 13:07:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 96E7560EDF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 07DCD1675;
	Thu, 14 Oct 2021 15:07:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 07DCD1675
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1634216874;
	bh=auF8lDnr7S62rpWgMQpeavD3yriSAnlJB2yZpogwNTk=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=emUBWQBeDBQhg40PL8yxZmzBoA6nj1LgkwjRdySuJNq28PYcGDJWjH1odMCrWP8eB
	 J21fm3T5te1XP8O8s+VuuCJ8SVYg+Mp9WuMVvAIn6JsT1h3uIYDkYTSO2UBXOytp1t
	 6xljR22mf0n8ZTmiiwWCe0LenAECIj5m4WGrX1yU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 57D7EF804AD;
	Thu, 14 Oct 2021 15:06:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D14A2F804AD; Thu, 14 Oct 2021 15:06:43 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7B7E5F80212
 for <alsa-devel@alsa-project.org>; Thu, 14 Oct 2021 15:06:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7B7E5F80212
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="yStf+bXm"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="7Irst2Yc"
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 044031FD29;
 Thu, 14 Oct 2021 13:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1634216799; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=iRmJ5zgA3EGLKJ8MRCeiAD16yv1Yi9Ms5l7mbe5Hzrw=;
 b=yStf+bXmdLiY44eHTjH330TRVm0yZTP65hL4YCRAblgZDrXRiqW59AfE485l1Ai/AomOhg
 YrlxTlknIaSJZ4Xe5I/IVn6stFeG5/oF3AyZnUMRgb7WV+HWrgMkkUXvNweGK1DKxc6Ip9
 kIq7nD70O4E8eH6nvihpVJ1Z8Q2af2g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1634216799;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=iRmJ5zgA3EGLKJ8MRCeiAD16yv1Yi9Ms5l7mbe5Hzrw=;
 b=7Irst2YcVzlKGOc8Kkk7AYZ0a+hTEuPxjQmQDzL90s2LusdR399b/qREuO1DlOy4svKYtv
 OtYGdt9F3nb7u0CQ==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
 by relay2.suse.de (Postfix) with ESMTP id E5D55A3B84;
 Thu, 14 Oct 2021 13:06:38 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 0/3] ALSA: usb-audio: Small improvements in mixer handling
Date: Thu, 14 Oct 2021 15:06:33 +0200
Message-Id: <20211014130636.17860-1-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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

Hi,

this is a patchset with small fixes for improving the USB-audio mixer
behavior.  Instead of treating the error from a control message
continuously, initialize all at the probe and keep the rest working.

The first two patches are rather fixes for error messages in
get_ctl_value_v2() function, the last one implements the new
behavior.


Takashi

===

Takashi Iwai (3):
  ALSA: usb-audio: Downgrade error message in get_ctl_value_v2()
  ALSA: usb-audio: Drop superfluous error message after disconnection
  ALSA: usb-audio: Initialize every feature unit once at probe time

 sound/usb/mixer.c | 42 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 36 insertions(+), 6 deletions(-)

-- 
2.26.2

