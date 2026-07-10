Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCB6AC4451C
	for <alsa-devel@archiver.kernel.org>; Sat, 18 Jul 2026 09:39:18 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 03CA26023D;
	Sat, 18 Jul 2026 11:39:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 03CA26023D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1784367557;
	bh=gYKJ+ZDttFlBeD2X43v36ymDeLeo1May/Tctjl3/jYQ=;
	h=From:To:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=BvuTLJfgyd2jHr6F6WCg3C5glX3MUfczuufM7GbWXEAqg1HkZqkghmknOydXaZAD3
	 QuZhYgZxBToXvh/5K7ppBq0EO4V9dgLsH3KqvmGakjjwVgloM3oMXBDz1+7IAY0Mdh
	 4B9mVgyfqrRAE0PDKlZNwQnzEZYwaGLkoADkeNDg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A36D2F8072A; Sat, 18 Jul 2026 11:36:51 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3F64FF8074A;
	Sat, 18 Jul 2026 11:36:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3325AF8057E; Fri, 10 Jul 2026 07:32:16 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1783661535;
	b=XQS9+LD8RxMJMMBt3LOGHABBZ65Ge64ao97ECznQhawRlWmWWjbCEithxP0euLo7ktnJ
	 jAlpOSUYsGYkPrOB75YyWN+hA+Q2WY7+SzjVxfxjB3DdSeU4CS+EQeQVbDush0+d+5dqk
	 Rcj3sEON98ABhnw9olrEprUWq3Qx8DQQ4a7xgLYQjnbhKaRVRfhCtbYbf84fwJ5yypFDi
	 sczvlUaDS/+AhuHjST+NBehhKmYqjiGs/26LYM3CMYzY8sz8y7qDFWORUGwomWrxeYBBl
	 2WCM4FmTwd4cl8aohsqO7Iha26t3yrfQd2RpnOZXCXDAOCSya2WQfuHeP5Y5cvA2r8w==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1783661535;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=gYKJ+ZDttFlBeD2X43v36ymDeLeo1May/Tctjl3/jYQ=;
	b=E3hZPhGZsbsSogA5Ca/CS/tcTxSsSc90L+x9Tnwl5halJlYru2oncRNeoL/RlAnR0ocB
	 qDWSfGD8s3lGmpwcFHkAmly1cEFpGoHRW7SnIqI+ijd3wjhOlRqmBc48NEh/tNYf2zBo8
	 7cbMBEHV0Vcrg/gbaKHwkLX+RmwCnKBZydFiwBCglqZncgYTGi8quGXsNLPo246hFQBOT
	 V9chYaH741jXSgGt/IWJmph3gBo4h+B8ycLOuvEKbxWLH7USCVMB44PA1Dp7dQoIY805a
	 OqkSSZ7cEgCSCG6b/1Guq1w5gAFuigovipfXFbn+Vz/1dh0Gy/yPttLhYLPVyeybrDg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=digiscrypt.com header.i=@digiscrypt.com
 header.a=rsa-sha256 header.s=google header.b=aLJOfoEh;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 4A605F80423
	for <alsa-devel@alsa-project.org>; Fri, 10 Jul 2026 07:32:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4A605F80423
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=digiscrypt.com header.i=@digiscrypt.com
 header.a=rsa-sha256 header.s=google header.b=aLJOfoEh
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-37f9e2642deso86834a91.1
        for <alsa-devel@alsa-project.org>;
 Thu, 09 Jul 2026 22:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digiscrypt.com; s=google; t=1783661532; x=1784266332;
 darn=alsa-project.org;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HvkwVpFJp9sE3tZ/erGARoJxRvPvDK88ZX6KtuBBfOk=;
        b=aLJOfoEhoA4wvGWAYAqm5aBJ7I6RDAieztu9A25Q6SHz0ht0LrKd0XTGQlQtFbffRn
         Mo6N0kqeSVzXjpGzDtosKY3++nw7WkQmB2tCuMNQuTP+bFGYPQz/lkKxCIq3Hl/bHllE
         p8XI++ci3NReesZZwSX2ekXEp4cEZCXBkeXVfVMtSCI8xRTgGY5CDoe15ICTG0eVnaYR
         tqovWm+UcHrI2BSbKavWwpKPT6TEI7UgEhwj1ROOaSDGN3Z+dcWViA/gV/nX5J8gnZnu
         wPY1COizE6B7R0VHLq//LzmKO6w806nr9y87hFjXcuyzEyU4Nw61Nxx0I/nVBnsjFKNr
         vl+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783661532; x=1784266332;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HvkwVpFJp9sE3tZ/erGARoJxRvPvDK88ZX6KtuBBfOk=;
        b=QHkBUY5od5pSMyRfm9UgUZTsJ0tmNtqPEDtbxmcKJrDf8v6wnIq9zYhIt+fuk0tkWN
         yNcDvCMJ0V3SA4j+R7ENzvKxzNxd/2MozYpGvfIAh0oByx353aSmaR8apUt+9VwZJsVb
         XS48T+wi5nggcX5tX5SqstpTBtDq9c/lnhRv41r6adlr2LUKFY1sXD6SaJjbHMUQKSqs
         N1gd0dwdAT43FVUCyVh7irk6g2quiAO5D+3GgYkk8rHPqJmie8B68JwktU8xj1U5ew0c
         cWmcyR5+KZuZeFcc0WiOjeNqUZAw+81HkIXdqYdjP+74tz3Ss5NZ8D9ZGsL2n6kLwlMA
         XJ/g==
