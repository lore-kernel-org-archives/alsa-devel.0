Return-Path: <SRS0=jeAA=KJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14761C433ED
	for <alsa-devel@archiver.kernel.org>; Fri, 14 May 2021 15:44:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 768AA61029
	for <alsa-devel@archiver.kernel.org>; Fri, 14 May 2021 15:44:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 768AA61029
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0F52E1785;
	Fri, 14 May 2021 17:43:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0F52E1785
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1621007076;
	bh=c7dfcDSUedN/VQoQv/XM8fRZG2HhOOW57vq4i3XI37w=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=g0HqP3LthDG7KlOGvsIk0FSMQfMAiBugFyghH0DfP8VW5b93wJUgeA7vNwTY4VsD8
	 5nIX+heLmQAPbFuUhKsICnwRyhLCWU3V6PP2xs3VT3mudrKz0Aa7lEmESX4F1JUnmR
	 Q81NduleX1oyhNhg7L+bBQ9BH+MMh4QehqGi+eHo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 13047F804E4;
	Fri, 14 May 2021 17:39:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1DFDAF80240; Fri, 14 May 2021 16:18:53 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D1292F8012A
 for <alsa-devel@alsa-project.org>; Fri, 14 May 2021 16:18:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D1292F8012A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="OQ+w8jq4"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9C73C61408;
 Fri, 14 May 2021 14:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1621001918;
 bh=c7dfcDSUedN/VQoQv/XM8fRZG2HhOOW57vq4i3XI37w=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=OQ+w8jq41p/pK8QPzt383K43rnWDvG9IebEZzoZj7WKu0EgpEM3a4OB9pZnDV5/lC
 MxVWpkmQpp2inFtKTGn6bM1fAR+gA+04aBXFsHrR34k+VM9wQUFTEenWCHNxw8mV5S
 Rr3kzMIGVT+KJ8CgQJfj5jt0KJvZQg0gfBfD7ImGjDrz6TXEWqjpD0nn1NC8t6bBSV
 Y2m7PBzQCXheFvsYF9jZqx3chr66nJXcElBiHfvACPcxjY0VNJoiSeft4M6sPjRp9i
 /15Ta8qfh6z3LjSIBpnNeZl0hFKEsFjvWWGKfF/qxDT0jcgdTLCyifuXI2D1S1QhIL
 whK9i7cORQs2g==
Date: Fri, 14 May 2021 16:18:25 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Edward Cree <ecree.xilinx@gmail.com>
Subject: Re: [PATCH v2 00/40] Use ASCII subset instead of UTF-8 alternate
 symbols
Message-ID: <20210514161825.4e4c0d3e@coco.lan>
In-Reply-To: <8b8bc929-2f07-049d-f24c-cb1f1d85bbaa@gmail.com>
References: <cover.1620823573.git.mchehab+huawei@kernel.org>
 <d2fed242fbe200706b8d23a53512f0311d900297.camel@infradead.org>
 <20210514102118.1b71bec3@coco.lan>
 <61c286b7afd6c4acf71418feee4eecca2e6c80c8.camel@infradead.org>
 <8b8bc929-2f07-049d-f24c-cb1f1d85bbaa@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 14 May 2021 17:39:48 +0200
Cc: alsa-devel@alsa-project.org, kvm@vger.kernel.org,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>, linux-iio@vger.kernel.org,
 linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
 keyrings@vger.kernel.org, linux-sgx@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, linux-rdma@vger.kernel.org,
 linux-acpi@vger.kernel.org, Mali DP Maintainers <malidp@foss.arm.com>,
 linux-input@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-ext4@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 linux-media@vger.kernel.org, linux-pm@vger.kernel.org,
 coresight@lists.linaro.org, rcu@vger.kernel.org,
 mjpeg-users@lists.sourceforge.net, linux-arm-kernel@lists.infradead.org,
 linux-edac@vger.kernel.org, linux-hwmon@vger.kernel.org,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-integrity@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>
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

Em Fri, 14 May 2021 12:08:36 +0100
Edward Cree <ecree.xilinx@gmail.com> escreveu:

> For anyone who doesn't know about it: X has this wonderful thing called
>  the Compose key[1].  For instance, type =E2=8E=84--- to get =E2=80=94, o=
r =E2=8E=84<" for =E2=80=9C.
> Much more mnemonic than Unicode codepoints; and you can extend it with
>  user-defined sequences in your ~/.XCompose file.

Good tip. I haven't use composite for years, as US-intl with dead keys is
enough for 99.999% of my needs.=20

Btw, at least on Fedora with Mate, Composite is disabled by default. It has
to be enabled first using the same tool that allows changing the Keyboard
layout[1].

Yet, typing an EN DASH for example, would be "<composite>--.", with is 4
keystrokes instead of just two ('--'). It means twice the effort ;-)

[1] KDE, GNome, Mate, ... have different ways to enable it and to=20
    select what key would be considered <composite>:

	https://dry.sailingissues.com/us-international-keyboard-layout.html
	https://help.ubuntu.com/community/ComposeKey

Thanks,
Mauro
