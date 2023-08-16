Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B897C001E0
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Aug 2023 12:24:01 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 22AB0827;
	Wed, 16 Aug 2023 14:23:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 22AB0827
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1692188639;
	bh=By/C1T8vUJyaBRN3g949AOiuTNYNb6Lu+q7xLmc6Vi4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=UcmQu3M0J/mWgapLyYipAnPtPdpPQ8WiFS+ZCwAt041oXWbQyWwbHcJYW+kb+RZpf
	 1njD6TYSlR5lF4B4C5kWYc4dJ+X4rI8wU4k2w5+ucYARfFb7lNN8i21MJFqCli2p1O
	 7QcGrXr0F62bFSKNfXepgPotf4XEGkFNabZsJN2M=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 88756F8016D; Wed, 16 Aug 2023 14:22:34 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 1C83EF8016D;
	Wed, 16 Aug 2023 14:22:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2B01FF8016D; Wed, 16 Aug 2023 14:22:29 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 570ECF80074
	for <alsa-devel@alsa-project.org>; Wed, 16 Aug 2023 14:22:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 570ECF80074
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=doZV2IsL;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=0GPKxcIj
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de
 [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AD5941F74D;
	Wed, 16 Aug 2023 12:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1692188539;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Y0abpx6i0Ws/RZh4fVAk6Jn2cs+w+kHAqSQTosf15U=;
	b=doZV2IsLzukZBbEPNjYaMzI15q4gYnWHdJug3UGA149OlI0IHC0HVttNLRgGoFVPIBunDy
	nouOZ0wAYOQNNFwqprNttwx3JzUKLccK/9mjP1BSapS8XV6DOoLgLjgkZzd+ABc6mKKJY7
	UDuuaGrwzYoX6FYxC9nTt52r4sJ+1rA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1692188539;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Y0abpx6i0Ws/RZh4fVAk6Jn2cs+w+kHAqSQTosf15U=;
	b=0GPKxcIjKfHcaZMArKjfcCxQtNmm5EXC6KsakfGgHT7WYPZMR6v9ZdkQ8/ahFAEz3bel5F
	qTRCjDi2zxYjGXCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de
 [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 96CF01353E;
	Wed, 16 Aug 2023 12:22:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id NS5xJHu/3GRFNAAAMHmgww
	(envelope-from <tiwai@suse.de>); Wed, 16 Aug 2023 12:22:19 +0000
Date: Wed, 16 Aug 2023 14:22:19 +0200
Message-ID: <87v8dfch38.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Kailang <kailang@realtek.com>
Cc: "Joseph C. Sible" <josephcsible@gmail.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	"regressions@lists.linux.dev"
	<regressions@lists.linux.dev>,
	"perex@perex.cz" <perex@perex.cz>,
	"tiwai@suse.com" <tiwai@suse.com>,
	"alsa-devel@alsa-project.org"
	<alsa-devel@alsa-project.org>
Subject: Re: Fwd: [Bug 217440] New: ALC236 audio disappears from HP 15z-fc000
 on warm boot
In-Reply-To: <87il9gzn98.wl-tiwai@suse.de>
References: <87o7jshxch.wl-tiwai@suse.de>
	<CABpewhEG9ViuoCwZHmTN0Up-3jwZ1M-jfC+dAqo0zhqLOZtQ6g@mail.gmail.com>
	<01e212a538fc407ca6edd10b81ff7b05@realtek.com>
	<87il9gzn98.wl-tiwai@suse.de>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: GDEYNZHBJJW35ULJNGN6XPRZVACHU25H
X-Message-ID-Hash: GDEYNZHBJJW35ULJNGN6XPRZVACHU25H
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
Archived-At: <>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, 15 Aug 2023 11:08:19 +0200,
Takashi Iwai wrote:
> 
> On Tue, 15 Aug 2023 10:08:48 +0200,
> Kailang wrote:
> > 
> > Hi Takashi,
> > 
> > I think maybe attach patch is what you want.
> 
> Looks good.  Let's ask the reporter to test with it.

I believe this regression fix should go for 6.5-rc7.
Now applied.


Takashi

> 
> 
> Thanks!
> 
> Takashi
> 
> > 
> > > -----Original Message-----
> > > From: Joseph C. Sible <josephcsible@gmail.com>
> > > Sent: Friday, August 4, 2023 10:35 PM
> > > To: Takashi Iwai <tiwai@suse.de>
> > > Cc: Kailang <kailang@realtek.com>; Bagas Sanjaya <bagasdotme@gmail.com>;
> > > regressions@lists.linux.dev; perex@perex.cz; tiwai@suse.com;
> > > alsa-devel@alsa-project.org
> > > Subject: Re: Fwd: [Bug 217440] New: ALC236 audio disappears from HP
> > > 15z-fc000 on warm boot
> > > 
> > > 
> > > External mail.
> > > 
> > > 
> > > 
> > > On Mon, Jul 31, 2023 at 12:14 PM Takashi Iwai <tiwai@suse.de> wrote:
> > > >
> > > > ... and now we receive a regression report due to this change :-<
> > > >   https://bugzilla.kernel.org/show_bug.cgi?id=217732
> > > >
> > > > I believe the problem is that the patch disabled the 3kpull-low
> > > > behavior too much while some codecs still need it.
> > > >
> > > > The patch changes like:
> > > >
> > > > @@ -3638,8 +3640,7 @@ static void alc256_shutup(struct hda_codec
> > > *codec)
> > > >         /* If disable 3k pulldown control for alc257, the Mic detection will
> > > not work correctly
> > > >          * when booting with headset plugged. So skip setting it for the
> > > codec alc257
> > > >          */
> > > > -       if (codec->core.vendor_id != 0x10ec0236 &&
> > > > -           codec->core.vendor_id != 0x10ec0257)
> > > > +       if (spec->en_3kpull_low)
> > > >                 alc_update_coef_idx(codec, 0x46, 0, 3 << 12);
> > > >
> > > >         if (!spec->no_shutup_pins)
> > > >
> > > > ... while the only place setting spec->en_3kpull_low is:
> > > >
> > > > @@ -10682,6 +10683,8 @@ static int patch_alc269(struct hda_codec
> > > *codec)
> > > >                 spec->shutup = alc256_shutup;
> > > >                 spec->init_hook = alc256_init;
> > > >                 spec->gen.mixer_nid = 0; /* ALC256 does not have any
> > > > loopback mixer path */
> > > > +               if (codec->bus->pci->vendor == PCI_VENDOR_ID_AMD)
> > > > +                       spec->en_3kpull_low = true;
> > > >                 break;
> > > >         case 0x10ec0257:
> > > >                 spec->codec_variant = ALC269_TYPE_ALC257;
> > > >
> > > > Since spec->3n_3kpull_low is false as default, it means that, except
> > > > for ALC230/236/256 and PCI vendor AMD, the flag is never set, hence
> > > > it's no longer called.
> > > >
> > > > Shouldn't spec->en_3kpull_low be enabled rather as default?  Or which
> > > > models can set it?
> > > 
> > > In both my original bug and this new bug, the problem was that we're not
> > > calling it when we should be. Given that, wouldn't a simple fix be to call it if
> > > either the old condition or the new condition is true?
> > > E.g., something like this:
> > > 
> > > if ((codec->core.vendor_id != 0x10ec0236 && codec->core.vendor_id !=
> > > 0x10ec0257) || spec->en_3kpull_low)
> > > 
> > > Joseph C. Sible
> > > 
> > > ------Please consider the environment before printing this e-mail.
> > 
> > 
> 
