Return-Path: <SRS0=BjaJ=H2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D617C433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Feb 2021 12:53:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68A9364F0C
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Feb 2021 12:53:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68A9364F0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C6FFF1679;
	Wed, 24 Feb 2021 13:53:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C6FFF1679
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614171235;
	bh=38Pu3wu3c7i+stw295uGqMWQuud9FpmztFKPE6KWWvo=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LRwULUcpGKGNwU44YeP+sHDAroHwi0S9q1MmgrW1rWWZBf4VO/VBrKByjzSZCnK/I
	 fE++2vJhNOLHhoCeej1j5vT5/ut+ROYH9xjdyWQKe7QtloBntqd8ol+ASmTsGDoBu+
	 6bShCGScdf3/n0V1KHR4ois7g1BDZ0TOMa22S3vE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7DA4AF802E0;
	Wed, 24 Feb 2021 13:51:39 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C122CF802E7; Wed, 24 Feb 2021 13:51:37 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AADC8F802DF
 for <alsa-devel@alsa-project.org>; Wed, 24 Feb 2021 13:51:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AADC8F802DF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="n0ULOPrf"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4839164F24;
 Wed, 24 Feb 2021 12:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1614171090;
 bh=38Pu3wu3c7i+stw295uGqMWQuud9FpmztFKPE6KWWvo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=n0ULOPrfl4kXEYuGZYvxxDbT36G67SqnL9lOx0FnX/YbxflEqSa7faCtJLfMYf5oh
 bw5Cu9Bax/GU+qTFyX+9n2sN4mS1bd8c+fuHmwDyJONaWvbITlN/Nie615dSb4k6dR
 rtxDi3/+Lm2GPHRwwJfwzK040Y5bPhcFaguJNtkUE+hBgwXuwv8NJ4GxKoPzmTrNR/
 ODAdODUlZumlCNGcBJG1EfmJmaMgqwLM/cId74RCS4k35rXr5ads5r7wJGE4iqzRqy
 SgrXnRq6r1EhkwfC1R8URucgy/8qeGQObQgPI1rDnHwQ7a/DT35pmrj5BCJfvrk3Sh
 24rXRJXxzqC8A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.11 47/67] ALSA: usb-audio: Add DJM450 to Pioneer
 format quirk
Date: Wed, 24 Feb 2021 07:50:05 -0500
Message-Id: <20210224125026.481804-47-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210224125026.481804-1-sashal@kernel.org>
References: <20210224125026.481804-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>,
 alsa-devel@alsa-project.org, Olivia Mackintosh <livvy@base.nu>
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

From: Olivia Mackintosh <livvy@base.nu>

[ Upstream commit 3b85f5fc75d564a9eb4171dcb6b8687b080cd4d5 ]

Like the DJM-750, ensure that the format control message is passed to
the device when opening a stream. It seems as though fmt->sync_ep is not
always set when this function is called hence the passing of the value
at the call site. If this can be fixed, fmt->sync_up should be used as
the wvalue.

There doesn't seem to be a "cpu_to_le24" type function defined hence for
the open code but I did see a similar thing done in Bluez lib. Perhaps
we can get these definitions defined in byteorder.h. See hci_cpu_to_le24
in include/net/bluetooth/hci.h:2543 for similar usage.

Signed-off-by: Olivia Mackintosh <livvy@base.nu>
Link: https://lore.kernel.org/r/20210202134225.3217-2-livvy@base.nu
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/quirks.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index e196e364cef19..9ba4682ebc482 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1470,6 +1470,23 @@ static void set_format_emu_quirk(struct snd_usb_substream *subs,
 	subs->pkt_offset_adj = (emu_samplerate_id >= EMU_QUIRK_SR_176400HZ) ? 4 : 0;
 }
 
+static int pioneer_djm_set_format_quirk(struct snd_usb_substream *subs,
+					u16 windex)
+{
+	unsigned int cur_rate = subs->data_endpoint->cur_rate;
+	u8 sr[3];
+	// Convert to little endian
+	sr[0] = cur_rate & 0xff;
+	sr[1] = (cur_rate >> 8) & 0xff;
+	sr[2] = (cur_rate >> 16) & 0xff;
+	usb_set_interface(subs->dev, 0, 1);
+	// we should derive windex from fmt-sync_ep but it's not set
+	snd_usb_ctl_msg(subs->stream->chip->dev,
+		usb_rcvctrlpipe(subs->stream->chip->dev, 0),
+		0x01, 0x22, 0x0100, windex, &sr, 0x0003);
+	return 0;
+}
+
 void snd_usb_set_format_quirk(struct snd_usb_substream *subs,
 			      const struct audioformat *fmt)
 {
@@ -1483,6 +1500,9 @@ void snd_usb_set_format_quirk(struct snd_usb_substream *subs,
 	case USB_ID(0x534d, 0x2109): /* MacroSilicon MS2109 */
 		subs->stream_offset_adj = 2;
 		break;
+	case USB_ID(0x2b73, 0x0013): /* Pioneer DJM-450 */
+		pioneer_djm_set_format_quirk(subs, 0x0082);
+		break;
 	}
 }
 
-- 
2.27.0

