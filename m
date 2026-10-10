Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4F2DCA9EBE
	for <alsa-devel@archiver.kernel.org>; Sat, 10 Oct 2026 08:12:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A4E4B601FE;
	Sat, 10 Oct 2026 10:12:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A4E4B601FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791619966;
	bh=2rZUdgbMGJzhI9CwwX7Mud7hTxfmVTF1ZQqKv2q2yrQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=j7VW6yigP9lS5R8OWaQlGbi8CFXfTt/14/zJ4zognFG2orWy9mRM/78HO7SWPNrxA
	 Fy4V/umMcO5lmfIpZAQrlKEocTKeCr70wdRyUUnaWELGApXRXM8mIUq2EkuLgoqvY6
	 Li1EM7GELmDeq4Nc+mg6e0cpkFmw3mDKbniYXrqY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EB8F1F80602; Sat, 10 Oct 2026 10:12:12 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2C3C5F805F5;
	Sat, 10 Oct 2026 10:12:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C9D15F80542; Sat, 10 Oct 2026 10:12:05 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1791619921;
	b=YlSmkd/HRu4Ac4O+hM5bJev18BI8nbDGApW8p1ZmvH8TCUwft7HfpAbTBTfe8/VvWHxY
	 kPkLRzX2hmRtHTufhYce461Im0cYfNz6RTSbbxXVbZHQLt5sPlx3UcZdXF2o31LUwM0xe
	 +lWJPPDh88IXuVjMTv0bmc4+/BXSGLbi56q04mtaUx45kxp2CxCwmEBtKSQmDfduhA4Yr
	 AFX1sj99IQhGnDhJawG5tW9IQLnWk7lecyaTLSaQIsyLZk39qPzhrJA2kxmwTpUHWcC7c
	 2fdRkI6qhkaWkoaYlg3pWNRR7xckK1QGOLL2qOV9Oc6y/i47qwIrI2xf+JNpPQkFQVA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791619921;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version;
	bh=2rZUdgbMGJzhI9CwwX7Mud7hTxfmVTF1ZQqKv2q2yrQ=;
	b=qVvGS/vy2FVrRzVA2rIWg3X2TTVq3jLRknF9iKzfPIU9G2ned8FHmI2oxR9Dj46E9Y5y
	 irI6akYAbqWzZt4RVZZNAq8jR1qP+UngOrGguTASBoGLJjhk3xVAaWOKUGQ66BeAphy4v
	 YUhAVYGmNm9SrS1o4uaC1Eb+v0XjRH6QR520mGxirMZ1Vn6mGBQ3cPdVYIEdWNEj3rKAi
	 cDuA3dv3tw3VMwQGiiV29YlZYoF/LRmNKbJ/C77nRTonHaI/iV2aFlHplDCnH+x3lYL2n
	 5K4R14p16RiPbyHz3OgTMXUQdb3Ne7B5wMAhsgqohWauTX5xeyaDuO250R3Dtn2kc4A==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org
 header.a=rsa-sha256 header.s=korg header.b=cvxIrYN0;
	arc=none smtp.remote-ip=172.105.4.254
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 5DF82F80495
	for <alsa-devel@alsa-project.org>; Sat, 10 Oct 2026 10:12:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5DF82F80495
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org
 header.a=rsa-sha256 header.s=korg header.b=cvxIrYN0
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 7ACCF60052;
	Sat, 10 Oct 2026 08:11:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FFD81F000FF;
	Sat, 10 Oct 2026 08:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791619917;
	bh=zXoT75VAg0QQnbU3meJurk3OY8K/rR/+4AFCNCvYv6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cvxIrYN0nT21NXcwwJSlW+E2nE/B0SEXd0k91NtUC/PztsXLyMM36fkHKivfvP+XK
	 OPQczRwzcY0E0dtd/K2yfmw9o8FlkkikoaPHlVZ9xMJyRMNWQDZ3JZ97kGvBtIhGap
	 P3RlpVL8+TkcxIsC2fItVuPMLmzqcyvSkHi8Dee8=
Date: Sat, 10 Oct 2026 10:11:54 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Eli D <info@16bc.ru>
Cc: stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
	alsa-devel@alsa-project.org,
	Kamlesh Chhetty <kamleshkc2002@gmail.com>
Subject: Re: Backport request for 7.0.y and 7.1.y: 6485da8579e2 (ALSA: hda:
 Add Lenovo Legion 7i 16IAX7 17AA3874 quirk)
Message-ID: <2026101016-quarters-headlock-683c@gregkh>
References: <7afbbd73-a09b-48d4-a534-4b38ffc3e191@16bc.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7afbbd73-a09b-48d4-a534-4b38ffc3e191@16bc.ru>
Message-ID-Hash: KQEA2BQ2KDN64WTUI7QY6U4T7ITJB652
X-Message-ID-Hash: KQEA2BQ2KDN64WTUI7QY6U4T7ITJB652
X-MailFrom: gregkh@linuxfoundation.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/KQEA2BQ2KDN64WTUI7QY6U4T7ITJB652/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Sat, Oct 10, 2026 at 12:24:42AM +0500, Eli D wrote:
> Hello,
> 
> I would like to request a backport of the mainline commit
> 
>   6485da8579e2  ALSA: hda: Add Lenovo Legion 7i 16IAX7 17AA3874 quirk
> 
> into the 7.0.y and 7.1.y stable series.

Both of those series are long end-of-life, so there's nothing we can do
here.  Please use a more modern kernel release that is supported, as can
be seen on the kernel.org front page.

thanks,

greg k-h
