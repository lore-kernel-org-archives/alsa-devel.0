Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DDB9C79F82
	for <alsa-devel@archiver.kernel.org>; Sat,  5 Sep 2026 00:24:55 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DAEA1601D7;
	Sat,  5 Sep 2026 02:24:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DAEA1601D7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1788567892;
	bh=nl+dUoU/RGNcj0sJa+CCGct2Kk8JUnTgAVT+Eh82HpE=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=bOqgTkRdD3RrmtjrZmbsADzNkk4eRb4el/XIO0O6I+04luGxuxBRDI3oVD5hqCOsh
	 PaSte+E9p4nK9iUKJ/tgwCOu2wJd+2y3m0Ql6w0JruAzIx3ZI4fy5Klrkz1o90ej0q
	 jtR4sM1356rcflRGXXw4g1qYX59Xi4UM0whIFd70=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 24625F805F6; Sat,  5 Sep 2026 02:24:20 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E2811F805F5;
	Sat,  5 Sep 2026 02:24:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B9F9BF80525; Sat,  5 Sep 2026 02:24:11 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1788567850;
	b=miaNeQscmDDi7GsIMVpPOBzLNZKWQxnoAgOZ0LGXr8dXG7/T2w+ZUlqhwN8ltwtvkApX
	 wa8edNg7YcrcPan2GzttjohdH7NLa6s1t7Jb7NNDHRMsQXZM/g5fBv5LcDwBJnV3e3O2y
	 K9P9zMuBfN8vQbTylfMNaw7dmMSv/uQ7Ph9SN3+J0HeCGA57p+rbi7ow9HMRmu0BT+EdA
	 owu8FIMAhWkDB9VzSyulU4Diiucw9FF6loNdwH/EJnY+kB2SlrCsXST+bV1NZyv+3xdTF
	 SvRhED9qSqnnOX/Q3EnKj1MLj4CJhDxnpQveF22c+OFqO5pTeJZffUQokNbVhJwiR7Q==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1788567850;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=nl+dUoU/RGNcj0sJa+CCGct2Kk8JUnTgAVT+Eh82HpE=;
	b=fUhgZtZxYkXalqrr7TaNvvwtyqn6uD2Tjj+z+fIC4GdnUmmhxklS1MM/2w4nKdTyP1jh
	 iXbANdCbhQUFgcjUpI1xRFxIqYQmoO9VqNQbG/6/UTPI4STlwoIBUmYJ32r96kNtAxyS7
	 WGpOyNqIcg/d8rYXDxc99QXIXOyeyO03lsf547br4skGRwqWUFZYx705yAuTn7Uo3wKgE
	 bsiLg8R8Hm/zBOh6LsHzZADd6T+GyQZCVr8BUKbN2Xb1qCqx+CjPFXtO/rOVuivDi9luw
	 HlrCilcSxBs54ha39RAwSb49i8G50iLKOz6hf88XBruV40EOLJz6Wn7ToEp6U+uqJLw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id A2EF6F80185
	for <alsa-devel@alsa-project.org>; Sat,  5 Sep 2026 02:24:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A2EF6F80185
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18d244fb8809cb00-webhooks-bot@alsa-project.org>
In-Reply-To: <18d244fb87991500-webhooks-bot@alsa-project.org>
References: <18d244fb87991500-webhooks-bot@alsa-project.org>
Subject: sys/endian.h: No such file or directory
Date: Sat,  5 Sep 2026 02:24:11 +0200 (CEST)
Message-ID-Hash: 2AZGBPGMNJYCKLG6LLSDZUDSAM4LNFH5
X-Message-ID-Hash: 2AZGBPGMNJYCKLG6LLSDZUDSAM4LNFH5
X-MailFrom: github@alsa-project.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/2AZGBPGMNJYCKLG6LLSDZUDSAM4LNFH5/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib issue #522 was opened from FuwwyCodingCOwO:

It seems that GNU/Hurd does not have `sys/endian.h`, this could probably be fixed by instead using `endian.h` provided by [POSIX](https://pubs.opengroup.org/onlinepubs/9799919799/basedefs/endian.h.html). The [Hurd porting guidelines](https://www.gnu.org/software/hurd/hurd/porting/guidelines.html) seem to agree with this. I will make a pull request to go along with this.

configured with:
```
configure
    --prefix=/usr \
    --build=x86_64-pc-linux-gnu \
    --host=i686-gnu \
    --mandir=/usr/share/man \
    --infodir=/usr/share/info \
    --datadir=/usr/share \
    --sysconfdir=/etc \
    --localstatedir=/var/lib \
    --datarootdir=/usr/share \
    --disable-dependency-tracking \
    --disable-silent-rules \
    --disable-static \
    --docdir=/usr/share/doc/alsa-lib-1.2.16.1 \
    --htmldir=/usr/share/doc/alsa-lib-1.2.16.1/html \
    --with-sysroot=/usr/i686-gnu \
    --libdir=/usr/lib \
    --disable-maintainer-mode \
    --disable-resmgr \
    --enable-aload \
    --enable-rawmidi \
    --enable-seq \
    --enable-shared \
    --enable-thread-safety \
    --disable-python \
    --without-debug
```

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/522
Repository URL: https://github.com/alsa-project/alsa-lib
