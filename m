Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86555CA5FA7
	for <alsa-devel@archiver.kernel.org>; Tue, 29 Sep 2026 19:07:05 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BBA8B60253;
	Tue, 29 Sep 2026 21:06:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BBA8B60253
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1790708823;
	bh=eHNgYE1BdIraErQxKLawRC+Z1VdbqupeZ4CgZlyhygI=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=ZQc28ENH5AztnIZQo4EcpBS8Ib5xenAS48tBnHvoLS4GB8L+9Owl3JQhcPXR6YcSD
	 oVDGcIbcv28nVE1TQj4N4hlb9kXjDxtNK916sY25wdzsTDhWEBDx/KhVu9kEDxv3Nx
	 qZbuFe1i4OrLcZ/pgNZIyPxfWKOGudRdU2NRmLqI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0BBE7F806E8; Tue, 29 Sep 2026 21:05:10 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 71B06F806F0;
	Tue, 29 Sep 2026 21:05:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2797EF8057F; Mon, 21 Sep 2026 21:38:01 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=74.125.227.141
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1790019480;
	b=ZRlJ5SIcVMjTsv8/7L+FsJV9QdJhrWp6XO3MCStUycfJqZnGw1VU9zb9tqiCim747TE8
	 iI+oFOHp9Gm91ZeQX+IRVsqVoUQFdUZ3nc4yiwVCsLN0BjN7GenIHRhJpBy7h9u5sjC+6
	 0URJ2/ivitB3q0cqnaer7+bvbz+deKsNkVlhBL+0GwqsB0bnVskM1+bpgcb87j8yhgjar
	 42mhFkKu4GDOAXApLuwqsWToFlS2Qup6dblU4ymQcRZfNyxek2Itf8ehHGXT68GA7Wn3c
	 2pZXh4dG9Ncu6r+/yEzbO0frNWR35vRIoIFPDJhPR0hrk6VqFw7NuuiWXtpFNwaZOOA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1790019480;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=eHNgYE1BdIraErQxKLawRC+Z1VdbqupeZ4CgZlyhygI=;
	b=diRb0tuT8HNDcnnxJR7WAfYOoIVQv94mVcjGLO9/D/ePfxzvZXGJquJv98x7Rvz0PCbt
	 DYSAkvReQAMeUTRBRMDyYMcw8A6de+TFmRqB4kuCPx0CJBkSUoNMGLSetX/nM08PGPhlK
	 VdgIJCljHMn2M8FqLdMH0iFK/9K6fD0TZRKIy0ABFm13wjuPuR8IHPfsKe2OUgefoAc6o
	 OormGYdzRWTqSejaNxnUWxVeuSaU2VgsJO3rVUY8B5bmBL6bOzP9hEBC9M76KM1Zw6zlM
	 fdj8w1G7H8t/xrOqbNiVYaUc4qltKNAngT3fYI8qmRUHVI14SuiZNGyrHpgBU6LVRLg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=trailofbits.com header.i=@trailofbits.com
 header.a=rsa-sha256 header.s=google header.b="Qk3M/p9n";
	arc=none smtp.remote-ip=74.125.227.141
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 0B0F9F804CC
	for <alsa-devel@alsa-project.org>; Mon, 21 Sep 2026 21:37:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0B0F9F804CC
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=trailofbits.com header.i=@trailofbits.com
 header.a=rsa-sha256 header.s=google header.b=Qk3M/p9n
Received: by mail-pj2-f13.google.com with SMTP id
 98e67ed59e1d1-398c066106cso2667428a91.1
        for <alsa-devel@alsa-project.org>;
 Mon, 21 Sep 2026 12:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1790019477; x=1790624277;
 darn=alsa-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=24oiYNmQVTuE9tYr8bmlTOafQfPGTBwHcSANDMCgTuY=;
        b=Qk3M/p9n3AWxrfIU+SvnxpR9woUZFvN48t+eRgwQL/yJs9N6qRfk7ChLj0oL4IBY3d
         45j+12RH9ajqrlTtgcTVMtfhnXWlG2Tc7HuZZh+7TsoKgR3cy6RPH1Py0Jyn+qUTAFZC
         BVvjUZEU87Ilh3tUx3HYbmlwf9sKLOH/VRouQ55YV/TsbPadxFSexvya6Ma+S/W4yKtq
         8Vu0QLSgG1POuFL5p28zy74SpAV8O5MKrhYboW0wa+PwlCVziWJE3wTfT3oYWxjjcdXM
         ZQK04UmiOmB5xjIYWBRFC49zRYp/rpWNkNDWQHtwJV/XQhbRzksNx6KZR9Wla5Iv/648
         7WDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790019477; x=1790624277;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=24oiYNmQVTuE9tYr8bmlTOafQfPGTBwHcSANDMCgTuY=;
        b=vI5D07upqdPyJ80Sqn7YtTc9YtMnnTFGWeHpsLxc89zpcWqAZxBJuuO6TrhqqDvYGQ
         LDQo07ALq1IvJL8qBKi60PUYyLnI1d6tRq3jxYpnZR7reaIAQvfgjAZRcLb/QZ4sNwcH
         Avly9w2Z1GaFK9sM6oMjAvmFeKn3YeX9zXbJXMGn7fMuXToPQz4lgtYSnNq/IpHDXgO+
         JINetC1Avw9//nOj9IHUUywmoqOb2/BdoXHFoAeEw8Yrbs4UlFcBkY2lFnC+8eH08T1L
         cegQXOzCQg04pKhdhww9v8UfskNVNku3Uh9qrwJk5QH7YE1Nol0ek7FQH5gYuW+/FIsx
         0Hrw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwsgd/Pj+uLGtGj4LaxGAofOdKAgGCnyY/fvJVuJ4IEWG2ATUXM+K3AJTWpVwKAVuACz8B4TrVg1jPK@alsa-project.org
