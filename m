Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5134DC79F99
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Sep 2026 18:41:01 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B4DDB60322;
	Tue,  8 Sep 2026 20:40:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B4DDB60322
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1788892857;
	bh=0fZThvsJiB1SVp88p7xvj4Q2ng8o/do0QgwFtcYm9AY=;
	h=From:To:Cc:Subject:Date:References:List-Id:List-Archive:List-Help:
	 List-Owner:List-Post:List-Subscribe:List-Unsubscribe:From;
	b=N8cLsNaGFwAiz4dUdI5Vz5CVRvJFG6Tb0p+xyBvTb+KIuZTibdDvTERbWI1GYc2rB
	 LQyt8m9bNQEi6HlDwkbymjZ7X4HxrgscNKMFC8cjZ3YohfF+epTiDOROxR+IPdyq9L
	 JtAiOBp9uGe9Jmwu2pQ0i5nnQdSaguez4Pb0wYS4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D8FF4F89701; Tue,  8 Sep 2026 20:36:11 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 752F4F896F7;
	Tue,  8 Sep 2026 20:36:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CC800F804D6; Sun,  6 Sep 2026 09:11:52 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=106.10.244.166
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1788678711;
	b=nrnZK9XMc6E1sv9N2k21Wk4fym5MgZA5/jfb2JCwljVe4EP1O8Z3cvFBL/QB6ZbLBbgu
	 KnXHnIWn/5qbHSmQ+O2CoOIE5wuDmgB4lP6sScLeY9xw2zxdAbVRj8dYwZJRkmLs3AtNM
	 5bEUYPghrfJxpQvbV5x2DwiLFnGAmphcE457L2+lStMV8++9WRJYC+tZJYzLIsRnNHbSA
	 R/PtAY77PCluHVAoFX5KETQINax8EWVxMKE2YcKXXlt+KVDe8Wjscj/L/VFtG9gQBs7j2
	 jDlKUCY8zMlDulel3e123OWFap12cThk7r32K7oUbZicXlSkqF5SP1a00gu8KzReacQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1788678711;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID;
	bh=0fZThvsJiB1SVp88p7xvj4Q2ng8o/do0QgwFtcYm9AY=;
	b=UgZEBUGsBxgMFIcB+DyZ0JqEwaCwKWPQ8hyCtkC2darmwEyZijlgrF+6bFilE5RFZ0Lf
	 s0mqKJlkwGneLtd1KmYmzy0+6yk7FLm9ASLAO2NGw3TtE+2f7bHuVS+rD/Oyiyl1zOaW7
	 qcM7FGBb8bSjNKu+qf2dz1TLfdSvyyVQtxJrE16qpDvZBXXIb4TzGB6wBPA2VuyhK8yxY
	 Rp2i05MmOPZa3Jlg+3+0IdeFyPky0NWgkQev1jw+e0Ob1lZ5Rn5AcJZdeiYA7EXojchaW
	 a8OoqtxLsVlqG/BcAGqbLAfsz6K2xNjM4gtAYovCGARUXanDCKxzbAZ032baw6Msesg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256
 header.s=s2048 header.b=Y8CRXix5;
	arc=none smtp.remote-ip=106.10.244.166
Received: from sonic310-46.consmr.mail.sg3.yahoo.com
 (sonic310-46.consmr.mail.sg3.yahoo.com [106.10.244.166])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id BA367F800C1
	for <alsa-devel@alsa-project.org>; Sun,  6 Sep 2026 09:11:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BA367F800C1
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256
 header.s=s2048 header.b=Y8CRXix5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1788678702; bh=l9zWHxulmZx2cLXTPCewxnXcoi+pUT1U77rBAQVom2w=;
 h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To;
 b=Y8CRXix5LMSe1jbMXZg48IMh8cK3InGIHiGRl9R3gafWspsyRZY2305TCKyMnSAPA9alH3PTVCI9yto4Voh13um2xXcn4GNea+xEAQYxLC0igNWiYKGGUCkPqZu/UY56LNGS+2UuuS4w3dgYEpuqoyxHSyOZ1QN8K3F08vKf1ij9zRDxTAWIeUltng/i6WBilrApVoD4uprvlIUj4c53BnNOGjEH7yAxLFIjdp4d0mg1F4ruJNdHZ9aiV9zT+SicA9X6MA14+R+/4s9vdU0HCldFrERtBUk5GeLmVTEbpwg/7ERETUusAy18mecZ6MHRvR1uWBWPwVojSVuQ++T5dA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1788678702; bh=MmWwPBRmClXDJxBjGEzEnGqvtJHNUeZpnktxMmvAtyd=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=WoCuODK09jF27B1iOrGliJdqc3QB04R6nx4eoxtQhrdZKaco2cYYqwlobZHF/EsBrAgVkPiDHG7KJwKqv6ctfLy/GCOecggiWAxz+lJ1Vz+frQAY8kB2Sm3gwB/IeX/RRZtDQmcDiN4bpS5df+B7Nl7asymhH4troBkJ0xbKfzNh8oHpvq5fXjdMXknwaIgYKtSAjhHdfruyz0zN6bdXMGI3Z4qS0a9RDu7gRNtlvyY6jC9U3cOBOusIkZsqnw9qbGq0HB47c/zOK18R6TenR8MsKOnluLkG/s0RIxb1kvR7+4JxVh6NeJiDiJDlybYxlOCNbSa7RXUbDT+YIrD+qw==
