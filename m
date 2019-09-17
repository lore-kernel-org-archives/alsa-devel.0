Return-Path: <SRS0=kA1C=XM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4658C4CECD
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Sep 2019 13:16:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE3B821852
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Sep 2019 13:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="i6JG8K23";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o7W0fe2x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE3B821852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AF8511612;
	Tue, 17 Sep 2019 15:15:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AF8511612
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1568726160;
	bh=Yn0v6PEePwEPrCcrM3BlaGKDYm53tUnnupU9/ZTPYws=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=i6JG8K23eAzLCcHo8ooMDe03Gdd38v+6KKCSWOY5HrRk/9XuZ8LzOumfVHpA5+9DN
	 IhW4f2tyHOVum96dMiFcXKThbPd/dxHPy2uo6B3xEGy+pvDlw4/Bp31ag9/3rcZfaQ
	 ZVBs/+mUC5uOm6dyX7iBaagg2BjYOqWYDGn+ThfE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 282D3F802BD;
	Tue, 17 Sep 2019 15:15:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D1DB6F80361; Tue, 17 Sep 2019 15:15:08 +0200 (CEST)
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com
 [66.111.4.224])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C8033F801DA
 for <alsa-devel@alsa-project.org>; Tue, 17 Sep 2019 15:15:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C8033F801DA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="o7W0fe2x"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailnew.nyi.internal (Postfix) with ESMTP id 97A23FBD;
 Tue, 17 Sep 2019 09:14:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute5.internal (MEProxy); Tue, 17 Sep 2019 09:14:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; bh=ffqGmWNtiPZdJLib8YEYpgiwbTPe8JllutnExPNwb
 RY=; b=o7W0fe2x6NVFIBlrExbsvY3GHf46LYfxuD1QRpG6dn4bCLmpBV0mGNJX8
 YDeTQj8JFyvJNkFLThTQN1SH3ftNNI31eL/KgO3zmmgdWNefYrB6nUprS0FqMZfo
 5RtFXq72yga6Z2vamy64FHnQ8zBHLGs3O6GGoBV/AswIRx7eXxqq/TMi5K/D3cef
 UHFj4orHH1DsX04ubBqjb5RFMHPGsTtmU0XYPNS6IR/B5bR/4VZ/aLHTN3D1J74q
 APiNM89zGWKQU6MRtteTdFZ8GTSwmtUFE2lNqDXbV9CxEVEA6M0I+G+3FwJDYkjX
 W7vwtub89YF3b7WeAh+kMyGf80UDA==
X-ME-Sender: <xms:UdyAXU-tZzOOcsIQwAofHmSytI4Zt4HYHl4iZHuXYKpcIPaWk2yf_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudeigdefhecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenog
 frhhhishhhihhnghdqkfhppfgvthifohhrkhculdeftddtmdenucfjughrpefkuffhvfff
 jghftggfggfgsehtjeertddtreejnecuhfhrohhmpefvrghnuhcumfgrshhkihhnvghnuc
 eothgrnhhukhesihhkihdrfhhiqeenucffohhmrghinheplhhisggvrhgrphgrhidrtgho
 mhdprghlshgrqdhprhhojhgvtghtrdhorhhgpdhprghtrhgvohhnrdgtohhmnecukfhppe
 duleeirddvgeegrdduledurdduvddvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtrghn
 uhhksehikhhirdhfihenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:UdyAXaghGlRDaE4duTpEeQ_BXwAusUFgyJlITr-YBCErz5na8Y11qQ>
 <xmx:UdyAXa7DHyE0KnNegIfEUnLTGvZS2ANyKcfUN1XUsvQ-vJt38H4PbA>
 <xmx:UdyAXfarlEN1ZppId-isDOjvwKLRbQRlSLU38FhFuRxrvyr3uas9GQ>
 <xmx:UtyAXaywAazk8Bd6n3wX7y8k8w16mTU6E4EypKMHpAcpglJLzEp-TA>
Received: from laptop (unknown [196.244.191.122])
 by mail.messagingengine.com (Postfix) with ESMTPA id CC283D6005E;
 Tue, 17 Sep 2019 09:14:56 -0400 (EDT)
Message-ID: <e294e2985eda906be3c3625235cc28643208dab2.camel@iki.fi>
From: Tanu Kaskinen <tanuk@iki.fi>
To: Takashi Iwai <tiwai@suse.de>
Date: Tue, 17 Sep 2019 16:14:53 +0300
In-Reply-To: <s5himprulnt.wl-tiwai@suse.de>
References: <20190904164706.gwjbcywbj7emnwvr@localhost>
 <s5hv9u19x2f.wl-tiwai@suse.de> <20190910173345.63bv2xa4vlkxicxj@localhost>
 <365e4bcc033c151076140471225db51c80808b7f.camel@iki.fi>
 <s5himprulnt.wl-tiwai@suse.de>
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Cc: alsa-devel@alsa-project.org, frederik <frederik@ofb.net>
Subject: Re: [alsa-devel] parameter for pulse device?
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

On Tue, 2019-09-17 at 14:55 +0200, Takashi Iwai wrote:
> On Tue, 17 Sep 2019 14:51:01 +0200,
> Tanu Kaskinen wrote:
> > On Tue, 2019-09-10 at 10:33 -0700, frederik@ofb.net wrote:
> > > On Mon, Sep 09, 2019 at 07:52:24PM +0200, Takashi Iwai wrote:
> > > > It depends on how pcm.pulse is defined.  If it's defined to take an
> > > > argument, it can work like that.  (Or sometimes you may need to pass
> > > > the argument explicitly like "pulse:{device=mointor}".)
> > > > 
> > > > The standard pcm.pulse definition provided in alsa-plugins repo
> > > > doesn't take the argument, and that can be the reason.
> > > 
> > > Thank you Takashi. Would it be easy to change alsa-plugins so that it
> > > takes an argument? Is there a chance that this change would be
> > > accepted?
> > > 
> > > If you can point me to the section of code in e.g. "plughw" where
> > > argument parsing is done, then I would probably end up modifying
> > > alsa-plugins myself, just to simplify what I am doing.
> > 
> > This commit might be instructive:
> > https://git.alsa-project.org/?p=alsa-lib.git;a=commitdiff;h=3c199a0d199f0fae78c9c1b19c11878a6134b3a8
> 
> Yes, thanks for pointing an example.
> 
> Now I took a quick look at the current code, and one remaining problem
> is that there is no device parameter value corresponding to the
> default (=NULL).  Maybe we should accept the string "default" to be
> treated as NULL, for example.
> 
> Ditto for the server parameter.

Maybe "", i.e. the empty string, would be a good choice for the special
string representing NULL? It's not a valid device name or server
address, unlike "default", so there can't be any conflicts. Not that
"default" is very likely to cause conflicts either.

-- 
Tanu

https://www.patreon.com/tanuk
https://liberapay.com/tanuk

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
