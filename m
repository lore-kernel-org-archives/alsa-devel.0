Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27FBCCA9EC0
	for <alsa-devel@archiver.kernel.org>; Sat, 10 Oct 2026 19:41:30 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 30A8F601F5;
	Sat, 10 Oct 2026 21:41:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 30A8F601F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791661288;
	bh=2ENKqBaTPDdQhMdT3t9NB4MtzLMzeAWRcMV4ixhE+9M=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=hZKEdbfRlk0wMxavIbi7u/Yl1TH3gVNo3+b1KCU34Ejdre4U75jLctVXdNmx/y0BT
	 8ctYh6ikgGugwXESdgEEhLdyJV6r2znaRdhiQJtLBCIEKqTYtTxNGpedRczo/0sMhK
	 V/ooLa6WqBhZqCbVJT5uWU7l8+tNBjvoFGtlk4KM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D2914F805F5; Sat, 10 Oct 2026 21:40:54 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 44227F805FA;
	Sat, 10 Oct 2026 21:40:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3F753F80579; Thu,  8 Oct 2026 21:01:20 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1791486079;
	b=X5Cu6n8mZgJOW7DLof8oMXhLpA/lylUiZhQkeNCkR0UQVQ4xPC9cziWwA5ryRm97zBmQ
	 sXgWnctmYTpOhkQVTZ6Vq3dPMJm1hxOrlLidXJA80P83oj/5mIJT1J5zUjEAl+oJyOl6v
	 zln9JmeXWFF65yoZ12Bi7LJbUG8t/HumDuBVdnEtQ6CN3+9efY8aFfGLwCF86ll2YD6X8
	 Prpb/LK/lWDH7jNx3knDqyEilxey7f3yBVq3kRy2BMqE1Ni7G7ErdOsAjqcLMRND4oa4x
	 Irrp3G02v0EuxiO4fBoaKCZN/n8TpGoIzQNmXbwygjECVxy3W4seK0EQim83weznM0g==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791486079;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=2ENKqBaTPDdQhMdT3t9NB4MtzLMzeAWRcMV4ixhE+9M=;
	b=rluEy4D3l+IUNPLbdudUG2i3oK8RqnHZDeMEGLkg4eAwtzTX57SZya6dIpYPBNLYJfx4
	 oIvm+hZP38Ic1DnIZtcDkj2U52au4oz0uzxLVBRDL+gA4YtKMgRABESY7yVrF2KYjW798
	 QcPq8t6xr1VPfBcpESQrNpzRPIOyfRplloWdmkFpPjk6ymK8vlG6AEF1//3+fKTgqvH9s
	 A37KxIImu/s9elupngHwq4aAwpS/ZUHR+F+d9u6HlSnKgXPpDxQC0auE+6Tggd2Tz1mkL
	 694C0nW1HZWc2BNZz4Iv1zRQpRd42AFmZ6N9EH1Jj0a8okZmsfHTcAsa7bCaGNHycYQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=trailofbits.com header.i=@trailofbits.com
 header.a=rsa-sha256 header.s=google header.b=ZNIJT1ad;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 793E6F8007E
	for <sound-open-firmware@alsa-project.org>;
 Thu,  8 Oct 2026 21:01:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 793E6F8007E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=trailofbits.com header.i=@trailofbits.com
 header.a=rsa-sha256 header.s=google header.b=ZNIJT1ad
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-33fb4680717so2052475eec.1
        for <sound-open-firmware@alsa-project.org>;
 Thu, 08 Oct 2026 12:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1791486076; x=1792090876;
 darn=alsa-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FggUo6U2laVtXWdbUW1VXActXrfV6jQYFCULV8ijL9s=;
        b=ZNIJT1ad3SHbuk8q7dxNJG+jlwRsjpfcyb51CPrjObd1e0rxSxACEJOpsQ65Ui0i6W
         5wng8RXy5O1+g0eYY50A5lAt2NaKG3Kga+1nDqanJHqHJvaTnDp0zR/zzo0X/vDff9Pf
         4EBHRK2w4K469sHuxw6sgxbu7E/Mkns4L2U4SeNgWJz/Oa5QBEipiKt6ZsDfPlnEwW5D
         w1a32rWX37fZ9CyLPRp2x23YIbEZS/1AWPGShBVzKIkhUMoLE1Fssc6jdIUg02p0nbHx
         rAIvrjK4MrQvWCmDOMVYZ3/MHK/dL2B6j8YU9kLv04X8/I0awXHgu3fHcQC+y7bbzt0Y
         Xr+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791486076; x=1792090876;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FggUo6U2laVtXWdbUW1VXActXrfV6jQYFCULV8ijL9s=;
        b=YYVEfEGFBQldHM+c+Mn3m9rXtVqLjuEfN+z+7RGTb2nyEeTJJrbgrZpUBvsnFnamCq
         MvYFrlw79TEHx7WkrpGM6Q7fwsh2gjP8cDpla4cI2yDi7CUZrg/bIv6IJfpDfrI3Mx50
         +sTZr1fRmir7eju8KqUrsy+2iuuCzXQg7znYMx1Xi8ac96oR+KryJZW2Mun4PYCJoWoJ
         /zrf9A82pqw328hXK1exhungtPSX9YSpyoi3qDFcOiyOD0puwmwcw9GJfQUkky+rSRB+
         eCP3ZRM+3CMitZOyAFrdsLCyfNX53znMgroRVpDMlCeoDMYTAm3hLOI7zCqU+1BuKHWs
         FWEg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwyELnM0XAPN2WG3MDeGxQEJWRyPVj4lhejaszoAvf2C9wtRIXVeaPw4DaAmDlT9qksU9npyH+PWLQUsheu4gSa6woO@alsa-project.org
