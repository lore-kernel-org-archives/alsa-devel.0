Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C17C6C38A2D
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Oct 2022 21:13:22 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4132A67E8;
	Mon, 24 Oct 2022 23:12:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4132A67E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1666646000;
	bh=4DX7jNy+U+zToxaJBrx/yhiY7wZ2i58SEzBgOiv8KoU=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hjCT1RNsSA5yQ/ABv27XEBmcB7zTt5xXwHekj4guzWqfHQHNd5K7t+xm5Z3k84mpE
	 OdEOHUXAGs9tIwq+f+xGMED66KeZ6YkVm4GbZG4WEJC5/UrTcAbt3zIj8PpGG4xMtF
	 FhIZR0OqE5LAaZnEOyZyHBgFjYbOTNDdlGJX4m0E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D443CF8052F;
	Mon, 24 Oct 2022 23:12:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3FB08F80533; Mon, 24 Oct 2022 23:12:29 +0200 (CEST)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk
 [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CC6F3F80240
 for <alsa-devel@alsa-project.org>; Mon, 24 Oct 2022 23:12:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CC6F3F80240
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk
 header.b="ju4fAjHQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=1ZSbC1IVWiIAbIJCUCGttQ9weksvxLPKZ/m64zctsts=; b=ju4fAjHQPvtRj0VSkVMoxApNoB
 1wijSIHHMCXnuPu+LDpyBemfdp+fekCYc4yQ9VtUZMkhpP7uvfzl9UBXIByKtz71RAqUC2rZhGeGh
 4c0dX+ZxvbLL1wOW3rySXt7YfjkNKXoh4VngVdC4bnF7dvSCViFzuV8/1CQsWdn5xTT9aaikWgryQ
 d3quMb82+Oa6f6iMum8dmR7E5sC6lUYK6Iq4rOlrdaOzfi7VaQoqW71NlW2jy/TeMu6B3VrDCKqv5
 Zk3d4YUE7pHyw8C+5W5w2KHAvYBZbM45jsxy3c2zLf8HQRcLR6GrT8Zv0kMDBva2txm89spfFQ8EU
 /Vh9PocA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat
 Linux)) id 1on4jQ-00DaDF-0m; Mon, 24 Oct 2022 21:11:36 +0000
Date: Mon, 24 Oct 2022 22:11:36 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH] ALSA: au88x0: use explicitly signed char
Message-ID: <Y1b/iNMncyKI/W5c@ZenIV>
References: <20221024162929.536004-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221024162929.536004-1-Jason@zx2c4.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
 linux-kernel@vger.kernel.org
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

On Mon, Oct 24, 2022 at 06:29:29PM +0200, Jason A. Donenfeld wrote:
> With char becoming unsigned by default, and with `char` alone being
> ambiguous and based on architecture, signed chars need to be marked
> explicitly as such. This fixes warnings like:

It might make sparse to STFU, but it does *not* resolve the underlying
issue:

vortex_adb_checkinout() returns a number in range of 0..31 on success
and -ENOMEM on failure.  Quite a few callers don't bother to check...
