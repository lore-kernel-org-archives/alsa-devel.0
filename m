Return-Path: <SRS0=reWy=25=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04324C00523
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Jan 2020 09:55:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79CCA20705
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Jan 2020 09:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="fm8oZzhx";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="ZhKp0+ae";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dyRCe50A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79CCA20705
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B49E9170A;
	Wed,  8 Jan 2020 10:54:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B49E9170A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1578477336;
	bh=Cm4Vjw3T4BZJOHvZadHQWyd8/iSVJV57UEVvc9U4TRQ=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fm8oZzhxL4I2Wg70Zxzr5Y1alvVx0OUCYpCgPPcFqaRfSxZhVSWcp4XJ7iFy7hHmz
	 GKBofbcMxbZJD4UsKRsVKKgo+k8Y9OjqdEH/NH/KBL26sJDsTTJ5cl8/RLPHqDHEPY
	 p7TY+qOh0QAhLNKlc2E0hBF/2oWMfhVyRs9vND4g=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4B4FDF80149;
	Wed,  8 Jan 2020 10:54:46 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 00AE3F80159; Wed,  8 Jan 2020 10:54:43 +0100 (CET)
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 13302F8010B
 for <alsa-devel@alsa-project.org>; Wed,  8 Jan 2020 10:54:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 13302F8010B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="ZhKp0+ae"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="dyRCe50A"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.nyi.internal (Postfix) with ESMTP id E42F421EC3;
 Wed,  8 Jan 2020 04:54:34 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Wed, 08 Jan 2020 04:54:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm3; bh=FO3ror9j3ecUUm4jQ6i4ebbDLoc
 D3Re7L6fy48fzTTs=; b=ZhKp0+ae1XxFS5HO2VxJCaH+yuoudXzUSN3aw6BPn+q
 H2DToBKqmY/RgLbwE2hCRodi8eAkbyqUuIz01rJVr0i7yuZx2Mq50NtH5AIN1vov
 mbsWrI6DfgVEEGOGZrxrKI/pDb8NLSkdenzjzqkzuOIC/RMN+9z4ioOK3WNeZemv
 Mx5U8pJRYsofhyyOpyZ6YassXdG9uZxjOUi+tB9UccDfW6mEjUOXnxZyS2b+Enec
 cRr+6d0ehxyYrWf6l5Y4EAhTuOhHmN1BKcSzB5LiEsSRfojC2bLdBlNxjTgIuphb
 n64+AP9BbcQdpHekVxPAPoDQGRZLiKdOXlCcn6/2jdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=FO3ror
 9j3ecUUm4jQ6i4ebbDLocD3Re7L6fy48fzTTs=; b=dyRCe50AGMjp0GazEfZ9z/
 w0ngh3V/Y7dIXYzSHrRq1YWcu2tk5uBjG33iQb8OBb/WirV54X8Su1nhU/bvuGf0
 jlJcrcmoU/n9ZB7GrKCkreAQG0OF28ZDjOv7upI91KvL+OLf0nWR0DzEO0zAiVwT
 Ilr4ZF6qkjw3UkHWWZUXB5a6mo9PbxXRGi2Dv1rCVN7j2OdgSkh0KTmOf/tFMoTK
 FJ9RChMJxAvtl2v0fSBr98kJ3io8Rv5YVQQ9QoX9/0MrsSQKudILBrAyrrJvye4M
 2gWpzGJ37wovvJvwGJDkvROD9LazV+/DR7gFGjwPLkCA3srVJXd6ZDzXpuXgaYcw
 ==
X-ME-Sender: <xms:2qYVXs37azffVNAQL6eZnibjCRd-ONrnBrY4e9e4O9_YuoG4ESAFrg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvdehkedgtdelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjfgesthdtredttdervdenucfhrhhomhepvfgrkhgr
 shhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhird
 hjpheqnecuffhomhgrihhnpegsohhothhlihhnrdgtohhmpdhgnhhurdhorhhgnecukfhp
 pedugedrfedrjeehrddukedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrg
 hshhhisehsrghkrghmohgttghhihdrjhhpnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:2qYVXpujJRiPKYFVnBD0EuY_MNhvvrov-zjUot0sd9qsFRLZxgq0AQ>
 <xmx:2qYVXkaZAbAPYqVrx9eSLhenOJw1GfqveRCmxkUEqBFqboWMUF7M6g>
 <xmx:2qYVXnIacRDQ2LdQrOQap_v6maJmsAk-KhUNuD5mwI2tp0YRpcaGBg>
 <xmx:2qYVXr9weGEsPnaAQ3KcYXcHTSRlvcHR7OPv8UyIIR-H3tfY6N6Fmg>
Received: from workstation (ae075181.dynamic.ppp.asahi-net.or.jp [14.3.75.181])
 by mail.messagingengine.com (Postfix) with ESMTPA id 8149980063;
 Wed,  8 Jan 2020 04:54:33 -0500 (EST)
Date: Wed, 8 Jan 2020 18:54:31 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: The Dream Master Solo <dreammastersolo@gmail.com>
Message-ID: <20200108095430.GA16741@workstation>
Mail-Followup-To: The Dream Master Solo <dreammastersolo@gmail.com>,
 alsa-devel@alsa-project.org
References: <CAFmvAS8d0DCbJnzZjFbAD9-mP6gjRzjeEiVzOHDyCY5TLPKknw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAFmvAS8d0DCbJnzZjFbAD9-mP6gjRzjeEiVzOHDyCY5TLPKknw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] Tascam Coding Inquiry
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

Hi,

On Wed, Jan 08, 2020 at 01:36:36AM -0700, The Dream Master Solo wrote:
>    Hello and good day to you. I am reaching out in regards to code I've
>    found online. I looks like you are the author.
>    [1]https://elixir.bootlin.com/linux/v5.5-rc5/source/sound/firewire/tascam
>    I am interested in using this code in creating a 64 bit driver for OSX
>    10.13 or newer. I've just begun to learn coding a few weeks ago. Any
>    help that you can give me towards accomplishing this goal would be
>    greatly appreciated!

It's my pleasure to help developers ;) You can freely utilize the idea
written in the source of ALSA firewire-tascam driver with respect for
the modern framework of copyright treaty and law.

(This is one of my aim to publish the result of my reverse engineering
work for the series of device; FW-1884, FW-1082, FW-1804 and FE-8.)

I notice that it's better for you to have enough care of software
licensing itself. The source of driver is licensed under GNU General
Public License version 2.0 (GPLv2)[1]. Roughly speaking, when you just
copy any code from the source of driver to your software and distribute
your software to the others, your software should be licensed by GPLv2
or compatible ones because it includes lines in the source of driver.
On the other hand, as long as you write your software by your hand at
first place, you can freely license your software because the borrowing
of idea is free from the license on the copyright treaty and law.


Well, ALSA firewire-tascam driver uses controllers compliant to 1394
OHCI specification to communicate to the devices. For this purpose,
the driver uses kernel implementation of Linux FireWire subsystem. I
think that MacOS still includes the similar implementation and as a
first step you start study for it. Additionally the specification of
1394 OHCI will help your work:
 * 1394 Open Host Controller Interface Specification Release 1.00
   (October 20, 1997, Promoters of the 1394 Open HCI)
 * 1394 Open Host Controller Interface Specification Release 1.1
   (January 6, 2000, Promoters of the 1394 Open HCI)

[1] https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html


Regards

Takashi Sakamoto
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
