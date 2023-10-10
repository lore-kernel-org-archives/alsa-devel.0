Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 020D0CD68F2
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Oct 2023 04:39:58 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 762DEF96;
	Tue, 10 Oct 2023 06:39:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 762DEF96
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1696912795;
	bh=mJdP/EpLDF9ZKKmG9fH4C+jprWImTXx1O/vE46IJUEw=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=TQdYy/4cYGjGSk6/nlVkZHnJ0LturHbRHXRZuob/4tjfA67+0cqZZVk5i2mjLEYtv
	 SDe/UOsDb2u3V083H0TPtztGrHSuuPpkuKCLA8Ff22vrgm91cU/Ct4Gp+ruT4AQI+v
	 ithGTBzOS53CSj8EQoyKZ5/qPg076xMZhJTMaIxg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 85900F80166; Tue, 10 Oct 2023 06:39:04 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5F3CBF802BE;
	Tue, 10 Oct 2023 06:39:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D873CF802BE; Tue, 10 Oct 2023 06:35:51 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 9042CF80166
	for <alsa-devel@alsa-project.org>; Tue, 10 Oct 2023 06:35:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9042CF80166
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1696912544895051479-webhooks-bot@alsa-project.org>
References: <1696912544895051479-webhooks-bot@alsa-project.org>
Subject: Undefined symbols in version sccripts are error in LLD-17 (by
 default)
Message-Id: <20231010043551.D873CF802BE@alsa1.perex.cz>
Date: Tue, 10 Oct 2023 06:35:51 +0200 (CEST)
Message-ID-Hash: 76WGR3SDU4MVABRZ2KLAZI53ERJVZE24
X-Message-ID-Hash: 76WGR3SDU4MVABRZ2KLAZI53ERJVZE24
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/76WGR3SDU4MVABRZ2KLAZI53ERJVZE24/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib issue #356 was opened from parona-source:

LLD 17 defaults to erroring out on undefined symbols in version scripts.

```
libtool: link: clang -m32 -mfpmath=sse -shared  -fPIC -DPIC  .libs/conf.o .libs/confeval.o .libs/confmisc.o .libs/input.o .libs/output.o .libs/async.o .libs/error.o .libs/dlmisc.o .libs/socket.o .libs/shmarea.o .libs/userfile.o .libs/names.o  -Wl,--whole-archive control/.libs/libcontrol.a mixer/.libs/libmixer.a pcm/.libs/libpcm.a timer/.libs/libtimer.a rawmidi/.libs/librawmidi.a hwdep/.libs/libhwdep.a seq/.libs/libseq.a ucm/.libs/libucm.a -Wl,--no-whole-archive  -Wl,--as-needed -lm -lpthread -lrt  -m32 -mfpmath=sse -O3 -march=znver3 -Wl,--version-script=Versions -Wl,-z -Wl,defs -Wl,-O1 -Wl,--defsym=__gentoo_check_ldflags__=0   -Wl,-soname -Wl,libasound.so.2 -o .libs/libasound.so.2.0.0
x86_64-pc-linux-gnu-ld: error: version script assignment of 'ALSA_0.9.5' to symbol 'alsa_lisp' failed: symbol not defined
x86_64-pc-linux-gnu-ld: error: version script assignment of 'ALSA_1.2.10' to symbol 'snd_seq_seq_client_info_get_ump_group_enabled' failed: symbol not defined
x86_64-pc-linux-gnu-ld: error: version script assignment of 'ALSA_1.2.10' to symbol 'snd_seq_seq_client_get_ump_conversion' failed: symbol not defined
x86_64-pc-linux-gnu-ld: error: version script assignment of 'ALSA_1.2.10' to symbol 'snd_seq_seq_client_info_set_ump_group_enabled' failed: symbol not defined
x86_64-pc-linux-gnu-ld: error: version script assignment of 'ALSA_1.2.10' to symbol 'snd_seq_seq_client_set_ump_conversion' failed: symbol not defined
clang: error: linker command failed with exit code 1 (use -v to see invocation)
```

These symbols were added in https://github.com/alsa-project/alsa-lib/commit/2aefb5c41cc03b72b3161b57336dd4f924b7a90b, which include the subsequent commits makes me think these could be symbols that were added prematurely and that there is an intention to implement them. Which is why I am making an issue instead of making a pull request removing them.

@tiwai any input on this?

Bug: https://bugs.gentoo.org/914511

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/356
Repository URL: https://github.com/alsa-project/alsa-lib
