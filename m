Return-Path: <SRS0=T8Ko=BQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 099B3C433E0
	for <alsa-devel@archiver.kernel.org>; Thu,  6 Aug 2020 11:41:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 119FE221E2
	for <alsa-devel@archiver.kernel.org>; Thu,  6 Aug 2020 11:41:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="fqdS6Tx2";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="YSuxN43Z";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a4htpZaC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 119FE221E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 763021666;
	Thu,  6 Aug 2020 11:15:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 763021666
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1596705362;
	bh=rTGtTn/emJAtIimMu3rBd1IpbuDXjjehh2FyqVG9Iwg=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fqdS6Tx2z0l0Jo799/LuMO4UJhHGIXLP/yw2Kel3Bn2asBGEh7FvbkHCAf9wZtTns
	 Nc4HFi+8XMNB5gg4KsPDzk6o7wV61eqQfFl6HnbgREbm2wI6c8QhUzAQfpJq1QjovM
	 SVAK3lKkqNdFufGnGIpXf/wEPb0H4Jjn/6479cVg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F2F0BF80159;
	Thu,  6 Aug 2020 11:15:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 663E6F80159; Thu,  6 Aug 2020 11:15:10 +0200 (CEST)
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A37ECF800B7;
 Thu,  6 Aug 2020 11:15:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A37ECF800B7
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="YSuxN43Z"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="a4htpZaC"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
 by mailout.nyi.internal (Postfix) with ESMTP id 4DDDB5C01D9;
 Thu,  6 Aug 2020 05:15:03 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute2.internal (MEProxy); Thu, 06 Aug 2020 05:15:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm2; bh=2du+NCvGva8NqJAR7uK1+WcXq5Y
 UI3qSposCF3nkDsg=; b=YSuxN43ZkEr66EL0840T6W3+AFBoeyYs6VThsfOeqrg
 3csj3N3mFNtAo/Ri29vrfA/AqGCf4IXtV8Iris1LtWAmqlS2yECgfugt5AE8DTOc
 hshtwC+E4ek07YSvi2AX5nz8GTAsDns8HfRiL88tPKJ6Vr+FqUD3Qhg7RJKZeauI
 s7xmU4Q6H2esmULLuaKj2VHhMWRmNbTyvnHE2VLH8LHlMchgrB+wxx39kSdjtCSo
 lciBt21znTH97XoJqFKrc39e1HGX2jnCdwKQWu4uqxqxcU9D9xuV9LOpXyQpkldD
 RLdVC//9KNNiLE+RTcNkLFBz6qPEBdC6mvrK/2pLqQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=2du+NC
 vGva8NqJAR7uK1+WcXq5YUI3qSposCF3nkDsg=; b=a4htpZaCdhKps2URaXJtd/
 7yIO/QIksadLrUvroASVfoqTrRI1o/VKzFVYy4whWvSoFAk5p5nk5VTanIgViXoo
 J/hEA7iwwWdHSrrXIQvwB3yxxu9DT3jn7IWn2TUffkBFSoAaq4coMhIzuYs4Qbe5
 i2Zw7CYFZQbuvIvMSrLodNNiB/TBr6m5loVWrO+JuiuexefalnVHiy4v4TEaqbBj
 q49OMJNkNW+WbyhrW+2udYJATSmmHXklM+Kd/29nFL1/rm+K0GZx6m5zYWCu2lgA
 UFnkuAVfAzK6EJj74rALIv9IkJrwyzq7UpKmx1G1J+aLE6AUPxPi4HVz3XQnJsKg
 ==
