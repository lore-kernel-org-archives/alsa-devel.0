Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A50DCD8CA8
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Jun 2026 20:03:33 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B597A601BD;
	Tue,  9 Jun 2026 22:03:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B597A601BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1781035411;
	bh=vTH/srESL7tpS+ECPCB7v52KdDC9EcXkC0ey3n2L7To=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=FnLmp4oIBnGIzWQpFJh52TrFYmohL1tqtCYmhRWuraKtJ+T2OIW1VPu6fz/0OlrGo
	 H6SKnRumekm9mq4dH7eL79F+sSHuKgJZ+4PRcXVK6OfksDAq0n9bXOyD7SQezKFW95
	 NXCm+y7ZfL4Z2+/lXgnSlpBDe0BVG0kOXIgTyz3k=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6B8DFF805FB; Tue,  9 Jun 2026 22:02:56 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C0C59F805F6;
	Tue,  9 Jun 2026 22:02:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 34FDAF80496; Tue,  9 Jun 2026 22:02:51 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=209.85.219.48
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1781035370;
	b=qmlrfdvOyro1rXo+becxi1bfWdoYlpzbBuhrSmCZkKzZk8DSQGTV9ylYApIVJ+l9AoAc
	 m5/VdPAnn5NEJhmRDmruWZHnLIp+Zzs7fyM6mRo/xkYl7kyl/wC8cuLJ/dth3E4sAISgp
	 zhJCF7OePTYqZJpBYpaqhZ91DgXiPZpGggetlcS+B0aSLJmXyjJ/KLgcz1mXwgwXE81VY
	 EKcWo9H1FotrxVT4ON/TCK4hu/SYagWcic5SAqZ5Bc2MppEK7yaLcs/k7R32L8yUwjAhh
	 oqNAH55f6ujnZSUSo2ADpk7wZGD+r24jNblSC8Wzfm+lc3Sv+HeOGgZFDJMOKU35JHQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1781035370;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version;
	bh=vTH/srESL7tpS+ECPCB7v52KdDC9EcXkC0ey3n2L7To=;
	b=TrzSI5SsniH+Kal/0suLXwjmO9avv4vt+y0Pyvxp+kCJg1+lter3PjZPuN78F90F5otl
	 QKVS82MfiArEKd/aDKnasVflW/JgLa3NaXsgV081VqfqF44Tf01K4Wf0mXoI1bnx9yfKf
	 g4qaAnzvVOoQeUrIBIEThTOopFAHXQ/65ijaWiQBMO+BXgXxmICltp+KYNs20yw0qXjYz
	 lb8N6bBbaW36b3/YYWPjqloy8spp17rBiKPznx9g3vCkGURsymJwj9nE3zr6U7iNSZBzt
	 MbM/oVYnPpKzZd66+RW3ajFMdXBqXYHrSk8fBO3CO1jymD26ri4Q07vmdYsBLSbj+Ig==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=QPPrt6xB;
	arc=none smtp.remote-ip=209.85.219.48
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com
 [209.85.219.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 9837BF801F5
	for <alsa-devel@alsa-project.org>; Tue,  9 Jun 2026 22:02:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9837BF801F5
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=QPPrt6xB
Received: by mail-qv1-f48.google.com with SMTP id
 6a1803df08f44-8ce9df48e1bso58426536d6.1
        for <alsa-devel@alsa-project.org>;
 Tue, 09 Jun 2026 13:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781035367; x=1781640167;
 darn=alsa-project.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+TCKI/Z6pxJHU8K9ghal+V4w2YNU/rhZJK7YynAhpYM=;
        b=QPPrt6xBacx83lXvQoRNgHgxLkZ7C6//zxhUc79rPFxS2PusDAzLB57JSASnDOhs/m
         YrPMaBRHWGZStJE3uy5pJs7p/HeZN61uN25UwCw25Vo9oUwfskxnflgXQ/IqDAeCE/dE
         HemaVK47KeQdlVXRItGk8WUjYAooydCmHnqTVsJnNxlmpcxcOwY+7aILIfZzyAgzhXir
         FnXBWRT/bXqgutNeRnLI6uwRbe261ZlpjzkeeY9ptCqql7Vl7hW9uoeFQQOuhf4SIypJ
         wwzlEHtqo1XySWwYUoVHOKPGqQ/aglmwuBLvASzKoIkWGMchd+H2U2ZSfHQBuIhxCC6W
         KOiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781035367; x=1781640167;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+TCKI/Z6pxJHU8K9ghal+V4w2YNU/rhZJK7YynAhpYM=;
        b=UvbyfWvZxr9eKMP1oASXLjGisXvwqVKHweGiKdZiWKyWVrt/35LnjwlnEYHakjve3+
         2InxDbNzTO8i5dqnaRReb+gLO6r1iAsU2/9gJ8HCQj9+dADbrYGV0ccn31I6VX39CMFd
         Fc2LsPvQHNUTg1MrMOMCRFxTvhBkhIFeI+Lq4aFnPGBU1vl0X9F0Hi0/3HDxV97n2b+d
         MkNF9H56yG5SjTQfPoShk/8R7hKboxBGHuNoAP9JS0NWQ9CHUh/wJ6SRpVrClSj5oNsZ
         +JOL427Y6pg/LvB6nfdsPd3kBassZ6LFDPK0pV0tQ01v8dkW6lMx9+kfBrIeudHXqFfp
         IKZA==
X-Gm-Message-State: AOJu0Yx19rQQpKlnsSgJkpUIlqCqF7bf6AEW8pIk03tpG5FSNsNvArPl
	ZnjQqv8KEE2Ngs5Ih9YkmBJRPgDgxQO13FNQOPsBrPraK6b+i4QRVXc+78B1lw==
X-Gm-Gg: Acq92OGifohjI8+QuVpg2liubieYlSYGFbGq3SQ/45kQa7y/N0PipaYkGhAGSql5KtT
	ePiHNNIkGFgJvCga6QQFc9uZGPzqLEdSyyz639HVNdCkM0oCki5/ixH531wqQBnVnA3mcsdjAfY
	Q2OMyJx7baXiEhD53YRK1PvSpYL9Y4X4J5f2hMaXESQCdvV7ueEJrIdGY2J7b5Wnt04dxk5bjcz
	FVcyMpXZQFsHSTCzRoq9WmPDcaGC4IA/DnUfJgJzNr3FhhPMRtXtI5Sm2jMoTYCABPLSzhEFi/+
	n4ZWZPMZ+Sn1/9WLj1Ktt+Ujt2UJBN3X7wK93ZfCIhRLIVQgKAGgnRj7VNZY8oidbtRvR/jhYWc
	oW/jCzT5BKjNXZ9YuBfEQ36h5xo4/6fDbWZqGfdum3fgsuGw40iKFNW5k+VQXe2OXyuSxQXRMzW
	kJlbMzug2iX2p1JbBsZRO3
X-Received: by 2002:a05:6214:451f:b0:8cc:f175:3ac4 with SMTP id
 6a1803df08f44-8cee626eec5mr343689936d6.43.1781035367250;
        Tue, 09 Jun 2026 13:02:47 -0700 (PDT)
Received: from geday ([2804:7f2:800b:dd29::dead:c001])
        by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8cecd2629cesm207659566d6.41.2026.06.09.13.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 13:02:46 -0700 (PDT)
Date: Tue, 9 Jun 2026 17:02:41 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: furstblumier <seal@furst.blue>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, perex@perex.cz,
	linux-sound@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: Add quirk for HP 255 15.6 inch G9
 Notebook PC
Message-ID: <aihxYefWRPyf2zK9@geday>
References: <20260507202754.16114-1-seal@furst.blue>
 <20260609195443.498879-1-seal@furst.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609195443.498879-1-seal@furst.blue>
Message-ID-Hash: NUAGMH27E7RBGKQZGURHZROWPO4JV2ZP
X-Message-ID-Hash: NUAGMH27E7RBGKQZGURHZROWPO4JV2ZP
X-MailFrom: geraldogabriel@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/NUAGMH27E7RBGKQZGURHZROWPO4JV2ZP/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi Furst

On Tue, Jun 09, 2026 at 09:54:43PM +0200, furstblumier wrote:
> The HP 255 15.6 inch G9 Notebook PC (PCI SSID 103c:8a1b) uses the
> ALC236 codec but lacks an entry in the quirk table, causing the kernel
> to fall back to a null SSID match (103c:0000) and skip the necessary
> fixup. Add a quirk entry using ALC236_FIXUP_HP_MUTE_LED_COEFBIT2,
> matching the HP 255 G8 which uses the same codec and fixup. This fixes
> the mute-button LED and fixes an issue with unplugging and replugging a
> headset jack not being recognized as an audio sink.
> 
> Signed-off-by: Furst Blumier <seal@furst.blue>
> ---
>  sound/hda/codecs/realtek/alc269.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
> index 11d0ea8ed..08c8b17b7 100644
> --- a/sound/hda/codecs/realtek/alc269.c
> +++ b/sound/hda/codecs/realtek/alc269.c
> @@ -7063,6 +7063,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
>  	SND_PCI_QUIRK(0x103c, 0x89da, "HP Spectre x360 14t-ea100", ALC245_FIXUP_HP_SPECTRE_X360_EU0XXX),
>  	SND_PCI_QUIRK(0x103c, 0x89e7, "HP Elite x2 G9", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
>  	SND_PCI_QUIRK(0x103c, 0x8a0f, "HP Pavilion 14-ec1xxx", ALC287_FIXUP_HP_GPIO_LED),
> +	SND_PCI_QUIRK(0x103c, 0x8a1b, "HP 255 15.6 inch G9 Notebook PC", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
>  	SND_PCI_QUIRK(0x103c, 0x8a1f, "HP Laptop 14s-dr5xxx", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
>  	SND_PCI_QUIRK(0x103c, 0x8a20, "HP Laptop 15s-fq5xxx", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
>  	SND_PCI_QUIRK(0x103c, 0x8a25, "HP Victus 16-d1xxx (MB 8A25)", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
> -- 
> 2.54.0
> 

The body of the patch and all metadata are now correct but you replied
to your own message (that has been previously ignored) with the patch.

Please don't do this.

Please resend patches in their own thread, with the RESEND marker.

If in doubt about the kernel process, consult https://docs.kernel.org

