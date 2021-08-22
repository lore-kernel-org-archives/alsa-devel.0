Return-Path: <SRS0=Wxof=NN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3100AC4338F
	for <alsa-devel@archiver.kernel.org>; Sun, 22 Aug 2021 16:42:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72B9061267
	for <alsa-devel@archiver.kernel.org>; Sun, 22 Aug 2021 16:42:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 72B9061267
Authentication-Results: mail.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 279E1828;
	Sun, 22 Aug 2021 18:41:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 279E1828
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629650526;
	bh=JP2nuIEjLa95WZbXw9SMQMhnWiLSfMqsYYj6uOFWdWE=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VQUCYVSX/4/0W9dmiRwoUfXCxzvc1Elts9PMy+9YAAbj3d1+HL6sKv6+3WGz2l71Z
	 qVy20XwiUam+pgzK5K0HuAodBznTtsyoDWH7tY8+mAw+4h+dAsYVYPQeJvyL4dKOzb
	 TnILlrh3UuxUy1Hl4MWCi7ZugW2Uz5rosSejNV9g=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A4E3AF80171;
	Sun, 22 Aug 2021 18:41:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B8190F801D5; Sun, 22 Aug 2021 18:41:13 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 6A2DEF800EC
 for <alsa-devel@alsa-project.org>; Sun, 22 Aug 2021 18:41:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6A2DEF800EC
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1629650464306662083-webhooks-bot@alsa-project.org>
References: <1629650464306662083-webhooks-bot@alsa-project.org>
Subject: OpenAL fails to build with
 https://github.com/alsa-project/alsa-lib/commit/95eb312fade1908a2c944e9de4626c0ff60b2203
 commit
Message-Id: <20210822164113.B8190F801D5@alsa1.perex.cz>
Date: Sun, 22 Aug 2021 18:41:13 +0200 (CEST)
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

alsa-project/alsa-lib issue #172 was opened from shoober420:

The recent alsa-lib commit https://github.com/alsa-project/alsa-lib/commit/95eb312fade1908a2c944e9de4626c0ff60b2203 borks OpenAL from building. I thought it was an issue with OpenAL, but he mentions that its an issue with alsa-lib (https://github.com/kcat/openal-soft/issues/592#issuecomment-903211857). Here is the OpenAL build log just in case and a snippet of the OpenAL build error.

https://github.com/kcat/openal-soft/files/7026546/buildopenal.log

