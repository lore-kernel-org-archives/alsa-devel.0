Return-Path: <SRS0=LwrQ=AT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC4AEC433E0
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Jul 2020 14:45:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 368F02078B
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Jul 2020 14:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="V3vD/WoQ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="O+LMLEZ5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MePi1JHA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 368F02078B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B39C315F9;
	Wed,  8 Jul 2020 16:44:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B39C315F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594219549;
	bh=YhseJEePgvpSTmX9XlP8TaSDJ83VtMy6jUAsWBvn1lc=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=V3vD/WoQ5snqd7VfvWqpWn+s/6bBcl4NoL9mPNXiTi4bxzAJYz1mBkN6ykDP0J/p4
	 IVTPgzFVbk+yae1XlZYbYYJjm7H9FzQhlQpA730I0msQ8bg9zCAIeqCp0BCk96I+Bi
	 kJI0VEL/wn5qvCaqzekKpbJe2Jv6UrR3dnbGGkfw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 51263F8011F;
	Wed,  8 Jul 2020 16:44:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F2C39F8015A; Wed,  8 Jul 2020 16:44:56 +0200 (CEST)
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com
 [64.147.123.20])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5415AF8011F
 for <alsa-devel@alsa-project.org>; Wed,  8 Jul 2020 16:44:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5415AF8011F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="O+LMLEZ5"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="MePi1JHA"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
 by mailout.west.internal (Postfix) with ESMTP id A6A44DF2;
 Wed,  8 Jul 2020 10:44:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute2.internal (MEProxy); Wed, 08 Jul 2020 10:44:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm2; bh=zS4cLsxZBzFI7SbLtt7irGNd4KT
 +uosvycDIir2B79E=; b=O+LMLEZ5K4KMr/ojUJxkYCvX4Dev+IMnGu3zn0MCgYL
 6gVYZCe0r2qx5CY7OUnkDu1JK/jWvmb42E5QZMKa8v3z8BgP3wSMJyxPnCJi3kc1
 JdPkHLQZOGHboBYRjal8LCj6QOBmbdJEEdUs5gaUxzPUFdHOLKSzQmMdVyZYENgF
 HyT7044In1kQbqV5I+f1cF0Exr+k790D0QMnRC+qV/g3VhzhR8UGSUtc1jfNSaTH
 lPc9LWj3LhpCTKDld6K2IVmUGNYtRECukmXhV0qQDLsedCLE1jb7vqBYeYCqN4ip
 MhooTVznhCJmutVdtIarlKk5urSynv/jvbETH+XSSVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=zS4cLs
 xZBzFI7SbLtt7irGNd4KT+uosvycDIir2B79E=; b=MePi1JHASxajqlO+om3yCY
 GkvMdzMYnAT2uobpyiHNglGEsyMNsSjrSxS83IaacIFThKCviu6QyB54kiyzOgol
 GEdfoj8oJScD28FnI04NK/wBucr5sSSUmsPF8VIlZJOPkiuR6fwr4eUJUs1Zse9K
 Y4Z7khJ44Gx2Z6FAXYPJmreCnRxeCyA11g9XKl5DqmsrsmT11MTJL8emZo/3McV5
 EtX98rJuJHBWc+j4VnZDXK++/y3CPlnHWAU8/Z3dJFVl7x7ZGjy5ZzLgqKiyGuDb
 ns3D+Uv10zC4DTikxEFRg4IxuKsmUV2kTntZOcw3Q1khX9iRaZVEKkxFw2eWSJ9g
 ==
X-ME-Sender: <xms:29sFX_zxJWFJ7FyZSo26HQOniVnKfapb3mY5boX_nv-8S4z3WP43vQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudejgdekudcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehttdertd
 dttddvnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghs
 hhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeelhfeugedvje
 fgjefgudekfedutedvtddutdeuieevtddtgeetjeekvdefgeefhfenucfkphepudektddr
 vdefhedrfedrheegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:29sFX3SM1lj8GhTLrKDfALOveMD7ffS3jAU-mzMqJS_gI5KdsZX5Gg>
 <xmx:29sFX5Vd2p_b6xtIiIWs4-RftzYGpCrRv8Uca2wSwfK9as5Z761Lzw>
 <xmx:29sFX5giTQBMdi58SjhkMQHtuhUNnNIF74oJm7utnnFKbu0Iuuqgow>
 <xmx:29sFX0q4G3U3wplPlMHIQ9fwgXtU6yNQoqGX9x267sSMoyWUe8Mpeg>
Received: from workstation (ad003054.dynamic.ppp.asahi-net.or.jp
 [180.235.3.54])
 by mail.messagingengine.com (Postfix) with ESMTPA id F08C53280063;
 Wed,  8 Jul 2020 10:44:41 -0400 (EDT)
Date: Wed, 8 Jul 2020 23:44:39 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [RFT] ALSA control service programs for Digidesign Digi 002/003
 family and Tascam FireWire series
Message-ID: <20200708144439.GA27082@workstation>
Mail-Followup-To: Jaroslav Kysela <perex@perex.cz>,
 alsa-devel@alsa-project.org, sbahling@suse.com,
 ffado-devel@lists.sourceforge.net
References: <20200707125651.GA200100@workstation>
 <a322006e-bd58-4dba-f590-855be17a2cdb@perex.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a322006e-bd58-4dba-f590-855be17a2cdb@perex.cz>
Cc: ffado-devel@lists.sourceforge.net, alsa-devel@alsa-project.org,
 sbahling@suse.com
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

Hi Jaroslav,

On Tue, Jul 07, 2020 at 03:15:53PM +0200, Jaroslav Kysela wrote:
> Dne 07. 07. 20 v 14:56 Takashi Sakamoto napsal(a):
> > They have command line options. For all models of Digi 002/003 family, the
> > executable has an option for the numerical ID of sound card.
> > 
> > ```
> > Usage:
> >    snd-firewire-digi00x-ctl-service CARD_ID
> > 
> >    where:
> >      CARD_ID: The numerical ID of sound card.
> > ```
> 
> It's better to handle both card number and the card id string. In the latter
> case, the user may create independent environment and use udev or
> modprobe.conf configurations to address the devices. The card number may
> change when the plug-and-play devices are randomly connected / disconnected.
> 
> snd_card_new() - third argument.

Thanks for the comment and I also think it good idea for users to have
fixed configuration since the numerical ID of sound card differs
depending on system environment.

At the same time, I like to keep the specification of service programs
as small as possible. The numerical ID of sound card is enough to
identify target sound card, and it's sole way for it.

If implementing the idea, I need to add enough instructions about the
mechanism of card id string in kernel land so that users can utilize
it without any puzzle. Actually, the mechanism heavily depends on kernel
loadable module domain and I think it better not to consider that the
users are enough friendly to the domain.

Actually there are good tools to identify the numerical ID of user's
sound card, and usage of such tools are more friendly than module
manipulation and option documentation.

For future, I have a plan to write system service to handle udev
event and launch the service programs automatically. For the case,
the event includes enough information to construct arguments for
the service program, therefore no need to handle mapping information
and extra care of the card id string.

At last, the most of drivers in ALSA firewire stack don't support the
card id string, except for my initial work for bebob and fireworks
driver. If ALSA control core had a feature to change card id string
dynamically for existent card instance by ioctl command, or it had a
feature to maintain mapping between card id string and the other
identification such as system-wide or bus-wide UUID, I would be
willing to implement them to the drivers. At present, it's outside
of my work scope.


Thanks

Takashi Sakamoto
