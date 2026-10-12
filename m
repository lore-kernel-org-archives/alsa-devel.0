Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D732CA9ED0
	for <alsa-devel@archiver.kernel.org>; Mon, 12 Oct 2026 10:59:33 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 591C7601FD;
	Mon, 12 Oct 2026 12:59:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 591C7601FD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791802771;
	bh=GukRYsRjTQQnhmISVcxKD2uCMtiqdM/bzG2vZDaC/+A=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=hYm3Wt+JNtFSbhO0g6fiG8UGDE4ZE8Tp+XwPhuN8q7mn4tn9RmwHS1g0e4VzyUfo3
	 WNRclcLteNoV0ltcr5t0kCjxYW5jmMyvICGfe4uiX5sfdBPm6luEjAy4Y+tetwZE58
	 YulWbQSAxh50jscgQCGPlFGJHdCJEEN7wSWq/vo8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 73DE1F805F4; Mon, 12 Oct 2026 12:58:56 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 08F23F8058C;
	Mon, 12 Oct 2026 12:58:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9D2DEF80526; Mon, 12 Oct 2026 12:58:48 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=95.85.9.111
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1791802725;
	b=JECxEudaJf8+daTNp91Mzj8pFZz58XlfmnbIDk8Oot2NWkw4k1FVYsXK5e2GRUvqghcl
	 oPuKnl0UPfjYLxjNxdnpUgTyCjQPu846BTDcMcS1ms3v84fXJB0DyJoHB5SOjgYGOxYgX
	 rpx5nvwJvLJJfaQS3znniM8COUfT2c3OSp842rPh1nIVtwIxpuWTMNDyEylVVixdM23Hr
	 eWoic30Y00mLJ5q//GtmBvh1HjkDVdJ1bTJNQmOqSYl2Kj62oMXsEi1g7EE6oBLI/GoBf
	 cQ7ulPjxNP5MYli2BrudeOHPvbSE8ShzVwZM1BpvrlrGf8r48LjsPKzYd4tfGI7I/6Q==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791802725;
	h=Message-ID:Subject:From:To:Date:MIME-Version;
	bh=GukRYsRjTQQnhmISVcxKD2uCMtiqdM/bzG2vZDaC/+A=;
	b=S5ufBaBhYaPZsewX8NTBCMEa7GjCUFL8zvOC7oSzfn3LygwrvsEllbi0rdod9xCvzB3M
	 WZtRNR7WVjYTIOvgJd9ewYiZb+yf+mhX7riBt45x3eF72uinwxX3wcfY31lLZnVYzTKLI
	 FTWEwjQmUPS+X6LevrR/ZuQlRSpfTVN27GiFYnH01Q8fPMX7Mbp3qzMwF6uYWcrlun3nl
	 V0SY1GKP+6obDkGGqa5TzXSoS5TMrx/8jR14uNb5uDJVdK2yNat0nimWn285R5Nvw+aqv
	 n4U6RePcuNpHWTV7wjmQybbyKsGnAS7xAC3+h6S2m5mENBP+MXDg15PtaTcRKBIFBdw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=95.85.9.111
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with UTF8SMTPS id 426A0F80424
	for <alsa-devel@alsa-project.org>; Mon, 12 Oct 2026 12:58:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 426A0F80424
Received: from [192.168.2.4] (bc24bec8.dsl.pool.telekom.hu
 [::ffff:188.36.190.200])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 00000000000C70AA.000000006ACCBD62.00335E2B;
 Mon, 12 Oct 2026 12:58:42 +0200
Message-ID: <368151886b753a44feb5b56fe9c7147d9956ed4f.camel@irl.hu>
Subject: Re: [PATCH v2] ALSA: hda/tas2781: Enable bass speakers support
From: Gergo Koteles <soyer@irl.hu>
To: Georg Wenzel <g.wenzel@gmail.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org,
  linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 12 Oct 2026 12:58:47 +0200
In-Reply-To: 
 <CAKnFnk5ZY1njMkqwLPtOrv817LFfXS7jfh6vaEvqA03s8uorUA@mail.gmail.com>
References: <87cxtw2y8b.wl-tiwai@suse.de>
	 <20261004071202.89116-1-g.wenzel@gmail.com>
	 <08164314db94522865dd4681d414bc42939da545.camel@irl.hu>
	 <CAKnFnk5ZY1njMkqwLPtOrv817LFfXS7jfh6vaEvqA03s8uorUA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
MIME-Version: 1.0
Message-ID-Hash: CJJ2HUKGRTVDBBZRCIO6CVWO3GT2EGNM
X-Message-ID-Hash: CJJ2HUKGRTVDBBZRCIO6CVWO3GT2EGNM
X-MailFrom: soyer@irl.hu
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/CJJ2HUKGRTVDBBZRCIO6CVWO3GT2EGNM/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi Georg,

On Mon, 2026-10-12 at 10:47 +0200, Georg Wenzel wrote:
> Hi Gergo,
> I'm not very familiar with kernel development.
> My problem is that the subwoofer doesn't work without the patch, but it
> does work with the patch.
> So I figured others might be having the same problem, which is why I
> submitted the patch.
>=20

My problem is that this simplifies down the TAS2563 part of the driver
to setting just these few registers, bypassing the firmware and the
machine-specific calibration values.

Could there be a problem with your kernel config or your hardware?
Have you tried it with a distro kernel? If you live boot into a Fedora
it should work.

Best regards,
Gergo
