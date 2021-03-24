Return-Path: <SRS0=3oXn=IW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B42DC433C1
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Mar 2021 13:04:56 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FE18619F2
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Mar 2021 13:04:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FE18619F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 75A13167E;
	Wed, 24 Mar 2021 14:04:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 75A13167E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616591093;
	bh=7s0wgC78gblvxsaVykC5o0TrHN9wFqEsE0ymv0Ek41k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cmIt4Jf3/KdUGvPpR7feZP2/1/wpafF+BsWDxzz/7m5N93Bq9Y083LI5kq5OkE2/R
	 8dKuBcxdPOCuEhQZ2jZZJhj0M7BbQd8quBd25savioXP9FUnQKup1nh2zfdUgZJzGn
	 IWoDm/R5tyDUFJIDuk1+wdlG8e4KEj4OSbNZLIl4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D1C26F801EC;
	Wed, 24 Mar 2021 14:03:12 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CBE5DF8016B; Wed, 24 Mar 2021 13:03:40 +0100 (CET)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A83B6F800FF
 for <alsa-devel@alsa-project.org>; Wed, 24 Mar 2021 13:03:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A83B6F800FF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.b="bvTLiBhR"
Received: by mail-pj1-x102f.google.com with SMTP id
 x7-20020a17090a2b07b02900c0ea793940so1038709pjc.2
 for <alsa-devel@alsa-project.org>; Wed, 24 Mar 2021 05:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FATkkZW5gT6uwmMKXVlOuMMmfd9ddwuhih5MyWFIPmQ=;
 b=bvTLiBhRU3soTMqBX0VQdSLIblsRysTwSVpc4bpdzneTQae4VNTAa57FqkcQOHSdxP
 5T/cOhxmBED5YLIMA8FOn312AvJrpYFG55bg7f1NX7lYtA/FYYfkaIyKClO7kABgS9Yi
 +gLtYR/RuYBB1KsT52qcLAQyWCPNgre3E+kI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FATkkZW5gT6uwmMKXVlOuMMmfd9ddwuhih5MyWFIPmQ=;
 b=GnpN7/KVhadrO9ufXXegblZu/YqZIbfZW7X9NKR6kYjtsRR/ewbvLYYq/vp75oDoKa
 pXxraLJgzwQfZPAqgwwIWyKPQrlwYrZpaL1bZreODKekFl6wac40V3NbYwR2A5NYGBAA
 0jmBZ/H4W8LNAZ24Vf7WMAH71+3XAP9DK9MXjPaUe05bAZZ0KbRGRLj1sx1BH7IVyLbR
 DozNzSe57B/xtdZnHITrz5YbQ1vvUqXBBXswn2eySEJbjpyftuSFjfOkmXDhTlqnbgoT
 53++ua/LbWjPE2yBCThxORGZyRQIgZJWv3CzaAjt30XNmLVyl48YRO2puClOckQZTl22
 fRog==
X-Gm-Message-State: AOAM5301U4Psrmll8qrQONxd7pQNYVJpJRT1FEfD+6L8EKVV02g8IR2X
 HeNxL6BpZkOY7a+At/4fXCZ7bf26sYU6oLWxPzQSOg==
X-Google-Smtp-Source: ABdhPJyziTFkEoI+ZbWJUwmZhRSGltbFgoMaaVJA302FSTLfW+/DiK39CyZB4p3Y2l+t+8H4sKrXjjquDtSdg/5uXu4=
X-Received: by 2002:a17:903:1cc:b029:e6:f37a:2185 with SMTP id
 e12-20020a17090301ccb02900e6f37a2185mr3248586plh.67.1616587405693; Wed, 24
 Mar 2021 05:03:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210324105153.2322881-1-ikjn@chromium.org>
 <c21de867cf4ccbfcc8cf555c78dc70dd3a47dfe8.camel@infinera.com>
In-Reply-To: <c21de867cf4ccbfcc8cf555c78dc70dd3a47dfe8.camel@infinera.com>
From: Ikjoon Jang <ikjn@chromium.org>
Date: Wed, 24 Mar 2021 20:03:14 +0800
Message-ID: <CAATdQgDrri-tMtu3AOFRcbGHfL6hONDfdMdZh45BusbdAoWfdw@mail.gmail.com>
Subject: Re: [PATCH] ALSA: usb-audio: Apply sample rate quirk to Logitech
 Connect
To: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
X-Mailman-Approved-At: Wed, 24 Mar 2021 14:03:11 +0100
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
Cc: linux-kernel@vger.kernel, alsa-devel@alsa-project.org,
 Olivia Mackintosh <livvy@base.nu>, Dylan Robinson <dylan_robinson@motu.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Alexander Tsoy <alexander@tsoy.me>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>,
 Gregor Pintar <grpintar@gmail.com>, Dmitry Panchenko <dmitry@d-systems.ee>,
 open list <linux-kernel@vger.kernel.org>
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

On Wed, Mar 24, 2021, 7:16 PM Joakim Tjernlund <
Joakim.Tjernlund@infinera.com> wrote:

> On Wed, 2021-03-24 at 18:51 +0800, Ikjoon Jang wrote:
> > Logitech ConferenceCam Connect is a compound USB device with UVC and
> > UAC. Not 100% reproducible but sometimes it keeps responding STALL to
> > every control transfer once it receives get_freq request.
> >
> > This patch adds 046d:0x084c to a snd_usb_get_sample_rate_quirk list.
> >
> > Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=203419
> > Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
>
> Most Logitech USB headset I got needs a delay in snd_usb_ctl_msg_quirk()
> Have you tried to add say 20 ms delay in there?
>
>
I didn't try that. But it sounds reasonable to me.

let me try that quirk here. If that is the case, HID might need that delay
also. Logitech Group webcam had a similar problem on control xfer of
get_report from an another interface for HID.

And 20ms can be too long if it's applied to every control transfer. I will
test the device with shorter delay if you didn't try it before.

Any additional advice is welcome.

Thanks!

 Jocke
>
>
