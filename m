Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20356C54E58
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Mar 2024 21:45:52 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E431F22A6;
	Wed, 20 Mar 2024 22:45:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E431F22A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1710971149;
	bh=7veMNXpgGRbqRi474oCKjmnmLC+u3j7tDc/UD+MDScA=;
	h=Date:To:From:Subject:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=vf8jJRroi2fAz4kxE8QmcBVV+def0b26HEOenI19DagqThprY0VWpgHrswwCdnF6z
	 6a/xIE5U6f6sM6FAvhpkIBGNjAw5HL+qRwGkDb+DnpK8OKeHa5U2MthQQkrkpjJe0V
	 PZSIKaxyXntsSLlnVT0sPvEL/9/saKLJzc/mMO1o=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A3794F8055C; Wed, 20 Mar 2024 22:45:18 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6BF54F805A9;
	Wed, 20 Mar 2024 22:45:18 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EE8A4F804E7; Wed, 20 Mar 2024 22:45:09 +0100 (CET)
Received: from cloudserver3206585-3206616.home.pl
 (cloudserver3206585-3206616.home.pl [46.242.241.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id DED82F80088
	for <alsa-devel@alsa-project.org>; Wed, 20 Mar 2024 22:45:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DED82F80088
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=ijbd.eu header.i=@ijbd.eu header.a=rsa-sha256
 header.s=dkim header.b=oqJFov86
Received: from [192.168.1.26] (79.184.234.139.ipv4.supernova.orange.pl
 [79.184.234.139])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest
 SHA256)
	(No client certificate requested)
	by cloudserver3206585-3206616.home.pl (Postfix) with ESMTPSA id B881C102D0
	for <alsa-devel@alsa-project.org>; Wed, 20 Mar 2024 22:45:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ijbd.eu; s=dkim;
	t=1710971101; bh=7veMNXpgGRbqRi474oCKjmnmLC+u3j7tDc/UD+MDScA=;
	h=Date:To:From:Subject;
	b=oqJFov86JFrlcLQo/nYafKcPTivOj8rbAQTC1306A+rPuQ3Ykpn4NysA9h7o1yRu4
	 4rVsx12tmW9okUqyHsS3YYedI/6ktHVzT5SYg/tM4906/I1yLHX+F3lmHSqK1L5yJ5
	 CgvAxOaIyoAQrs8HHgGM6oPk1u4/Z8mbWQjXwjvng6D3PfYTeorW1ze3QXZq0XJpmG
	 y7GA5jKOm4T6h9ZY2PQw5n40bb6i0Hkq8wQ3dWStWY3yk15l8TEtT67xwsPf4r/Z/a
	 bokMcpARAiYuMLHeSy9Xzi1HCMBgRz0MTC3gj6g+8W853mhPDpkBq1O0LWqF47mqCR
	 erHNCcSFJXGRA==
Message-ID: <24b60761-a940-40e2-9f20-afb0e5eaf839@ijbd.eu>
Date: Wed, 20 Mar 2024 22:44:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: alsa-devel@alsa-project.org
Content-Language: en-US
From: Jacek Blocki <jblocki@ijbd.eu>
Subject: Internal speakers and headphone not working on Huawei notebook
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CLIENT-IP: 79.184.234.139
X-CLIENT-HOSTNAME: 79.184.234.139.ipv4.supernova.orange.pl
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: 
 gggruggvucftvghtrhhoucdtuddrgedvledrleeggdduheduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecunecujfgurhepkfffgggfvffhufgtgfesthekredttddvjeenucfhrhhomheplfgrtggvkhcuuehlohgtkhhiuceojhgslhhotghkihesihhjsggurdgvuheqnecuggftrfgrthhtvghrnhephefghfeifeekhfejvedttedvueegkefhhefghefggffhjeekheefieektddvueegnecuffhomhgrihhnpehrvghsuhhlthdrtggrthenucfkphepjeelrddukeegrddvfeegrddufeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepjeelrddukeegrddvfeegrddufeelpdhhvghloheplgduledvrdduieekrddurddviegnpdhmrghilhhfrhhomheplfgrtggvkhcuuehlohgtkhhiuceojhgslhhotghkihesihhjsggurdgvuheqpdhnsggprhgtphhtthhopedupdhrtghpthhtoheprghlshgrqdguvghvvghlsegrlhhsrgdqphhrohhjvggtthdrohhrgh
X-DCC--Metrics: sv109.home.net.pl 1024; Body=1 Fuz1=1 Fuz2=1
Message-ID-Hash: NPCOFYZCYQVYJY4O34ZTRHFK2LGGNF3D
X-Message-ID-Hash: NPCOFYZCYQVYJY4O34ZTRHFK2LGGNF3D
X-MailFrom: jblocki@ijbd.eu
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/NPCOFYZCYQVYJY4O34ZTRHFK2LGGNF3D/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hello,

I have Huawei notebook (KLVL-WXXW-PCB) with Ubuntu 22.04.3 LTS installed 
alongside Windows. In Ubuntu, neither internal speakers nor headphone 
jack work. I only see Dummy Output while trying to adjust volume, but 
sound works with external HDMI monitor. Internal speakers work with 
Windows, so I believe hardware is fine and kernel driver 
(snd_hda_intel?) needs to be modified to fix the problem.
I have submitted Ubuntu bug report back in January, but nobody touched 
it. So I try this list hoping for better result.

$ cat /proc/asound/cards
  0 [Generic        ]: HDA-Intel - HD-Audio Generic
                       HD-Audio Generic at 0xd03c0000 irq 64
  1 [acp            ]: acp - acp
                       HUAWEI-KLVL_WXXW-M1010-KLVL_WXXW_PCB

I run 6.5.0-26-generic kernel.

Regards, Jacek Błocki


