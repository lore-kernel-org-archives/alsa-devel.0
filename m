Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2BA6C5DF94
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Aug 2026 11:46:23 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9194F6022A;
	Mon, 24 Aug 2026 13:46:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9194F6022A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1787571981;
	bh=zQIkyS1Lj6vpFLEgvVf29BKxv90WRLvahDHgjm6NvLw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=QJahk0oVLEhikvxE4qA+6k7N89zJnwLOFOkwBQf0gghdo4fCNVyThz2QSlhZIVHcf
	 dVW9gBEn9DmjYeIPTAAjhPlsr9r15p39LNHNUyncVgZQFNLrg2MdeJMqB4jSrJjB/M
	 9PRYck316YO/bpTexSyMIWSQt8ahSwp7SqvJBdzQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 84687F8061C; Mon, 24 Aug 2026 13:45:31 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A6D4CF80611;
	Mon, 24 Aug 2026 13:45:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A697FF805A8; Mon, 24 Aug 2026 03:56:14 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=182.22.18.26
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1787536568;
	b=YQiMFM2rRV98zM6owKX0wsO+MjyYaD2ot9fK3hJuQuJoC0aqnYuz0SIx4YDIzaLOTIfF
	 o3HYaIiDVCMY4qEeuFW3qt3hSpAQw7wmP+tGwKlkbrylhYtWbhaO4TFpvsW9hGm13eMD7
	 BerZohHs7dZYSUyVQzgZl765SEpT+g7Z+4M5i6N5U8tKQLV8njeCRIon/bW8wyvbm3d/j
	 VpgYEjLo9HwFKqWdSauEVr/k1Jihwn00593dn/ubFhYemQTW0FGswNDbh1HzbwZixa2zM
	 HkGl65nGufMYo0vXLbeqGaBJKjCDkDr7dHrQny/LiFNX5loZILIii214/t6/kJZPu0w==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1787536568;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version;
	bh=zQIkyS1Lj6vpFLEgvVf29BKxv90WRLvahDHgjm6NvLw=;
	b=HGoJx8szjG0HSSdVUr/8TQMESczhMXbylBAemEHzHzdgTaM6U1nVZZJdACtUkXtXADeF
	 JJcHA5ERn5ZbEMp8yzu0nxu9BAXeBQ5ay84II77tSAd4Zk5fzPh2TkpFcIwGCZMfvIVto
	 ZO6YbpxzhmCD9daON39gVGg0MnTzoHBShSXfb7lYZBeh3EEjqNTThbOh4Oo27LTzO0aAa
	 iBV1OsyORGI9W5Lph4Omj5v3c5jtWv4jurYWLPZSvMAe1Mel34uAkVAagCDq8kUC74i8/
	 Zh2z2LCnqeTSEU5a69ZTqYR4bqwfYEOKmlciz/5sxGsx2pkxlLHKGxMJ7Icq1xxv2SA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=yahoo.co.jp header.i=@yahoo.co.jp header.a=rsa-sha256
 header.s=yahoocojp-202506 header.b=c4cPzV64;
	arc=none smtp.remote-ip=182.22.18.26
