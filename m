Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C18E9EB64D9
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Jul 2023 07:02:03 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6F2EF851;
	Mon, 10 Jul 2023 09:01:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6F2EF851
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1688972521;
	bh=OQ6bJNXpMj/oMZcbI336u2DFiwGgKM24H3kWNExk2Us=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=WHIZtH4MjULlXrqZ7kOPhqO27Pcy4aQT/JOkBfdPw9tTo97hm2l90eabTv9+Q7bQU
	 vl53b7TZzaWOtxCHzrb9uQa/YBFazb1B8BIaRgzFDrXeTnU0dWldvIqUhKS8bFY7MX
	 yKbQcwitMFzh+R47wytIbAWjAIR6diimCNwNtnXw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 880F6F800E4; Mon, 10 Jul 2023 09:00:27 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 53561F8055C;
	Mon, 10 Jul 2023 09:00:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 94E7BF80551; Mon, 10 Jul 2023 09:00:23 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 4F327F800E4
	for <alsa-devel@alsa-project.org>; Mon, 10 Jul 2023 09:00:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4F327F800E4
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=SAiFS8bt;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=VK/0YYUx
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de
 [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6B2081F38D;
	Mon, 10 Jul 2023 07:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1688972411;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8lsYU8eTR/+2vxTT2ktjYy/lbIGikqZVqJISjVkDRtU=;
	b=SAiFS8bt3oIoIjNAkhH/jJ5HPdyfxiXucL0tM8Mli0hsVI313mfFGPPNIvnbqw9dhfE8A8
	R1bQm1u2oLNujzhILJAl8xcqc/A5y2BKAtTFli04SRbB8edImnqWZk6jxtSNh2UY1aFwJZ
	FgOWNst2w50UC9aNhqX3mzKinGjPRBo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1688972411;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8lsYU8eTR/+2vxTT2ktjYy/lbIGikqZVqJISjVkDRtU=;
	b=VK/0YYUxyWgb7TXPucwL/gw+iaHL6jQupqHrwbxhabF/nOZtUMDTBl5vKABHVwtHmgQMiF
	eHC/PJ6YNWbSr8CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de
 [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 30AB61361C;
	Mon, 10 Jul 2023 07:00:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id xGgzCnusq2S1YgAAMHmgww
	(envelope-from <tiwai@suse.de>); Mon, 10 Jul 2023 07:00:11 +0000
Date: Mon, 10 Jul 2023 09:00:09 +0200
Message-ID: <87wmz8i746.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Cc: =?ISO-8859-1?Q?=22N=EDcolas_F=2E_R=2E_A=2E=22?= Prado
 <nfraprado@collabora.com>,	Jaroslav Kysela <perex@perex.cz>,
	kernel@collabora.com,	AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>,	Shuah Khan <shuah@kernel.org>,
	Takashi Iwai <tiwai@suse.com>,	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/2] kselftest/alsa: pcm-test: Decrease stream duration
 from 4 to 2 seconds
In-Reply-To: <06b8bfde-e4f1-48ea-aa3e-35d2fe5df046@sirena.org.uk>
References: <20230620220839.2215057-1-nfraprado@collabora.com>
	<20230620220839.2215057-3-nfraprado@collabora.com>
	<33bea0d3-b8dd-4936-812e-392166df4437@sirena.org.uk>
	<443f697b-fecf-6e8e-0b76-65257aff7da8@perex.cz>
	<9069ad0c-d166-4620-a3de-a36ab233cab0@sirena.org.uk>
	<5c2d5213-5299-44f1-9611-26002c8a5d3a@notapiano>
	<87352krcz5.wl-tiwai@suse.de>
	<f5cab2c2-1638-4d19-aff3-d46ed34b857e@sirena.org.uk>
	<87wmzwptu0.wl-tiwai@suse.de>
	<06b8bfde-e4f1-48ea-aa3e-35d2fe5df046@sirena.org.uk>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
Message-ID-Hash: RUR2YT3Z6SHP57E3RSCVOZGBRPHJCMK7
X-Message-ID-Hash: RUR2YT3Z6SHP57E3RSCVOZGBRPHJCMK7
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/RUR2YT3Z6SHP57E3RSCVOZGBRPHJCMK7/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, 21 Jun 2023 20:19:46 +0200,
Mark Brown wrote:
> 
> On Wed, Jun 21, 2023 at 08:13:11PM +0200, Takashi Iwai wrote:
> > Mark Brown wrote:
> 
> > > It feels like it might be good to let it cook for a bit longer before
> > > going to Linus (eg, applying after the merge window) so we've more
> > > chance to see what the impact is on other boards?
> 
> > I'm fine with that option, too.  Are most of selftests performed on
> > linux-next basis, or rather on Linus tree?
> 
> For KernelCI we've got coverage on both.  I can also run stuff on the
> boards I have in my lab on demand of course, but there's more coverage
> in KernelCI.

OK, now I applied those two patches to for-next branch (i.e. for 6.6
kernel).  Let's watch out.


thanks,

Takashi