OpenAL build error.
```
[84/97] /usr/bin/x86_64-pc-linux-gnu-g++ -m32 -DALC_API="__attribute__((visibility(\"protected\"))) __attribute__((force_align_arg_pointer))" -DAL_ALEXT_PROTOTYPES -DAL_API="__attribute__((visibility(\"protected\"))) __attribute__((force_align_arg_pointer))" -DAL_BUILD_LIBRARY -DOpenAL_EXPORTS -DRESTRICT=__restrict -I/var/tmp/portage/media-libs/openal-9999/work/openal-9999/include -I/usr/include/pipewire-0.3 -I/usr/include/spa-0.2 -I/var/tmp/portage/media-libs/openal-9999/work/openal-9999_build-abi_x86_32.x86 -I/var/tmp/portage/media-libs/openal-9999/work/openal-9999 -I/var/tmp/portage/media-libs/openal-9999/work/openal-9999/common  -march=native -Ofast -pipe -fno-plt -fno-common -fno-semantic-interposition -fipa-pta -falign-functions=32 -fdevirtualize-at-ltrans -fuse-linker-plugin -floop-nest-optimize -fgraphite-identity -fno-signed-zeros -fno-trapping-math -fassociative-math -freciprocal-math -fno-math-errno -ffinite-math-only -fno-rounding-math -fno-signaling-nans -fcx-limited-ran
 ge -fexcess-precision=fast -w -flto=auto -fPIC -Winline -Wunused -Wall -Wextra -Wshadow -Wconversion -Wcast-align -Wpedantic -Wold-style-cast -Wnon-virtual-dtor -Woverloaded-virtual -fno-math-errno -fvisibility=hidden -msse2 -mfpmath=sse -pthread -std=gnu++14 -MD -MT CMakeFiles/OpenAL.dir/alc/backends/alsa.cpp.o -MF CMakeFiles/OpenAL.dir/alc/backends/alsa.cpp.o.d -o CMakeFiles/OpenAL.dir/alc/backends/alsa.cpp.o -c /var/tmp/portage/media-libs/openal-9999/work/openal-9999/alc/backends/alsa.cpp
FAILED: CMakeFiles/OpenAL.dir/alc/backends/alsa.cpp.o 
/usr/bin/x86_64-pc-linux-gnu-g++ -m32 -DALC_API="__attribute__((visibility(\"protected\"))) __attribute__((force_align_arg_pointer))" -DAL_ALEXT_PROTOTYPES -DAL_API="__attribute__((visibility(\"protected\"))) __attribute__((force_align_arg_pointer))" -DAL_BUILD_LIBRARY -DOpenAL_EXPORTS -DRESTRICT=__restrict -I/var/tmp/portage/media-libs/openal-9999/work/openal-9999/include -I/usr/include/pipewire-0.3 -I/usr/include/spa-0.2 -I/var/tmp/portage/media-libs/openal-9999/work/openal-9999_build-abi_x86_32.x86 -I/var/tmp/portage/media-libs/openal-9999/work/openal-9999 -I/var/tmp/portage/media-libs/openal-9999/work/openal-9999/common  -march=native -Ofast -pipe -fno-plt -fno-common -fno-semantic-interposition -fipa-pta -falign-functions=32 -fdevirtualize-at-ltrans -fuse-linker-plugin -floop-nest-optimize -fgraphite-identity -fno-signed-zeros -fno-trapping-math -fassociative-math -freciprocal-math -fno-math-errno -ffinite-math-only -fno-rounding-math -fno-signaling-nans -fcx-limited-range -fexc
 ess-precision=fast -w -flto=auto -fPIC -Winline -Wunused -Wall -Wextra -Wshadow -Wconversion -Wcast-align -Wpedantic -Wold-style-cast -Wnon-virtual-dtor -Woverloaded-virtual -fno-math-errno -fvisibility=hidden -msse2 -mfpmath=sse -pthread -std=gnu++14 -MD -MT CMakeFiles/OpenAL.dir/alc/backends/alsa.cpp.o -MF CMakeFiles/OpenAL.dir/alc/backends/alsa.cpp.o.d -o CMakeFiles/OpenAL.dir/alc/backends/alsa.cpp.o -c /var/tmp/portage/media-libs/openal-9999/work/openal-9999/alc/backends/alsa.cpp
In file included from /usr/include/alsa/asoundlib.h:55,
                 from /var/tmp/portage/media-libs/openal-9999/work/openal-9999/alc/backends/alsa.cpp:51:
/usr/include/alsa/rawmidi.h:107:9: error: '__u8' does not name a type
  107 |         __u8 frame_type;
      |         ^~~~
/usr/include/alsa/rawmidi.h:108:9: error: '__u8' does not name a type
  108 |         __u8 length; /* number of valid bytes in data field */
      |         ^~~~
/usr/include/alsa/rawmidi.h:109:9: error: '__u8' does not name a type
  109 |         __u8 reserved[2];
      |         ^~~~
/usr/include/alsa/rawmidi.h:110:9: error: '__u32' does not name a type; did you mean '__m32'?
  110 |         __u32 tv_nsec;          /* nanoseconds */
      |         ^~~~~
      |         __m32
/usr/include/alsa/rawmidi.h:111:9: error: '__u64' does not name a type; did you mean '__m64'?
  111 |         __u64 tv_sec;           /* seconds */
      |         ^~~~~
      |         __m64
/usr/include/alsa/rawmidi.h:112:9: error: '__u8' does not name a type
  112 |         __u8 data[SND_RAWMIDI_FRAMING_DATA_LENGTH];
      |         ^~~~
```

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/172
Repository URL: https://github.com/alsa-project/alsa-lib
