Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07018CC6B03
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Oct 2026 13:05:00 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 509EA601FF;
	Tue, 13 Oct 2026 15:04:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 509EA601FF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791896697;
	bh=/+OIcG+CafyzVhe5eezNsS2ymROGZcx58GyFUp1yydg=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=JITAlK9d8/snllowdyRtZO5ll+PiAl9HxP4Ah1CYxXfl7C/pNq/ntO4WVGztgDgPx
	 kOeTKjO4aZCCr3V14mM81sLAd5+6lIpt8TcgHG9XLAHOjY7L2+6dQZBOifUa8sdEI4
	 BN0oiFgEDBcCTvxcuvSYc94fBs0eJCnbCMDd489g=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 211C0F80631; Tue, 13 Oct 2026 15:03:54 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9B058F80631;
	Tue, 13 Oct 2026 15:03:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A56BBF80495; Tue, 13 Oct 2026 15:03:45 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=95.85.9.111
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1791896616;
	b=A96hpAEPaIBWwTI26AjNcqPRji/LaOq8AZKyUJ6z2mXhoWKvizdQ9sTgBSTqwrda4rTD
	 dyKgLx82T2VI4GrmuQnwwGgSwM3Td6+im+FC9oRAz45bBnzjFm+tD38QqpVghytplStNi
	 XEy8TaNU2ph+kxrhAy96HW70niCKRP9xgpGvJqrSY4+TSAcROPAXr8hBzCQ6Kz1yaAa1H
	 nPW3cNgn4pIfH5DovX8dFf/BD2FIaXREq4F780ypvCRiOANapAv+R84qSEs8F4NVrDtSp
	 hiSwRhVk89gAoO71Y8AyD6Xvq/edlhaIP8wfVw9sCg+avQlWI3EQWr3DPKzJO1tNnnQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791896616;
	h=From:To:Subject:Date:Message-ID:Mime-Version;
	bh=/+OIcG+CafyzVhe5eezNsS2ymROGZcx58GyFUp1yydg=;
	b=R8j5UwWdwHDFaJurRgFMtKMhVyzS0lqEtj8PbHHigPPeZERlEfQ5ytSUwEA7x+3GR7Vo
	 M3ub/k9QNmylcAMY3pdBkBDVkxlNcTUvRiuSkMM+9otEYxgjJb30TthvINNO5b+vujvXp
	 Uw4bb5u3AIhot5iuNsy/fuPHMD9PUKlYf2YNPfRj2Hc5KSSilNiLI2gILcF0dLNlJXN/J
	 T0PtwXh1uoYYUV6wgGhaaqqQWQiREKFe6HZRZRxzC+hxmQb4EYdVeaazkL4AuumprAtV+
	 Kz8Q8FpaPPabdmNKCItUTYD3YDBlf3whEjPNJIQ8+xZCVZa/+gQXb7jsnJOHDZapfqw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=95.85.9.111
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with UTF8SMTPS id 30B81F800EE
	for <alsa-devel@alsa-project.org>; Tue, 13 Oct 2026 15:03:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 30B81F800EE
Received: from fedori.lan (51b68c74.dsl.pool.telekom.hu
 [::ffff:81.182.140.116])
  (AUTH: PLAIN soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 00000000000C70AA.000000006ACE2C23.00339CB5;
 Tue, 13 Oct 2026 15:03:31 +0200
From: Gergo Koteles <soyer@irl.hu>
To: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
  Baojun Xu <baojun.xu@ti.com>, Sen Wang <sen@ti.com>,
  Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
  Philipp Oster <philippdev5396@outlook.de>,
  Georg Wenzel <g.wenzel@gmail.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
  alsa-devel@alsa-project.org, Gergo Koteles <soyer@irl.hu>
Subject: [PATCH v2 0/2] ALSA: hda/tas2781: Skip invalid TAS2563 UEFI
 calibration data
Date: Tue, 13 Oct 2026 15:02:19 +0200
Message-ID: <cover.1791895478.git.soyer@irl.hu>
X-Mailer: git-send-email 2.56.0
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mime-Autoconverted: from 8bit to 7bit by courier 1.0
Message-ID-Hash: QAGYJRHPSPPWSQ3IZTX3NRUDJ4IXDXRR
X-Message-ID-Hash: QAGYJRHPSPPWSQ3IZTX3NRUDJ4IXDXRR
X-MailFrom: soyer@irl.hu
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/QAGYJRHPSPPWSQ3IZTX3NRUDJ4IXDXRR/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi,

Georg Wenzel experienced a regession with TAS2563 amplifiers. His laptop 
lacks proper calibration data, and due to a bug, the driver failed to 
apply them in the v6.16.x. That's why they worked.

The amplifiers operate even without calibration data, so the calibration 
setup can be skipped if the data is invalid.

The first patch simplifies error paths in the tas2563_save_calibration() 
function.

The second patch skips the zero UEFI calibration data as it is not 
necessary to apply.

The previous patch for this problem
3bc4fc135ec7 ("ALSA: hda/tas2781: Enable bass speakers support")
should be removed/reverted.

Gergo Koteles (2):
  ALSA: hda/tas2781: Assign total_sz at the end of the function
  ALSA: hda/tas2781: Skip invalid TAS2563 UEFI calibration data

 .../hda/codecs/side-codecs/tas2781_hda_i2c.c  | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

-- 
2.56.0

