Return-Path: <SRS0=W6oB=5D=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C0D5C10DCE
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Mar 2020 06:23:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D57B22076D
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Mar 2020 06:23:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="nNKTVE90";
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="dDYk9G2C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VR1i8a1v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D57B22076D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 06FC1175A;
	Wed, 18 Mar 2020 07:22:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 06FC1175A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584512620;
	bh=E5YLPBqL0PR2e9MJvgxykD62EP/kM2Rhg/3uL4MrI5A=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nNKTVE90YPTN0qBgiYfxLXRRqFs/yDrmwH7QAPdi1dbPWXuP8eclumd+THJcxO8KK
	 nnI1VrVy09PV2f6vImnTWk3xVHb9mBSs+IJEV0gOaCdYQ8YRDzMillB1ZxtCk9hX4N
	 Kk9sOARNG52sQHTfKPMGRppfx/7QXPPe6uZiJHQo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 61707F80132;
	Wed, 18 Mar 2020 07:22:49 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C6A68F80139; Wed, 18 Mar 2020 07:22:47 +0100 (CET)
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6E355F800B7
 for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2020 07:22:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6E355F800B7
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="dDYk9G2C"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="VR1i8a1v"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
 by mailout.nyi.internal (Postfix) with ESMTP id 0E4A25C0118;
 Wed, 18 Mar 2020 02:22:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute2.internal (MEProxy); Wed, 18 Mar 2020 02:22:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=3Fy9avsuXKUYcmccofl6Ea0WtbW
 Y/XlQ1vnEAoRT+jU=; b=dDYk9G2CDkzEQuUP9Q0/A4P+z5ekN065qEvuorm6eBy
 rgQp9f2ZXuz83RkWDTH3tVvvb4bytXOQvj3RdvEqrFdkjNaXcZFH9qoz0p5xi6V/
 dtjfPqDtiB/Wqri4c1CCgKxXTUwKF/kehpEEQw8STpDjy5nevLcv625EF1qdix3i
 eVykcEz3ootQGqAspZcp9TSpGgDQqPHtVANjzaPjPE6i8vrsRC/QDA8t0hc7AGgj
 Eg8c+vYEfwPnv4l4MO7Xa96vFYDwmpHniaqQZM6CxGBx4yPjfLIdYPJgEU1NjljR
 y9M4wqIL2lCjVjTV1kqrk6UfkhzQKX/CfbGM5jAxLgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=3Fy9av
 suXKUYcmccofl6Ea0WtbWY/XlQ1vnEAoRT+jU=; b=VR1i8a1vDfCEf21bWXsn+L
 Z+dnvoXwifZ5fUxMzyQTwafc2BDX28aEqLAyL9z0s/Sjz3bvm4M/gQdtUXycqQu2
 KJ3fGcwYD99WOvA1/SWOu9eQWVP7rIUv4t5KMw7Qf4wukz82WjoMoN0F/UgdEeEy
 wEEzNQVplbr80hE6nUcQ7hHDHmx/o1je4OAGi/5UszC/2xi9fdQgj8N6AmM/7KOV
 qCOd2KTNVzThrsSIuSQDgmClhIcFjJf2jWfgmu2TFcwauXl6nmwItVwLZQDV59j+
 XXa1W/PJG27j7BW7AQMT/uT0vV2fZJ3pxmfSa7fgxra2FhuHMU2pNdzWti82klEg
 ==
X-ME-Sender: <xms:K75xXo-bhgJrF4re9ri9hS2GOA4ulLf9iVSLIT2sbVMceCVXoHretw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrudefiedgledtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujggfsehttd
 ertddtredvnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
 rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucffohhmrghinhepghhithhhuhgsrd
 gtohhmnecukfhppedugedrfedrjeegrdduieeknecuvehluhhsthgvrhfuihiivgeptden
 ucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthh
 hirdhjph
X-ME-Proxy: <xmx:K75xXiTzlJ_9y0kBvLaApXgl6NzmMT1jLgQe_NTJRzZOhjpNlDkaFA>
 <xmx:K75xXtR0mGhiARvF7xR5leqN-laTCftYKjA_Gg76SREnj-UHrx1wIw>
 <xmx:K75xXu4HTzj8FBDppWyefyPRTBiRt8NEsBGx0WB8gpbhGFFaq80e-A>
 <xmx:LL5xXlOz_mnKMSkzuovH_3aMB42kbFpYW-f8NuCgoxFKOZVj-8ymdQ>
Received: from workstation (ae074168.dynamic.ppp.asahi-net.or.jp [14.3.74.168])
 by mail.messagingengine.com (Postfix) with ESMTPA id 10D37328005D;
 Wed, 18 Mar 2020 02:22:33 -0400 (EDT)
