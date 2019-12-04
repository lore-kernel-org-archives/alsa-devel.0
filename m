Return-Path: <SRS0=elh7=Z2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B14F8C432C0
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Dec 2019 00:34:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B04D320674
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Dec 2019 00:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="h3E8kq2e";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="a/Owld5g";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X27DFwuz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B04D320674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7B9B883E;
	Wed,  4 Dec 2019 01:33:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7B9B883E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575419683;
	bh=ml1+S6PeDnLlNZ/LtnlAHT669aOzXdXGc2YUxn6WYes=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=h3E8kq2eTuqbWtM2qRjQbNlsP9Zs8/BFS49F16aH3n/qXohNiIT35bjViAsFIjU1i
	 YLvnvVAOcypvvuesfidv5VNS9QZy93XwxEHlhmg7soL1X3sBVJN/DMaYl8Q+HdbmD8
	 bKcVq0hZEj8aIuUXCBKYtUJ529F0RfgBwlzFwnQc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 03BD3F8015A;
	Wed,  4 Dec 2019 01:33:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4ED47F80227; Wed,  4 Dec 2019 01:33:51 +0100 (CET)
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 042F1F800F0
 for <alsa-devel@alsa-project.org>; Wed,  4 Dec 2019 01:33:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 042F1F800F0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="a/Owld5g"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="X27DFwuz"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.nyi.internal (Postfix) with ESMTP id BE31D22411;
 Tue,  3 Dec 2019 19:33:44 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Tue, 03 Dec 2019 19:33:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm3; bh=HoS5/hFr6r7FU+ju7/vGxzxB+Ty
 a/M3JfutX9u46Q2A=; b=a/Owld5gs+bJJaYuyHsqZ20YpkM3sKZX9ilkh2gbw77
 ooOk8aIdJRGH1pTYspWxbDbHojNGwQoGkDwooaUp+t0nBtk254ZAMeb/X9t4Uc8S
 tl+Pb53GBc7+zhzBXydkQ+kODxL4gvdgpxDnlVSg1C5akRLjuqv/f4j99dlBxi3X
 4AxHJGtMsMf9o2+vSJvmCIh0alxekjt+4I5ulQ34mkRNjt5cC4VDN8eTnllsiVqn
 9ZcqUvOqVzfOobdvnG6hQKkAPl5ks+JpjAZ2G1M0mb9Rh4Rm1Fjr+9pppm6YWXEd
 Lx9M3sGTxsppm9SpKjWMZIbEgAxLL9+hjpy1zsLp7xA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=HoS5/h
 Fr6r7FU+ju7/vGxzxB+Tya/M3JfutX9u46Q2A=; b=X27DFwuzjrXRgO7AMSGADF
 ivC12cMCfNwgu/Ym453eBJEigOKFd09+AfiWbvf5PK6oDBGFVSqjA+Vm7NU1ODgL
 SqbeCoHvD68lexwImjRV+Kq4Cm49IvXSg99Er/SNoKWCcDK7X0C28ssOq0V0GFMu
 +FMDJCiENaJoA0iGEZ0SHl7nUZMB3oUXWJtrZeYkkRC26ThBsVTtWMyMwEPk6QNT
 dqpyLwu/+MSpdapi5PkTBltu0MJYmESdkbXmyEtuNTS9C3hqtr179sdFQ19l07ER
 P0z27Ej7eHl5cNFNmqCnjVvT+Z99SXD0SfLclgGkOCxAP+D5+ElPIwkuQK+lTF8g
 ==
