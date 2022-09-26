Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A034DC32771
	for <alsa-devel@archiver.kernel.org>; Mon, 26 Sep 2022 14:05:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D4CEA828;
	Mon, 26 Sep 2022 16:04:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D4CEA828
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1664201147;
	bh=QWIUj5390jT/xGz2yVzEkO1spRWX7snq8eHKuhuvv8k=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=se2gbJBpW9rroUAZwVnwDzVj/Irh7ENb6hGbMwxLQpAYS1aUANUKlruAa9R3bimAT
	 lDplQ5SxFNawVmlMdu6VSAeqF0mFPkA79L9OpgDPndUY08q7HfcLZaKHclS66cT741
	 9nbB9PJbZNpT8pJImPItg5MhhN3zc+92VK7lmflA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 71F6EF80254;
	Mon, 26 Sep 2022 16:04:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8386EF8027D; Mon, 26 Sep 2022 16:04:56 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9DC55F80115
 for <alsa-devel@alsa-project.org>; Mon, 26 Sep 2022 16:04:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9DC55F80115
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
 header.i=@linuxfoundation.org header.b="KUyRLlk4"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id EB0A160DD6;
 Mon, 26 Sep 2022 14:04:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A95D6C433C1;
 Mon, 26 Sep 2022 14:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1664201086;
 bh=QWIUj5390jT/xGz2yVzEkO1spRWX7snq8eHKuhuvv8k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KUyRLlk4VjBT+WwHeKGEZCAJDAj1g7kfKkZa9jAo1+pjbufX9tQ5DEYBBrlvmKKV2
 rylJZbznxQmtcGZAx1LZX5kwS2H1kEbhk0vAFtU8uJZMwn9zhvZ92MwfzVvoZAhoUS
 Mon1veE80QQSuNqxHeR9qcR2364bAhua8at1Qjv4=
Date: Mon, 26 Sep 2022 16:05:19 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH 11/11] usb: gadget: Replace runtime->status->state
 reference to runtime->state
Message-ID: <YzGxn2PK7811Vhb0@kroah.com>
References: <20220926135558.26580-1-tiwai@suse.de>
 <20220926135558.26580-12-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220926135558.26580-12-tiwai@suse.de>
Cc: Felipe Balbi <balbi@kernel.org>, alsa-devel@alsa-project.org
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

On Mon, Sep 26, 2022 at 03:55:58PM +0200, Takashi Iwai wrote:
> The recent change in ALSA core allows drivers to get the current PCM
> state directly from runtime object.  Replace the calls accordingly.
> 
> Cc: Felipe Balbi <balbi@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
> 
> I'm going to merge this through sound git tree as it requires ALSA core
> changes.

Looks good to me:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
