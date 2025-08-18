Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF002CA0ED1
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Aug 2025 09:12:58 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D5056601F5;
	Mon, 18 Aug 2025 11:12:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D5056601F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1755508374;
	bh=f3/b24vi4WZUZhzGoyU68h/F9jJknT4PhA/ZhSGgCmA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=PuPsbLykU6cQVAhXjzcDeodLKR8v96Ii3jn/HeTCTqBZeiUaevruowb1I2Gs0vNbE
	 NHgHauq9teqVRspQw3bEexCXk+l3gW8h8zJBxeZziDoWyvhcIQtjkSodX1v2U7z4GQ
	 Gj6T2N3Tq3531UeDOXrJnbrraKylp+LmrIXFKitE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A9FF3F805D7; Mon, 18 Aug 2025 11:12:10 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0C819F805D3;
	Mon, 18 Aug 2025 11:12:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C038BF8028B; Mon, 18 Aug 2025 11:11:51 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 23487F80217
	for <alsa-devel@alsa-project.org>; Mon, 18 Aug 2025 11:11:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 23487F80217
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=zbcSSq0s;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=rztUsYzt;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=zbcSSq0s;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=rztUsYzt
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 26A721F44E;
	Mon, 18 Aug 2025 09:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1755508307;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UIFh0u3sb9PLm3aSj2RqklSdtaj/XkSF6e+6PoFJ/og=;
	b=zbcSSq0sdEeYvaCEyPccL50PwuWVqDpT4ftQKZM6Wy7lszXRwPYmqA2EKhbbGDukkvRj9n
	UPGGF+sjWUoZjfff0myC2JOX0Yzz+4cmo93khMPTB1fdUiw9+TqUi0Frkgtq9gUvtOtpH1
	Y0+8yO7PWUBmlroYYI6yDZNhC7ebfUU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755508307;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UIFh0u3sb9PLm3aSj2RqklSdtaj/XkSF6e+6PoFJ/og=;
	b=rztUsYzt7kIU/Zf8jvJseHdUn4m+K+mQxNWZ6/7RcGqYWrTst9W/WTiARJnxvwNSgMjvUZ
	B7ueW8knsNkIMBDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1755508307;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UIFh0u3sb9PLm3aSj2RqklSdtaj/XkSF6e+6PoFJ/og=;
	b=zbcSSq0sdEeYvaCEyPccL50PwuWVqDpT4ftQKZM6Wy7lszXRwPYmqA2EKhbbGDukkvRj9n
	UPGGF+sjWUoZjfff0myC2JOX0Yzz+4cmo93khMPTB1fdUiw9+TqUi0Frkgtq9gUvtOtpH1
	Y0+8yO7PWUBmlroYYI6yDZNhC7ebfUU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755508307;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UIFh0u3sb9PLm3aSj2RqklSdtaj/XkSF6e+6PoFJ/og=;
	b=rztUsYzt7kIU/Zf8jvJseHdUn4m+K+mQxNWZ6/7RcGqYWrTst9W/WTiARJnxvwNSgMjvUZ
	B7ueW8knsNkIMBDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C442E13A55;
	Mon, 18 Aug 2025 09:11:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id f1ewLlLuomigNAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 18 Aug 2025 09:11:46 +0000
Date: Mon, 18 Aug 2025 11:11:46 +0200
Message-ID: <87zfbxvvsd.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Shenghao Ding <shenghao-ding@ti.com>
Cc: <broonie@kernel.org>,
	<andriy.shevchenko@linux.intel.com>,
	<13564923607@139.com>,
	<13916275206@139.com>,
	<alsa-devel@alsa-project.org>,
	<linux-kernel@vger.kernel.org>,
	<baojun.xu@ti.com>,
	<Baojun.Xu@fpt.com>,
	<jesse-ji@ti.com>
Subject: Re: [PATCH v2] ALSA: hda/tas2781: Add name prefix tas2781 for
 tas2781's dvc_tlv and amp_vol_tlv
In-Reply-To: <20250816042741.1659-1-shenghao-ding@ti.com>
References: <20250816042741.1659-1-shenghao-ding@ti.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[139.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.intel.com,139.com,alsa-project.org,vger.kernel.org,ti.com,fpt.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
Message-ID-Hash: 4AV45XVPBLW2JUBRKDFO5ANUVWH3IHGP
X-Message-ID-Hash: 4AV45XVPBLW2JUBRKDFO5ANUVWH3IHGP
X-MailFrom: tiwai@suse.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4AV45XVPBLW2JUBRKDFO5ANUVWH3IHGP/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Sat, 16 Aug 2025 06:27:41 +0200,
Shenghao Ding wrote:
> 
> With some new devices adding into the driver, dvc_tlv and amp_vol_tlv will
> cause confusion for customers on which devices they support.
> 
> Fixes: 5be27f1e3ec9 ("ALSA: hda/tas2781: Add tas2781 HDA driver")
> Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>

Thanks, applied now.


Takashi
