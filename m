Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3258F606A32E
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=BOAx50/7;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=bOzWfDHK
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6246D60202;
	Mon,  2 Nov 2026 14:51:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6246D60202
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1793627501;
	bh=+BDDKc4Fo82TfQu52UTaHwsZp5Jsbne7r5tspFIBGbc=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=BOAx50/77Eh5vxTWKIfG+NBagXY4KP6aLoBrPnGQ/8UrQgJLgK84QiFwYgRImGiQ5
	 oJAqRdYW4udQmdTgyJ9JvXMCFzda9uqoE+HZJqRyxlJV9qvMNs5PF/JVQ8kuVXcATg
	 9Zw12BacAyKHsBG00FacmCI5hY2g9iYikXyTtq4U=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D6B09F80604; Mon,  2 Nov 2026 14:51:07 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 4DB95F80600;
	Mon,  2 Nov 2026 14:51:07 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 16586F8014E; Mon,  2 Nov 2026 14:41:17 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 13A04F80095
	for <alsa-devel@alsa-project.org>; Mon,  2 Nov 2026 14:41:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 13A04F80095
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=bOzWfDHK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version:
	Content-Type; bh=+BDDKc4Fo82TfQu52UTaHwsZp5Jsbne7r5tspFIBGbc=;
	b=bOzWfDHK0kLICbRKKRSqeeZKf6mlr7ZACHL4/Zc+q2I0L5MAEsZpg69xlVnydn
	ZaaoiOFyWayujne7hVAceKy1rVm48aIkmJ93ZLFaYp1SSUuBlZRsqUSM+47NfJuk
	AvhI9JvdKrzXWJFIvNdcjFsaWeGMWAuLwE7AzgBszhrrI=
Received: from pan-u.. (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id
 _____wD3__Gf_edqwFRmEw--.60931S2;
	Mon, 02 Nov 2026 11:04:00 +0800 (CST)
From: RenPanpan <rppxj178543@163.com>
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [DISCUSSION] ALSA: usb-audio: Card naming for composite devices
Date: Mon,  2 Nov 2026 11:02:51 +0800
Message-ID: <20261102030359.17222-1-rppxj178543@163.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3__Gf_edqwFRmEw--.60931S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU8xhpUUUUU
X-CM-SenderInfo: huss5yirxykkqt6rljoofrz/xtbC6QA8O2rn-aDp4QAA32
Message-ID-Hash: QCUXA7ENEQ2JPQGMH5AOOFD2P2TRUOIJ
X-Message-ID-Hash: QCUXA7ENEQ2JPQGMH5AOOFD2P2TRUOIJ
X-MailFrom: rppxj178543@163.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/QCUXA7ENEQ2JPQGMH5AOOFD2P2TRUOIJ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

Hi Takashi,

Thank you for taking the patch.

The quirk entry fixes the ALSA card name — cat /proc/asound/cards now
shows "MAXHUB Speaker" instead of the generic "Touch Device". That
resolves the issue for this device.

I will hold off on the general iTerminal approach for composite devices
for now, and revisit it if more devices with the same issue are found.

Thanks again for your time.

Best regards,
RenPanpan

