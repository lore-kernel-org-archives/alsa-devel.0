Return-Path: <SRS0=dMuI=H3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3059BC433DB
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Feb 2021 11:27:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62C2564EF1
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Feb 2021 11:27:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62C2564EF1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F0C2B1678;
	Thu, 25 Feb 2021 12:26:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F0C2B1678
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614252441;
	bh=Ii6mCKLdMk+Svk1KpodaVpXsreuwHJe163Dne4id3BY=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LO4t+yyMqxv/IbjDx1kFZ7mJQMzM+Jbe5lqcVt1MYJK2COO+mAx/8mcTtrHHG7vuj
	 UBZgx1kn6ZmXKSAd2olWUV5VrjAsmqhv39vag7emXv6GBRaO45yHMydweqzxHdwhb1
	 eDobbXC+0GpZOqXgMdP/BmMqn8rEaD4mvhqWMPCg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 315ABF8026C;
	Thu, 25 Feb 2021 12:25:34 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A062AF8016A; Sun, 21 Feb 2021 12:29:52 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E9CECF80082
 for <alsa-devel@alsa-project.org>; Sun, 21 Feb 2021 12:29:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E9CECF80082
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Hg/RZgO7"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 05E7F64EE6;
 Sun, 21 Feb 2021 11:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1613906975;
 bh=Ii6mCKLdMk+Svk1KpodaVpXsreuwHJe163Dne4id3BY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Hg/RZgO7qxllEtTrL+rwIOgLwBckH64fiQbKiNXlL8AzYSvzcxfNBvGyfvQgJnm7X
 A3BNl7/KbTkMm329Fkn5y4jeAe5WPqHPwFs64MmyLQG/1kJbiBrzjwdqhhbrxxwy+D
 MUzSjQmZwUNIJrhBtRDMH54pU4gW7Q6CQZ16ChqyBXxeXEpb+ic+dKogt/ldAdOkb9
 92ESx35CwxZNauEHtcE+oiaUDtz3xHTeB3JRpsSRNloN8gceKCvM1CEMW1CkPlu9f9
 /feOqkMJI3MfpccHMN5KFRiecFdBrb70cEBJl1naM8bSWSXMnv2WxVgUS/wrXfFQVi
 FuSDpxGGekG/w==
Date: Sun, 21 Feb 2021 12:29:31 +0100
From: Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v3 5/7] HID: lenovo: Set LEDs max_brightness value
Message-ID: <20210221122931.78f9a448@kernel.org>
In-Reply-To: <20210221112005.102116-6-hdegoede@redhat.com>
References: <20210221112005.102116-1-hdegoede@redhat.com>
 <20210221112005.102116-6-hdegoede@redhat.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 25 Feb 2021 12:25:30 +0100
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>,
 alsa-devel@alsa-project.org, Jiri Kosina <jikos@kernel.org>,
 linux-leds@vger.kernel.org, linux-input@vger.kernel.org
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

Reviewed-by: Marek Beh=C3=BAn <kabel@kernel.org>
