Return-Path: <SRS0=1tVn=5J=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1006C10DCE
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Mar 2020 04:34:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 329B220714
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Mar 2020 04:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="S3ztNC7Q";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="nOt1Fpmc";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="3l6lc9ei"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 329B220714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 61536886;
	Tue, 24 Mar 2020 05:33:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 61536886
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585024483;
	bh=LYR21+iEciL5wSp6Feg5Jys/m7fDb7g4Awj2zn5f+PM=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=S3ztNC7QCOOvgfjXZ36FaJvRhzHGkCeaTobPbikG2LXkSgEz+0TTLgkrtNTCt6sHa
	 NCsT1b1Jp69wDBzEDfCkRhTgApy8sTphbei0mI6D0XQO7GSc3P4dgR1xFhUnfSBiM0
	 3uB8mvqqZJehX1OdcxZIrrNLaKfoBw+KH0zr6bl0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C0573F801F8;
	Tue, 24 Mar 2020 05:33:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A684CF801F9; Tue, 24 Mar 2020 05:33:49 +0100 (CET)
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 026C7F800B9
 for <alsa-devel@alsa-project.org>; Tue, 24 Mar 2020 05:33:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 026C7F800B9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="nOt1Fpmc"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="3l6lc9ei"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
 by mailout.nyi.internal (Postfix) with ESMTP id 253D45C0175;
 Tue, 24 Mar 2020 00:33:41 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute2.internal (MEProxy); Tue, 24 Mar 2020 00:33:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=AxD+NP1PALnv0ubHDZDdV54ODew
 skX6J3+HDgStYDvk=; b=nOt1FpmcbZi47wG63CtHvOBMScWuiLZHF1hOLcgEKFO
 E6aw4Pd67zclySB5fthJ2/M2ijT+9k88i6B4j+C4RUjZNYnTxADbEScX9ApYJmaQ
 LfGwPJdgfa8URHy39TInMdBnzp3/8xC52o9STni0LCCWY0UUsgVrS7MqsOJaPkJf
 XP/7KYQ1TX1qOG2svvZPWIdEfBJwVQh43JDwyaDGjyF9TGiomHmz9Nl/W8TVMMc2
 WeZ6bly2I/FC0MluQiW1CMgVIjd5hpr7MlHC9GBF3rwXV6pzQUN+4+iWCiFN+UpX
 rUtQVD/+ow2u0b/K4VzcpXu9Wko8CitVvHIUOxhqI5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=AxD+NP
 1PALnv0ubHDZDdV54ODewskX6J3+HDgStYDvk=; b=3l6lc9eiWux6UmEFx222M9
 NmMb3fv6DoE+T/bTJGW5JxrwbfOUGHF67Z5BCyvQVN2jzHtnbrUyB1LJjqPI3D2W
 Wgk3UKPKRi16s5XSRCX8Peo0tjbxnA7unNH1dS+1obZmhuFD/CQgmXX4zUNAzNHB
 zquU05oZJVQJN6X58fi5q3WbEHnJBLO9L8//5M+ng4EoV/HZhxbTjU4Y/UkUm3o+
 CRNZA1aDquL1VQkB+LY86hPf1DWykDqD6wDUnfYSyTeGWz2xS7ysZYHMHsIUSV97
 WpRa0GgWZqGkRbG0lPMRiwUOuOWqckBpsGrJ3cSd5PWrEzAqEaD3c2HCO6L10OGA
 ==
X-ME-Sender: <xms:o415Xm4bS_eW9jvxRgmdXSH45AI-Af3GrzhHC0KomVfIZQqrYpzf5A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrudegledgieelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjfgesthdtredttdervdenucfhrhhomhepvfgrkhgr
 shhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhird
 hjpheqnecukfhppedugedrfedrjeegrdduieeknecuvehluhhsthgvrhfuihiivgeptden
 ucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthh
 hirdhjph
