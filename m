Return-Path: <SRS0=xxPz=2E=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AFC3C43603
	for <alsa-devel@archiver.kernel.org>; Sat, 14 Dec 2019 16:53:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8249A2465B
	for <alsa-devel@archiver.kernel.org>; Sat, 14 Dec 2019 16:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="rnM47Ig1";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="Qf5EtPEf";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ymE61kp9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8249A2465B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5B4EC1668;
	Sat, 14 Dec 2019 17:52:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5B4EC1668
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576342426;
	bh=B0oydHAvWqG6P5hZM8+el/Vo9YZW65LQl687xaNm7fk=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rnM47Ig1Dzpr/yjC/ROIUGMYtco01qxXl/W/gck1JGtqZjmd9aDHlfBrfmEToJK6H
	 mzbSR6D+e2Jf3TB/Bs/waHCJX+vuX+6pVgN524YdmNkKWgnD0g9pQck0nDM4VH60rv
	 qp6YK6f3B4hU2u/fsHWwtzCujmDd+aut2rGtRo6g=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D9540F8014F;
	Sat, 14 Dec 2019 17:52:55 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 22E9EF8020C; Sat, 14 Dec 2019 17:52:55 +0100 (CET)
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 70EA4F8014F
 for <alsa-devel@alsa-project.org>; Sat, 14 Dec 2019 17:52:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 70EA4F8014F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="Qf5EtPEf"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="ymE61kp9"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.nyi.internal (Postfix) with ESMTP id 590402251A;
 Sat, 14 Dec 2019 11:52:48 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Sat, 14 Dec 2019 11:52:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm3; bh=vKnzcJruGs+WMjaKysxM9n8QHpy
 FfscUhPXrG3taV2s=; b=Qf5EtPEfy5cpO1nD5jcQR0stidIjL5/rO+aj7WLbt6B
 qaQTiMlDcsNrq9x3QiVLHAN4oCfF8cQDQCmvmVCGtOVOXccZ0GnBvf2cdDc3Jxj+
 a1QwP6iH4bVu7xWmUZfer2oiB2Wt/rQYHvH009Iujl+Z8oID04eRy9jHBXR3P2MP
 h2js+8ef+n4Eeyc5KjY8o1Uh9qB7jPqFYlo1dmJ1INUHtAF17DZPeax9JnDNgBhK
 WYyzYbn5wHS1zPwmWnGNAe5U9LYkWbS49d7JLjYU+fJMWwEzZ2t3RcKzm4/CM0B9
 JPr4ZlTjN5xF6KTVOh6rCyva3EyahaGGvoYwv5fwyOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=vKnzcJ
 ruGs+WMjaKysxM9n8QHpyFfscUhPXrG3taV2s=; b=ymE61kp9Iw5Bde/JCAGr2l
 Z0CHzy1N+5EX+Ea9kVxGAW1a7L24TY5sefP8PNYlHX0pdO0JVQXLE3XXD6+6RVcR
 Xr/QJuP/2cVcGYRh4dl0Crbkd2PZN5fH1msPG2z/OEDHFV9SrBI3jzut6wxplVC6
 LRDyf4ESmGReu8nnClpXer6tDPGh0jlospI0suHkkbvmhdVVycU3JqUluF2oLnI1
 Iv3SDWphIHEj1jIjoVUrN7yTttGCLsfabL1CLfypcBCMy07E6T4FB5bdLjZz1NIu
 4P5kXWmsGixk01vJcYsHtjP3fLn/QFh9LR5gAe34fp0GOtIg276IxQ2y9vqT+cnw
 ==
