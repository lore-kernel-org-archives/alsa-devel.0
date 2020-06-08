Return-Path: <SRS0=Yvqk=7V=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B2FC433DF
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Jun 2020 19:59:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3B24206D5
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Jun 2020 19:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="VOR72slr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3B24206D5
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5736A15E4;
	Mon,  8 Jun 2020 21:58:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5736A15E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591646364;
	bh=6e78wA/g2QhjQETjicnoFKRZt9d25DK/fO2qhjO08KI=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VOR72slrQUfLe4YWVWtq8ASrU0GDJ4UCEoLjdzU47CKBvMunh9zzqQmmRP+maja2M
	 /r4HcMpK0bL8tXeB34Xn887rRkHcNlJ+WXFX9ejRey+aoXRm6yrutZkNAxMV0hvVwO
	 j7HIIxWoMn0Pe1MawS0kMFQLiT1zSvGPx4mEk/KQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F293EF801F7;
	Mon,  8 Jun 2020 21:58:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6EC70F8021C; Mon,  8 Jun 2020 21:58:28 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 8BACBF80125
 for <alsa-devel@alsa-project.org>; Mon,  8 Jun 2020 21:58:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8BACBF80125
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1591646297430129051-webhooks-bot@alsa-project.org>
References: <1591646297430129051-webhooks-bot@alsa-project.org>
Subject: 1.2.3: alsa-libs is not LTO ready
Message-Id: <20200608195828.6EC70F8021C@alsa1.perex.cz>
Date: Mon,  8 Jun 2020 21:58:27 +0200 (CEST)
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

alsa-project/alsa-lib issue #56 was edited from kloczek:

