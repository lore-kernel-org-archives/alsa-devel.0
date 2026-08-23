Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30BEDC5DF81
	for <alsa-devel@archiver.kernel.org>; Sun, 23 Aug 2026 20:12:02 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BF22060260;
	Sun, 23 Aug 2026 22:11:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BF22060260
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1787515919;
	bh=o0oLYeg+AMkrsGKKwhlYuhqHLgXY26Njy3kz0UUEpmI=;
	h=From:Date:Subject:To:Cc:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=hoCJTKeG/5uzDUypEgrUeIpchzCMUyDOL0OIu+cBBXr1k5XMWaGJYiS5otKgI6jVJ
	 8pmzfU9pKjngeTGkoAaEMQ4VExtEhTVHuT2XZmE/dS5Ad2uQnrQ7So4WMaRNH4AwTn
	 a0huJx6qfltNlSmsa3YqXvxSRsEp2KF+NU1RH0UI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9FDC6F805FB; Sun, 23 Aug 2026 22:11:23 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5D2D7F805F5;
	Sun, 23 Aug 2026 22:11:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 08943F8055B; Sun, 23 Aug 2026 22:11:17 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.44
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1787515876;
	b=of3pO9VPQzYIawQY3fla9h/Vhp/anO0Rp41HHYausEiwdNUTzy9WR/Z3aOS8sHb01gRe
	 Chfz/WC2bjqySGtL914UQfQktFav/xiSm5yj3H8Um0S1zD8j8ckTnL+p6cEq88pusS/Jt
	 H1sMnI+zKTX4pd8rbw1R+0Rw85LkTLnsvHZ7R/OxB3g7wnFlPfoXZHft0hoRZOvXYh2XM
	 Q33O32bAudnD8cbqXpPdKO3zqgAthT3o9LsxmDI68LUvJm93CqxofZx+hu9J5V8m2XhGS
	 Sc1nHfFeXt41w+2yg0xb3eG/RZY8Gne1HbUm+d3uZMkub+hg4l2fiDhOX7rU/fTyMtw==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1787515876;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To;
	bh=o0oLYeg+AMkrsGKKwhlYuhqHLgXY26Njy3kz0UUEpmI=;
	b=hjYtnUxMT3gPpDIwvR5LPau61UdFK7UYDxGzC1VpGsnGiy0/Dw4RoUSp4/qRSN6ZrwvC
	 yTux3fRfpiTT7vYOgjwAUe2+cNA7d7wyIa5tw7mkWvu9u9XSEZryKdSt3KJacgHFIckAQ
	 rvp2bdvdGSn0KEbG3SgmGeQLRL11Yusl9wHGybCadoJqFBBrMfZftxjWB3mRK14/xP0DT
	 lISn2RCNttGqVgIz1o4iWfNqYjBXCtZNfEBxzV7QeEk6k4dIlthDCF+wcp3rStDDolJgH
	 tTuztRDb/iltVUEZvpzPKAjaV08Ujepv07hXYCIZd8MHx39TL92r4eav4/dRfnPHwmw==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=rXfglj4b;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.44
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com
 [209.85.210.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 2BD1AF80149
	for <alsa-devel@alsa-project.org>; Sun, 23 Aug 2026 22:11:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2BD1AF80149
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=rXfglj4b
Received: by mail-ot1-f44.google.com with SMTP id
 46e09a7af769-7f432ac553fso2608871a34.3
        for <alsa-devel@alsa-project.org>;
 Sun, 23 Aug 2026 13:11:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787515873; cv=none;
        d=google.com; s=arc-20260327;
        b=I+y/ioEPkMbNEtCNEInE0JBpD70i2XtguD67E88i0Cxoeaase3wwatcV/KQ2sqdwYP
         qOxnOaDQzxLKudakXn0y11L47uoc0K4OpbFXeEC3gujc2UGLBEQX0ZdKVLS27QKmdvzw
         inBIwbtuB9n4t0kN0l3dEjQxr+7BzIW+TX894WzWLfbUk+/By8UThEq7jx6ofYp2uF5p
         JURcFgBT9RMVJo39+jQLAP9N9j6xziZnE9z1rZmlf7t1JRVNa2fwO5isWAJjgERWAlPd
         H9lkIORJLNqr6G+cWqXU73ozD54K6Ql0SN63vKbb0pBIirLnBtmM9S76FCtWa9srLRVn
         9YGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=fPiWE97Pa6ZFut9x7bbN5/Df1oHR1v5zBrs60gN9ZtU=;
        fh=DctAOP+rpKOZ4C17ETaENgq7BC9RYC9lIwxRvT+wtkA=;
        b=bw09wykavIUo7xia02liivXSWIPZxDs07WYYnGiqmqXe7N3e6KYmKOIJyal7HR63Vn
         7QT5YFW8Kku/LunKGq3sfDnC9OzQLBQrQbM+F2o6ZhIgwcQjtyYqxALH28x7W8o4voH5
         sD/p5Nep6xQretjgoyeTxf3wv6iU4C2Yof0n5Ss4IzbHW7mama0aeMVAHHI9MnTAr9BZ
         YSPFgTyIx0Luna+4faehmNXlwKuzJS6+mdVOCoV8DVr16+uYcqKXEN0JXcq2aaQvKNQj
         JE46+HgX9dGh3mSWaeKz8xYP4YAveQY6Opi6kGPX4KpjEmvkkgoLwDq/YAZqh1nK9CgI
         1hcQ==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787515873; x=1788120673;
 darn=alsa-project.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fPiWE97Pa6ZFut9x7bbN5/Df1oHR1v5zBrs60gN9ZtU=;
        b=rXfglj4b/bsxPJdMap0cBiKiTAZKJxCYfgTVSvdXX0gFQEiDBE7da85oWhZHHplMmg
         eWGpPOXnvECNZhYybtBAHlt4rxbuRocFtJvkN+buaTcXs4DtUaW/FjZ3Aezdsh0lcTqs
         5FRHOs7wbjuFojA8pJZLyKdKkDAEVrlH9vy+9HOFCSK5I+mx2aVLqzHYSIi4rB8UpqaK
         80WvbIQ/qjPPnyS4hrUnlMELIfstoP0NUt1tv1ULlPujzkw4dsip+KDptwWhY1FFim8g
         FKc1CSZK4p/W6i80m3Zm4wntVmdoBPFbvFYW6UHqgY4TKJ7rUhL4pEuj5ZJM+ZhHIO0f
         +Rcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787515873; x=1788120673;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fPiWE97Pa6ZFut9x7bbN5/Df1oHR1v5zBrs60gN9ZtU=;
        b=fj+heOMrN4H3XVg8dDurxt2OO20x0mLikLvE+2gzUfCUtbwM4UTGZMpGg07aFeS+4P
         0CUqBU8vc8z/RKq3R5xb/Mj50adwQAmCdQE8EqiuXHardMOugdgZTBSUJW4J64Q9qiQS
         HeXGsAqQ9yTNoEF9TmErm7H56d6RR0cq8Xot6ZEXPvQI/NGE86FcALNeuTFKfXiY5BzL
         b4NTKRo89JwECJGTCK6EqnxF4R95qIsqF6sLlvp3YaQq69t4XYQcjlLJCHNI54Fc78qP
         dLIQ3PnHkdDQ2sqy1Kv/2FBWP4UOOvsvesoLtM/dUnjzziKO6BgK/GntL/xSzxR11j9P
         EBtg==
X-Gm-Message-State: AFuF++mOtedMvspxl1zFRSCWug7dzO1ZrjyStXfNK+7pmZwq2qgwHMKc
	yvBBgB0ZJC+PIgsjikT7BEMfjqxFGsf2yQ/JayZ2MB3qWpiGzJSTQ8kmMArQW8SmukK4bCYoV7y
	QzOMU9CPOilm2oKvFwuP4OcGQrSe8emkaMYiMjLhDTbMU
X-Gm-Gg: AR+sD132JUu4wZABO1HxXGwczmSWMDlS1G+aBC3yUz77mafE8YCrEvVoJSDSojD419r
	+C8Fcf58TDTsArXMSBawgd3ZeazvabGpmKoUQ63gxUxbYMMNvR5am9cjUtZbxGL92/AdSo/gpjI
	cEcSwO8zAYtZaUh6NhkBIlGxEfwXTNaE0BKCJQQY8QO0TwDSfMuKFrnoqNyR4j+EpqG3oZCXf48
	lb020K96Xc+BjhPTlw9fbWcEXAHOl+JH32uh+L0OuYGad4IAllfYArC64jm6gOA03VDKZNUybNP
	UTRMveRokARvSRs/yJjl8u8UQcoHJb52cGnQzV4I6+hVBeKHJWiuA0OOOGy5TYkWxsVb+SGEBkY
	IdKHLO3npIbHrIUA9jLgFBIPWXJ+E+Gw=
X-Received: by 2002:a05:6830:7101:b0:7e6:e1d2:3bd0 with SMTP id
 46e09a7af769-7f46149516emr24535088a34.10.1787515872720; Sun, 23 Aug 2026
 13:11:12 -0700 (PDT)
MIME-Version: 1.0
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Mon, 24 Aug 2026 01:11:01 +0500
X-Gm-Features: AcwNN1Va6OJUZ1qE8ebJagLgjgV7G7iRhLdFj3EV8KRmeuh47uzzuJlslkVcgzk
Message-ID: 
 <CABXGCsPVLke4_j-FfGqTMN4tG88G5ckf13_xxKRe=j_w+sWTvQ@mail.gmail.com>
Subject: UCM: two devices that exclude a third but not each other
To: alsa-devel@alsa-project.org
Cc: Jaroslav Kysela <perex@perex.cz>
Content-Type: text/plain; charset="UTF-8"
Message-ID-Hash: 7WCF6RC65FNKQRXXUM7NDTIS22QKGJDN
X-Message-ID-Hash: 7WCF6RC65FNKQRXXUM7NDTIS22QKGJDN
X-MailFrom: mikhail.v.gavrilov@gmail.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7WCF6RC65FNKQRXXUM7NDTIS22QKGJDN/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi,

A shape I cannot express, on a card where it is the natural one.

The interface has two microphone channels. A UCM profile splits them
into two mono devices, and they work perfectly well at the same time --
two speakers, or a voice and an instrument. The same two channels can
also be taken as one stereo device, which is what you want for a
balanced source arriving on both at once.

So there are two sensible configurations: the two mono devices
together, or the stereo device alone. The stereo device excludes each
mono device; the mono devices do not exclude each other. That is what
I wrote:

    SectionDevice."In1"  { ConflictingDevice [ "In12" ] ... }
    SectionDevice."In2"  { ConflictingDevice [ "In12" ] ... }
    SectionDevice."In12" { ConflictingDevice [ "In1" "In2" ] ... }

and I got three configurations instead of two, each offering only one
microphone. This is what alsa-lib reports back:

    $ alsaucm -c M62 list _conflictingdevs/In1/HiFi
      In2
      In12

In2 is in that list, and nothing in the profile put it there.

verb_dev_list_check() in src/ucm/parser.c explains it. The second pass
adds, for every device D and every target T in D's list, all the other
members of D's list to T's list. So the stereo device listing both
halves makes the halves list each other, and two microphones that can
run together are offered one at a time.

Expressing it the other way round does not escape it. With
SupportedDevice instead, each mono device supporting the other and
everything except the stereo device:

    SectionDevice."In1"  { SupportedDevice [ "In2" "Aux" "BT" ... ] }
    SectionDevice."In12" { SupportedDevice [ "Aux" "BT" ... ] }

    $ alsaucm -c M62 list _supporteddevs/In1/HiFi
      In12
      In2
      ...

In12 is in In1's supported list, and the profile says the opposite. The
closure propagates through shared neighbours: In1 and In12 both support
Line1, so Line1 acquires both, and the pass that adds every other
member of a list to each target hands In12 back to In1.

All three devices then coexist, and on this card that is worse than
useless rather than merely wrong. Their mixer elements overlap -- one
preamp per channel, and the stereo element covers both -- so the nodes
restore different remembered gains over the same hardware. A recording
made that way came back clipped at 0 dBFS with its two channels 12 dB
apart in RMS, while a simultaneous mono take from the same source sat
at -18 dBFS.

Both list types are group relations, then, and a partial relation
cannot be written. A profile has to choose: two mono inputs or one
stereo pair. I have chosen the two mono inputs and said so in the file,
but I would rather describe the card than choose for its owner.

Is there a way to express this that I have missed? If there is not,
would a pairwise form be worth considering -- a list taken as written,
without the closure -- alongside the grouping one, so that existing
profiles keep their meaning?

-- 
Thanks,
Mikhail Gavrilov.