X-YMail-OSG: mA.nyxQVM1lBE5sEC5ACsLpO2NOAs8RmCUT0m7NJ3SXVkZLNJMBSsFe6KotsSre
 2HTJA7RGmJZNW8eUOHztsmnloI2fXjz0uNGMoGZE9LXf1FNjc_gmPZtebPg8jh2YCmYo6CQMlLvy
 75NzLSEai.9BV.DA3mBhRDIvlt.Zr1G7S5n73Kt_vICd3CFYXZMdoyjAH.xFvsjy2734RSNDpvgS
 wlqQ6bFWTWtGmb13NiU3vVmn6IUFO5p2KJklvuXRljr8NR0IygwLvvCS8IEI0yUBkA2HtB1QRL47
 dfu30mB5IuoglyNOvRF6I59fMtusqGonFECvcbA8KG1fUEHAoWmBdJS9k6q.p5ABMk.eIuyQP2aZ
 w2MB__DMo8DLgrhY2RomgID7yqiik2HNT8RzYnfrTl9gIR_nt1HfyxvsnV6dKlGMlPZ.ApLUBveC
 bkkysr.roHq7cZtvebKOd2A31TBiyCuCZgyCvMHcwbwksf1FpRRt6DOXHrTMFFz0zHfoWHmmAISn
 scXzvIuosL_FiDVSs5Jiv_ZisBtEyRqK1Ie4Z0yBGDLlDlxWuXDg9lOxwWDsHJRr_SKomZpC0HzF
 OQXHwvNPXN6IGcdARYZOc_yt7ITs1VDcIjx2Nm9Nob.877.F.yq59jLR.vp1ha79sDPREJAb4p_R
 dk0SNn0C7XyGjl8nFYlG484TgYz_91nOi3fMrESucNHdv_4ef2P9BrGHMZhf74SZ2CX..TRnTuej
 sM_SrH2Ro83b.l_yCSjefLnZloPa1dWQUPH7JDBxX9wB_PMOHRRlyFNMHa88Sr.GYR6AS.GrVZPh
 YUAZYLU7QNdAaUAizK.fTgUj0s1DKL6u4jG98w60ZPA31YFa2HYrVdy_v.9hCDm0UWcN_sYnDTG8
 junPHsv6DZewBDLGTkhq1H6yO2LFVUjUl01oOBJT_VgZBtdmPQhvWXeB9e53CC_7hGCwqQwM0LJg
 9XHB61hEP6g8MVCmoxZwaRIaKLsyMUU5UKgt7tBjZeBIg7gv01D5bRsyyk721RFoYcLvt9pzR6AY
 U92X2RSrZYSVqkjqYTfKa8mN70r2ZnQWl_bkhygFWyqNfAVnAe5qsTIGb6WnuDBQAUctQqCOrK2W
 sOPlmTP4i4hO2sdlMTZOd4VO3Z4xvCNvkxWlm9O3XyZOTlYZvXw..UFaOI60aoZ3M6NZE84Vtp9N
 z85HMuve4ScpuWngtDdrPZfgsSKrb_taIcV4DUCPN36Z7hAURONsshehaBdJdE.TWTdNaOHeX4Ep
 nJU4M3iUUhc3acuRJnQcyj76K7uAg1T40U9_zQeNW79Ukp8nP2A8g4MviXcI74RNKVEjeJImWAES
 rlU1CXhDrlWjLiWS45mFIiA3GbiRBZ3loL.yTHyRpj.2G6xyJOhhfXoD5seJopoB.MNK9FcTjPei
 D0cLC5SIBRFWpMq.cdrcf3nHUdxVV2lYGYeUIFJF8SlX4PkmeAZzC89mfgaphgMXyUcssqs8F_2y
 8EzEv.lbQm7xIJ.zG8bXsYYn_WeerLrGUToaUmtmRLgSQ4JBMX3olkl3iomT_Jhwm9G5saEYa_rr
 yrsbfY.gGjLM9Aob4h79lOF91PcwnX.SQb0ILllWl2Vl0cPnTrnAFy0VyuCL06STlmbpg7GaRuLO
 B19gbb50S7fYfr7rrkqhNu99mGUcBvRSkgK15cH6tvvcyxUsrVGoGZ0An9RbcFH9e4ttm_LPDtmM
 ctvR.5vJPqay7Ykp6LgF3NyeBc2FLANZfL5qXI4hiwtrQ5KirvWYnZ9JvHZjiH_N7di3hVjOJ75v
 OMj7EaZ7irXp9LRHo6ngU1FiEE0HcfsQgpWiMs8GD9faCr9vRlMPt2BbvhBEZTOY4hi1ssrmok5X
 zjrW0hseJyYkCYXY_HHPG8.bW11ml3ptgSJnuAehXMYcd6zDaifmQKykPox4rlB76AKEWl8FCuiF
 0Fpoxbrd0fUSkGzuRzoRFLeqdGTZsxtow9Ho3Nw0woWWiiXfbFPesvPbc9I9Pr4Er7s2qFLf7BFD
 J3oLb4mHIEX65I7EyfQFQgm2q4e4qP3hCUCdHSiqNjqQVk_fChnUBXKk6oXQGWj4_.gr0Sr5nJ.s
 34xTteo6JFfjtxN4_QCO6C6IxrxDf8nqXvTAz9LqCE_8ooIiRSKKVUBQEVmuU0cSJfJBflgQyZJ.
 .bFMowCGHBEAy_7jwO7vwT0xZO3v27XMMwVHWOy6lPfDygdHVbHwYCi3qzu.YotYSersM3T8y5BA
 eYprNgJneJZtw0Jd9C5nVflTckHOw91V16IBHJw--