X-Gm-Message-State: AFq9FYKK9uN9lgDxkU8NcyimIC4SZh6D+sw3swY5EdU6RwIcNJTOus5E
	DhK6Gr6QX+r1NDxezRUiCz4B6P4KNAKem3lE8f02+YwWDriDqQfArT+maqolWylwYMs=
X-Gm-Gg: AYBFou1ro/qQZwjm43r/iitHPcPfdoA+ioPyKNO/h8kkIhSDaIVV32so/oeI63OBjsz
	3s6CzDuB8lky2d4eD3U/ZC5jWJRRL5mZcAhOPH5xbTm3hBgNyIq5VSwCJ5rTwOuVZlKVIecPaBE
	xBDZmWgNMunU3Vk7gE9FBAAU9xcH2Wh5XunIThCCrkrF+qDSMcW3+R8A8Crrgv5R7oVO5HulOaC
	D1qu1oVVlB6T7NjJUBHZG56Yxv/gJHTJGMhLLdVaUO1ArxBQLuNNqAEAbsJgHDiS0G2XqeBogkv
	ZxB5dll4hdeMoNEDOfB16E2GSBc+ZHq5WFNqv2/tIb6T56HYTT6/eRmZaxcGqhIsN2E7rKWr/Er
	zVX5KktrJh98mm/H0FMdaTjKzx8P7trqmUAqpd5U3CEnIWzhDEh9PFiI/Hf38tVvRx57BeiMG/x
	8tJ+aj2o0Jw2UBuKM1Ib9ACUrMxR9Myg//mM0AlLZK7qdchCIZf6S8/gBlve13x2psMFKziyxls
	7qqVwuA4i+uR/UOzu52SLh6GLC9DAVqbx6oQn6esgb7r7DTjh3R5OK8u95EMiWqIoGAzulkW0Pe
	RiYKT4M=
X-Received: by 2002:a05:7301:d194:b0:351:28eb:8cd8 with SMTP id
 5a478bee46e88-3515ddee11cmr7825200eec.18.1791486073803;
        Thu, 08 Oct 2026 12:01:13 -0700 (PDT)
Received: from localhost.localdomain
 ([2603:8001:5f01:8bab:bc88:5ec1:4f8a:5b23])
        by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537b3eccebsm405691eec.12.2026.10.08.12.01.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 Oct 2026 12:01:12 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	=?utf-8?q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	sound-open-firmware@alsa-project.org,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	linux-sound@vger.kernel.org,
	Seppo Ingalsuo <seppo.ingalsuo@linux.intel.com>,
	Liam Girdwood <liam.r.girdwood@intel.com>
Subject: [PATCH 6.6.y 0/2] asoc: backport CVE-2025-21870
Date: Thu,  8 Oct 2026 15:01:02 -0400
Message-ID: <20261008190108.96660-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: artem@trailofbits.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-sound-open-firmware.alsa-project.org-0;
 header-match-sound-open-firmware.alsa-project.org-1; emergency;
 member-moderation
Message-ID-Hash: KRLTJ3JFTSJIQ4RU364XE3UMULCTQQLH
X-Message-ID-Hash: KRLTJ3JFTSJIQ4RU364XE3UMULCTQQLH
X-Mailman-Approved-At: Sat, 10 Oct 2026 19:40:48 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/KRLTJ3JFTSJIQ4RU364XE3UMULCTQQLH/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi Greg, Sasha, and maintainers,

I'm working through the smaller CVE backports still missing from 6.6.y.
These 2 upstream changes belong together for CVE-2025-21870. They must be
applied in this order because the later change depends on or completes the
earlier one.

The complete series is already present in 6.12.y, 6.18.y, and 7.2.y.
These fixes also affect 6.1.y, which will need a separate backport; this
series is only for 6.6.y.

Could you please consider this series for 6.6.y?

Thanks,
Artem Dinaburg

Series:
  1. ASoC: SOF: topology: Parse DAI type token for dspless mode
  2. ASoC: SOF: ipc4-topology: Harden loops for looking up ALH copiers

base: v6.6.157 (79643295eba17affbd16ca97f3ef04c90266b28c) plus stable-queue
revision 958ddf240a33ef26b1771be944f0ea6c3b597472
