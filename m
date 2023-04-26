Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80FE2C77B60
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Apr 2023 14:01:20 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 146871049;
	Wed, 26 Apr 2023 16:00:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 146871049
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1682517677;
	bh=vZYOd9ZMoYmwf3b+spb+OoUtq8EhF1VgLjGvisoKmCQ=;
	h=Date:From:To:Subject:In-Reply-To:References:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=chFnH3ygST7ngXJerkKBvxCoDwNt0zBI7/kazAinH6XVpWBRCwkVlyG3y0EE3ONIL
	 NF4agznJxfxUrSlPnqnf9CHFmAcPPH9k+EcOlCl2tJNQJYDj5MuTqfwULf9mG+I7IQ
	 ZD3XaSQfAH7bFQXG0yAqvenKDOtYpUQN5UEcSlaA=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 64C37F80236;
	Wed, 26 Apr 2023 15:59:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 94A57F80236; Wed, 26 Apr 2023 15:59:51 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 751E2F80104
	for <alsa-devel@alsa-project.org>; Wed, 26 Apr 2023 15:59:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 751E2F80104
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=a/pNTmBr
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id DDAB361A4D;
	Wed, 26 Apr 2023 13:59:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04792C433EF;
	Wed, 26 Apr 2023 13:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1682517582;
	bh=vZYOd9ZMoYmwf3b+spb+OoUtq8EhF1VgLjGvisoKmCQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=a/pNTmBrpkctU2watCmwLjtb9DTn4oxxQ3qxLdRM05LSK/NPv3+y1N36Q9/aqfZ7Q
	 G847Lc20im7jcw0hR0mX+peDIwADEZs8GfJzCNamltqolMZ6UR+fc9yWwb89AQ+3+m
	 ThxA535qRJEuy3WzVc5upOSec8SSKU0H5LU7n0sfC3TiYqw0TseWMXPGT0Pk2NU0sb
	 oBWpi52MEHKDmuMOdchJVfjipJFOPCl68PvI+OEHQFcFRb41yPs5fRnxd5Vb4hCpNn
	 +iJKCALqhIRs3YIWJ2DFWEwQt8i2i2tIkNY5zFJG0a2FlmklkgDAir3LOQ/Rz1Q+sN
	 dXJLJJVsIN69w==
Date: Wed, 26 Apr 2023 06:59:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jaroslav Kysela <perex@perex.cz>
Subject: Re: USB sound card freezes USB after resume from suspend
Message-ID: <20230426065941.7615ffc6@kernel.org>
In-Reply-To: <a2e18eaa-2984-c2ba-f101-e16ad1dae0a0@perex.cz>
References: <20230425111924.05cf8b13@kernel.org>
	<87pm7rtdul.wl-tiwai@suse.de>
	<7645c6c8-a21c-23d7-5c19-cd2892b98481@perex.cz>
	<87leifjc16.wl-tiwai@suse.de>
	<a2e18eaa-2984-c2ba-f101-e16ad1dae0a0@perex.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-ID-Hash: BDKHPIAW23ALTKPOTZUWTUZLDCMBXSDU
X-Message-ID-Hash: BDKHPIAW23ALTKPOTZUWTUZLDCMBXSDU
X-MailFrom: kuba@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: Takashi Iwai <tiwai@suse.de>, Takashi Iwai <tiwai@suse.com>,
 alsa-devel@alsa-project.org, linux-usb@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, regressions@lists.linux.dev
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/BDKHPIAW23ALTKPOTZUWTUZLDCMBXSDU/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, 26 Apr 2023 13:04:15 +0200 Jaroslav Kysela wrote:
> > A good point, it'll be a patch like below.  
> 
> It looks good.
> 
> Reviewed-by: Jaroslav Kysela <perex@perex.cz>
> 
> > But we still need to figure out what's actually happening there.
> >     
> >> But I cannot reproduce this lock here.  
> > 
> > Here too.  Could be tied with the config or the device?  
> 
> Perhaps. Jakub, could you do more debugging (printk, traces)?

Let me get back to you on Saturday - I'll test the patch and try a bit
of bisecting. Can't promise much in terms of printing, because IDK what
to print :(
