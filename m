Return-Path: <SRS0=uvJZ=6W=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC233C38A2A
	for <alsa-devel@archiver.kernel.org>; Fri,  8 May 2020 07:33:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6572520643
	for <alsa-devel@archiver.kernel.org>; Fri,  8 May 2020 07:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="BS8ueEbH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JkHuSfml"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6572520643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A40F217AD;
	Fri,  8 May 2020 09:33:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A40F217AD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588923237;
	bh=ASu/ieS8Y72mpl8mKOef8GWmIcaZP5JCToPvddluXvk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BS8ueEbH2P5VDtXNNSU5+HBpqZyQ+oAXOUoHF1xT5tgn8U7VWoNCzzkoyQyXle51m
	 koRqf2xbVcAXwWGdcKGGG/s44wgTeMkYtWtXljPjB/eUH5kC+yuy5eMfd8qinI0hcb
	 EfNlRedlLKwnR7JqVF7ZQU835xaBepl6bGC0Mb7w=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 15928F800E7;
	Fri,  8 May 2020 09:33:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DCC78F8015F; Thu,  7 May 2020 12:01:29 +0200 (CEST)
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com
 [IPv6:2a00:1450:4864:20::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0A5BBF800AD
 for <alsa-devel@alsa-project.org>; Thu,  7 May 2020 12:01:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0A5BBF800AD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="JkHuSfml"
Received: by mail-lj1-x241.google.com with SMTP id l19so5614854lje.10
 for <alsa-devel@alsa-project.org>; Thu, 07 May 2020 03:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=P1Be+iELEaGBQtXonCwj1c6TNB0kDNwS6v3vYCB59a0=;
 b=JkHuSfml3EgARYC8FMpEd3gAeS1UEfhzcr3L/FFfyBwuVYzu5arGB1JQrQVXCSAx8o
 dKj87Um3DMpdj2UhEhYv0n8z452mqoRtxpaVW0E/fr1g7tBZfAleLPgSyfvZ6Y7sKaEn
 rn5SbK5SLZynH8v8mbhmPoALXMC7dpaJJYpjTYAk+CjTcBSjfE7yd8301n7XrNeUxLdr
 zF1yv/Hc6WbIS26fNfBbnEvCGXAOBRG3RrRvIEc+y993L6zgPv1ojRknB0PiyQIQPbD6
 qKGLrrK9SLGbfuLliVSEEOmc+oZcGGnDtpGmfi3YJ9sVVkm8TAMoUAijxsqkJEwajuJY
 6/bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=P1Be+iELEaGBQtXonCwj1c6TNB0kDNwS6v3vYCB59a0=;
 b=nP0QZOYgKynrVY0o6EboYWqKTkXMu/uAeFQXDp1HrYPZ9T39ajh9vUr6IYhwyN03iD
 oXUgQTipLObAexD8oKc/HXqYZrYCQwIJsOKm6fDYCiPo6j5ETe96wlGJtETVournFnUX
 Dn1NnKCAzJhDfugdsD6G/0JHV1AEG7sjjDdh68A/lta6UdQfBO2+HEKQdSyZYtPB8XtC
 WsatA6I6nOSyrLsk3uzjsx367aHelLo9XH+dhDu/iwxAMNN1Ege7MwYIbXOxhicyUL/s
 HBAVTAze6HYcpoAbuvK9m+iF8+zpbukuc5heAqGLTEBFJzN0sTe1QObpsh4UdPzQgADa
 bKWQ==
X-Gm-Message-State: AGi0PuZo1RzdFaYm3vcR92yEW9LfneId9FAwY/93M106yqHZUWnuqifG
 ZlBVd3JPaF8KmcDG09gNIlDG2UyIvv5mEOmokOY=
X-Google-Smtp-Source: APiQypK+mPvbELrXTbvTW39d/VBur7XHkX0v6bjIPELwPCrK3R3hHWSWXKncrvOzzO8clbdIJ6FHXDpwpK9eVZWrUqI=
X-Received: by 2002:a2e:8949:: with SMTP id b9mr8109025ljk.108.1588845682372; 
 Thu, 07 May 2020 03:01:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAFcO6XMWpUVK_yzzCpp8_XP7+=oUpQvuBeCbMffEDkpe8jWrfg@mail.gmail.com>
 <s5hbln05b1h.wl-tiwai@suse.de>
In-Reply-To: <s5hbln05b1h.wl-tiwai@suse.de>
From: butt3rflyh4ck <butterflyhuangxx@gmail.com>
Date: Thu, 7 May 2020 18:01:11 +0800
Message-ID: <CAFcO6XMitGEYHYykgmzWc4NWME+O+1KTXfmf2zaeN147c2y4_A@mail.gmail.com>
Subject: Re: KASAN: use-after-free Write in snd_rawmidi_kernel_write1
To: Takashi Iwai <tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 08 May 2020 09:33:05 +0200
Cc: security@kernel.org, alsa-devel@alsa-project.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, tiwai@suse.com,
 linux-kernel@vger.kernel.org, syzkaller <syzkaller@googlegroups.com>
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

No, it's not.

Regards,
  butt3rflyh4ck.


On Thu, May 7, 2020 at 5:50 PM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Thu, 07 May 2020 09:54:34 +0200,
> butt3rflyh4ck wrote:
> >
> > I report a bug (in linux-5.7-rc1) found by syzkaller.
> >
> > kernel config:
> > https://github.com/butterflyhack/syzkaller-fuzz/blob/master/v5.7.0-rc1.config
> > reproducer:
> > https://github.com/butterflyhack/syzkaller-fuzz/blob/master/repro.cprog
>
> Is this report different from your another one?
>   https://lore.kernel.org/r/CAFcO6XMGT42wFBxEa01Ee5Msuecm+WiXnn4rc-VWkC4vTzycPg@mail.gmail.com
>
>
> thanks,
>
> Takashi