X-Sonic-MF: <mafiatamilan@yahoo.com>
X-Sonic-ID: cd298061-56d0-4ae7-9e77-8e3d8b9010fd
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic310.consmr.mail.sg3.yahoo.com with HTTP; Sun, 6 Sep 2026 07:11:42 +0000
Received: by hermes--production-sg3-664647588b-52h4b (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID b18fd0aebb47f8ebafacf0df8444bc70;
          Sun, 06 Sep 2026 07:09:41 +0000 (UTC)
From: David <mafiatamilan@yahoo.com>
To: Mark Brown <broonie@kernel.org>,
 Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
 Takashi Iwai <tiwai@suse.de>, linux-sound@vger.kernel.org,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 David <mafiatamilan@yahoo.com>
Subject: [PATCH] ASoC: amd: yc: Fix internal mic for HP board 8C30
Date: Sun, 06 Sep 2026 12:39:39 +0530
Message-ID: <178867857905.85694.5014721659216165123@yahoo.com>
X-Mailer: git-send-email 2.45.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
References: <178867857905.85694.5014721659216165123.ref@yahoo.com>
X-MailFrom: mafiatamilan@yahoo.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: TES5Z4YQRCXL4M5W6AVPIHJT2PCPBATD
X-Message-ID-Hash: TES5Z4YQRCXL4M5W6AVPIHJT2PCPBATD
X-Mailman-Approved-At: Tue, 08 Sep 2026 18:35:32 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/TES5Z4YQRCXL4M5W6AVPIHJT2PCPBATD/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The HP laptop with AMD Ryzen 5 7535HS and ACP 6.x coprocessor (PCI ID
1022:15e2, subsystem 103c:8c30) requires an entry in yc_acp_quirk_table[]
to enable the internal digital microphone (DMIC).

Without this quirk, acp6x_probe() returns -ENODEV and the internal
microphone remains undetected.

Add a DMI quirk matching vendor "HP" and board name "8C30" to enable
ACP DMIC support.

Signed-off-by: David <mafiatamilan@yahoo.com>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 73baa48..0d3304d 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -721,6 +721,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 		.driver_data = &acp6x_card,
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "HP"),
+			DMI_MATCH(DMI_BOARD_NAME, "8C30"),
+		}
+	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "HP"),
 			DMI_MATCH(DMI_BOARD_NAME, "8EE4"),
 		}
 	},
-- 
2.45.0

