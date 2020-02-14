Return-Path: <SRS0=Q+Fc=4C=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B4A7C3B1A1
	for <alsa-devel@archiver.kernel.org>; Fri, 14 Feb 2020 16:06:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F9D2217F4
	for <alsa-devel@archiver.kernel.org>; Fri, 14 Feb 2020 16:06:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="tKBAUlrR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FSlTUjqB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F9D2217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EE8A916BC;
	Fri, 14 Feb 2020 17:05:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EE8A916BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581696367;
	bh=TLUvmA8xhMqadwEaOa0F0P2EYwb9g+QdvJOX7u7mawc=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tKBAUlrRUJg7gNhdgnbe+BTrgwAFwc2MVAbCU0VOIJbGrHoCR+p4IqpfApyDEpMLs
	 kPmvwJJjpIp8NpQNkvyBBD5LCMoA9fc17op+D1y55AOIjA102iTvozkQW8IQnXMmEa
	 l10Wtd1vif7VQwNjMpuUbll8thrqk43hhs/XJC/M=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 39665F8014F;
	Fri, 14 Feb 2020 16:59:02 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 099BBF80276; Fri, 14 Feb 2020 16:59:00 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D8BF9F800F0
 for <alsa-devel@alsa-project.org>; Fri, 14 Feb 2020 16:58:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D8BF9F800F0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="FSlTUjqB"
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 84B802467C;
 Fri, 14 Feb 2020 15:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1581695935;
 bh=AWcXrUPmg1Ok0gkYHL79LaRTs1+QfXtcYfPh5YIhW2I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=FSlTUjqBqkTlCgefOQNUhLzg1x8O9OST6mdesnqR0dX83/cW/sO+PgNISqmbGgHOC
 s48PLn0gNgB8IkbxhQlcfo3/vnPivOEpdo9P7KgE4v/hriaWAURu4BERzxCw2UJqgf
 FmYU1x1WHJjMa8v7twAp52RQ8ANXYNvPb1YmboQw=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Date: Fri, 14 Feb 2020 10:47:42 -0500
Message-Id: <20200214154854.6746-470-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214154854.6746-1-sashal@kernel.org>
References: <20200214154854.6746-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Cc: Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>,
 alsa-devel@alsa-project.org, Nicola Lunghi <nick83ola@gmail.com>
Subject: [alsa-devel] [PATCH AUTOSEL 5.5 470/542] ALSA: usb-audio: add
	quirks for Line6 Helix devices fw>=2.82
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

From: Nicola Lunghi <nick83ola@gmail.com>

[ Upstream commit b81cbf7abfc94878a3c6f0789f2185ee55b1cc21 ]

With firmware 2.82 Line6 changed the usb id of some of the Helix
devices but the quirks is still needed.

Add it to the quirk list for line6 helix family of devices.

Thanks to Jens for pointing out the missing ids.

Signed-off-by: Nicola Lunghi <nick83ola@gmail.com>
Link: https://lore.kernel.org/r/20200125150917.5040-1-nick83ola@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/format.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/usb/format.c b/sound/usb/format.c
index d79db71305f63..53922f73467f4 100644
--- a/sound/usb/format.c
+++ b/sound/usb/format.c
@@ -296,6 +296,9 @@ static int line6_parse_audio_format_rates_quirk(struct snd_usb_audio *chip,
 	case USB_ID(0x0E41, 0x4242): /* Line6 Helix Rack */
 	case USB_ID(0x0E41, 0x4244): /* Line6 Helix LT */
 	case USB_ID(0x0E41, 0x4246): /* Line6 HX-Stomp */
+	case USB_ID(0x0E41, 0x4248): /* Line6 Helix >= fw 2.82 */
+	case USB_ID(0x0E41, 0x4249): /* Line6 Helix Rack >= fw 2.82 */
+	case USB_ID(0x0E41, 0x424a): /* Line6 Helix LT >= fw 2.82 */
 		/* supported rates: 48Khz */
 		kfree(fp->rate_table);
 		fp->rate_table = kmalloc(sizeof(int), GFP_KERNEL);
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
