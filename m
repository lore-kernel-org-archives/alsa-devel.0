Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98377C433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Dec 2021 13:59:06 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E9F8417E2;
	Mon, 13 Dec 2021 14:58:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E9F8417E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1639403944;
	bh=1USJyK5D94uDOuLnUPjIg0OKQaWPcei2cKCXhH/RmIM=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QPuPH2fD2acot708z0JPrFVvDKbI7Dbv8MxRQJKmqnlAEL+Ty7vFyQg8IoHrlIyvL
	 +guRc/nHNZxlUdSnBCAklpIYnQ6rzljqNlO7FEs0SEbdVnrY4yw/9rK8wUqH9tlznt
	 N55CKTVGc6nKsDdKksns/H+R4Mb8WgP/YGVjpiAM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8D444F80161;
	Mon, 13 Dec 2021 14:58:13 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 02D1BF8025D; Mon, 13 Dec 2021 14:58:12 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9F7D9F80161
 for <alsa-devel@alsa-project.org>; Mon, 13 Dec 2021 14:58:04 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id BA394A003F;
 Mon, 13 Dec 2021 14:57:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz BA394A003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1639403878; bh=ERfDJ+5y6FB2daGqxZ7WlC4n5x7Koq/GR/LiVwCS4vI=;
 h=Date:Subject:To:References:Cc:From:In-Reply-To:From;
 b=Dd7kn8LVfHHLKtzssilVOYPb6xBpqKmmuasJuOix92LzPuq/LfP/ukpnGllvz5NO0
 3LYQf78m7i2nbLKyeS7UXK8OqTR3+Mogn/V7qO6UeKWIDZXwKAuCZeQoUKxa84gdRm
 JoiKj6nADqAHuoMh52/XXk+4vzWunEH+ZD4NgE/8=
Received: from [192.168.100.98] (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Mon, 13 Dec 2021 14:57:56 +0100 (CET)
Message-ID: <6dac7c41-dce1-a03b-f890-65c9e9abf00e@perex.cz>
Date: Mon, 13 Dec 2021 14:57:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 1/2] ALSA: gus: Fix erroneous memory allocation
Content-Language: en-US
To: Takashi Iwai <tiwai@suse.de>
References: <20211213132444.22385-1-tiwai@suse.de>
From: Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <20211213132444.22385-1-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: ALSA development <alsa-devel@alsa-project.org>
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

On 13. 12. 21 14:24, Takashi Iwai wrote:
> snd_gf1_mem_xalloc() returns NULL incorrectly when the memory chunk is
> allocated in the middle of the chain.  This patch corrects the return
> value to treat it properly.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Reviewed-by: Jaroslav Kysela <perex@perex.cz>

			Thanks,
				Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
