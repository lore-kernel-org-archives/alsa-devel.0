Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DED38C433EF
	for <alsa-devel@archiver.kernel.org>; Sun,  3 Apr 2022 10:26:37 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1B22C17E9;
	Sun,  3 Apr 2022 12:25:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1B22C17E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1648981596;
	bh=RvHM58+WCVSmdblL+XcB4dmfmhFU3wC8gZT9rrOz3DY=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YfUgGb5XaqIZbew8MeDMi3MdmMjuXwXr2AJ2EtZUj43BNJBeuDF94nmgWTX2LEqyK
	 t+FVOGfHczUbxpEVMtfF7Cd+93zrTL04AlwiwMpHEE1UKcmkZdzDWvw/GVJSCZnqfX
	 1zeInXZdF4TCLGsJO4b1pKGa0tq596RcME0PW438=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7C225F8051B;
	Sun,  3 Apr 2022 12:25:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 553DDF8051C; Sun,  3 Apr 2022 12:25:04 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 10699F8050F;
 Sun,  3 Apr 2022 12:25:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 10699F8050F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
 header.i=@linuxfoundation.org header.b="WtvY7jHb"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id C35CA60FF8;
 Sun,  3 Apr 2022 10:24:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A416FC340ED;
 Sun,  3 Apr 2022 10:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1648981499;
 bh=RvHM58+WCVSmdblL+XcB4dmfmhFU3wC8gZT9rrOz3DY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=WtvY7jHbpQ0hk9paN5/seBFJmvgS7OB/skxReyOVy25PKTDkHbZIXjtPyvNtp4efi
 pH07baedTwQD2WyOQxBiuKoECvft8ECfBQk4gzgQDOHlQFvTF37qBe2plosclWSxLq
 lJgFirF+EEvFH+1nsHa8v8EAqJShGHYRcDcP55c4=
Date: Sun, 3 Apr 2022 12:24:48 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: Re: [PATCH for-stable] ASoC: SOF: Intel: Fix NULL ptr dereference
 when ENOMEM
Message-ID: <Ykl18HLtHn/xwtdC@kroah.com>
References: <20220402163026.11299-1-ammarfaizi2@gnuweeb.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220402163026.11299-1-ammarfaizi2@gnuweeb.org>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org, gwml@vger.gnuweeb.org,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, Takashi Iwai <tiwai@suse.com>,
 Keyon Jie <yang.jie@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>,
 stable@vger.kernel.org, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Rander Wang <rander.wang@intel.com>, Daniel Baluta <daniel.baluta@nxp.com>,
 linux-kernel@vger.kernel.org, sound-open-firmware@alsa-project.org
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

On Sat, Apr 02, 2022 at 11:30:26PM +0700, Ammar Faizi wrote:
> 
> Hello Greg,
> 
> commit b7fb0ae09009d076964afe4c1a2bde1ee2bd88a9 upstream.
> 
> Please take these two backport patches:
> 1. For Linux 5.4 LTS.
> 2. For Linux 5.10 LTS.
> 
> Both will be sent as a reply to this email.
> 
> Thank you!
> 
> =====
> 
> 5.4 failed report:
> https://lore.kernel.org/stable/164889915082249@kroah.com/
> 
> 
> 5.10 failed report:
> https://lore.kernel.org/stable/164889914960214@kroah.com/
> 
> -- 
> Ammar Faizi
> 

Both now queued up, thanks!

greg k-h