X-ME-Sender: <xms:FsorXzf7U7irnNP17bv51oxIu4cEHwTOnHOWdGoJrtoP2yNGypJ00Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrkedtgddugecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehttdertd
 dttddvnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghs
 hhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpefgveetvefgve
 eftdegfeehkeeukeevkeefheehfffhkeetkedtvdehfeejledtieenucffohhmrghinhep
 fihikhhiphgvughirgdrohhrghenucfkphepudektddrvdefhedrfedrheegnecuvehluh
 hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhh
 ihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:FsorX5N8H4Dp733yJXI9KPj1YDBdf8EHJkrC4PPWNZsrZmqprrN8Rg>
 <xmx:FsorX8h0OCDJ-ocaEQG5PzLMnQVQv-xDZcCaoGb8uWTKtNZZ3DW4oQ>
 <xmx:FsorX0_VOM4n0geNbS1elYkjLW4NvzFhwEPHmPLA0MzgplQ537Tl1g>
 <xmx:F8orX4WbkeKqzlQ5gUwdgZtpsDiRoKasTdiuU5ngg7_9S7dE014OLg>
Received: from workstation (ad003054.dynamic.ppp.asahi-net.or.jp
 [180.235.3.54])
 by mail.messagingengine.com (Postfix) with ESMTPA id 0EA4030600A3;
 Thu,  6 Aug 2020 05:15:00 -0400 (EDT)
Date: Thu, 6 Aug 2020 18:14:58 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Tom Yan <tom.ty89@gmail.com>
Subject: Re: Why doesn't mixer control (values) have some kind of locking
 mechanism? (mutex?)
Message-ID: <20200806091458.GA360003@workstation>
Mail-Followup-To: Tom Yan <tom.ty89@gmail.com>, alsa-devel@alsa-project.org,
 alsa-user@alsa-project.org,
 pulseaudio-discuss@lists.freedesktop.org,
 pierre-louis.bossart@linux.intel.com
References: <CAGnHSEkpYqyZJjG587FSVUzYX2zV1tm83zj+uGjF4e24o4iAMA@mail.gmail.com>
 <20200806020601.GA6286@laptop>
 <CAGnHSEnMhF-1y7rL=JsmcFdTNVaA5ygv5N4TS9dhpORyOm+H_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGnHSEnMhF-1y7rL=JsmcFdTNVaA5ygv5N4TS9dhpORyOm+H_A@mail.gmail.com>
Cc: alsa-devel@alsa-project.org, pulseaudio-discuss@lists.freedesktop.org,
 alsa-user@alsa-project.org, pierre-louis.bossart@linux.intel.com
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

On Thu, Aug 06, 2020 at 04:57:02PM +0800, Tom Yan wrote:
> The problem/race I am trying to point out is, one process can
> get()/read before another finishing its get()+put() pair (which is
> required by volume setting/adjusting), so something like
> get1()->get2()->put1()->put2() could easily happen (where each put()
> relies on / is "configured" with volumes of their respective get()).
> The lock will need to intentionally stall further get()/read as well.

In my opinion, in the above case, it's possible to serialize each
transaction which consists of get/put (read/write in userspace
application) with lock/unlock mechanism.

+-----------+-----------+
| process A | process B |
+-----------+-----------+
|   lock    |           |
|   get     |           |
|           |lock(EPERM)| reschedule lock/get/set/unlock actions
|   set     |           |
|           |lock(EPERM)| reschedule lock/get/set/unlock actions
|  unlock   |           |
|           |   lock    |
|           |   get     |
|           |   set     |
|           |  unlock   |
+-----------+-----------+

(Of course, the above is achieved when the series of operations is done
by userspace applications. For simplicity, I don't mention about
in-kernel initiators of the get/set actions. In this point, I don't
address to the message Pierre posted.)

> If we for some reason want to avoid using locks, put() needs to be
> atomic by design (like, "embed" get() in itself and use arrays for
> volume values, instead of requiring those to be implemented in the
> userspace manually / with a loop). Unfortunately that isn't the case
> in ALSA.
 
I get your intension is something like compare-and-swap[1]. At present,
ALSA control core has no functionality like it, but it's worth to
investigate. The ioctl request should includes a pair of 'struct
snd_ctl_elem_value' in its argument. In a design of ALSA control
core, the pair should be processed in each driver since ALSA control
core has no 'cache' of the content of 'struct snd_ctl_elem_value' except
for user-defined control element set.

Here, would I ask your opinion to the lock/get/set/unlock actions
from userspace? It can really not be one of solution for the issue?

[1] https://en.wikipedia.org/wiki/Compare-and-swap


Regards

Takashi Sakamoto