Date: Wed, 18 Mar 2020 15:22:31 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Mathias Buhr <napcode@apparatus.de>
Subject: Re: snd_dice: Clicking artifacts with TC StudioKonnekt 48
Message-ID: <20200318062230.GA7323@workstation>
Mail-Followup-To: Mathias Buhr <napcode@apparatus.de>,
 alsa-devel@alsa-project.org
References: <921a3b13-b44e-3300-bb72-84cbc9e3dd88@apparatus.de>
 <20200222012510.GA4883@laptop>
 <e29617da-9d34-c99f-f425-5d2aef59b623@apparatus.de>
 <20200224002031.GA10405@laptop>
 <3b42e75b-07ec-9dd4-b399-dbad30afc5a4@apparatus.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b42e75b-07ec-9dd4-b399-dbad30afc5a4@apparatus.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org
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

Hi,

On Wed, Feb 26, 2020 at 01:51:53PM +0100, Mathias Buhr wrote:
> On 24.02.20 01:20, Takashi Sakamoto wrote:
> > Hi,
> >
> > On Sat, Feb 22, 2020 at 05:49:29PM +0100, Mathias Buhr wrote:
> >> Thanks for your reply Takashi! It clarifies the situation. I'lll stick
> >> with ffado then.
> >>
> >> Regards,
> >>
> >> Mathias
> > Both of libffado2 and ALSA dice driver have problems for each, but it's
> > a convenient option for users of Dice-based devices to use the former,
> > at present. I've been improved ALSA dice driver for years with the other
> > drivers, but it doesn't bring so hasty changes since it's a kind of
> > reverse-engineering; no one knows the actual design and few ones can
> > make discussion based on the fact.
> >
> >
> > Well, I also own TC Electronic Sudio Konnekt 48 and I've investigated
> > its protocol to configure I/O routings on internal DSP. After my
> > vacation, I'll send information about it for your convenience
> > (maybe next week).
> >
> >
> > Regards
> >
> > Takashi Sakamoto
> 
> Thanks Takashi! I'd appreciate that!

This is my memo about the part of configuration in this model
for analog I/O:

Addr: 0x'ffff'e0a0'13dc
Offset: quadlet: target
- 0x00: 00 00 00 00:
- 0x04: ff ff fc 18:
- 0x08: ff ff fd a8:
- 0x0c: 00 00 00 00:
- 0x10: 00 00 00 01:
- 0x14: 00 00 00 37: main out L source
- 0x18: 00 00 00 00:
- 0x1c: 00 00 00 00:
- 0x20: 00 00 00 38: main out R source
- 0x24: 00 00 00 00:
- 0x28: 00 00 00 00:
- 0x2c: 00 00 00 01:
- 0x30: 00 00 00 37: phones 1 source
- 0x34: 00 00 00 00:
- 0x38: 00 00 00 00:
- 0x3c: 00 00 00 38: phones 2 source
- 0x40: 00 00 00 00:
- 0x44: 00 00 00 00:
- 0x48: 00 00 00 01:
- 0x4c: 00 00 00 37: line 5 source
- 0x50: 00 00 00 00:
- 0x54: 00 00 00 00:
- 0x58: 00 00 00 5a: line 6 source
- 0x5c: 00 00 00 00:
- 0x60: 00 00 00 00:
- 0x64: 00 00 00 01:
- 0x68: 00 00 00 3d: line 7 source
- 0x6c: 00 00 00 00:
- 0x70: 00 00 00 00:
- 0x74: 00 00 00 3e: line 8 source
Values:
- Unused: unused
- Mic/Inst/Line input:0x01-0x0c
- S/PDIF input:       0x0d/0x0e
- ADAT input:         0x0f-0x16
- Stream input:       0x37-0x4e
- Mixer output:       0x55/0x56
- Aux 1 output:       0x57/0x58
- Aux 2 output:       0x59/0x5a
- Reverb output:      0x5b/0x5c

You can configure your device by 'firewire-request' command in
'linux-firewire-utils' repository.
https://github.com/cladisch/linux-firewire-utils

For example, when switching source of main out L from stream-1 to
mic/inst/line input 1:
$ printf %x $((0xffffe0a013dc + 0x14))
0xffffe0a013f0
$ ./firewire-request /dev/fw1 read 0xffffe0a013f0
result: 00000037
$ ./firewire-request /dev/fw1 write 0xffffe0a013f0 0x00000001
$ ./firewire-request /dev/fw1 read 0xffffe0a013f0
result: 00000001


Regards

Takashi Sakamoto
