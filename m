Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3806CDB46B
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Jun 2026 07:41:32 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3EA82601F6;
	Mon, 22 Jun 2026 09:41:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3EA82601F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1782114089;
	bh=H9tqhbQtiiE4POzraMo21BferQUyWbC39Be1ZIoOL8o=;
	h=From:Date:Subject:To:Cc:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=bMOMj0QnbcUwz7Wr2dK5nvyv65cCWohT2NSmmUQB/fOTe2lnYUG4c8AuQGigMSUDU
	 du2yecWywcf0bkKbGEdt8zZ+/OKiNhp4GTLEDqBpGmh5MrcWYN8lcYgct9ypHqydOL
	 mb5YW1Cq0/f1JjUxC87zlyPNixfXTDEfh60ej5Vw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CA4B8F80600; Mon, 22 Jun 2026 09:40:52 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 45902F80600;
	Mon, 22 Jun 2026 09:40:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1FEF9F804F2; Sat, 13 Jun 2026 16:13:14 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.44
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1781359992;
	b=Wa/jT8cf8dbARxxwi7EpPC5nM3/apIkEGC5WQ9SXAfKQ4zzLjqzJWqScUbXwpU7IkPIc
	 7ssSyDaP3ZTJ04HhbVD7TILyBKDmG7e6ENzWHl1Dmcx523s6PaAU6TfAlR3B8Co4Ewgby
	 Ocbx5D1fua5HzLnfBBix/BMrTON9Dv9evADkt4Tp2tzgsRX6BMN5hAXcxRI4/xPrMi1eJ
	 DvS/NTQHDHduqmn9mI0QQ6VtuNj6rzlvX0us4pQ5TDuPRJnLWl/B4e90ewl4obQuellKA
	 PhIDjTg8BHm32CMuz8EK29YPIGwL6UEVw3vKu07V0sjJZlbEI8KOmsPiUw79rYspFeQ==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1781359992;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To;
	bh=IOHyYLr79bqUc2o8qHGBuqlg6/DpdqqrWfsGN88eeUI=;
	b=T6iPSdqkX18GpB9JwHQEAD1U9YyK4a+oiGUtFKElgTdfL/4E/8CK6kU59gjDz5z63Jf8
	 3I4RxEbQgopZNzcDW1HCAEf1CJwRYvlZZeaZHdSKP1GO8ZRNnt0ZT4YtdCooYVieI6WXQ
	 54xvHkqB5aA/csGJnwzXvOZfTC0Cn+nEJroI4zN3Ne4jDWRHdgn7KGJJxFa6YBBbYWdHG
	 sirMHo1yNBLKl/hl7jtQHFm7b5K+C7PRBs4E6T9AqtCkWXLonsxwwo5y/jyziwvgacwgf
	 3xhyjjktzxnE9vyBcVUgW/vbFmJJ1Q1xuU5DRbn3qlNSVwLecg7Z0oS/km70mTZDd9g==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=bKx5LIfi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.44
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com
 [74.125.224.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 617A2F8015B
	for <alsa-devel@alsa-project.org>; Sat, 13 Jun 2026 16:13:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 617A2F8015B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=bKx5LIfi
Received: by mail-yx1-f44.google.com with SMTP id
 956f58d0204a3-6603246b66dso1981767d50.1
        for <alsa-devel@alsa-project.org>;
 Sat, 13 Jun 2026 07:13:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781359989; cv=none;
        d=google.com; s=arc-20240605;
        b=GGXKTbOfyf9O9gVxgjtkAh++xwcDgqoq1SPbgDbNznDwTo2Ixe+VbQkSFKr7f9CCO2
         f1BwRPxgjL5XXcszspzSR/Q8E02zoiQJlKnuDBZuAMMmcbU81R2e4VhfC/WKPgCIG2dK
         qryh8u7utpPrvZ2FztbMoFh+NtzUVL9pHg9NJIjrm4dNdg2Kn6u4gUWzHgLVAYebtjFs
         awkYAFttRwGbfmLwBkNMuf+LSPnyXZ2CYYKNzNUh75lwPopjYlqfb64l6Gze8irzBdTp
         smZZlqkjObP2/rPQouqhOHYyA62Xo7+VAKFFdFqeJQGiHh1b/Oc5XcJToHgScu+PnJ5f
         iakg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=6wDqtqupnEPZSvQJqXTCwRofUEAIOKhjWLYOXxWfhEc=;
        fh=ZmzfaBnzubu8F1ml2TDX9kkQZVyRCkO74tlTsYk/+ro=;
        b=TQqomYdSfRsdWHVjzysM2RDKGB66qMAWczl7YFgNyUuocFMMIqno1JykZ4cTODf6Bb
         VQfCSYRu0Y9UHH2miV6MnAPSDVci5dvJoWROqHCLGNOmz5hEmpOQt0sE+wRNHRJYf+/8
         XalujKGWhG3U/PqANCHT1mjkeJcTZqnnVKOdV5ZCNBbLliBYeqpbQwQGC+WAuz2M12BO
         P6rU1C+Yjhrv/YxCRN6/QlZQj37pKLFm/0WIGpQit1cEXlX4FMHIOXxIIiBa1hPwvCzi
         gCbBlVffaZwvK5zZ+Yr4ezRh48pTMZweje4IxzKvn4upJNoJ00ELYYealEPMYse7/BSV
         oHNA==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781359989; x=1781964789;
 darn=alsa-project.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6wDqtqupnEPZSvQJqXTCwRofUEAIOKhjWLYOXxWfhEc=;
        b=bKx5LIfi5dHz2qukG5puZi0rJphJmm016jU4289uQmgvHASgrfxiGaUi7HAILDF/el
         KXNl79caVbbDoiMRczw6sLaQ3UsWlecY/vfK3tgw+kuPZ4OoEksO1lFxAqm96TCZzA0R
         JPvBDWNclWcDDWgS/OUA2CB0wxaGXFrNUTsYaS0OyzXhvvquSffkRHRwrhsW6xv3qlvB
         e/Ki5UB0rOrM6D0lWGw6fMjH3OX4n0eyO3X6JmuIjt07GtOUE+y0dfKe56yRWVtFrmb8
         Ycod1VrIt3GU0Ku7JG+56E4dt5yQYY67yyU6N5uV124GbSDhyvZcDaJIPO+S7ivdJD9F
         AmwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781359989; x=1781964789;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6wDqtqupnEPZSvQJqXTCwRofUEAIOKhjWLYOXxWfhEc=;
        b=bQPzguDUKKDXLoCC2wViAxZ1gMw5MkSA4eFIExw4F1dn++em7C9WQR2IlOFUYqyazO
         HebWhx2JzkIbFJEbJfeAgOsZaboKqhJ/BJQnUp5m0xZgTeY5sRvuL0GnYp1MQgIPK7+H
         w4WYkl67mjjHmxDd/X2FnpR4Th0e8hx0Ee9GZSU4gBfGiPglUOvKP2z7BFmEy+rty1c/
         5/BcBNj+kG7/ROdf3QqjcdkFGH7AahWs/G6THd4ctT/7ZAprF606EtDAN19uOOkegklG
         KON2RofaM4VHrrWOb2a3I4mn3AKwD2QBZN7a1RoXdcxYAKOMDjEAzM+FiOjQr0FgSABN
         l1kg==
X-Gm-Message-State: AOJu0YzBohQCF8RdRGfJv1rCht2KYtUikJbToZeNvQOYQi0vi0DrBnNC
	0mGLNw8lZG1BvEtZFRjfopQAJGsPfdy3/9Ov++vv97tDQd1nQChZUXXJSSb4QyH4CFSdrXbnyMz
	gPzoLUECFP0Mu26XLq5AkPUn9O/aMX/Q=
X-Gm-Gg: Acq92OEX8JgS86XZJk57gexeBZtr/ETNkknF0SOXk5ZqcyMmge6qUBnY8Fuqi0ZMlHb
	utUugwXkO5sqRGApQeSEXpQwUyyBuS2xqA2d5mIT6sL7GItSwAbcAjL9A++L953ofgP+N61GJ0w
	vBcJq+sMziFx0VeQGh8LhTgP6r/0ObIoZ+F3Bvt2jsgzbpeDHFIGMhHY2tKQi9TsUwmdbFfza8Y
	A28E31AYiiiyV1L/vh5DmTqfn+P4M6wVdLJ7lPxaCJcInpyvTvQq20hRJvco2P1PrNllrQRVgUq
	m2iOjZlj3M7qbvf9hA==
X-Received: by 2002:a05:690e:4410:b0:65e:5aa3:9640 with SMTP id
 956f58d0204a3-66277ff4d0bmr3985949d50.25.1781359989372; Sat, 13 Jun 2026
 07:13:09 -0700 (PDT)
MIME-Version: 1.0
From: Msh <mshharish0234@gmail.com>
Date: Sat, 13 Jun 2026 19:42:57 +0530
X-Gm-Features: AVVi8CeDB73Yj5z7xLgaBAk_yu7L9uFvCD9IGDUNxfiSy8DvfqN5MhZ81Ujsdwk
Message-ID: 
 <CAMcthxYWbQY8tuUBg4g6oSgFsMK=XUnJxN3-8ZSKH+Q1oxObLg@mail.gmail.com>
Subject: [PATCH] ALSA: hda/realtek: Fix speaker pin routing for HP Pavilion
 Gaming 15 (103c:8742)
To: tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org
Content-Type: multipart/mixed; boundary="0000000000006272d10654233134"
X-MailFrom: mshharish0234@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: N43LDPHS7PK4NSJV4X3TQQMGPLJRAYVQ
X-Message-ID-Hash: N43LDPHS7PK4NSJV4X3TQQMGPLJRAYVQ
X-Mailman-Approved-At: Mon, 22 Jun 2026 07:40:47 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/N43LDPHS7PK4NSJV4X3TQQMGPLJRAYVQ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

--0000000000006272d10654233134
Content-Type: text/plain; charset="UTF-8"

Greetings,

I want to report a missing speaker quirk for the HP Pavilion Gaming
Laptop 15-dk1xxx. Right now, the internal audio sounds very thin and
tinny on Linux.

== Hardware Info ==
Laptop: HP Pavilion Gaming Laptop 15-dk1xxx
Codec: Realtek ALC285
Subsystem ID: 103c:8742

== The Issue ==
By default, dmesg shows line_outs=1 and only uses pin 0x14.
When looking at the raw codec dump, Node 0x17 (the internal bass/mid
speakers) is marked as disabled or disconnected by the default factory
firmware:
-------------------------------------
Node 0x17 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
-------------------------------------
Because of this 0x411111f0 value, the driver leaves the internal
woofers completely turned off.

== The Fix ==
I fixed this by creating a manual firmware patch in hda-jack-retask.fw
to force Node 0x17 to act as an internal speaker:
-------------------------------------
[codec]
0x808606c8 0x103c8742 0

[pincfg]
0x14 0x90170110
0x17 0x90170115
-------------------------------------
After doing this, dmesg updates to line_outs=2 (0x14/0x17/0x0/0x0/0x0)
type:speaker. Both the tweeters and woofers fire together, and the
laptop audio finally sounds full and normal.
I have attached the original, clean codec dump file
(hp_pavilion_alc285_codec.txt) from /proc/asound/card0/codec#0 before
any overrides were applied.
Hopefully, a maintainer can add this subsystem ID (103c:8742) and the
pin table fix into sound/pci/hda/patch_realtek.c so it works out of
the box for everyone in the next kernel releases.

Note: I am just a user, not a software engineer or a native English
speaker. I used an AI tools to help me read my terminal logs,
understand the codec dump, and find the correct pin values to fix my
laptop audio. I am sharing these verified hardware details so the
developers can easily implement the patch.

--
Best Regards,
MSH

--0000000000006272d10654233134
Content-Type: text/plain; charset="US-ASCII";
 name="hp_pavilion_alc285_codec.txt"
Content-Disposition: attachment; filename="hp_pavilion_alc285_codec.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_mqcfdq8q0>
X-Attachment-Id: f_mqcfdq8q0

Q29kZWM6IFJlYWx0ZWsgQUxDMjg1CkFkZHJlc3M6IDAKQUZHIEZ1bmN0aW9uIElkOiAweDEgKHVu
c29sIDEpClZlbmRvciBJZDogMHgxMGVjMDI4NQpTdWJzeXN0ZW0gSWQ6IDB4MTAzYzg3NDIKUmV2
aXNpb24gSWQ6IDB4MTAwMDAyCk5vIE1vZGVtIEZ1bmN0aW9uIEdyb3VwIGZvdW5kCkRlZmF1bHQg
UENNOgogICAgcmF0ZXMgWzB4NTYwXTogNDQxMDAgNDgwMDAgOTYwMDAgMTkyMDAwCiAgICBiaXRz
IFsweGVdOiAxNiAyMCAyNAogICAgZm9ybWF0cyBbMHgxXTogUENNCkRlZmF1bHQgQW1wLUluIGNh
cHM6IE4vQQpEZWZhdWx0IEFtcC1PdXQgY2FwczogTi9BClN0YXRlIG9mIEFGRyBub2RlIDB4MDE6
CiAgUG93ZXIgc3RhdGVzOiAgRDAgRDEgRDIgRDMgRDNjb2xkIENMS1NUT1AgRVBTUwogIFBvd2Vy
OiBzZXR0aW5nPUQwLCBhY3R1YWw9RDAKR1BJTzogaW89Mywgbz0wLCBpPTAsIHVuc29saWNpdGVk
PTEsIHdha2U9MAogIElPWzBdOiBlbmFibGU9MCwgZGlyPTAsIHdha2U9MCwgc3RpY2t5PTAsIGRh
dGE9MCwgdW5zb2w9MAogIElPWzFdOiBlbmFibGU9MCwgZGlyPTAsIHdha2U9MCwgc3RpY2t5PTAs
IGRhdGE9MCwgdW5zb2w9MAogIElPWzJdOiBlbmFibGU9MCwgZGlyPTAsIHdha2U9MCwgc3RpY2t5
PTAsIGRhdGE9MCwgdW5zb2w9MApOb2RlIDB4MDIgW0F1ZGlvIE91dHB1dF0gd2NhcHMgMHg0MWQ6
IFN0ZXJlbyBBbXAtT3V0CiAgQ29udHJvbDogbmFtZT0iU3BlYWtlciBQbGF5YmFjayBWb2x1bWUi
LCBpbmRleD0wLCBkZXZpY2U9MAogICAgQ29udHJvbEFtcDogY2hzPTMsIGRpcj1PdXQsIGlkeD0w
LCBvZnM9MAogIERldmljZTogbmFtZT0iQUxDMjg1IEFuYWxvZyIsIHR5cGU9IkF1ZGlvIiwgZGV2
aWNlPTAKICBBbXAtT3V0IGNhcHM6IG9mcz0weDU3LCBuc3RlcHM9MHg1Nywgc3RlcHNpemU9MHgw
MiwgbXV0ZT0wCiAgQW1wLU91dCB2YWxzOiAgWzB4NTQgMHg1NF0KICBDb252ZXJ0ZXI6IHN0cmVh
bT0xLCBjaGFubmVsPTAKICBQQ006CiAgICByYXRlcyBbMHg0MF06IDQ4MDAwCiAgICBiaXRzIFsw
eGVdOiAxNiAyMCAyNAogICAgZm9ybWF0cyBbMHgxXTogUENNCiAgUG93ZXIgc3RhdGVzOiAgRDAg
RDEgRDIgRDMgRVBTUwogIFBvd2VyOiBzZXR0aW5nPUQwLCBhY3R1YWw9RDAKTm9kZSAweDAzIFtB
dWRpbyBPdXRwdXRdIHdjYXBzIDB4NDFkOiBTdGVyZW8gQW1wLU91dAogIENvbnRyb2w6IG5hbWU9
IkhlYWRwaG9uZSBQbGF5YmFjayBWb2x1bWUiLCBpbmRleD0wLCBkZXZpY2U9MAogICAgQ29udHJv
bEFtcDogY2hzPTMsIGRpcj1PdXQsIGlkeD0wLCBvZnM9MAogIEFtcC1PdXQgY2Fwczogb2ZzPTB4
NTcsIG5zdGVwcz0weDU3LCBzdGVwc2l6ZT0weDAyLCBtdXRlPTAKICBBbXAtT3V0IHZhbHM6ICBb
MHgwMCAweDAwXQogIENvbnZlcnRlcjogc3RyZWFtPTEsIGNoYW5uZWw9MAogIFBDTToKICAgIHJh
dGVzIFsweDQwXTogNDgwMDAKICAgIGJpdHMgWzB4ZV06IDE2IDIwIDI0CiAgICBmb3JtYXRzIFsw
eDFdOiBQQ00KICBQb3dlciBzdGF0ZXM6ICBEMCBEMSBEMiBEMyBFUFNTCiAgUG93ZXI6IHNldHRp
bmc9RDAsIGFjdHVhbD1EMApOb2RlIDB4MDQgW1ZlbmRvciBEZWZpbmVkIFdpZGdldF0gd2NhcHMg
MHhmMDAwMDA6IE1vbm8KTm9kZSAweDA1IFtWZW5kb3IgRGVmaW5lZCBXaWRnZXRdIHdjYXBzIDB4
ZjAwMDAwOiBNb25vCk5vZGUgMHgwNiBbQXVkaW8gT3V0cHV0XSB3Y2FwcyAweDQxMTogU3RlcmVv
CiAgQ29udmVydGVyOiBzdHJlYW09MSwgY2hhbm5lbD0wCiAgUENNOgogICAgcmF0ZXMgWzB4NDBd
OiA0ODAwMAogICAgYml0cyBbMHhlXTogMTYgMjAgMjQKICAgIGZvcm1hdHMgWzB4MV06IFBDTQog
IFBvd2VyIHN0YXRlczogIEQwIEQxIEQyIEQzIEVQU1MKICBQb3dlcjogc2V0dGluZz1EMCwgYWN0
dWFsPUQwCk5vZGUgMHgwNyBbQXVkaW8gSW5wdXRdIHdjYXBzIDB4MTAwNTFiOiBTdGVyZW8gQW1w
LUluCiAgQW1wLUluIGNhcHM6IG9mcz0weDE3LCBuc3RlcHM9MHgzZiwgc3RlcHNpemU9MHgwMiwg
bXV0ZT0xCiAgQW1wLUluIHZhbHM6ICBbMHg5NyAweDk3XQogIENvbnZlcnRlcjogc3RyZWFtPTAs
IGNoYW5uZWw9MAogIFNESS1TZWxlY3Q6IDAKICBQQ006CiAgICByYXRlcyBbMHg0MF06IDQ4MDAw
CiAgICBiaXRzIFsweGVdOiAxNiAyMCAyNAogICAgZm9ybWF0cyBbMHgxXTogUENNCiAgUG93ZXIg
c3RhdGVzOiAgRDAgRDEgRDIgRDMgRVBTUwogIFBvd2VyOiBzZXR0aW5nPUQwLCBhY3R1YWw9RDAK
ICBDb25uZWN0aW9uOiAxCiAgICAgMHgyNApOb2RlIDB4MDggW0F1ZGlvIElucHV0XSB3Y2FwcyAw
eDEwMDUxYjogU3RlcmVvIEFtcC1JbgogIENvbnRyb2w6IG5hbWU9IkNhcHR1cmUgVm9sdW1lIiwg
aW5kZXg9MCwgZGV2aWNlPTAKICAgIENvbnRyb2xBbXA6IGNocz0zLCBkaXI9SW4sIGlkeD0wLCBv
ZnM9MAogIENvbnRyb2w6IG5hbWU9IkNhcHR1cmUgU3dpdGNoIiwgaW5kZXg9MCwgZGV2aWNlPTAK
ICAgIENvbnRyb2xBbXA6IGNocz0zLCBkaXI9SW4sIGlkeD0wLCBvZnM9MAogIERldmljZTogbmFt
ZT0iQUxDMjg1IEFuYWxvZyIsIHR5cGU9IkF1ZGlvIiwgZGV2aWNlPTAKICBBbXAtSW4gY2Fwczog
b2ZzPTB4MTcsIG5zdGVwcz0weDNmLCBzdGVwc2l6ZT0weDAyLCBtdXRlPTEKICBBbXAtSW4gdmFs
czogIFsweDNmIDB4M2ZdCiAgQ29udmVydGVyOiBzdHJlYW09MCwgY2hhbm5lbD0wCiAgU0RJLVNl
bGVjdDogMAogIFBDTToKICAgIHJhdGVzIFsweDU2MF06IDQ0MTAwIDQ4MDAwIDk2MDAwIDE5MjAw
MAogICAgYml0cyBbMHhlXTogMTYgMjAgMjQKICAgIGZvcm1hdHMgWzB4MV06IFBDTQogIFBvd2Vy
IHN0YXRlczogIEQwIEQxIEQyIEQzIEVQU1MKICBQb3dlcjogc2V0dGluZz1EMCwgYWN0dWFsPUQw
CiAgQ29ubmVjdGlvbjogMQogICAgIDB4MjMKTm9kZSAweDA5IFtBdWRpbyBJbnB1dF0gd2NhcHMg
MHgxMDA1MWI6IFN0ZXJlbyBBbXAtSW4KICBBbXAtSW4gY2Fwczogb2ZzPTB4MTcsIG5zdGVwcz0w
eDNmLCBzdGVwc2l6ZT0weDAyLCBtdXRlPTEKICBBbXAtSW4gdmFsczogIFsweDk3IDB4OTddCiAg
Q29udmVydGVyOiBzdHJlYW09MCwgY2hhbm5lbD0wCiAgU0RJLVNlbGVjdDogMAogIFBDTToKICAg
IHJhdGVzIFsweDU2MF06IDQ0MTAwIDQ4MDAwIDk2MDAwIDE5MjAwMAogICAgYml0cyBbMHhlXTog
MTYgMjAgMjQKICAgIGZvcm1hdHMgWzB4MV06IFBDTQogIFBvd2VyIHN0YXRlczogIEQwIEQxIEQy
IEQzIEVQU1MKICBQb3dlcjogc2V0dGluZz1EMCwgYWN0dWFsPUQwCiAgQ29ubmVjdGlvbjogMQog
ICAgIDB4MjIKTm9kZSAweDBhIFtWZW5kb3IgRGVmaW5lZCBXaWRnZXRdIHdjYXBzIDB4ZjAwMDAw
OiBNb25vCk5vZGUgMHgwYiBbVmVuZG9yIERlZmluZWQgV2lkZ2V0XSB3Y2FwcyAweGYwMDAwMDog
TW9ubwpOb2RlIDB4MGMgW1ZlbmRvciBEZWZpbmVkIFdpZGdldF0gd2NhcHMgMHhmMDAwMDA6IE1v
bm8KTm9kZSAweDBkIFtWZW5kb3IgRGVmaW5lZCBXaWRnZXRdIHdjYXBzIDB4ZjAwMDAwOiBNb25v
Ck5vZGUgMHgwZSBbVmVuZG9yIERlZmluZWQgV2lkZ2V0XSB3Y2FwcyAweGYwMDAwMDogTW9ubwpO
b2RlIDB4MGYgW1ZlbmRvciBEZWZpbmVkIFdpZGdldF0gd2NhcHMgMHhmMDAwMDA6IE1vbm8KTm9k
ZSAweDEwIFtWZW5kb3IgRGVmaW5lZCBXaWRnZXRdIHdjYXBzIDB4ZjAwMDAwOiBNb25vCk5vZGUg
MHgxMSBbVmVuZG9yIERlZmluZWQgV2lkZ2V0XSB3Y2FwcyAweGYwMDAwMDogTW9ubwpOb2RlIDB4
MTIgW1BpbiBDb21wbGV4XSB3Y2FwcyAweDQwMDQwYjogU3RlcmVvIEFtcC1JbgogIENvbnRyb2w6
IG5hbWU9IkludGVybmFsIE1pYyBCb29zdCBWb2x1bWUiLCBpbmRleD0wLCBkZXZpY2U9MAogICAg
Q29udHJvbEFtcDogY2hzPTMsIGRpcj1JbiwgaWR4PTAsIG9mcz0wCiAgQW1wLUluIGNhcHM6IG9m
cz0weDAwLCBuc3RlcHM9MHgwMywgc3RlcHNpemU9MHgyNywgbXV0ZT0wCiAgQW1wLUluIHZhbHM6
ICBbMHgwMyAweDAzXQogIFBpbmNhcCAweDAwMDAwMDIwOiBJTgogIFBpbiBEZWZhdWx0IDB4Yjdh
NjAxYzA6IFtGaXhlZF0gTWljIGF0IE90aCBNb2JpbGUtSW4KICAgIENvbm4gPSBEaWdpdGFsLCBD
b2xvciA9IFVua25vd24KICAgIERlZkFzc29jaWF0aW9uID0gMHhjLCBTZXF1ZW5jZSA9IDB4MAog
ICAgTWlzYyA9IE5PX1BSRVNFTkNFCiAgUGluLWN0bHM6IDB4MjA6IElOCiAgUG93ZXIgc3RhdGVz
OiAgRDAgRDEgRDIgRDMgRVBTUwogIFBvd2VyOiBzZXR0aW5nPUQwLCBhY3R1YWw9RDAKTm9kZSAw
eDEzIFtQaW4gQ29tcGxleF0gd2NhcHMgMHg0MDA0MGI6IFN0ZXJlbyBBbXAtSW4KICBBbXAtSW4g
Y2Fwczogb2ZzPTB4MDAsIG5zdGVwcz0weDAzLCBzdGVwc2l6ZT0weDI3LCBtdXRlPTAKICBBbXAt
SW4gdmFsczogIFsweDAwIDB4MDBdCiAgUGluY2FwIDB4MDAwMDAwMjA6IElOCiAgUGluIERlZmF1
bHQgMHg0MDAwMDAwMDogW04vQV0gTGluZSBPdXQgYXQgRXh0IE4vQQogICAgQ29ubiA9IFVua25v
d24sIENvbG9yID0gVW5rbm93bgogICAgRGVmQXNzb2NpYXRpb24gPSAweDAsIFNlcXVlbmNlID0g
MHgwCiAgUGluLWN0bHM6IDB4MDA6CiAgUG93ZXIgc3RhdGVzOiAgRDAgRDEgRDIgRDMgRVBTUwog
IFBvd2VyOiBzZXR0aW5nPUQwLCBhY3R1YWw9RDAKTm9kZSAweDE0IFtQaW4gQ29tcGxleF0gd2Nh
cHMgMHg0MDA1OGQ6IFN0ZXJlbyBBbXAtT3V0CiAgQ29udHJvbDogbmFtZT0iU3BlYWtlciBQbGF5
YmFjayBTd2l0Y2giLCBpbmRleD0wLCBkZXZpY2U9MAogICAgQ29udHJvbEFtcDogY2hzPTMsIGRp
cj1PdXQsIGlkeD0wLCBvZnM9MAogIEFtcC1PdXQgY2Fwczogb2ZzPTB4MDAsIG5zdGVwcz0weDAw
LCBzdGVwc2l6ZT0weDAwLCBtdXRlPTEKICBBbXAtT3V0IHZhbHM6ICBbMHgwMCAweDAwXQogIFBp
bmNhcCAweDAwMDEwMDE0OiBPVVQgRUFQRCBEZXRlY3QKICBFQVBEIDB4MjogRUFQRAogIFBpbiBE
ZWZhdWx0IDB4OTAxNzAxMTA6IFtGaXhlZF0gU3BlYWtlciBhdCBJbnQgTi9BCiAgICBDb25uID0g
QW5hbG9nLCBDb2xvciA9IFVua25vd24KICAgIERlZkFzc29jaWF0aW9uID0gMHgxLCBTZXF1ZW5j
ZSA9IDB4MAogICAgTWlzYyA9IE5PX1BSRVNFTkNFCiAgUGluLWN0bHM6IDB4NDA6IE9VVAogIFVu
c29saWNpdGVkOiB0YWc9MDAsIGVuYWJsZWQ9MAogIFBvd2VyIHN0YXRlczogIEQwIEQxIEQyIEQz
IEVQU1MKICBQb3dlcjogc2V0dGluZz1EMCwgYWN0dWFsPUQwCiAgQ29ubmVjdGlvbjogMQogICAg
IDB4MDIKTm9kZSAweDE1IFtWZW5kb3IgRGVmaW5lZCBXaWRnZXRdIHdjYXBzIDB4ZjAwMDAwOiBN
b25vCk5vZGUgMHgxNiBbUGluIENvbXBsZXhdIHdjYXBzIDB4NDAwNThkOiBTdGVyZW8gQW1wLU91
dAogIEFtcC1PdXQgY2Fwczogb2ZzPTB4MDAsIG5zdGVwcz0weDAwLCBzdGVwc2l6ZT0weDAwLCBt
dXRlPTEKICBBbXAtT3V0IHZhbHM6ICBbMHg4MCAweDgwXQogIFBpbmNhcCAweDAwMDAwMDFjOiBP
VVQgSFAgRGV0ZWN0CiAgUGluIERlZmF1bHQgMHg0MTExMTFmMDogW04vQV0gU3BlYWtlciBhdCBF
eHQgUmVhcgogICAgQ29ubiA9IDEvOCwgQ29sb3IgPSBCbGFjawogICAgRGVmQXNzb2NpYXRpb24g
PSAweGYsIFNlcXVlbmNlID0gMHgwCiAgICBNaXNjID0gTk9fUFJFU0VOQ0UKICBQaW4tY3Rsczog
MHgwMDoKICBVbnNvbGljaXRlZDogdGFnPTAwLCBlbmFibGVkPTAKICBQb3dlciBzdGF0ZXM6ICBE
MCBEMSBEMiBEMyBFUFNTCiAgUG93ZXI6IHNldHRpbmc9RDAsIGFjdHVhbD1EMAogIENvbm5lY3Rp
b246IDIKICAgICAweDAyKiAweDAzCk5vZGUgMHgxNyBbUGluIENvbXBsZXhdIHdjYXBzIDB4NDAw
NThkOiBTdGVyZW8gQW1wLU91dAogIENvbnRyb2w6IG5hbWU9IkJhc3MgU3BlYWtlciBQbGF5YmFj
ayBTd2l0Y2giLCBpbmRleD0wLCBkZXZpY2U9MAogICAgQ29udHJvbEFtcDogY2hzPTMsIGRpcj1P
dXQsIGlkeD0wLCBvZnM9MAogIEFtcC1PdXQgY2Fwczogb2ZzPTB4MDAsIG5zdGVwcz0weDAwLCBz
dGVwc2l6ZT0weDAwLCBtdXRlPTEKICBBbXAtT3V0IHZhbHM6ICBbMHgwMCAweDAwXQogIFBpbmNh
cCAweDAwMDAwMDFjOiBPVVQgSFAgRGV0ZWN0CiAgUGluIERlZmF1bHQgMHg0MTExMTFmMDogW04v
QV0gU3BlYWtlciBhdCBFeHQgUmVhcgogICAgQ29ubiA9IDEvOCwgQ29sb3IgPSBCbGFjawogICAg
RGVmQXNzb2NpYXRpb24gPSAweGYsIFNlcXVlbmNlID0gMHgwCiAgICBNaXNjID0gTk9fUFJFU0VO
Q0UKICBQaW4tY3RsczogMHg0MDogT1VUCiAgVW5zb2xpY2l0ZWQ6IHRhZz0wMCwgZW5hYmxlZD0w
CiAgUG93ZXIgc3RhdGVzOiAgRDAgRDEgRDIgRDMgRVBTUwogIFBvd2VyOiBzZXR0aW5nPUQwLCBh
Y3R1YWw9RDAKICBDb25uZWN0aW9uOiAzCiAgICAgMHgwMiAweDAzIDB4MDYqCk5vZGUgMHgxOCBb
UGluIENvbXBsZXhdIHdjYXBzIDB4NDAwNDhiOiBTdGVyZW8gQW1wLUluCiAgQW1wLUluIGNhcHM6
IG9mcz0weDAwLCBuc3RlcHM9MHgwMywgc3RlcHNpemU9MHgyNywgbXV0ZT0wCiAgQW1wLUluIHZh
bHM6ICBbMHgwMCAweDAwXQogIFBpbmNhcCAweDAwMDAwMDI0OiBJTiBEZXRlY3QKICBQaW4gRGVm
YXVsdCAweDQxMTExMWYwOiBbTi9BXSBTcGVha2VyIGF0IEV4dCBSZWFyCiAgICBDb25uID0gMS84
LCBDb2xvciA9IEJsYWNrCiAgICBEZWZBc3NvY2lhdGlvbiA9IDB4ZiwgU2VxdWVuY2UgPSAweDAK
ICAgIE1pc2MgPSBOT19QUkVTRU5DRQogIFBpbi1jdGxzOiAweDAwOgogIFVuc29saWNpdGVkOiB0
YWc9MDAsIGVuYWJsZWQ9MAogIFBvd2VyIHN0YXRlczogIEQwIEQxIEQyIEQzIEVQU1MKICBQb3dl
cjogc2V0dGluZz1EMCwgYWN0dWFsPUQwCk5vZGUgMHgxOSBbUGluIENvbXBsZXhdIHdjYXBzIDB4
NDAwNDhiOiBTdGVyZW8gQW1wLUluCiAgQ29udHJvbDogbmFtZT0iTWljIEJvb3N0IFZvbHVtZSIs
IGluZGV4PTAsIGRldmljZT0wCiAgICBDb250cm9sQW1wOiBjaHM9MywgZGlyPUluLCBpZHg9MCwg
b2ZzPTAKICBBbXAtSW4gY2Fwczogb2ZzPTB4MDAsIG5zdGVwcz0weDAzLCBzdGVwc2l6ZT0weDI3
LCBtdXRlPTAKICBBbXAtSW4gdmFsczogIFsweDAwIDB4MDBdCiAgUGluY2FwIDB4MDAwMDM3MjQ6
IElOIERldGVjdAogICAgVnJlZiBjYXBzOiBISVogNTAgR1JEIDgwIDEwMAogIFBpbiBEZWZhdWx0
IDB4MDRhMTEwNDA6IFtKYWNrXSBNaWMgYXQgRXh0IFJpZ2h0CiAgICBDb25uID0gMS84LCBDb2xv
ciA9IEJsYWNrCiAgICBEZWZBc3NvY2lhdGlvbiA9IDB4NCwgU2VxdWVuY2UgPSAweDAKICBQaW4t
Y3RsczogMHgyNDogSU4gVlJFRl84MAogIFVuc29saWNpdGVkOiB0YWc9MDIsIGVuYWJsZWQ9MQog
IFBvd2VyIHN0YXRlczogIEQwIEQxIEQyIEQzIEVQU1MKICBQb3dlcjogc2V0dGluZz1EMCwgYWN0
dWFsPUQwCk5vZGUgMHgxYSBbUGluIENvbXBsZXhdIHdjYXBzIDB4NDAwNDhiOiBTdGVyZW8gQW1w
LUluCiAgQW1wLUluIGNhcHM6IG9mcz0weDAwLCBuc3RlcHM9MHgwMywgc3RlcHNpemU9MHgyNywg
bXV0ZT0wCiAgQW1wLUluIHZhbHM6ICBbMHgwMCAweDAwXQogIFBpbmNhcCAweDAwMDAzNzI0OiBJ
TiBEZXRlY3QKICAgIFZyZWYgY2FwczogSElaIDUwIEdSRCA4MCAxMDAKICBQaW4gRGVmYXVsdCAw
eDQxMTExMWYwOiBbTi9BXSBTcGVha2VyIGF0IEV4dCBSZWFyCiAgICBDb25uID0gMS84LCBDb2xv
ciA9IEJsYWNrCiAgICBEZWZBc3NvY2lhdGlvbiA9IDB4ZiwgU2VxdWVuY2UgPSAweDAKICAgIE1p
c2MgPSBOT19QUkVTRU5DRQogIFBpbi1jdGxzOiAweDAwOiBWUkVGX0hJWgogIFVuc29saWNpdGVk
OiB0YWc9MDAsIGVuYWJsZWQ9MAogIFBvd2VyIHN0YXRlczogIEQwIEQxIEQyIEQzIEVQU1MKICBQ
b3dlcjogc2V0dGluZz1EMCwgYWN0dWFsPUQwCk5vZGUgMHgxYiBbUGluIENvbXBsZXhdIHdjYXBz
IDB4NDAwNThmOiBTdGVyZW8gQW1wLUluIEFtcC1PdXQKICBBbXAtSW4gY2Fwczogb2ZzPTB4MDAs
IG5zdGVwcz0weDAzLCBzdGVwc2l6ZT0weDI3LCBtdXRlPTAKICBBbXAtSW4gdmFsczogIFsweDAw
IDB4MDBdCiAgQW1wLU91dCBjYXBzOiBvZnM9MHgwMCwgbnN0ZXBzPTB4MDAsIHN0ZXBzaXplPTB4
MDAsIG11dGU9MQogIEFtcC1PdXQgdmFsczogIFsweDgwIDB4ODBdCiAgUGluY2FwIDB4MDAwMTM3
MzQ6IElOIE9VVCBFQVBEIERldGVjdAogICAgVnJlZiBjYXBzOiBISVogNTAgR1JEIDgwIDEwMAog
IEVBUEQgMHgyOiBFQVBECiAgUGluIERlZmF1bHQgMHg0MTExMTFmMDogW04vQV0gU3BlYWtlciBh
dCBFeHQgUmVhcgogICAgQ29ubiA9IDEvOCwgQ29sb3IgPSBCbGFjawogICAgRGVmQXNzb2NpYXRp
b24gPSAweGYsIFNlcXVlbmNlID0gMHgwCiAgICBNaXNjID0gTk9fUFJFU0VOQ0UKICBQaW4tY3Rs
czogMHgwMDogVlJFRl9ISVoKICBVbnNvbGljaXRlZDogdGFnPTAwLCBlbmFibGVkPTAKICBQb3dl
ciBzdGF0ZXM6ICBEMCBEMSBEMiBEMyBFUFNTCiAgUG93ZXI6IHNldHRpbmc9RDAsIGFjdHVhbD1E
MAogIENvbm5lY3Rpb246IDIKICAgICAweDAyKiAweDAzCk5vZGUgMHgxYyBbVmVuZG9yIERlZmlu
ZWQgV2lkZ2V0XSB3Y2FwcyAweGYwMDAwMDogTW9ubwpOb2RlIDB4MWQgW1BpbiBDb21wbGV4XSB3
Y2FwcyAweDQwMDQwMDogTW9ubwogIFBpbmNhcCAweDAwMDAwMDIwOiBJTgogIFBpbiBEZWZhdWx0
IDB4NDA2MDAwMDE6IFtOL0FdIE1vZGVtIExpbmUgYXQgRXh0IE4vQQogICAgQ29ubiA9IFVua25v
d24sIENvbG9yID0gVW5rbm93bgogICAgRGVmQXNzb2NpYXRpb24gPSAweDAsIFNlcXVlbmNlID0g
MHgxCiAgUGluLWN0bHM6IDB4MjA6IElOCiAgUG93ZXIgc3RhdGVzOiAgRDAgRDEgRDIgRDMgRVBT
UwogIFBvd2VyOiBzZXR0aW5nPUQwLCBhY3R1YWw9RDAKTm9kZSAweDFlIFtQaW4gQ29tcGxleF0g
d2NhcHMgMHg0MDA1MDE6IFN0ZXJlbwogIFBpbmNhcCAweDAwMDAwMDEwOiBPVVQKICBQaW4gRGVm
YXVsdCAweDQxMTExMWYwOiBbTi9BXSBTcGVha2VyIGF0IEV4dCBSZWFyCiAgICBDb25uID0gMS84
LCBDb2xvciA9IEJsYWNrCiAgICBEZWZBc3NvY2lhdGlvbiA9IDB4ZiwgU2VxdWVuY2UgPSAweDAK
ICAgIE1pc2MgPSBOT19QUkVTRU5DRQogIFBpbi1jdGxzOiAweDQwOiBPVVQKICBQb3dlciBzdGF0
ZXM6ICBEMCBEMSBEMiBEMyBFUFNTCiAgUG93ZXI6IHNldHRpbmc9RDAsIGFjdHVhbD1EMAogIENv
bm5lY3Rpb246IDEKICAgICAweDA2Ck5vZGUgMHgxZiBbVmVuZG9yIERlZmluZWQgV2lkZ2V0XSB3
Y2FwcyAweGYwMDAwMDogTW9ubwpOb2RlIDB4MjAgW1ZlbmRvciBEZWZpbmVkIFdpZGdldF0gd2Nh
cHMgMHhmMDAwNDA6IE1vbm8KICBQcm9jZXNzaW5nIGNhcHM6IGJlbmlnbj0wLCBuY29lZmY9MTQy
Ck5vZGUgMHgyMSBbUGluIENvbXBsZXhdIHdjYXBzIDB4NDAwNThkOiBTdGVyZW8gQW1wLU91dAog
IENvbnRyb2w6IG5hbWU9IkhlYWRwaG9uZSBQbGF5YmFjayBTd2l0Y2giLCBpbmRleD0wLCBkZXZp
Y2U9MAogICAgQ29udHJvbEFtcDogY2hzPTMsIGRpcj1PdXQsIGlkeD0wLCBvZnM9MAogIEFtcC1P
dXQgY2Fwczogb2ZzPTB4MDAsIG5zdGVwcz0weDAwLCBzdGVwc2l6ZT0weDAwLCBtdXRlPTEKICBB
bXAtT3V0IHZhbHM6ICBbMHg4MCAweDgwXQogIFBpbmNhcCAweDAwMDEwMDFjOiBPVVQgSFAgRUFQ
RCBEZXRlY3QKICBFQVBEIDB4MjogRUFQRAogIFBpbiBEZWZhdWx0IDB4MDQyMTEwMjA6IFtKYWNr
XSBIUCBPdXQgYXQgRXh0IFJpZ2h0CiAgICBDb25uID0gMS84LCBDb2xvciA9IEJsYWNrCiAgICBE
ZWZBc3NvY2lhdGlvbiA9IDB4MiwgU2VxdWVuY2UgPSAweDAKICBQaW4tY3RsczogMHhjMDogT1VU
IEhQCiAgVW5zb2xpY2l0ZWQ6IHRhZz0wMSwgZW5hYmxlZD0xCiAgUG93ZXIgc3RhdGVzOiAgRDAg
RDEgRDIgRDMgRVBTUwogIFBvd2VyOiBzZXR0aW5nPUQwLCBhY3R1YWw9RDAKICBDb25uZWN0aW9u
OiAyCiAgICAgMHgwMiAweDAzKgpOb2RlIDB4MjIgW0F1ZGlvIE1peGVyXSB3Y2FwcyAweDIwMDEw
YjogU3RlcmVvIEFtcC1JbgogIEFtcC1JbiBjYXBzOiBvZnM9MHgwMCwgbnN0ZXBzPTB4MDAsIHN0
ZXBzaXplPTB4MDAsIG11dGU9MQogIEFtcC1JbiB2YWxzOiAgWzB4ODAgMHg4MF0gWzB4ODAgMHg4
MF0gWzB4ODAgMHg4MF0gWzB4ODAgMHg4MF0gWzB4ODAgMHg4MF0KICBDb25uZWN0aW9uOiA1CiAg
ICAgMHgxOSAweDFhIDB4MWIgMHgxZCAweDEzCk5vZGUgMHgyMyBbQXVkaW8gTWl4ZXJdIHdjYXBz
IDB4MjAwMTBiOiBTdGVyZW8gQW1wLUluCiAgQW1wLUluIGNhcHM6IG9mcz0weDAwLCBuc3RlcHM9
MHgwMCwgc3RlcHNpemU9MHgwMCwgbXV0ZT0xCiAgQW1wLUluIHZhbHM6ICBbMHg4MCAweDgwXSBb
MHg4MCAweDgwXSBbMHg4MCAweDgwXSBbMHg4MCAweDgwXSBbMHgwMCAweDAwXQogIENvbm5lY3Rp
b246IDUKICAgICAweDE5IDB4MWEgMHgxYiAweDFkIDB4MTIKTm9kZSAweDI0IFtBdWRpbyBTZWxl
Y3Rvcl0gd2NhcHMgMHgzMDAxMDE6IFN0ZXJlbwogIENvbm5lY3Rpb246IDMKICAgICAweDEyKiAw
eDEzIDB4MTgK
--0000000000006272d10654233134--