When build with LTO test suite is failing
```
[tkloczko@barrel alsa-lib-1.2.3]$ make check
Making check in doc
make[1]: Entering directory '/home/tkloczko/rpmbuild/BUILD/alsa-lib-1.2.3/doc'
Making check in pictures
make[2]: Entering directory '/home/tkloczko/rpmbuild/BUILD/alsa-lib-1.2.3/doc/pictures'
make[2]: Nothing to be done for 'check'.
make[2]: Leaving directory '/home/tkloczko/rpmbuild/BUILD/alsa-lib-1.2.3/doc/pictures'
make[2]: Entering directory '/home/tkloczko/rpmbuild/BUILD/alsa-lib-1.2.3/doc'
make[2]: Nothing to be done for 'check-am'.
make[2]: Leaving directory '/home/tkloczko/rpmbuild/BUILD/alsa-lib-1.2.3/doc'
make[1]: Leaving directory '/home/tkloczko/rpmbuild/BUILD/alsa-lib-1.2.3/doc'
Making check in include
make[1]: Entering directory '/home/tkloczko/rpmbuild/BUILD/alsa-lib-1.2.3/include'
Making check in sound
make[2]: Entering directory '/home/tkloczko/rpmbuild/BUILD/alsa-lib-1.2.3/include/sound'
Making check in uapi
make[3]: Entering directory '/home/tkloczko/rpmbuild/BUILD/alsa-lib-1.2.3/include/sound/uapi'
make[3]: Nothing to be done for 'check'.
make[3]: Leaving directory '/home/tkloczko/rpmbuild/BUILD/alsa-lib-1.2.3/include/sound/uapi'
make[3]: Entering directory '/home/tkloczko/rpmbuild/BUILD/alsa-lib-1.2.3/include/sound'
make[3]: Nothing to be done for 'check-am'.
make[3]: Leaving directory '/home/tkloczko/rpmbuild/BUILD/alsa-lib-1.2.3/include/sound'
make[2]: Leaving directory '/home/tkloczko/rpmbuild/BUILD/alsa-lib-1.2.3/include/sound'
make[2]: Entering directory '/home/tkloczko/rpmbuild/BUILD/alsa-lib-1.2.3/include'
make[2]: Leaving directory '/home/tkloczko/rpmbuild/BUILD/alsa-lib-1.2.3/include'
make[1]: Leaving directory '/home/tkloczko/rpmbuild/BUILD/alsa-lib-1.2.3/include'
Making check in src
make[1]: Entering directory '/home/tkloczko/rpmbuild/BUILD/alsa-lib-1.2.3/src'
Making check in control
make[2]: Entering directory '/home/tkloczko/rpmbuild/BUILD/alsa-lib-1.2.3/src/control'
make[2]: Nothing to be done for 'check'.
make[2]: Leaving directory '/home/tkloczko/rpmbuild/BUILD/alsa-lib-1.2.3/src/control'
Making check in mixer
make[2]: Entering directory '/home/tkloczko/rpmbuild/BUILD/alsa-lib-1.2.3/src/mixer'
make[2]: Nothing to be done for 'check'.
make[2]: Leaving directory '/home/tkloczko/rpmbuild/BUILD/alsa-lib-1.2.3/src/mixer'
Making check in pcm
make[2]: Entering directory '/home/tkloczko/rpmbuild/BUILD/alsa-lib-1.2.3/src/pcm'
make[3]: Entering directory '/home/tkloczko/rpmbuild/BUILD/alsa-lib-1.2.3/src/pcm'
make[3]: Nothing to be done for 'check-am'.
make[3]: Leaving directory '/home/tkloczko/rpmbuild/BUILD/alsa-lib-1.2.3/src/pcm'
make[2]: Leaving directory '/home/tkloczko/rpmbuild/BUILD/alsa-lib-1.2.3/src/pcm'
Making check in timer
make[2]: Entering directory '/home/tkloczko/rpmbuild/BUILD/alsa-lib-1.2.3/src/timer'
make[2]: Nothing to be done for 'check'.
make[2]: Leaving directory '/home/tkloczko/rpmbuild/BUILD/alsa-lib-1.2.3/src/timer'
Making check in rawmidi
make[2]: Entering directory '/home/tkloczko/rpmbuild/BUILD/alsa-lib-1.2.3/src/rawmidi'
make[2]: Nothing to be done for 'check'.
make[2]: Leaving directory '/home/tkloczko/rpmbuild/BUILD/alsa-lib-1.2.3/src/rawmidi'
Making check in hwdep
make[2]: Entering directory '/home/tkloczko/rpmbuild/BUILD/alsa-lib-1.2.3/src/hwdep'
make[2]: Nothing to be done for 'check'.
make[2]: Leaving directory '/home/tkloczko/rpmbuild/BUILD/alsa-lib-1.2.3/src/hwdep'
Making check in seq
make[2]: Entering directory '/home/tkloczko/rpmbuild/BUILD/alsa-lib-1.2.3/src/seq'
make[2]: Nothing to be done for 'check'.
make[2]: Leaving directory '/home/tkloczko/rpmbuild/BUILD/alsa-lib-1.2.3/src/seq'
Making check in ucm
make[2]: Entering directory '/home/tkloczko/rpmbuild/BUILD/alsa-lib-1.2.3/src/ucm'
make[2]: Nothing to be done for 'check'.
make[2]: Leaving directory '/home/tkloczko/rpmbuild/BUILD/alsa-lib-1.2.3/src/ucm'
Making check in conf
make[2]: Entering directory '/home/tkloczko/rpmbuild/BUILD/alsa-lib-1.2.3/src/conf'
Making check in cards
make[3]: Entering directory '/home/tkloczko/rpmbuild/BUILD/alsa-lib-1.2.3/src/conf/cards'
make[3]: Nothing to be done for 'check'.
make[3]: Leaving directory '/home/tkloczko/rpmbuild/BUILD/alsa-lib-1.2.3/src/conf/cards'
Making check in pcm
make[3]: Entering directory '/home/tkloczko/rpmbuild/BUILD/alsa-lib-1.2.3/src/conf/pcm'
make[3]: Nothing to be done for 'check'.
make[3]: Leaving directory '/home/tkloczko/rpmbuild/BUILD/alsa-lib-1.2.3/src/conf/pcm'
make[3]: Entering directory '/home/tkloczko/rpmbuild/BUILD/alsa-lib-1.2.3/src/conf'
make[3]: Nothing to be done for 'check-am'.
make[3]: Leaving directory '/home/tkloczko/rpmbuild/BUILD/alsa-lib-1.2.3/src/conf'
make[2]: Leaving directory '/home/tkloczko/rpmbuild/BUILD/alsa-lib-1.2.3/src/conf'
make[2]: Entering directory '/home/tkloczko/rpmbuild/BUILD/alsa-lib-1.2.3/src'
make[2]: Nothing to be done for 'check-am'.
make[2]: Leaving directory '/home/tkloczko/rpmbuild/BUILD/alsa-lib-1.2.3/src'
make[1]: Leaving directory '/home/tkloczko/rpmbuild/BUILD/alsa-lib-1.2.3/src'
Making check in src/topology
make[1]: Entering directory '/home/tkloczko/rpmbuild/BUILD/alsa-lib-1.2.3/src/topology'
make[1]: Nothing to be done for 'check'.
make[1]: Leaving directory '/home/tkloczko/rpmbuild/BUILD/alsa-lib-1.2.3/src/topology'
Making check in modules
make[1]: Entering directory '/home/tkloczko/rpmbuild/BUILD/alsa-lib-1.2.3/modules'
Making check in mixer
make[2]: Entering directory '/home/tkloczko/rpmbuild/BUILD/alsa-lib-1.2.3/modules/mixer'
Making check in simple
make[3]: Entering directory '/home/tkloczko/rpmbuild/BUILD/alsa-lib-1.2.3/modules/mixer/simple'
make[3]: Nothing to be done for 'check'.
make[3]: Leaving directory '/home/tkloczko/rpmbuild/BUILD/alsa-lib-1.2.3/modules/mixer/simple'
make[3]: Entering directory '/home/tkloczko/rpmbuild/BUILD/alsa-lib-1.2.3/modules/mixer'
make[3]: Nothing to be done for 'check-am'.
make[3]: Leaving directory '/home/tkloczko/rpmbuild/BUILD/alsa-lib-1.2.3/modules/mixer'
make[2]: Leaving directory '/home/tkloczko/rpmbuild/BUILD/alsa-lib-1.2.3/modules/mixer'
make[2]: Entering directory '/home/tkloczko/rpmbuild/BUILD/alsa-lib-1.2.3/modules'
make[2]: Nothing to be done for 'check-am'.
make[2]: Leaving directory '/home/tkloczko/rpmbuild/BUILD/alsa-lib-1.2.3/modules'
make[1]: Leaving directory '/home/tkloczko/rpmbuild/BUILD/alsa-lib-1.2.3/modules'
Making check in aserver
make[1]: Entering directory '/home/tkloczko/rpmbuild/BUILD/alsa-lib-1.2.3/aserver'
make[1]: Nothing to be done for 'check'.
make[1]: Leaving directory '/home/tkloczko/rpmbuild/BUILD/alsa-lib-1.2.3/aserver'
Making check in test
make[1]: Entering directory '/home/tkloczko/rpmbuild/BUILD/alsa-lib-1.2.3/test'
Making check in .
make[2]: Entering directory '/home/tkloczko/rpmbuild/BUILD/alsa-lib-1.2.3/test'
make  control pcm pcm_min latency seq playmidi1 timer rawmidi midiloop oldapi queue_timer namehint client_event_filter chmap audio_time user-ctl-element-set pcm-multi-thread
make[3]: Entering directory '/home/tkloczko/rpmbuild/BUILD/alsa-lib-1.2.3/test'
make[3]: 'control' is up to date.
make[3]: 'pcm' is up to date.
make[3]: 'pcm_min' is up to date.
make[3]: 'latency' is up to date.
make[3]: 'seq' is up to date.
make[3]: 'playmidi1' is up to date.
make[3]: 'timer' is up to date.
make[3]: 'rawmidi' is up to date.
make[3]: 'midiloop' is up to date.
/bin/sh ../libtool  --tag=CC   --mode=link gcc -Wall -pipe -g -O2 -g -pipe -Wall -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -Wp,-D_GLIBCXX_ASSERTIONS -fstack-protector-strong -grecord-gcc-switches -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection -flto=auto -flto-partition=none  -Wl,-z,relro -Wl,--as-needed  -Wl,-z,now -specs=/usr/lib/rpm/redhat/redhat-hardened-ld -flto=auto -flto-partition=none -fuse-linker-plugin -o oldapi oldapi.o ../src/libasound.la
libtool: link: gcc -Wall -pipe -g -O2 -g -pipe -Wall -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -Wp,-D_GLIBCXX_ASSERTIONS -fstack-protector-strong -grecord-gcc-switches -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection -flto=auto -flto-partition=none -Wl,-z -Wl,relro -Wl,--as-needed -Wl,-z -Wl,now -specs=/usr/lib/rpm/redhat/redhat-hardened-ld -flto=auto -flto-partition=none -fuse-linker-plugin -o .libs/oldapi oldapi.o  ../src/.libs/libasound.so -lm -ldl -lpthread -lrt
/usr/bin/ld: oldapi.lto.o: in function `main':
/home/tkloczko/rpmbuild/BUILD/alsa-lib-1.2.3/test/oldapi.c:39: undefined reference to `snd_pcm_hw_params_get_access@ALSA_0.9'
collect2: error: ld returned 1 exit status
make[3]: *** [Makefile:529: oldapi] Error 1
make[3]: Leaving directory '/home/tkloczko/rpmbuild/BUILD/alsa-lib-1.2.3/test'
make[2]: *** [Makefile:796: check-am] Error 2
make[2]: Leaving directory '/home/tkloczko/rpmbuild/BUILD/alsa-lib-1.2.3/test'
make[1]: *** [Makefile:645: check-recursive] Error 1
make[1]: Leaving directory '/home/tkloczko/rpmbuild/BUILD/alsa-lib-1.2.3/test'
```

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/56
Repository URL: https://github.com/alsa-project/alsa-lib
