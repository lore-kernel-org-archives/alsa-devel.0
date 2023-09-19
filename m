Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CAE3CD54B5
	for <alsa-devel@archiver.kernel.org>; Tue, 19 Sep 2023 11:20:33 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7CF3BE73;
	Tue, 19 Sep 2023 13:19:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7CF3BE73
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1695122431;
	bh=BUFH8kp44u8h9iO3b/j058kfVeD0z8pcJ+KnoHGOdq4=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=YbRckKV1i/Vg4JjAFudhMYdzplSs2laFpIR526BVUzyMNVcqNIvmt35Cazrf/jZC4
	 GmyePMrz/LAPBywY5Zv85uS+TRObMdK66rMxB/zxGp77Z5RIFR0yolHOsUFg3hPQrG
	 EAud8uVpnBT8GrlSfXEc5Ta/LJwoU7TWko0Ugzqo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E345BF80125; Tue, 19 Sep 2023 13:19:10 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 267CBF8025A;
	Tue, 19 Sep 2023 13:19:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6F325F8025A; Tue, 19 Sep 2023 13:19:05 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 71DB3F80125
	for <alsa-devel@alsa-project.org>; Tue, 19 Sep 2023 13:19:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 71DB3F80125
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1695122341086722851-webhooks-bot@alsa-project.org>
References: <1695122341086722851-webhooks-bot@alsa-project.org>
Subject: topology.c: error: 'LC_ALL' undeclared - compiling alsa-utils 1.2.10
 with musl
Message-Id: <20230919111905.6F325F8025A@alsa1.perex.cz>
Date: Tue, 19 Sep 2023 13:19:05 +0200 (CEST)
Message-ID-Hash: WYMS56WGODDGCDAU2NGKTCY6DJZVFYRC
X-Message-ID-Hash: WYMS56WGODDGCDAU2NGKTCY6DJZVFYRC
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/WYMS56WGODDGCDAU2NGKTCY6DJZVFYRC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-utils issue #239 was edited from michaelopdenacker:

I'm facing the below issue trying to compile alsa-utils with the musl C library with the Yocto Project Poky master branch:

x86_64-poky-linux-musl-gcc  -m64 -march=core2 -mtune=core2 -msse3 -mfpmath=sse -fstack-protector-strong  -O2 -D_FORTIFY_SOURCE=2 -Wformat -Wformat-security -Werror=format-security --sysroot=/home/mike/work/yocto/poky/build/tmp/work/core2-64-poky-linux-musl/alsa-utils/1.2.10/recipe-sysroot -DHAVE_CONFIG_H -I. -I../../alsa-utils-1.2.10/topology -I../include  -Wall -I../../alsa-utils-1.2.10/include -DALSA_TOPOLOGY_PLUGIN_DIR=\"/usr/lib/alsa-topology\"   -O2 -pipe -g -feliminate-unused-debug-types -fcanon-prefix-map  -fmacro-prefix-map=/home/mike/work/yocto/poky/build/tmp/work/core2-64-poky-linux-musl/alsa-utils/1.2.10/alsa-utils-1.2.10=/usr/src/debug/alsa-utils/1.2.10-r0  -fdebug-prefix-map=/home/mike/work/yocto/poky/build/tmp/work/core2-64-poky-linux-musl/alsa-utils/1.2.10/alsa-utils-1.2.10=/usr/src/debug/alsa-utils/1.2.10-r0  -fmacro-prefix-map=/home/mike/work/yocto/poky/build/tmp/work/core2-64-poky-linux-musl/alsa-utils/1.2.10/build=/usr/src/debug/alsa-utils/1.2.10-r0  -fdebug-prefix
 -map=/home/mike/work/yocto/poky/build/tmp/work/core2-64-poky-linux-musl/alsa-utils/1.2.10/build=/usr/src/debug/alsa-utils/1.2.10-r0  -fdebug-prefix-map=/home/mike/work/yocto/poky/build/tmp/work/core2-64-poky-linux-musl/alsa-utils/1.2.10/recipe-sysroot=  -fmacro-prefix-map=/home/mike/work/yocto/poky/build/tmp/work/core2-64-poky-linux-musl/alsa-utils/1.2.10/recipe-sysroot=  -fdebug-prefix-map=/home/mike/work/yocto/poky/build/tmp/work/core2-64-poky-linux-musl/alsa-utils/1.2.10/recipe-sysroot-native=  -c -o pre-process-dai.o ../../alsa-utils-1.2.10/topology/pre-process-dai.c
| ../../alsa-utils-1.2.10/topology/topology.c: In function 'main':
| ../../alsa-utils-1.2.10/topology/topology.c:442:9: warning: implicit declaration of function 'setlocale' [-Wimplicit-function-declaration]
|   442 |         setlocale(LC_ALL, "");
|       |         ^~~~~~~~~
| ../../alsa-utils-1.2.10/topology/topology.c:442:19: error: 'LC_ALL' undeclared (first use in this function)
|   442 |         setlocale(LC_ALL, "");
|       |                   ^~~~~~

Including <locale.h> in topology.c makes the error go away.
I'll send a patch shortly.
Michael

Issue URL     : https://github.com/alsa-project/alsa-utils/issues/239
Repository URL: https://github.com/alsa-project/alsa-utils
