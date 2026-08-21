Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFCDAC5DF7D
	for <alsa-devel@archiver.kernel.org>; Fri, 21 Aug 2026 09:23:12 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 19BE260297;
	Fri, 21 Aug 2026 11:22:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 19BE260297
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1787304189;
	bh=XLWwXO09die+Dfnt0iosV41usjvUe7pNRoxUIT+I8ec=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=hRQYwSpoYd1HlDl3ESnHIT1CCyOMQKMBbFLF+tFatJ5jtV8Ztqala1WvIfSp0ZqsL
	 OD7nqL9JwFbWGt0edaZvFIN4TdRjaG8kLnwROnhqLR9gIJoo7Vo837Y+GYL6Fs+6Xz
	 jT9uo8l7MwsHLTf4sU4b6NiazCR/6+U/bRx8eqqY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E35DBF804CC; Fri, 21 Aug 2026 11:22:31 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2DB50F805FF;
	Fri, 21 Aug 2026 11:22:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 491C0F8051D; Fri, 21 Aug 2026 11:22:24 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1787304143;
	b=jzEM5ED0oqIyrT3rRJdSCu+91d+NChXNFjN3A6FlgnuCgrBVwYEPmDOP0AmaBilmVEyK
	 TCji0EQyjeExW/5Qvk7m1S06/m3LzUTSD+LUjRk+6/DucEpIKiJ/AQqB47/T3LAeD2Vyb
	 WZ2a2gpMnEpbeOleGQLxgS0XCYsKFcl8hUyjf53KI1gC3S3nU5WcNWK3GeJ3RLx0UzhPw
	 a0KstcKWOyjQFhnhPV5+DTo0VfW3GbU6zy9BrSaEfZng/3ibMrVOtNfOQYYzsUEENRDfR
	 etXErIC3uS3GKSUFpOLQhd1eMu0/MOhSgXp7/NjRbXDUlqIdsKpdXy1Xak8MxMaWL1A==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1787304143;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=XLWwXO09die+Dfnt0iosV41usjvUe7pNRoxUIT+I8ec=;
	b=pbPw3d/ci9VTRHlkRvnA+PX0+8ChxvMwtX/fYqlKJiHxU+hddtxaD66PmXqB3xKp87jT
	 8DrFxqK03AXnQBpHDLhJ+oR8DclR/U83pduZNeOGYiEejJR2O/NnuPZh5MPC7Oi4zu9Qb
	 i5lOYHVBfBKqrpVxJRQg2jtM4h7vc6fp1uxphgNYC5DarP6xQt0HF1bLeHkFzfq6PH7Ax
	 5UYwC7B7KKemi5a67PbvZIOPuyfin9etxYauAvDILZ1EIr09LDtvtE7btYY9fiJcZYuFw
	 +rN+6xXAphAMFIkSHkhd7oJwrVou1rKIsgErcQ43GaYOPcb0F9cxxMCpat7E1qUT8Jw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 856C9F804CC
	for <alsa-devel@alsa-project.org>; Fri, 21 Aug 2026 11:22:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 856C9F804CC
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18cdc7a5c0df7100-webhooks-bot@alsa-project.org>
In-Reply-To: <18cdc7a5c0c04100-webhooks-bot@alsa-project.org>
References: <18cdc7a5c0c04100-webhooks-bot@alsa-project.org>
Subject: ALSA AAF PCM: speaker-test reports "Write error: -32,
 Broken pipe" with -p option but works with -P option
Date: Fri, 21 Aug 2026 11:22:24 +0200 (CEST)
Message-ID-Hash: Q72ZXUQI3DOGTPZMA72RWRRUOBRZPECH
X-Message-ID-Hash: Q72ZXUQI3DOGTPZMA72RWRRUOBRZPECH
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/Q72ZXUQI3DOGTPZMA72RWRRUOBRZPECH/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-utils issue #333 was opened from liuyq0509-ux:

Hi everyone,

I am testing an ALSA AAF PCM plugin for AVTP audio streaming on an ARM development board. The PCM configuration is as follows:

```
pcm.aaf0 {
type aaf
ifname eth0.5
addr 01:AA:AA:AA:AA:AA
prio 2
streamid AA:BB:CC:DD:EE:FF:000B
mtt 50000
time_uncertainty 1000
frames_per_pdu 12
ptime_tolerance 100
}
```

When I run `speaker-test` with the following command:

`speaker-test -p 25000 -F S16_BE -c 2 -r 48000 -D aaf0`


The device is opened successfully and the hardware parameters are set:
Playback device is aaf0
Stream parameters are 48000Hz, S16_BE, 2 channels
Using 16 octaves of pink noise
Rate set to 48000Hz (requested 48000Hz)
Buffer size range from 1 to 206158430
Period size range from 0 to 206158431
Requested period time 25000 us
Periods = 4
was set period_size = 1200
was set buffer_size = 4800
0 - Front Left
Write error: -32, Broken pipe
Write error: -32, Broken pipe
Write error: -32, Broken pipe
...

However, if I change the command to use `-P`:

`speaker-test -P 480 -F S16_BE -c 2 -r 48000 -D aaf0`

The test runs normally without any `Broken pipe` errors:


layback device is aaf0
Stream parameters are 48000Hz, S16_BE, 2 channels
Using 16 octaves of pink noise
Rate set to 48000Hz (requested 48000Hz)
Buffer size range from 1 to 206158430
Period size range from 0 to 206158431
Periods = 480
was set period_size = 12000
was set buffer_size = 5760000
0 - Front Left
1 - Front Right
Time per period = 0.283478
0 - Front Left
1 - Front Right
Time per period = 0.242246

Does anyone know why `-p 25000` causes `Broken pipe` while `-P 480` works?

Could this be related to:
- ALSA buffer/period configuration?
- AAF plugin internal scheduling?
- AVTP packet timing requirements?
- PTP synchronization?
- CBS/QoS configuration?

Any suggestions would be appreciated. Thanks!

Issue URL     : https://github.com/alsa-project/alsa-utils/issues/333
Repository URL: https://github.com/alsa-project/alsa-utils
