Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFE4DEB64DD
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Jul 2023 08:16:28 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7C648207;
	Thu, 13 Jul 2023 10:15:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7C648207
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1689236186;
	bh=RqhBbBu5q6VwYWgVfFzB51+DvgIBaxYhb/wQ52swrnU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=tAkBvYqseTB/n5s5DlPJ7Kfa3Nu0GVty1ofqdWi0xVIj4adVjQ7XYsncdUJE5Rlps
	 7npU+P9WI21zKaSyTMF+cLentY2/AEHuKY3tBACHtVEQhA0hSKjpZuWbcxQ7ESl4kN
	 S+pgxyXHqjlzeaOwPaLE7Lkbpea7KsWaojoyO8Xc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E0159F8047D; Thu, 13 Jul 2023 10:15:35 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 87747F800E4;
	Thu, 13 Jul 2023 10:15:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4A0B5F80249; Thu, 13 Jul 2023 10:15:31 +0200 (CEST)
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 78424F800E4
	for <alsa-devel@alsa-project.org>; Thu, 13 Jul 2023 10:15:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 78424F800E4
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id 964CD24080;
	Thu, 13 Jul 2023 04:15:21 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
	id 1qJrTt-hrY-00; Thu, 13 Jul 2023 10:15:21 +0200
Date: Thu, 13 Jul 2023 10:15:21 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH 2/3] ALSA: emu10k1: remove superfluous IRQ enable state
 saving
Message-ID: <ZK+ymU7ynF0eRy8R@ugly>
References: <20230712145750.125086-1-oswald.buddenhagen@gmx.de>
 <20230712145750.125086-2-oswald.buddenhagen@gmx.de>
 <875y6ogxt8.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <875y6ogxt8.wl-tiwai@suse.de>
Message-ID-Hash: MOOJLA3TLOMOGM7HE2Q7ILKHCVGI2OPJ
X-Message-ID-Hash: MOOJLA3TLOMOGM7HE2Q7ILKHCVGI2OPJ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/MOOJLA3TLOMOGM7HE2Q7ILKHCVGI2OPJ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, Jul 13, 2023 at 07:55:31AM +0200, Takashi Iwai wrote:
>On Wed, 12 Jul 2023 16:57:49 +0200,
>Oswald Buddenhagen wrote:
>> 
>> The mixer, PCM prepare, MIDI, synth driver, and procfs callbacks are all
>> always invoked with IRQs enabled, so there is no point in saving the
>> state.
>> 
>> snd_emu1010_load_firmware_entry() is called from emu1010_firmware_work()
>> and snd_emu10k1_emu1010_init(); the latter from snd_emu10k1_create() and
>> snd_emu10k1_resume(), all of which have IRQs enabled.
>> 
>> The voice and memory functions are called from mixed contexts, so they
>> keep the state saving.
>> 
>> The low-level functions all keep the state saving, because it's not
>> feasible to keep track of what is called where.
>> 
>Wouldn't it make more sense if you replace it with a mutex?
>It'll become more obvious that it's only for non-IRQ context, too.
>
huh?
at least some of the ~six different locks touched by this patch 
absolutely _are_ used in irq context. this patch is concerned only about 
the specific call sites, where we know that local irqs are enabled, so 
we can unconditionally re-enable them rather than restoring the old 
state (the latter being a much more expensive operation). the code 
already contains precedents for this, and the complementary optimization 
of not disabling/restoring irqs where we know that they are already 
disabled.

the reg_lock would be convertible to a mixer_mutex in most mixer 
callbacks, but that is an orthogonal question, which is raised in the 
next commit.

regards
