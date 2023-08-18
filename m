Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D54D5EE4982
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Aug 2023 17:34:19 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B8BA9EC4;
	Fri, 18 Aug 2023 19:33:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B8BA9EC4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1692380056;
	bh=13aM6JkGrYthQGuJ1FMiXOV9vMniB9ZodEkIZKF33t8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=V0cTuvSMDSeSB8GUZ5BaDZ42+/iEGwGTpp+LCQpWYSIOotjn2SMEP8qekQL3HzZCx
	 PuDxll9LOyUsggwPfq/r4RK6ezHsUXLt49yVYBBCGkJjpA8Pe9KLtntPoL6NLTwa7N
	 NfLfPVzVgdv2zzn4E5q1smzyIM73yz9hxlQ789AI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 29B54F80510; Fri, 18 Aug 2023 19:32:58 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BD7B4F801EB;
	Fri, 18 Aug 2023 19:32:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7F442F801EB; Fri, 18 Aug 2023 19:32:53 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2001:67c:2178:6::1c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 43EA6F80027
	for <alsa-devel@alsa-project.org>; Fri, 18 Aug 2023 19:32:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 43EA6F80027
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=G/3ZhP+a;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=4wVSFv6R
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de
 [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 750962188D;
	Fri, 18 Aug 2023 17:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1692379964;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=298+RGsHxVRuLELFU08aTI9N02wy5sfYR26qB9BOyks=;
	b=G/3ZhP+arvMQsKd6ghvlGcilBwdreiEDIGDBnwj1c7lJM2Q22UU2euubdptFpJFFpxZZK5
	M+cD8lRpDrbVXg7hRjXydkLrN0A/w5g0vPQ89VHV98uPHUoljxu1KY2MN5yEtR/x5p+Bt0
	y25yYwKKD95FbLp7pd3JnOdCFOTbCuY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1692379964;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=298+RGsHxVRuLELFU08aTI9N02wy5sfYR26qB9BOyks=;
	b=4wVSFv6Rz3b4Vc0GGzdSX6xUA97zexzMXWRZp5GZ7mbcFOGnXcpS7TV0VtyfL6MFiW1pRm
	0gmr+lSFcvOmUQAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de
 [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 16853138F0;
	Fri, 18 Aug 2023 17:32:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id +199BDyr32Q9GQAAMHmgww
	(envelope-from <tiwai@suse.de>); Fri, 18 Aug 2023 17:32:44 +0000
Date: Fri, 18 Aug 2023 19:32:43 +0200
Message-ID: <87r0o0gssk.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Shenghao Ding <shenghao-ding@ti.com>,
	robh+dt@kernel.org,
	lgirdwood@gmail.com,
	perex@perex.cz,
	kevin-lu@ti.com,
	13916275206@139.com,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	liam.r.girdwood@intel.com,
	mengdong.lin@intel.com,
	baojun.xu@ti.com,
	thomas.gfeller@q-drop.com,
	peeyush@ti.com,
	navada@ti.com,
	broonie@kernel.org,
	gentuser@gmail.com
Subject: Re: [PATCH v4 1/2] ALSA: hda/tas2781: Add tas2781 HDA driver
In-Reply-To: <72960354-3f69-e2fa-e7b0-dc8b61ca4940@linux.intel.com>
References: <20230818085836.1442-1-shenghao-ding@ti.com>
	<87pm3kk63a.wl-tiwai@suse.de>
	<72960354-3f69-e2fa-e7b0-dc8b61ca4940@linux.intel.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
Message-ID-Hash: WLCSIMOPO7M54TVN4FZAUB5DZG3S2LRW
X-Message-ID-Hash: WLCSIMOPO7M54TVN4FZAUB5DZG3S2LRW
X-MailFrom: tiwai@suse.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/WLCSIMOPO7M54TVN4FZAUB5DZG3S2LRW/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, 18 Aug 2023 18:36:16 +0200,
Pierre-Louis Bossart wrote:
> 
> 
> 
> On 8/18/23 05:17, Takashi Iwai wrote:
> > On Fri, 18 Aug 2023 10:58:35 +0200,
> > Shenghao Ding wrote:
> >>
> >> Integrate tas2781 configs for Lenovo Laptops. All of the tas2781s in the
> >> laptop will be aggregated as one audio device. The code support realtek
> >> as the primary codec. Rename "struct cs35l41_dev_name" to
> >> "struct scodec_dev_name" for all other side codecs instead of the certain
> >> one.
> >>
> >> Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>
> > 
> > Now I applied both patches to for-next branch.
> > 
> > The patch 2 needed some minor adjustment in Kconfig to be applied to
> > the latest branch, but I resolved it locally.
> 
> There are a number of issues I just reported, I guess they will have to
> be handled with a follow-up patch now?

Yes, let's fix incrementally on the top.


Takashi
