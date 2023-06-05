Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41C6FC7EE23
	for <alsa-devel@archiver.kernel.org>; Mon,  5 Jun 2023 07:40:38 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BD5663E8;
	Mon,  5 Jun 2023 09:39:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BD5663E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1685950835;
	bh=HRfJ20bZpQyRfryOtJCxDmOmgBtT7yMXjVzqsv8Q1rM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=i6H87wGjNQQYPWaGl5Ziqyh1aLHn8iY241uMU2dZkd86paSEOvmVy2Utf44h8IBDd
	 cIcPz+iIuNunaomI/Pt1M9nSHF28OAflaOWVctZIBqI9NeLJADHKgzdN4zRVeFEOk/
	 zut8Xy9a/NKRwClGrMEdgCkYSKv9ecqwT77Wdq+M=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A17DEF80494; Mon,  5 Jun 2023 09:39:19 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3878AF80290;
	Mon,  5 Jun 2023 09:39:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 159AEF80199; Mon,  5 Jun 2023 09:39:15 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 1A846F800ED
	for <alsa-devel@alsa-project.org>; Mon,  5 Jun 2023 09:39:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1A846F800ED
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=Ljr/3IJf;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=LIduBt30
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de
 [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D2DC121AF9;
	Mon,  5 Jun 2023 07:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1685950752;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jo1q+EVjn19uDq4zjiSV84GIoMoRkmgfMQr5y8Y0sh4=;
	b=Ljr/3IJfvzKGbcl04cpIA/S5nywdRuAjIc/pvUU0xLFFw2jLIHkleajo3IbzBWKOzh/+5p
	SXnF7bnTtn2EoxxNu9BNaJ6FVCa5hPpHEWfYHtfrnq/m6Y7SogBURuKw1TiqmMIs77eX7u
	9jPjGrKjtpoBBZ+k95zypyxYTxEnyj8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1685950752;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jo1q+EVjn19uDq4zjiSV84GIoMoRkmgfMQr5y8Y0sh4=;
	b=LIduBt30SdkWJwxcgODlfTdahkIDG7jqbF+O1BH3nWgma9i/L46CLyjujoL+WcVUitJ8Wk
	hFDcca92QFuM1bCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de
 [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A11B3139C7;
	Mon,  5 Jun 2023 07:39:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id egd0JiCRfWT7cAAAMHmgww
	(envelope-from <tiwai@suse.de>); Mon, 05 Jun 2023 07:39:12 +0000
Date: Mon, 05 Jun 2023 09:39:12 +0200
Message-ID: <87pm6aicin.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"perex@perex.cz" <perex@perex.cz>,
	"michael@ralston.id.au"
	<michael@ralston.id.au>,
	"linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
	"tiwai@suse.com" <tiwai@suse.com>,
	"alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] ALSA: usb-audio: Fix "cannot set freq 48000 to ep 0x3"
 msgs
In-Reply-To: <202bbbc0f51522e8545783c4c5577d12a8e2d56d.camel@infinera.com>
References: <20230601131116.1014250-1-joakim.tjernlund@infinera.com>
	<202bbbc0f51522e8545783c4c5577d12a8e2d56d.camel@infinera.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
Message-ID-Hash: ZXLJKV7AYBIVGKCJQESES762AWBRK376
X-Message-ID-Hash: ZXLJKV7AYBIVGKCJQESES762AWBRK376
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZXLJKV7AYBIVGKCJQESES762AWBRK376/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, 01 Jun 2023 16:28:05 +0200,
Joakim Tjernlund wrote:
> 
> Adding Michael Ralston <michael@ralston.id.au>
> 
> He did have problems with his behringer UMC404HD device when this whole seq. was removed.
> Ralston, can you try if the below change affects your device?

Sorry for the late reaction, as I've been off in the last weeks.

The code sequence there seems pretty sensitive, and swapping or
dropping the call might break things easily on certain devices,
unfortunately.  So, I guess we can't take the patch as is.  If any, we
need to fiddle the call order depending on the device quirk or such.
I guess we may try to fit with the existing quirk flag.  Let me check
it later.


thanks,

Takashi


>  Jocke
> 
> On Thu, 2023-06-01 at 15:11 +0200, Joakim Tjernlund wrote:
> > On some USB speaker devices(Jabra/Logitech) we see above error
> > msg when connecting device to computer and kernel is probing the device.
> > 
> > Moving the snd_usb_init_sample_rate() to after usb_set_interface() makes
> > the error go away.
> > 
> > Signed-off-by: Joakim Tjernlund <joakim.tjernlund@infinera.com>
> > Cc: stable@vger.kernel.org
> > ---
> >  sound/usb/stream.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/sound/usb/stream.c b/sound/usb/stream.c
> > index f10f4e6d3fb8..d9ac8663a48b 100644
> > --- a/sound/usb/stream.c
> > +++ b/sound/usb/stream.c
> > @@ -1226,8 +1226,8 @@ static int __snd_usb_parse_audio_interface(struct snd_usb_audio *chip,
> >  		/* try to set the interface... */
> >  		usb_set_interface(chip->dev, iface_no, 0);
> >  		snd_usb_init_pitch(chip, fp);
> > -		snd_usb_init_sample_rate(chip, fp, fp->rate_max);
> >  		usb_set_interface(chip->dev, iface_no, altno);
> > +		snd_usb_init_sample_rate(chip, fp, fp->rate_max);
> >  	}
> >  	return 0;
> >  }
> 
