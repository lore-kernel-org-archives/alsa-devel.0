Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0BE1C43217
	for <alsa-devel@archiver.kernel.org>; Tue, 26 Apr 2022 19:03:29 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EFFCC1856;
	Tue, 26 Apr 2022 21:02:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EFFCC1856
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1650999808;
	bh=Yin+YIOwRDSLjxFgNOB0DFj+qPCPFVJCMRkOd+EWZdQ=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FXCpXb53bME2Pr9GpnXjZMNBwSiNCZS9rkUhv4hr+X08uYeoIcXl9mM8tf1LwFyHN
	 c2Qwtu1tfX+YUQuCtCY4EviepBTpG5kCTgZJggEDGkluvvq1TIKqifi49p3HjhNy06
	 p6d2h0F6r+biGwQ908WPMXjU3ZfhW035LuAQPU7g=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 019ACF80511;
	Tue, 26 Apr 2022 21:02:04 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 47011F8050F; Tue, 26 Apr 2022 21:02:00 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E5C1BF804FE
 for <alsa-devel@alsa-project.org>; Tue, 26 Apr 2022 21:01:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E5C1BF804FE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="HWAW4530"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 00658619A9;
 Tue, 26 Apr 2022 19:01:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DD0BC385AD;
 Tue, 26 Apr 2022 19:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1650999707;
 bh=Yin+YIOwRDSLjxFgNOB0DFj+qPCPFVJCMRkOd+EWZdQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=HWAW4530gzEiEjR1/9S5parkOPlkV733WvLz2yx6T51lQL/nsGd/mM8IvjRO65rXn
 RKy6FSO+KOLyH7J1X7gPJ2wMaReN9l03zLhvpJLZWejkK6Qj5Z2RZimAFVDNtcJvYR
 bp1qwPMF8NAN/82YdGHlGf8xj0Q8z+94WNNOIBVRYJIM+Yt7Hm2g1PzCu1gs/e1ygH
 bEE3I8ElKiDpVnMKJX/GBfK1LTEeMqva9SsaWGCLCDClFpOtsp8/C2fU4KYUcvy2XA
 LUXpd2Z0hu7JDYjUk8R8VUmNNIi/tQ6GtlxkSKQdh9bRuGOYpDfMQpDFyiMkivMbqG
 xoFGfFiQd1D8Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.17 02/22] ASoC: cs35l41: Fix a shift-out-of-bounds
 warning found by UBSAN
Date: Tue, 26 Apr 2022 15:01:25 -0400
Message-Id: <20220426190145.2351135-2-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220426190145.2351135-1-sashal@kernel.org>
References: <20220426190145.2351135-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org,
 tanureal@opensource.cirrus.com, patches@opensource.cirrus.com, tiwai@suse.com,
 lgirdwood@gmail.com, david.rhodes@cirrus.com,
 Hui Wang <hui.wang@canonical.com>, Mark Brown <broonie@kernel.org>,
 james.schulman@cirrus.com
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

From: Hui Wang <hui.wang@canonical.com>

[ Upstream commit 0b3d5d2e358ca6772fc3662fca27acb12a682fbf ]

We enabled UBSAN in the ubuntu kernel, and the cs35l41 driver triggers
a warning calltrace like below:

cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: bitoffset= 8, word_offset=23, bit_sum mod 32=0, otp_map[i].size = 24
cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: bitoffset= 0, word_offset=24, bit_sum mod 32=24, otp_map[i].size = 0
================================================================================
UBSAN: shift-out-of-bounds in linux-kernel-src/sound/soc/codecs/cs35l41-lib.c:836:8
shift exponent 64 is too large for 64-bit type 'long unsigned int'
CPU: 10 PID: 595 Comm: systemd-udevd Not tainted 5.15.0-23-generic #23
Hardware name: LENOVO \x02MFG_IN_GO/\x02MFG_IN_GO, BIOS N3GET19W (1.00 ) 03/11/2022
Call Trace:
 <TASK>
 show_stack+0x52/0x58
 dump_stack_lvl+0x4a/0x5f
 dump_stack+0x10/0x12
 ubsan_epilogue+0x9/0x45
 __ubsan_handle_shift_out_of_bounds.cold+0x61/0xef
 ? regmap_unlock_mutex+0xe/0x10
 cs35l41_otp_unpack.cold+0x1c6/0x2b2 [snd_soc_cs35l41_lib]
 cs35l41_hda_probe+0x24f/0x33a [snd_hda_scodec_cs35l41]
 cs35l41_hda_i2c_probe+0x65/0x90 [snd_hda_scodec_cs35l41_i2c]

When both bitoffset and otp_map[i].size are 0, the line 836 will
result in GENMASK(-1, 0), this triggers the shift-out-of-bounds
calltrace.

Here add a checking, if both bitoffset and otp_map[i].size are 0,
do not run GENMASK() and directly set otp_val to 0, this will not
bring any function change on the driver but could avoid the calltrace.

Signed-off-by: Hui Wang <hui.wang@canonical.com>
Link: https://lore.kernel.org/r/20220324081839.62009-2-hui.wang@canonical.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/cs35l41-lib.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs35l41-lib.c b/sound/soc/codecs/cs35l41-lib.c
index e5a56bcbb223..281a710a4123 100644
--- a/sound/soc/codecs/cs35l41-lib.c
+++ b/sound/soc/codecs/cs35l41-lib.c
@@ -831,12 +831,14 @@ int cs35l41_otp_unpack(struct device *dev, struct regmap *regmap)
 					GENMASK(bit_offset + otp_map[i].size - 33, 0)) <<
 					(32 - bit_offset);
 			bit_offset += otp_map[i].size - 32;
-		} else {
+		} else if (bit_offset + otp_map[i].size - 1 >= 0) {
 			otp_val = (otp_mem[word_offset] &
 				   GENMASK(bit_offset + otp_map[i].size - 1, bit_offset)
 				  ) >> bit_offset;
 			bit_offset += otp_map[i].size;
-		}
+		} else /* both bit_offset and otp_map[i].size are 0 */
+			otp_val = 0;
+
 		bit_sum += otp_map[i].size;
 
 		if (bit_offset == 32) {
-- 
2.35.1

