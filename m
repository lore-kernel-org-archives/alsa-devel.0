Return-Path: <SRS0=nFZf=IA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68407C433E0
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Mar 2021 16:53:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 598F864F27
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Mar 2021 16:53:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 598F864F27
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxedocomputers.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C5CCA1795;
	Tue,  2 Mar 2021 17:52:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C5CCA1795
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614703985;
	bh=5uFPcMZrgT1aKIcRQJGiYOS91UA6Mf24B8sAe+xbQrA=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KzJ9/AfostpRLhCzqilw+9W9KAklIpdnrRa6w7TzI9EBdma9WKT1suSb+OXIPd165
	 SbGMnB165JeH7lwXmruTJmcj1DNsGoIXMF1Tjn39fqT1fozPSd9+mgmxC4ZWQdXOkc
	 mNW42lb0xJSvxYzJW+CSdgxSxQJv4BmRsysbf4to=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7235EF80269;
	Tue,  2 Mar 2021 17:52:03 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6A4EEF80273; Tue,  2 Mar 2021 17:52:02 +0100 (CET)
Received: from srv6.fidu.org (srv6.fidu.org [159.69.62.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2EDF3F80088
 for <alsa-devel@alsa-project.org>; Tue,  2 Mar 2021 17:51:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2EDF3F80088
Received: from localhost (localhost.localdomain [127.0.0.1])
 by srv6.fidu.org (Postfix) with ESMTP id 770CBC800D3;
 Tue,  2 Mar 2021 17:51:52 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
 by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id KBrrrSGKOnzX; Tue,  2 Mar 2021 17:51:52 +0100 (CET)
Received: from [IPv6:2003:e3:7f23:4700:cc41:88a7:f2f8:d6b8]
 (p200300E37f234700CC4188A7f2f8d6b8.dip0.t-ipconnect.de
 [IPv6:2003:e3:7f23:4700:cc41:88a7:f2f8:d6b8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: wse@tuxedocomputers.com)
 by srv6.fidu.org (Postfix) with ESMTPSA id 3F11DC80094;
 Tue,  2 Mar 2021 17:51:52 +0100 (CET)
Subject: Re: [PATCH] ALSA: hda/realtek: Add quirk for Clevo NH55RZQ
To: Takashi Iwai <tiwai@suse.de>
References: <c7a394b1-edd3-a692-0981-45086da82aac@tuxedocomputers.com>
 <s5hsg5dfy4h.wl-tiwai@suse.de>
From: Werner Sembach <wse@tuxedocomputers.com>
Autocrypt: addr=wse@tuxedocomputers.com; keydata=
 mDMEX6ALvhYJKwYBBAHaRw8BAQdAG/kE3mlbV1YLpCU8iA7Pyq2eDq9LxzGQxcOZODh2Vnq0
 KFdlcm5lciBTZW1iYWNoIDx3c2VAdHV4ZWRvY29tcHV0ZXJzLmNvbT6IlgQTFggAPhYhBNzq
 jJqAsvWKK1h7bi7eQpXUvijKBQJfoAu+AhsDBQkJZgGABQsJCAcCBhUKCQgLAgQWAgMBAh4B
 AheAAAoJEC7eQpXUvijKzkEA/jblmQRWU/e18oo8J9GPHWOCRUA1WJLUt9lSye5cgl2vAP0Y
 q+EpkDRS+QqtIcIr3fVELwA4b/V1lVE2LW+plcmdCbg4BF+gC74SCisGAQQBl1UBBQEBB0Bc
 k3J9DVAB4ysrdDcKE7L9iAUjlWD+rsLh/5soPORqFQMBCAeIfgQYFggAJhYhBNzqjJqAsvWK
 K1h7bi7eQpXUvijKBQJfoAu+AhsMBQkJZgGAAAoJEC7eQpXUvijKBBYA/2DT2g26dpTU2Rbc
 lqviltu+woGZCd0GBfRgXuzUK0OfAQCwr8qPCl8uIsBgOsDmWIJYByG2ddwmXiAgBS1985bM Ag==
Message-ID: <25fe7622-75e4-ec57-84e3-a41560bb8dee@tuxedocomputers.com>
Date: Tue, 2 Mar 2021 17:51:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <s5hsg5dfy4h.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, tiwai@suse.com
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

Hello Takashi,
> The patch isn't cleanly applicable.  Could you try to submit via
> git-send-email instead?

I'm sorry the editor + mailer i used replaced tabs with spaces and made a=
 html mail.

Already resend the patch with tabs, but only after that I realized that e=
ven the "plain" mails are converted to html.

It's probably still broken so don't waste your time with it, i will read =
the man page of git send-mail now ^^.

> Cc to stable is worthwhile.  You can simply add
>   Cc: <stable@vger.kernel.org>
>
> around your signed-off-by lines in the patch.

Ok (also forgot that in my resend patch)

Kind regards,

Werner Sembach


