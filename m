Return-Path: <SRS0=ObP5=KM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB8AC433ED
	for <alsa-devel@archiver.kernel.org>; Mon, 17 May 2021 11:32:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2DB461209
	for <alsa-devel@archiver.kernel.org>; Mon, 17 May 2021 11:32:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2DB461209
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 47C4B1661;
	Mon, 17 May 2021 13:31:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 47C4B1661
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1621251123;
	bh=IqUZ0sNLzRXtoD/YFOpvkpCv7NFriIwqrV0nk+tQFjA=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tPGeIuKyZX/GVvm7VRUUBl7okkcIvXrRJI43dGgN2HEephtMChh2V5XxkUuhX7OGs
	 1ZH7e3OVsYQ+Y302TBtbkzu4K8+C1DK/qrLXk3AUZXA7FIJXN3jrf7YugUlG6E7Ne9
	 zEgUU6s0hkOsip5iLIudMwe52FTtbEeXekBlTWkA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4A7D2F80258;
	Mon, 17 May 2021 13:30:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 35C01F8020B; Mon, 17 May 2021 13:25:07 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C551CF80169
 for <alsa-devel@alsa-project.org>; Mon, 17 May 2021 13:25:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C551CF80169
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="SjZiucxT"
Received: by mail.kernel.org (Postfix) with ESMTPSA id E8DE86100C;
 Mon, 17 May 2021 11:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1621250697;
 bh=IqUZ0sNLzRXtoD/YFOpvkpCv7NFriIwqrV0nk+tQFjA=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=SjZiucxTGgskw3bZqxU8hkRIDqvLkRPDUPXGysGlCLAY4qMHHwLFDNWf7GzwMPeSy
 k6gBtne3rZl4OWw9EJiAKpC90ICt4wmL+dOW1/wtHGSzFBwlIEB7lPhufz0SGrH9U0
 8BeoyWN0zwaq92smlvSCsJzkysY0ZKum/rQEXJAZuksdPKz9UCm2b6rTTMrYAXAHuw
 m5K5R4IDiLhuXBms1/YwUa6BMqBAHs9uv2Ndu7DwgV1+6w7DgEDLXe2pUPRnLtE+Wd
 GExQHVUHQydYOYDz+zZFmQU4ywGdNTNfxU1WppJsq+V8siRV5m9U5SOv7k7mbiC129
 mEKSngo0SzESg==
Date: Mon, 17 May 2021 13:24:46 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH v3 00/16] Replace some bad characters on documents
Message-ID: <20210517132446.7edba98f@coco.lan>
In-Reply-To: <30cd6dd9d1049d56b629c92a5f385b84c026b445.camel@infradead.org>
References: <cover.1621159997.git.mchehab+huawei@kernel.org>
 <30cd6dd9d1049d56b629c92a5f385b84c026b445.camel@infradead.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 17 May 2021 13:30:15 +0200
Cc: alsa-devel@alsa-project.org, kvm@vger.kernel.org,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>, linux-pci@vger.kernel.org,
 Lai Jiangshan <jiangshanlai@gmail.com>,
 Thorsten Leemhuis <linux@leemhuis.info>, netdev@vger.kernel.org,
 Andreas Dilger <adilger.kernel@dilger.ca>,
 Joel Fernandes <joel@joelfernandes.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-acpi@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
 Corentin Labbe <clabbe@baylibre.com>, Jakub Kicinski <kuba@kernel.org>,
 linux-ext4@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
 Mike Leach <mike.leach@linaro.org>, Jean Delvare <jdelvare@suse.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, coresight@lists.linaro.org,
 Steven Rostedt <rostedt@goodmis.org>, rcu@vger.kernel.org,
 mjpeg-users@lists.sourceforge.net,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
 Theodore Ts'o <tytso@mit.edu>, Mathieu Poirier <mathieu.poirier@linaro.org>,
 intel-wired-lan@lists.osuosl.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, Leo Yan <leo.yan@linaro.org>,
 linux-media@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
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

Em Mon, 17 May 2021 11:48:04 +0100
David Woodhouse <dwmw2@infradead.org> escreveu:

> On Sun, 2021-05-16 at 12:18 +0200, Mauro Carvalho Chehab wrote:
> > The conversion tools used during DocBook/LaTeX/html/Markdown->ReST=20
> > conversion and some cut-and-pasted text contain some characters that
> > aren't easily reachable on standard keyboards and/or could cause=20
> > troubles when parsed by the documentation build system. =20
>=20
> Better.
>=20
> But you still don't say *why* it matters whether given characters are
> trivial to reach with standard keyboard layouts, or specify *what*
> 'troubles' the offending characters cause.

See the patches in the series. The reason for each particular case
is there on each patch, like on this one:

	[PATCH v3 13/16] docs: sound: kernel-api: writing-an-alsa-driver.rst: repl=
ace some characters

	The conversion tools used during DocBook/LaTeX/html/Markdown->ReST
	conversion and some cut-and-pasted text contain some characters that
	aren't easily reachable on standard keyboards and/or could cause
	troubles when parsed by the documentation build system.
	=20
	Replace the occurences of the following characters:
=09
		- U+00a0 ('=C2=A0'): NO-BREAK SPACE
		  as it can cause lines being truncated on PDF output

	Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>


Thanks,
Mauro