X-ME-Proxy: <xmx:pI15XiTulnwHb2kv29AHj_ogiUp2td00Y05KCT8LPv7SOV9Ss8gxTA>
 <xmx:pI15Xm748i8mCekDU7h3suKR9mFWMHiiZFvGTGL_d2sSEF5HDWfHtA>
 <xmx:pI15Xk2tjBlGKAbgAE1F5VDvQG7QRQpuQPSrJt_1cpW8hooGTJl4Xg>
 <xmx:pY15Xosf-K-YN0NobQmv0mefVjAPFpU4mlcPZ0NvPPNtrmtqm5WNjg>
Received: from workstation (ae074168.dynamic.ppp.asahi-net.or.jp [14.3.74.168])
 by mail.messagingengine.com (Postfix) with ESMTPA id E78E43063669;
 Tue, 24 Mar 2020 00:33:38 -0400 (EDT)
Date: Tue, 24 Mar 2020 13:33:36 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ALSA: core: sysfs: show components string
Message-ID: <20200324043336.GA8342@workstation>
Mail-Followup-To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, 
 alsa-devel@alsa-project.org, tiwai@suse.de,
 broonie@kernel.org
References: <20200323193623.3587-1-pierre-louis.bossart@linux.intel.com>
 <20200324015331.GA3679@workstation>
 <d31659cc-d528-345f-1e56-b0cfae36be5c@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d31659cc-d528-345f-1e56-b0cfae36be5c@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org
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

On Mon, Mar 23, 2020 at 10:34:23PM -0500, Pierre-Louis Bossart wrote:
> On 3/23/20 8:53 PM, Takashi Sakamoto wrote:
> > Hi,
> > 
> > On Mon, Mar 23, 2020 at 02:36:23PM -0500, Pierre-Louis Bossart wrote:
> > > Add attribute and show the components string. This is useful to see
> > > what is provided to userspace and e.g. used by UCM to understand the
> > > card configuration:
> > > 
> > > root@plb:~# more /sys/class/sound/card0/components
> > > HDA:8086280b,80860101,00100000 cfg-spk:2 hs:rt711 spk:rt1308 mic:rt715
> > > 
> > > Note that the style uses what's recommended by checkpatch.pl and is
> > > slightly different from other sysfs attributes.
> > > 
> > > Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > > ---
> > >   sound/core/init.c | 12 ++++++++++++
> > >   1 file changed, 12 insertions(+)
> > I have a concern about this patch in a point of userspace interface.
> > 
> > The 'component' field of 'struct snd_ctl_card_info' is just defined to
> > have strings with space-separated chunks, and its actual value is not
> > so fine-documented, thus it's largely different depending of developers
> > of each driver.
> 
> In case you missed it, the components are used by machine drivers to report
> e.g. number of speakers, mics, etc, so that UCM can find the right
> configuration. For a given family of products, the syntax will be fixed,
> e.g. hs stands for headset codec, etc.
 
Actually the syntax is just fixed to devices which a part of ALSA
in-kernel driver supports. There's no specification widely used to all of
ALSA in-kernel drivers.

(Of cource, it covers many of actual devices which assumed users own.)

> > $ cat include/uapi/sound/asound.h
> >       ...
> >   941 struct snd_ctl_card_info {
> >           ...
> >   950     unsigned char components[128];  /* card components / fine identification, delimited with one space (AC97 etc..) */
> >   951 };
> > 
> > On the other hand, the node of sysfs is quite common in Linux because
> > it's tightly coupled to kernel objects. Let you see files under
> > 'Documentation/ABI/'. We can find efforts to maintain sysfs node so
> > safe and stable. Due to this reason, it's better to take more care when
> > adding new node.
> > 
> > Would I request you the reason to add this node and the reason that
> > current ALSA control interface doesn't satisfy your requirement?
> 
> simplicity for user support. Anyone can peak at a sysfs file, not everyone
> is familiar with the alsa control interface.
> 
> We get lots of bug reports from people who are asking for configuration
> help, and the simpler the command is the better.

For my information, would I request you to disclose the part of such reports?

I need supplemental information about the reason to add the alternative
path to expose it, especially the reason that no developers work to
improve existent tool relevant to UCM and are going to wish to add the
alternative without utilizing ALSA control character device.


Regards

Takashi Sakamoto
