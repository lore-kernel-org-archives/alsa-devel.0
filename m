Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01FCFC6FA82
	for <alsa-devel@archiver.kernel.org>; Fri, 23 Sep 2022 08:44:08 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D476883D;
	Fri, 23 Sep 2022 10:43:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D476883D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1663922646;
	bh=xuDq04V3ERIqON4UuLH1RmjGkFR75KWm8lnYzEvFeDI=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IQGxByAU9i+IyQ4qtnB6zwtb+VNMt0cLx5oqANa2JiutyzST+uMzOl7MjUCy9DX0R
	 RiAU9+YxSD6kgi+US9ksZmneJxUkBvxJtMkKZLPqyA4FR5FWgvEo1xdhwuq1rtdHvA
	 5hxGfsPVhR06Qn35mMHZjwtxqsvjw8pl1fWz7GwQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D57E8F80539;
	Fri, 23 Sep 2022 10:42:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0FA5BF80155; Tue, 20 Sep 2022 07:25:08 +0200 (CEST)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5B526F800C9
 for <alsa-devel@alsa-project.org>; Tue, 20 Sep 2022 07:25:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5B526F800C9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="LHecsjIM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1663651505; x=1695187505;
 h=date:from:to:cc:subject:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=xuDq04V3ERIqON4UuLH1RmjGkFR75KWm8lnYzEvFeDI=;
 b=LHecsjIMcxi9LPtOYxrBMTecEvzQcer05YVvlTAR4yPFZdXAXLgNvpjs
 IEMOgk9YDzE3WQvSPjHu6u6GL6OnO1wX9Wn6zPGkEp53p4nlPRmL1Gz+U
 VqhkpdxrCrWlG6kNTYzlz5092lk3ktx3XwaWMoh4YRtrVSFYYqvp27Mut
 ZhDlBshMksXSZhpWWzz5tXRQ4QJoRIEfiH3A1cbc+xyJIHwZjFq3h1n5c
 tLDFD5lW3RL1B6DB+m1zC2ehVwDnac0I/WXL84kTQtdIHMF6LRn5ewL2f
 sGRfbKs7fKgB0QbCuvJubL4B4WD63FMQgRv+A9SGBmPlKv/rw9JN83/9C g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="282629096"
X-IronPort-AV: E=Sophos;i="5.93,329,1654585200"; d="scan'208";a="282629096"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2022 22:25:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,329,1654585200"; d="scan'208";a="794124954"
Received: from linux.intel.com ([10.54.29.200])
 by orsmga005.jf.intel.com with ESMTP; 19 Sep 2022 22:25:01 -0700
Received: from maurocar-mobl2 (maurocar-mobl2.ger.corp.intel.com
 [10.252.59.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by linux.intel.com (Postfix) with ESMTPS id C58B4580713;
 Mon, 19 Sep 2022 22:24:56 -0700 (PDT)
Date: Tue, 20 Sep 2022 07:24:54 +0200
From: Mauro Carvalho Chehab <mauro.chehab@linux.intel.com>
To: Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH v6 0/4] Let userspace know when snd-hda-intel needs i915
Message-ID: <20220920072454.4cf91f24@maurocar-mobl2>
In-Reply-To: <Ynl7xGy+a9MYjXi1@bombadil.infradead.org>
References: <cover.1652113087.git.mchehab@kernel.org>
 <Ynl7xGy+a9MYjXi1@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 23 Sep 2022 10:42:24 +0200
Cc: alsa-devel@alsa-project.org, Richard Weinberger <richard@nod.at>,
 Kai Vehmanen <kai.vehmanen@intel.com>, Greg KH <gregkh@linuxfoundation.org>,
 intel-gfx@lists.freedesktop.org, Lucas De Marchi <lucas.demarchi@intel.com>,
 Takashi Iwai <tiwai@suse.com>, dri-devel@lists.freedesktop.org,
 Vignesh Raghavendra <vigneshr@ti.com>, David Airlie <airlied@linux.ie>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 linux-modules@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
 linux-mtd@lists.infradead.org, Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-kernel@vger.kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@intel.com>
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

Hi Luis,

On Mon, 9 May 2022 13:38:28 -0700
Luis Chamberlain <mcgrof@kernel.org> wrote:

> On Mon, May 09, 2022 at 06:23:35PM +0200, Mauro Carvalho Chehab wrote:
> > Currently, kernel/module annotates module dependencies when
> > request_symbol is used, but it doesn't cover more complex inter-driver
> > dependencies that are subsystem and/or driver-specific.
> >   
> 
> At this pount v5.18-rc7 is out and so it is too late to soak this
> in for the proper level of testing I'd like to see for modules-next.
> So I can review this after the next merge window. I'd want to beat
> the hell out of this and if possible I'd like to see if we can have
> some test coverage for the intended goal and how to break it.

Any news with regards to this patch series?

Regards,
Mauro
