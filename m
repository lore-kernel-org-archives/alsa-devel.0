Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D49EDCD5BCA
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Nov 2025 11:18:23 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0C4D660205;
	Thu, 13 Nov 2025 12:18:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0C4D660205
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1763032701;
	bh=2IWJskiGPiHVYRf8sJWXGdSKVTDk1ddHZqaqXN170bM=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=vaKxRP4xAq+U8tah6HOG9AZQhnspsfWS1zle5Z5KB8/dbNkuo/oCcNarhVK/NTriY
	 +eIwuf3IexjuNthXus8V0q1UvXt6Z1tXaA0zn3rFjFa0E4G7r62ERHqWhS5jxilhe8
	 HXSe4Ov4JoCB0RNnvpasi135fOf+wkVKadI37R88=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BB0B3F80533; Thu, 13 Nov 2025 12:17:46 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 81A12F805C4;
	Thu, 13 Nov 2025 12:17:46 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BD4CAF80533; Thu, 13 Nov 2025 12:17:33 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 5514CF80027
	for <alsa-devel@alsa-project.org>; Thu, 13 Nov 2025 12:17:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5514CF80027
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18778cda09d0cb00-webhooks-bot@alsa-project.org>
In-Reply-To: <18778cda085e7600-webhooks-bot@alsa-project.org>
References: <18778cda085e7600-webhooks-bot@alsa-project.org>
Subject: aplay: cannot play S24_LE wav file recorded with arecord
Date: Thu, 13 Nov 2025 12:17:33 +0100 (CET)
Message-ID-Hash: SR4LGKQCTT2V2BCDS7W4FACDSOHZRFDV
X-Message-ID-Hash: SR4LGKQCTT2V2BCDS7W4FACDSOHZRFDV
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/SR4LGKQCTT2V2BCDS7W4FACDSOHZRFDV/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-utils issue #308 was opened from yoshihisa-yamamoto-re:

My environment is alsa-utils version : 1.2.14  (Debian trixie)

I tried to record and play PCM audio as S24_LE format over alsa as follows:
```
arecord  -f S24_LE out.wav
aplay out.wav
```
However, the audio turned into noise and did not seem to play properly.

This problem does **not** seem to occur when using alsa-utils version 1.2.9 (Ubuntu 24.04 LTS).
Searching through the commits, I found the closed issue https://github.com/alsa-project/alsa-utils/pull/260.

>From reading the source, it appears that the header information has been rewritten, so I dumped it to check, and it looks like this:

hexdump of wav created with alsa-utils version 1.2.14 :
```
00000000  52 49 46 46 24 e2 04 00  57 41 56 45 66 6d 74 20  |RIFF$...WAVEfmt |
00000010  10 00 00 00 01 00 01 00  40 1f 00 00 00 7d 00 00  |........@....}..|
00000020  04 00 20 00 64 61 74 61  00 e2 04 00 e6 67 8d ff  |.. .data.....g..|
00000030  c8 fd 8e ff 0c 8e 90 ff  c6 18 92 ff 0a 9e 93 ff  |................|
00000040  ec 1d 95 ff 7e 98 96 ff  d2 0d 98 ff fd 7d 99 ff  |....~........}..|
00000050  10 e9 9a ff 1c 4f 9c ff  35 b0 9d ff 6b 0c 9f ff  |.....O..5...k...|
00000060  cf 63 a0 ff 74 b6 a1 ff  68 04 a3 ff be 4d a4 ff  |.c..t...h....M..|
00000070  86 92 a5 ff cf d2 a6 ff  a9 0e a8 ff 25 46 a9 ff  |............%F..|
```

hexdump of wav created with alsa-utils version 1.2.9 :
```
00000000  52 49 46 46 24 e2 04 00  57 41 56 45 66 6d 74 20  |RIFF$...WAVEfmt |
00000010  10 00 00 00 01 00 01 00  40 1f 00 00 00 7d 00 00  |........@....}..|
00000020  04 00 18 00 64 61 74 61  00 e2 04 00 17 3d fe ff  |....data.....=..|
00000030  3e 3d fe ff 86 41 fe ff  cb 47 fe ff 3b 46 fe ff  |>=...A...G..;F..|
00000040  10 47 fe ff e3 4d fe ff  66 4f fe ff 8d 50 fe ff  |.G...M..fO...P..|
00000050  be 4f fe ff 40 58 fe ff  e7 5b fe ff 27 60 fe ff  |.O..@X...[..'`..|
00000060  f9 60 fe ff ce 61 fe ff  ce 63 fe ff d3 68 fe ff  |.`...a...c...h..|
00000070  83 6f fe ff 84 6c fe ff  22 73 fe ff 91 6d fe ff  |.o...l.."s...m..|
```
As the change in Commit 9cdcbe0e932b97fac88a6195f87647159a6c7194, the header information has changed BitsPerSample (bit_p_spl) from 24bit to 32bit (0x22-0x23).
If I change this header info and treat the 1.2.14 wav as 24-bit per sample as before, the audio seems to play correctly.
I don't have the correct information for S24_LE format, so I don't know if the header information is wrong or if I should modify the arecord to match this 32-bit.

Issue URL     : https://github.com/alsa-project/alsa-utils/issues/308
Repository URL: https://github.com/alsa-project/alsa-utils
