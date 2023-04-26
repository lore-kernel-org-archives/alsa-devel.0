Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1FDBC77B78
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Apr 2023 06:07:04 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7393C83A;
	Wed, 26 Apr 2023 08:06:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7393C83A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1682489222;
	bh=38EStCK+I9/jWmvc8PUH9hdUp7kT10X3GheSahy577I=;
	h=Date:From:To:Subject:References:In-Reply-To:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=KKl81uuZ1aoxQY9txRray+dpicm9C849sbDBJ+LWOAqUbc6p5B95+vfCh5h8q29ha
	 fA0BtXSvyYaI+bcs9MlgAXH6ie4J5BLXw7cMezBrUkl9pWD13z5DJp+QFwAaXgi3hd
	 ZgkidPb52hV2k+xHG/yKUf10RKQnt0SNMN9NnIso=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 83290F80236;
	Wed, 26 Apr 2023 08:05:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9B113F80236; Wed, 26 Apr 2023 08:05:45 +0200 (CEST)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 4CFE8F8018A
	for <alsa-devel@alsa-project.org>; Wed, 26 Apr 2023 08:05:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4CFE8F8018A
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20221208 header.b=DZGRz3tS
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-1879fc89e67so4429135fac.0
        for <alsa-devel@alsa-project.org>;
 Tue, 25 Apr 2023 23:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682489139; x=1685081139;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V4i0azaBg7O2s6i4lwA15XawiNtASRWPXQ/VuKlA5y4=;
        b=DZGRz3tSKIM2yXRQmQejA1m9L1rhn9ngygTpxg2tEEFW4UHsFzpizqKNaC0i5ZMsB9
         Wf/6DqLPtTBZ4UCIRcvDMsFtPExPvuKsnYn4cl/6V09kaJV2b7KuHdAPGGqg14Ba71/6
         BFWTSJonGZp1HtMPI1LRPuGCoo2jkqSoTJXpGZNE3wZ7HumZfFY99/gKVhgH013dnqpa
         nZ2Cbhare84sYNoDNaIBkyN42makDPewKDVUGI4hghhDjUhSx8Xy0dU4GyjX9CEfs6XQ
         sTA+nSvekL+Jt0zR4FcB2ITzZUnEPY6BM7l6Wqgl7RNiQBycHPo/lYgkYZcV40J35XI0
         nQOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682489139; x=1685081139;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V4i0azaBg7O2s6i4lwA15XawiNtASRWPXQ/VuKlA5y4=;
        b=YhvWm3H47N95yCAKpqD7hbWnzVzs6VAeUeEocnebLxEXIUor+VCCV9bT+W6h99V6FS
         tsilSEiSKo4mrjQZqiCTLq5yWYCFgF56Dx4cnsPfY9JHIyLB3BtxVpfnbsnw0WRn7nGG
         CyqlNo5WpmK4c1GR2z83HzIAofros4mfPPbRFTzlQYLNlaaQYmH4hkLWSEFGv10TPvfe
         nFtD/HZN5lO/Gj9Ma38mK5/1lL8Ng8qj2+OuveuFWZdetwl8LA6OlODJBUDrzzr19SSg
         T3TOBAHJqOF8Y2Ov1du0k781TvpBzm6WH/8jftir2VO2ESVcw/HgktJv1qHEaEgtrAn1
         7MZQ==
X-Gm-Message-State: AAQBX9e7vuzEKacaqcHiDFBzuaWPcHTzweZX326Ff92E6jiFeVL2fI6E
	nX8F4t1Ja5S/AhWVTysTQcY=
X-Google-Smtp-Source: 
 AKy350ZHxqPcx48WmgJoNKk72NuAnR2wRNBXtbnH/rNu5oApfZDn4ef/OFrMfGVEPtbRYNXgZGn/UQ==
X-Received: by 2002:a05:6870:8a11:b0:184:6a66:fd9e with SMTP id
 p17-20020a0568708a1100b001846a66fd9emr11813434oaq.8.1682489139578;
        Tue, 25 Apr 2023 23:05:39 -0700 (PDT)
Received: from geday ([2804:7f2:8006:a502:65e3:3fd9:3321:ba17])
        by smtp.gmail.com with ESMTPSA id
 p22-20020a05687052d600b0017243edbe5bsm6280115oak.58.2023.04.25.23.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 23:05:39 -0700 (PDT)
Date: Wed, 26 Apr 2023 03:05:53 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: USB sound card freezes USB after resume from suspend
Message-ID: <ZEi/QWRlJetMZ2R9@geday>
References: <20230425111924.05cf8b13@kernel.org>
 <87pm7rtdul.wl-tiwai@suse.de>
 <ZEi6x155vF5GLeXT@geday>
 <87mt2vtc31.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mt2vtc31.wl-tiwai@suse.de>
Message-ID-Hash: XZ4IPFSTWPNHUNDEYZTT6NLBQSVEJMYT
X-Message-ID-Hash: XZ4IPFSTWPNHUNDEYZTT6NLBQSVEJMYT
X-MailFrom: geraldogabriel@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: Jakub Kicinski <kuba@kernel.org>, Takashi Iwai <tiwai@suse.com>,
 alsa-devel@alsa-project.org, linux-usb@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, regressions@lists.linux.dev
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/XZ4IPFSTWPNHUNDEYZTT6NLBQSVEJMYT/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, Apr 26, 2023 at 08:02:58AM +0200, Takashi Iwai wrote:
> On Wed, 26 Apr 2023 07:46:47 +0200,
> Geraldo Nascimento wrote:
> > 
> > Hello Jakub and Takashi,
> > 
> > On Wed, Apr 26, 2023 at 07:24:50AM +0200, Takashi Iwai wrote:
> > > On Tue, 25 Apr 2023 20:19:24 +0200,
> > > Jakub Kicinski wrote:
> > > > 
> > > > Hi!
> > > > 
> > > > For a few weeks now I can't use any USB devices if I suspend my laptop
> > > > with my USB sound card active and resuming it without it connected.
> > 
> > Takashi, did you pay attention to the workflow of triggering Jakub's
> > bug? He suspends the computer with the sound card active, disconnects
> > the sound card and expects to resume his computer back to an usable
> > state.
> 
> It's a pretty normal procedure for many people; most of USB type-C
> docks have a USB audio built-in, and people remove the machine from
> the dock after suspend.  So that's an operation that is seen everyday
> everywhere.
> 
> Still I haven't heard this issue, and it implies that it's either
> something new or specific to the machine or the environment.  Or we've
> been just lucky...
> 
> 
> Takashi

Understood, sorry for adding noise then.

Thanks,
Geraldo Nascimento
