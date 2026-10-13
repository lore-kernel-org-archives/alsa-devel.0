Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6A89CC6B10
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Oct 2026 09:58:37 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BE33A60201;
	Tue, 13 Oct 2026 11:58:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BE33A60201
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791885513;
	bh=jD6s030I8OhUIG6dldoOQZD5OeAiaWNv8Jnyq8lDkyc=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=h3ivV0bvPXzBei9vC5ptDjWSL5DK1DXGuFEpYuuDxDSdalaC4IenTEy3iDs/x2Wxm
	 oYFAT1DXn8YuwBXZR2BjizVobtUMZnLMT/moYu3V12AHRbTSRTdE1lWZV8yUvX8h4e
	 V56KtdX7EUuBgxArDng5PL0ORc78zgpgiUrbHXeY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B9349F805FE; Tue, 13 Oct 2026 11:57:55 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9D186F80602;
	Tue, 13 Oct 2026 11:57:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5472FF805A0; Tue, 13 Oct 2026 11:57:47 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=95.85.9.111
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1791885466;
	b=UvYdUdXPh8zL+UrpXsA93GBAu5WiRKKC0zDS0lrX5voaghrM72bp4AFY4EoZ/8Di0OYS
	 AjkrvoevVAjNTq68Q/LdYr3WriyKyhUk3zRgpKYsXanYTCl+pLBh5UeDuOP59HyHfnfSY
	 MmSUclvd1jTMZ2f9/4NAjqVHSmM1GakmUCqhK5fKaDbT3YILedVLVUX2U42OCQ8mmDuAV
	 z9aJheK+6GmsILWY5xHEv1Ulpqm19DT4gfemNuEDCaCkM+SAoGuWNLKj40YRFpfx4NFU/
	 11XgwBsP+556cvPRL0IO/KfMMgUwxgJB+8VdyAfxx4ErvmiH3B6+pEJmMB5feeEb+gA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791885466;
	h=From:To:Subject:Date:Message-ID:Mime-Version;
	bh=jD6s030I8OhUIG6dldoOQZD5OeAiaWNv8Jnyq8lDkyc=;
	b=g3UY7OzfnnE+9PHZMXcDbPtCcE4whzNhRff+RDsReequ/8/haWIiYlWYQZlvzJETk3A2
	 44+3stYJJMSEjbESfgDJAex24U9XHovnq/CAUxrvW/aIZPTJU4WCXF70D4qIVzBcT2EWy
	 hU8mNpj59ENfiuJyzjrLfPVCnE2+tMAFAVniDziVQ5ZP122VIIO77x9xwvTxm6UEaNJ87
	 REOguDCIit2FLhkRW3jrqj6nEWEMBD1TS5+zBix63/ZDbJ/Un7M32zLavIS2FcMYzMYTF
	 nfAV+FObpaMNCxafYB6NFrcwdVfd+QansG8QdmP/wbHLs3XJLREys1Jwxy+kL6TzPXg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=95.85.9.111
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with UTF8SMTPS id 001C0F80448
	for <alsa-devel@alsa-project.org>; Tue, 13 Oct 2026 11:57:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 001C0F80448
Received: from fedori.lan (51b68c74.dsl.pool.telekom.hu
 [::ffff:81.182.140.116])
  (AUTH: PLAIN soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 00000000000C70AA.000000006ACE0097.003393E3;
 Tue, 13 Oct 2026 11:57:43 +0200
From: Gergo Koteles <soyer@irl.hu>
To: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
  Baojun Xu <baojun.xu@ti.com>, Sen Wang <sen@ti.com>,
  Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
  Philipp Oster <philippdev5396@outlook.de>,
  Georg Wenzel <g.wenzel@gmail.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
  alsa-devel@alsa-project.org, Gergo Koteles <soyer@irl.hu>
Subject: [PATCH 0/2] ALSA: hda/tas2781: Skip invalid TAS2563 UEFI calibration
 data
Date: Tue, 13 Oct 2026 11:57:02 +0200
Message-ID: <cover.1791883592.git.soyer@irl.hu>
X-Mailer: git-send-email 2.56.0
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mime-Autoconverted: from 8bit to 7bit by courier 1.0
Message-ID-Hash: KRQBAQ5SQALGR4H7EGTUIQ7IA4CY3BNJ
X-Message-ID-Hash: KRQBAQ5SQALGR4H7EGTUIQ7IA4CY3BNJ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/KRQBAQ5SQALGR4H7EGTUIQ7IA4CY3BNJ/>
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

 sound/hda/codecs/side-codecs/tas2781_hda_i2c.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

-- 
2.56.0