X-ME-Sender: <xms:6P7mXQo2hw1qCAwm3ETB3YNhxfHzwSKDLbqiYFjGL_mL5bwBtdOJEA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudejkedgvdefucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujggfsehttd
 ertddtredvnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
 rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucffohhmrghinhepmhgrihhntghonh
 htvgigthdrnhgvfidpghhithhhuhgsrdgtohhmpdhmrghinhhlohhophdrnhgvfienucfk
 phepudegrdefrdejhedrudekudenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkh
 grshhhihesshgrkhgrmhhotggthhhirdhjphenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:6P7mXQSx65XUdm42pPmEJMfRhs4bA1-FKhXrba00le0-VQQfQ3CDnA>
 <xmx:6P7mXVPu5e-NVXC13kFyegi4by-fPUOA15eKyTJMiJOeCj3IyOREEg>
 <xmx:6P7mXbMTB5zIyj4gxvyYA6zNQxQDdFtn2BLjX03Rk5U4TwhXpM9UEA>
 <xmx:6P7mXYmXFiDKrc2Xelom5K1k2Knn4MS7OvKofgGCtXIC8V4xxYvbmQ>
Received: from workstation (ae075181.dynamic.ppp.asahi-net.or.jp [14.3.75.181])
 by mail.messagingengine.com (Postfix) with ESMTPA id 43C498005B;
 Tue,  3 Dec 2019 19:33:43 -0500 (EST)
Date: Wed, 4 Dec 2019 09:33:40 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: perex@perex.cz
Message-ID: <20191204003339.GA2876@workstation>
Mail-Followup-To: perex@perex.cz, alsa-devel@alsa-project.org
References: <20191201080449.GA408@workstation>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191201080449.GA408@workstation>
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

On Sun, Dec 01, 2019 at 05:04:50PM +0900, Takashi Sakamoto wrote:
> Since Audio Mini Conference 2018, I continued to work for alsa-gi[1] in
> my local to integrate toward better I/O libraries. However I realized
> that its basic design includes some disadvantages to produce useful APIs.
> 
> I rethink the design and realize it better to wrap each of structures
> in <sound/asound.h> simply. Then, I restart it as alsa-gobject[2].
> At present, master branch includes a library, `libalsactl0` for the
> most of I/O features in ALSA control interface, which is compatible with
> GObject mechanism and GObject introspection.
> 
> Jaroslav, would you please delete the alsa-gi repository and fork
> the master branch from my alsa-gobject repository, then apply enough
> configurations to the new repository?
> 
> 
> My repository includes four branches as well for ALSA
> hwdep/rawmidi/timer/seq interfaces. The most of features in each
> interface is already available via included libraries but under heavy
> development.
> 
> I already start to test them with Python 3 (PyGObject) and they seem
> work well. I also test them with Rust bindings generated by gtk-rs/gir[3]
> tool. Near future I also publish Rust crates for further convenience.
> 
> 
> For your interests, this Python 3 script is a sample to listen one
> event from ALSA control character device. This simple program is not
> terminated voluntarily or by sending UNIX signal, thus please generate
> control event by alsamixer or amixer:
> 
> ```
> #!/usr/bin/env python3
> 
> import gi
> gi.require_version('GLib', '2.0')
> gi.require_version('ALSACtl', '0.0')
> from gi.repository import GLib, ALSACtl
> 
> class MyCard(ALSACtl.Card):
>     def __init__(self, card_id, ctx, dispatcher):
>         super().__init__()
>         self.open(card_id)
> 
>         self.create_source().attach(ctx)
> 
>         self.__dispatcher = dispatcher
> 
>     def do_handle_disconnection(self):
>         self.__dispatcher.quit()
> 
>     def do_handle_elem_event(self, elem_id, events):
>         # Print the first event and quit event loop.
>         print(elem_id.get_iface().value_nick,
>               elem_id.get_device_id(), elem_id.get_subdevice_id(),
>               elem_id.get_name(), elem_id.get_index(),
>               events.value_nicks)
>         self.__dispatcher.quit()
> 
> 
> ctx = GLib.MainContext.new()
> dispatcher = GLib.MainLoop.new(ctx, False)
> card = MyCard(0, ctx, dispatcher)
> 
> dispatcher.run()
> ```
> 
> [1] https://github.com/alsa-project/alsa-gi
> [2] https://github.com/takaswie/alsa-gobject
> [3] https://github.com/gtk-rs/gir

Would I expect your arrangement for this project, or should I continue
to develop it apart from alsa-project?


Regards

Takashi Sakamoto
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