X-Gm-Message-State: AFuF++nDaa2MOo11OVmCDx/1IJ2XtY084Qa8uRFzwX3X5lHpkx9KqNRw
	VhhSYkpbBjBnnMyRKaEFirlXASzMW4CtF2BWug8cKM6/jqGvMGjw3E989H583YuiwkU=
X-Gm-Gg: AYBFou3y3oE4g+nDGe2Eu1NcKT9QaboVmxW/Tjvf7gcyw66D6c5c0csd5iXlKtAn5wT
	u3GFEKsj169X5HcT7CkiSQX6HV8a6akuCNkEeITqfqp4MVU/B93tkTlhqkHhxC8xCFQA3ypzoWW
	0NE+A3Q7nnoj/fqTYdW4xzznOPa2eaM4lezANMB0R8DSvbkmBVcmanhVdjbNmyMq4w60y0IwA1I
	iuFHn78l3tVB5gaY4EMEmKVEbDiBzzEWARdD+VNyTtQFQ5NQd+Oni1pr3mwDT6MayoiN/dTo9UG
	FS+xw2dIMefhw+Gef8H3fdQyezW3VICIgCy9PaaYnq4DC37uyILlbn8J/bhRJ4sy7UIH5BaFES0
	DfiPL3tTDzBUwRm6vW8swLeMGg8mNKeBggXGHkZWMwCTyQ9Rps79lOYfyHqLc5VX32sTvJdLp9U
	MMyvv4uAjntlPV8eLCDlC+A+ceUBRLgiuf3xUwLyvXwHxu95wQErW0x0DmcehBlo5QzqzUMB8BL
	ph0ffla3dAi5aUR14wnTTRN9iYvY35wTvF3fSCa+7rTIbLcEHboryyWq9qV/ejo2Y4A8e25TCs2
	TtOQ6Q==
X-Received: by 2002:a17:90b:582b:b0:398:a486:81ec with SMTP id
 98e67ed59e1d1-39e54e3c640mr24749161a91.11.1790019476637;
        Mon, 21 Sep 2026 12:37:56 -0700 (PDT)
Received: from localhost.localdomain
 ([2603:8001:5f01:8bab:289a:f600:f11e:a45c])
        by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33e5ebcdbd8sm288500eec.16.2026.09.21.12.37.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 21 Sep 2026 12:37:56 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	sound-open-firmware@alsa-project.org,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
	Dan Carpenter <error27@gmail.com>
Subject: [PATCH 6.1.y 0/2] ASoC: SOF: backport CVE-2023-54233 to 6.1.y
Date: Mon, 21 Sep 2026 15:37:46 -0400
Message-ID: <20260921193750.82134-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: artem@trailofbits.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: YQQCWWMINHXZG3Q2GESL53GXX3PU7QVX
X-Message-ID-Hash: YQQCWWMINHXZG3Q2GESL53GXX3PU7QVX
X-Mailman-Approved-At: Tue, 29 Sep 2026 19:04:43 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/YQQCWWMINHXZG3Q2GESL53GXX3PU7QVX/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi Greg, Sasha, and SOF maintainers,

I am working through the smaller CVE backports that 6.1.y still needs.
This series handles CVE-2023-54233. Patch 1 adds the missing module-info
guards; patch 2 is its immediate diagnostic follow-up.

The stable tag on patch 1 says 6.2+, but the same unsafe dereference is in
6.1.y. I kept the pair together and did not bring in the later topology
refactors.

Could you please queue this series for 6.1.y?

Thanks,
Artem Dinaburg

AI assistance: An LLM helped find the missing CVE fix, adapt
it, and prepare the draft; I reviewed the code and build output.

Guennadi Liakhovetski (1):
  ASoC: SOF: avoid a NULL dereference with unsupported widgets

Peter Ujfalusi (1):
  ASoC: SOF: ipc4-topology: Clarify bind failure caused by missing
    fw_module

 sound/soc/sof/ipc4-topology.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

-- 
2.39.5

