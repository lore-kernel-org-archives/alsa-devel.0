Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91855EB64DC
	for <alsa-devel@archiver.kernel.org>; Tue, 11 Jul 2023 10:13:06 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5861A83A;
	Tue, 11 Jul 2023 12:12:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5861A83A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1689070383;
	bh=hnNDdRgtwLsNT36EU87StAs/HYG3vsm+5U1isBAVh7o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Ik+tq4yD9/TdE69VuySFAliKjQd52bN0MJod++46Zxq/vCPpI2ac5XSRDjNdBmsPp
	 26pgQenQ+1upTyseUz4hH9wz4j4xE69h1YYG+prowar9fB+SFYL0o8Kd2uLLc+hcPE
	 aelRQle6jMdxyKaz9DQ9Wcradu8LPRPu3LdzVtos=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 265F4F80153; Tue, 11 Jul 2023 12:11:49 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A69F5F80249;
	Tue, 11 Jul 2023 12:11:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C0D82F80249; Tue, 11 Jul 2023 12:11:43 +0200 (CEST)
Received: from bluemchen.kde.org (bluemchen.kde.org
 [IPv6:2001:470:142:8::100])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 1FA7DF80153
	for <alsa-devel@alsa-project.org>; Tue, 11 Jul 2023 12:11:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1FA7DF80153
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id 9DA3A24264;
	Tue, 11 Jul 2023 06:11:30 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
	id 1qJALC-WJY-00; Tue, 11 Jul 2023 12:11:30 +0200
Date: Tue, 11 Jul 2023 12:11:30 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH 2/2] ALSA: emu10k1: track loss of external clock on E-MU
 cards
Message-ID: <ZK0q0prNuOz2Be6b@ugly>
References: <20230710065956.1246364-1-oswald.buddenhagen@gmx.de>
 <20230710065956.1246364-2-oswald.buddenhagen@gmx.de>
 <87ttubyfh9.wl-tiwai@suse.de>
 <ZKxBJVxHdkmpHSVh@ugly>
 <87cz0zxbih.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87cz0zxbih.wl-tiwai@suse.de>
Message-ID-Hash: UGU7Q623IDJRQDY7TDHEIV7VEG7YYU2A
X-Message-ID-Hash: UGU7Q623IDJRQDY7TDHEIV7VEG7YYU2A
X-MailFrom: ossi@kde.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/UGU7Q623IDJRQDY7TDHEIV7VEG7YYU2A/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, Jul 11, 2023 at 07:28:22AM +0200, Takashi Iwai wrote:
>Again, snd_ctl_notify() itself doesn't need the rwsem lock at all.
>
ah, you mean i could fully release it before the notification.

>It's snd_ctl_notify_one() that needs a more careful call pattern.
>
i suppose that's because the snd_ctl_layer callbacks might require it.
i would recommend actually documenting that.

>And, that ugly implementation is a thing to be improved in future in
>ALSA core side.
>
it is? like, really? or is it just a far-off idea with no concrete plan 
whatsoever? is there an actual problem to solve, or is it just a sense 
of "yeah, this could be nicer ... somehow"? i mean, this is the mixer -  
one would be hard-pressed to find an actual bottleneck in there.

regards