X-ME-Sender: <xms:XxP1XXzyGeY2fEOX6YbHI-AZ-DbZ5RIabOtpazNLxz9nFlL8EeVTYA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvddtuddgleehucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucgoufhushhpvggtthffohhmrghinhculdegledmne
 cujfgurhepfffhvffukfhfgggtuggjfgesthdtredttdervdenucfhrhhomhepvfgrkhgr
 shhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhird
 hjpheqnecuffhomhgrihhnpehgihhthhhusgdrihhopdhgihhthhhusgdrtghomhdprghl
 shgrqdhprhhojhgvtghtrdhorhhgnecukfhppedugedrfedrjeehrddukedunecurfgrrh
 grmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhp
 necuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:XxP1XZWxIfQh-Pk4X6fB_zZI7vw_EfHPww-70xMDZdsKdVs6WDhyUA>
 <xmx:XxP1XWTG6jBLE68J1FiGDgqgJXXyMf4TtSlCE5-wU8VD1PoeWsNXVw>
 <xmx:XxP1XZQzUtiohybsqgw-cZ8SxPF4A_351yQt7sEaa7-ylBKo8ckZYg>
 <xmx:YBP1XYctkp6qU-8H_nWgd8Zzv2WzcN6wy2aaVyGHhhmZhxdEiDorjQ>
Received: from workstation (ae075181.dynamic.ppp.asahi-net.or.jp [14.3.75.181])
 by mail.messagingengine.com (Postfix) with ESMTPA id F405C80060;
 Sat, 14 Dec 2019 11:52:45 -0500 (EST)
Date: Sun, 15 Dec 2019 01:52:43 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Jaroslav Kysela <perex@perex.cz>
Message-ID: <20191214165242.GA32025@workstation>
Mail-Followup-To: Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org
References: <20191201080449.GA408@workstation>
 <b121b3eb-3bb8-7efc-d5e1-f470049899b7@perex.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b121b3eb-3bb8-7efc-d5e1-f470049899b7@perex.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] Restart alsa-gi project as alsa-gobject project
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Hi Jaroslav,

On Fri, Dec 13, 2019 at 12:17:12PM +0100, Jaroslav Kysela wrote:
> Dne 01. 12. 19 v 9:04 Takashi Sakamoto napsal(a):
> > Hi Jaroslav,
> > 
> > Since Audio Mini Conference 2018, I continued to work for alsa-gi[1] in
> > my local to integrate toward better I/O libraries. However I realized
> > that its basic design includes some disadvantages to produce useful APIs.
> > 
> > I rethink the design and realize it better to wrap each of structures
> > in <sound/asound.h> simply. Then, I restart it as alsa-gobject[2].
> > At present, master branch includes a library, `libalsactl0` for the
> > most of I/O features in ALSA control interface, which is compatible with
> > GObject mechanism and GObject introspection.
> > 
> > Jaroslav, would you please delete the alsa-gi repository and fork
> > the master branch from my alsa-gobject repository, then apply enough
> > configurations to the new repository?
> 
> Hi Takashi,
> 
> I am sorry that it took so long but I was really busy with other things.
> The alsa-gobject repository is set, synced with git.alsa-project.org now
> like other repos. The settings should be similar to alsa-gi, so you should
> have write permissions. If you hit any issue, just let me know.
> 
> The original alsa-gi repository was archived and I will remove it later.
> 
> There is only one difference - I did not clone this repo from yours via
> github. It might make sense, if you fork the alsa-project repo to your
> github repository and push your changes back (alsa-project/alsa-gobject ->
> takaswie/alsa-gobject), so the fork link system on github will be updated
> properly.

Thanks for your arrangement against the busy week ;) According to your
instruction, I update my remote repository for the link system. My
remote alsa-gi repository is also private now and will be removed enough
later.

Here excuse me for request you another work for documentation of
alsa-gobject. I utilize glib/gobject architecture developed by GNOME
project for gtk+. Documentation can be automatically generated by
gtk-doc. I'd like to publish the documentation in github pages[1]. I'd
like you to add another repository to maintain the publish the
documentation.

You can see an actual example of documentation for libhinawa. The
documentation is available in URL of github.io, and published documents
are maintained in my remote repository[3].

But this is not a kind of urgent work. I'm OK that you make it enough
later ;)

[1] https://pages.github.com/
[2] https://takaswie.github.io/libhinawa-docs/
[3] https://github.com/takaswie/libhinawa-docs


Thanks

Takashi Sakamoto
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