X-Gm-Message-State: AOJu0Yx3653LX2635IFHWCa1i/wM52G7geTmLBw9AAsUe/hAZl4tgGU2
	kuHufP5v5iJ1fAZNoNn3iMflmZESzE0UM2a2Z1p4htqBbCc/3N9opvWtNfy3ZMO7gr1RfEWAfnS
	unA+CiZszBE8=
X-Gm-Gg: AfdE7clDoNjCgs6sO3KPDREvt0fSsOxN4fz48RjPTa8iF2RcTtbpU4IjVnkRhWSl0FA
	JhXP20Fu8Wl2u/rGtg74/m778P75n7AmorIoB8KWjtyNSLW0KgfcMqWxKD8sWYfdt2ZlaAkqW1f
	V2WJDd/z54OKYtHq7m34L5SuTSlRbNhuAX8/SEbxjCBbD9X0ITFyH2AxvmXzoEnkpmlAJtQjMhZ
	ue2qvFkvg0n+kafqMrbUAHtTa0rn55upvbombU7ZbPvlL+OsOAmCzJzPmbw8bZbfLpzACM7EmFQ
	LR/NPUJdm5t5cOp3PTQjBSgbpA/zlynciIya+JZWsi8qkkC3yG6sEwW1j3sJAAU9lzeN0XlxbSg
	LDqDxJWeFCsBigCEgVdA/FYNT0FPLL3uWkx+MTfZNqrBung/+pFb2q2D99CscOTg4BQrxBNbu3h
	hw562w/Z/m1VgUXAkwoQ4VU5PMl7UuQQF58DtmNHufvPkn9A87KOicCId7j4G/eSpDwWMLRRyN7
	l4yNptJtcI/M+j8cVI0ojVMy1i+TySRPrgFGjOBfND7/AbkSM3YGXca8KRY+pQvBU6L9k3ssRhJ
	X5jp7GyjrN0WFqYC9uOcof+v/rmEFw==
X-Received: by 2002:a17:90a:e7c4:b0:381:152b:d59d with SMTP id
 98e67ed59e1d1-38a21ce4a8bmr5938820a91.7.1783661531310;
        Thu, 09 Jul 2026 22:32:11 -0700 (PDT)
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 ([2401:4900:1c06:5ddd:7136:4c99:1a8c:2a09])
        by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3117d847e17sm34823942eec.18.2026.07.09.22.32.08
        for <alsa-devel@alsa-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 22:32:10 -0700 (PDT)
From: Sayed Kaif <skaif@digiscrypt.com>
To: alsa-devel@alsa-project.org
Subject: 
 [PATCH] ASoC: SOF: ipc3: validate extended data size before mailbox read
Date: Fri, 10 Jul 2026 11:02:06 +0530
Message-ID: <178366152673.60795.8532044316034947597@digiscrypt.com>
X-CodeOps-Marker: 89de701b92b3424881b9081176765430
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
X-MailFrom: skaif@digiscrypt.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: G253NJFWKCFUHKMGI6K7S6JLSPG75EUB
X-Message-ID-Hash: G253NJFWKCFUHKMGI6K7S6JLSPG75EUB
X-Mailman-Approved-At: Sat, 18 Jul 2026 09:36:47 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/G253NJFWKCFUHKMGI6K7S6JLSPG75EUB/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

ipc3_fw_parse_ext_data() reads the firmware boot extended data from the
DSP mailbox into a fixed PAGE_SIZE buffer. For each SOF_IPC_FW_READY block
it copies ext_hdr->hdr.size - sizeof(*ext_hdr) bytes into ext_data behind
the already-read header via snd_sof_dsp_block_read(), which resolves to
memcpy_fromio() with that length.

hdr.size is supplied by the DSP and is never checked. A block that declares
hdr.size larger than PAGE_SIZE overflows the ext_data heap allocation, and a
block that declares hdr.size smaller than sizeof(*ext_hdr) makes the size_t
length argument underflow to a huge value. Either case corrupts kernel
memory while parsing the firmware ready message.

Reject a block whose declared size does not fit the PAGE_SIZE buffer or is
too small to contain the header before performing the copy.

Signed-off-by: Sayed Kaif <skaif@digiscrypt.com>
---
diff --git a/sound/soc/sof/ipc3.c b/sound/soc/sof/ipc3.c
index 85bb22bbe1..72e8b827ad 100644
--- a/sound/soc/sof/ipc3.c
+++ b/sound/soc/sof/ipc3.c
@@ -598,6 +598,19 @@ static int ipc3_fw_parse_ext_data(struct snd_sof_dev *sdev, u32 offset)
 	ext_hdr = ext_data;
 
 	while (ext_hdr->hdr.cmd == SOF_IPC_FW_READY) {
+		/*
+		 * The ext data is read into the PAGE_SIZE buffer, so the
+		 * firmware-provided size must not exceed it and must be large
+		 * enough to cover the header that was already read.
+		 */
+		if (ext_hdr->hdr.size < sizeof(*ext_hdr) ||
+		    ext_hdr->hdr.size > PAGE_SIZE) {
+			dev_err(sdev->dev, "invalid ext data size 0x%x\n",
+				ext_hdr->hdr.size);
+			ret = -EINVAL;
+			break;
+		}
+
 		/* read in ext structure */
 		snd_sof_dsp_block_read(sdev, SOF_FW_BLK_TYPE_SRAM,
 				       offset + sizeof(*ext_hdr),
-- 
2.52.0
