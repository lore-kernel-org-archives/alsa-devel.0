Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45251C433F5
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Mar 2022 07:55:24 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 431741705;
	Mon,  7 Mar 2022 08:54:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 431741705
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1646639723;
	bh=nSHbSNLVLura+a601pjRTuAdhTA5vDw6fiYHhx3TNLU=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jgMxcSQifJ624ENLhwNfwGgW+6ZqciG5lbe/afiNIrdlStDGwmaHdCmChftYrUrLa
	 gz6lw+9UrUZszCDouo8rMccngLq/xmG7XqVzBk3q6AZMY7njxOikG8Yg/cYafdlTQF
	 EDjCkcE6qVc4PJ5RuAXqPP9Nh14sys+PGPmZvP4c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D94D4F800D1;
	Mon,  7 Mar 2022 08:54:32 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 50C01F8013F; Mon,  7 Mar 2022 08:54:31 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 25567F800D1
 for <alsa-devel@alsa-project.org>; Mon,  7 Mar 2022 08:54:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 25567F800D1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
 header.i=@linuxfoundation.org header.b="zIimn5Sx"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 1F3FBB81025;
 Mon,  7 Mar 2022 07:54:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 224A2C340EF;
 Mon,  7 Mar 2022 07:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1646639666;
 bh=nSHbSNLVLura+a601pjRTuAdhTA5vDw6fiYHhx3TNLU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=zIimn5Sx+tC7b+DMFcIIkUqq8UryWrQvKOuJInbgqBVfSSygtbuqc0cDSPChgRwaI
 tyLVJNxFVqZZA5nzyQD7i61k7OdjoKF+3ZFydQbqnW2Si6iwzYO+WgKMBnldFgHAfo
 m64ryOlKQUmo0QQTAOXbRw8Hqmc6LkDBEqScMw/8=
Date: Mon, 7 Mar 2022 08:54:23 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Oh Eomji <eomji.oh@samsung.com>
Subject: Re: [PATCH 1/2] sound: usb: Add vendor's hooking interface
Message-ID: <YiW6L9nv1+GwDEpd@kroah.com>
References: <CGME20220307022409epcas2p4a2955a746c87d66564556e18ab94845f@epcas2p4.samsung.com>
 <1646619720-97113-1-git-send-email-eomji.oh@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1646619720-97113-1-git-send-email-eomji.oh@samsung.com>
Cc: alsa-devel@alsa-project.org, JaeHun Jung <jh0801.jung@samsung.com>,
 Leon Romanovsky <leon@kernel.org>, Pavel Skripkin <paskripkin@gmail.com>,
 open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>
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

On Mon, Mar 07, 2022 at 11:21:59AM +0900, Oh Eomji wrote:
> In mobile, a co-processor can be used with USB audio to improve power
> consumption.  To support this type of hardware, hooks need to be added
> to the USB audio subsystem to be able to call into the hardware when
> needed.
> 
> The main operation of the call-backs are:
>   - Initialize the co-processor by transmitting data when initializing.
>   - Change the co-processor setting value through the interface
>     function.
>   - Configure sampling rate
>   - pcm open/close
>   - other housekeeping

You need to supply the users of the callbacks/hooks, otherwise we can
not properly evaluate them, nor can we accept them.

I have been saying this for over a year, please submit ALL of the needed
parts for these hooks to even be able to be considered.  Otherwise they
will just be ignored for the obvious reasons stated numerous times in
the past.

thanks,

greg k-h