Received: from omggw0020.mail.otm.yahoo.co.jp (omggw0020.mail.otm.yahoo.co.jp
 [182.22.18.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 1FA39F8007E
	for <alsa-devel@alsa-project.org>; Mon, 24 Aug 2026 03:56:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1FA39F8007E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=yahoo.co.jp header.i=@yahoo.co.jp header.a=rsa-sha256
 header.s=yahoocojp-202506 header.b=c4cPzV64
X-YMail-OSG: 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
X-Sonic-MF: seiji_adachi@yahoo.co.jp
Received: from sonicgw.mail.gze.yahoo.co.jp by
 sonicconh6103.mail.ssk.ynwp.yahoo.co.jp with HTTP;
 Mon, 24 Aug 2026 01:55:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787536553;
	s=yahoocojp-202506; d=yahoo.co.jp;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date;
	bh=2ty3l7VK47XMut+ML4O58QjOF9P7wfShH03Yg5DECT4=;
	b=c4cPzV64SDAblyd5ShXkbS2gEZR9EiQJLmbDLLQ+C+1X/TDjNDF68Qnvelxvepf+
	ltn9b7j5CsoHk2pEkjfO3GV6knXiUS2rADM2pn2VyushvlDsXQFJzxvsxXOZ8ANIYcO
	UvMTn6Zy8+/gRhMUzFDJCsrYxQ8eeHJHLyspFe+WOOakOEUsrKzW5J0rnTAzeAzM8vB
	IzuWhfQMY2ur3jpilrKPeaZnQJB24I2CfNMpEJfA9PI823jRXTvmCzNlKIw6FPU6u7p
	vs2EN/gQhoBZmZj2EEp2PyBeri8ByF7JoqUs6oCFmSdenAjHUcTM/A0/tpCM3nFQeNb
	64w6Rfmevw==
Received: by smtphe6005.mail.ssk.ynwp.yahoo.co.jp (YJ Hermes SMTP Server) with
 ESMTPA ID 5aca8373ffdf25969dbbace978b2903c;
          Mon, 24 Aug 2026 10:55:54 +0900 (JST)
Date: Mon, 24 Aug 2026 10:55:53 +0900
From: Seiji Adachi <seiji_adachi@yahoo.co.jp>
To: alsa-devel@alsa-project.org
Cc: Seiji Adachi <seiji_adachi@yahoo.co.jp>
Subject: Re: [PATCH] ASoC: amd: yc: Add Lenovo ThinkPad E16 Gen 2 (21JN) to
 quirks
Message-ID: <aoukqUoiIzcctf-k@adriana>
References: <almeAbvirJwQ5doF.ref@adriana>
 <almeAbvirJwQ5doF@adriana>
 <alnKI3bPaZUc6uwB@adriana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alnKI3bPaZUc6uwB@adriana>
X-MailFrom: seiji_adachi@yahoo.co.jp
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: JB5AJASVVIJ7UMV3WUKBMO7NZUV4E6PZ
X-Message-ID-Hash: JB5AJASVVIJ7UMV3WUKBMO7NZUV4E6PZ
X-Mailman-Approved-At: Mon, 24 Aug 2026 11:45:26 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/JB5AJASVVIJ7UMV3WUKBMO7NZUV4E6PZ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi,

I am writing to provide an update regarding the internal microphone issue on Lenovo ThinkPad E16 Gen 2 (21JN-003SCD).

I have recently updated the kernel to version 7.1.8+deb13-amd64 (Debian trixie-backports), but the internal digital microphone (DMIC) is still not recognized.

Output of `arecord -l` on kernel 7.1.8:
**** List of CAPTURE Hardware Devices ****
card 1: Generic_1 [HD-Audio Generic], device 0: CX11880 Analog [CX11880 Analog]
  Subdevices: 0/1
  Subdevice #0: subdevice #0

Could you please check if the DMI entry for 21JN can be added to sound/soc/amd/yc/acp6x-mach.c?

Thank you for your help.

Best regards,
Seiji


On Fri, Jul 17, 2026 at 02:22:27PM +0800, Seiji Adachi wrote:
> Hi,
> 
> An update on this: I have just upgraded my system kernel to the latest available version, 7.0.13. 
> 
> However, the internal digital microphone (DMIC) is still not detected (`arecord -l` shows the same result as before). 
> 
> So the quirk entry for "21JN" is definitely still needed in the latest kernel version.
> 
> Best regards,
> 
> Seiji
> 
> On Fri, Jul 17, 2026 at 11:17:58AM +0800, Seiji Adachi wrote:
> > Hi,
> > 
> > I have a Lenovo ThinkPad E16 Gen 2 (AMD Ryzen 7 7735HS) with machine type "21JN".
> > Currently, the internal digital microphone (DMIC) is not detected on Debian 13 (kernel 6.18).
> > 
> > Similar to the "21M5" model, this "21JN" model also requires a DMI quirk entry to enable the internal microphone.
> > 
> > Could you please add the "21JN" model to the quirk list in `sound/soc/amd/yc/acp6x-mach.c`?
> > 
> > DMI info:
> > - Vendor: LENOVO
> > - Product Name: 21JN
> > 
> > Thank you,
> > 
> > Seiji Adachi
