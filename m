Return-Path: <SRS0=elh7=Z2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E81AC43603
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Dec 2019 13:36:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E3672077B
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Dec 2019 13:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Xg/Ic1mk";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="WC6lCTOg";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NVHYB6PL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E3672077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2D67A1666;
	Wed,  4 Dec 2019 14:35:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2D67A1666
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575466559;
	bh=GD3acRgDFmynAZQa+O0P7U5FLrHgqW67NXpp5PScdLk=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Xg/Ic1mknqvilAszWtIQtpoK8rj2ez4UWOXR6KpSjEqQ49+0lYOUhSZDpk9N0FtNg
	 XIOYUqkw8BrK6ZxqOeSoSgeBa03q5WBN3YSY4kIRPI8sLqN5N0JM1+jaGOcna0bwJi
	 gII2hAg00xQ9SuGnKiJL2bB64NXSIp5qRhDWoj0s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 820BBF801D9;
	Wed,  4 Dec 2019 14:35:08 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 34556F801EC; Wed,  4 Dec 2019 14:35:06 +0100 (CET)
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1B3FCF8010F
 for <alsa-devel@alsa-project.org>; Wed,  4 Dec 2019 14:35:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1B3FCF8010F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="WC6lCTOg"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="NVHYB6PL"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.nyi.internal (Postfix) with ESMTP id 102CF22668;
 Wed,  4 Dec 2019 08:34:59 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute1.internal (MEProxy); Wed, 04 Dec 2019 08:34:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm3; bh=6AjFW+e5QrXYHnXK8jIRCF2gG8e
 MPaX9knwwsCzr0zA=; b=WC6lCTOgg7DyBHmqs6wj6e2ePomfPmIBUx+po7y4cRg
 /bcx1pkOiNXwHHEn4IJYwgSGtEAkgNiAuecQVpWZ/AyZsnDitbdDG4/Oi7aLqY+Y
 Y97ZXV3xLPkmfd5q+SMTLFrlb2IDWN50EYgZMjO68bt35P8nPz12KFPbxcYO7zw0
 vTKmnwZmOBD75S+5QROr6Eq/i7xze/tvejrSDpD5BoWKlR4B4TKT7o4WRhBDpF1s
 KdKWyn2DSvBzm+YghzthWets84fCRZYXPinqtF4KF2yu0CsoduKCaCimTmuO3DPT
 hu2MfagBPzJYTGIoBFnS3xnVRL5r4v2df4+z9FFNl8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=6AjFW+
 e5QrXYHnXK8jIRCF2gG8eMPaX9knwwsCzr0zA=; b=NVHYB6PLWE1hfvm4R26I36
 /x0reCHtMvOnySZtPrbt5fBdMPKiqlCRNr7v/1nEjWusdpQX2XCN2Fi4JPNIfwPe
 bPcLZrWcQAtSp2O3kPlZTE4CLQoZ9J/r6dzMON6FXetJVPcrXRudP7RFMELWHgjM
 m9WzerjnCNF3wpy0uewNGwa/IFoO/9Cid5MzBcZPu7hNE893pdcUOmuC6i7qcF3j
 wDN+VhY2LH7WMvwLSHvTolvOlHH8ra4KBNjH1gYT24m7k/WqVgcnL8yvz7RgAFsY
 XdSay4sqQe8svSRm6Zi4mQ0owLJnTd87h5tW5CnmVlyWrvn6AGIZ+WA62zS6uPow
 ==
X-ME-Sender: <xms:ArbnXf3CG09jx99NyNIYzXYtanLAY5HD379ALHxAvw189Qnq6Btvbg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudejledghedvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujggfsehttd
 ertddtredvnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
 rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucffohhmrghinhepghhithhhuhgsrd
 gtohhmnecukfhppedugedrfedrjeehrddukedunecurfgrrhgrmhepmhgrihhlfhhrohhm
 pehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhpnecuvehluhhsthgvrhfuih
 iivgeptd
X-ME-Proxy: <xmx:ArbnXfpPRJA21SJ14GulEAwI0qC8svtYAH9itbQOhNw8-4176vstCQ>
 <xmx:ArbnXWOQNMtsRXxbCmVw4O-YU3n6Qpt_mIuVbNSt46pegd1EAJCGYg>
 <xmx:ArbnXQqlBCheZ7iFRFQpvqD-9H0twkz8akFJAqOMpLf7V4EU5rsA0g>
 <xmx:A7bnXXpvG7dy73WLraU9jjzD9rv3XJ6GPN5LXtEEoLCNwjwl_28lbg>
Received: from workstation (ae075181.dynamic.ppp.asahi-net.or.jp [14.3.75.181])
 by mail.messagingengine.com (Postfix) with ESMTPA id 78D2C30600A8;
 Wed,  4 Dec 2019 08:34:57 -0500 (EST)
Date: Wed, 4 Dec 2019 22:34:54 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Jaroslav Kysela <perex@perex.cz>
Message-ID: <20191204133454.GA2578@workstation>
Mail-Followup-To: Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org
References: <20191201080449.GA408@workstation>
 <20191204003339.GA2876@workstation>
 <d0172374-857c-7663-1afc-acaf1a5d023d@perex.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d0172374-857c-7663-1afc-acaf1a5d023d@perex.cz>
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

On Wed, Dec 04, 2019 at 10:10:49AM +0100, Jaroslav Kysela wrote:
> Dne 04. 12. 19 v 1:33 Takashi Sakamoto napsal(a):
> > Would I expect your arrangement for this project, or should I continue
> > to develop it apart from alsa-project?
> 
> You're the only developer for this thus I'll shift the repos in the ALSA
> project on github. You should also write to README that this project is not
> using alsa-lib, thus the extra abstraction interfaces from alsa-lib cannot
> be used. Or do you plan to build gobjects on top of alsa-lib, too?

Mmm. I guess that there's miscommunication about the design of alsa-gi
project at first place. I remember you were not at the same room in the
audio mini conf.

The original alsa-gi is independent of alsa-lib[1]. This has been
immutable since I mentioned about the project in the audio miniconf[2],
thus alsa-gobject is just on <sound/asound.h> and <sound/asequencer.h> as
well. The project is thin layer between produced API and character devices
for applications to execute I/O as easy as possible. This point is
important to write tests and to implement some ctl/sequencer drivers in
userland.

For the design, at present, I have no plan to be on alsa-lib. Especially,
the combination of configuration space and domain specific language is
not surely supported. The below features of alsa-lib are not supported
by alsa-gobject:

 * text files for configuration space
 * parser of domain specific language
 * plug-in mechanism for all interfaces
 * hctrl interface
 * mixer interface and sctl plug-in mechanism
 * plug-in SDK for pcm/ctl interfaces

I think it possible to implement the equivalents by high-level
programming languages as well as the below features:

 * Parser/builder for Type-Length-Value array for ctl interface
 * Converter between MIDI messages and ALSA sequencer events
 * topology interface
 * ucm interface

But at present my concern is I/O between user/kernel space, thus I have
no plan to work for the above items now, except for TLV parser/builder.

[1] You can find no strings for 'alsa-lib' in meson.build.
https://github.com/takaswie/alsa-gi/blob/master/src/meson.build
[2] https://github.com/takaswie/presentations/blob/master/20181021/contents.md#mockup-alsa-gi


Regards

Takashi Sakamoto
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
