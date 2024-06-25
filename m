Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 378A2C2BD09
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Jul 2024 12:31:47 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AE9182BCC;
	Mon,  1 Jul 2024 14:31:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AE9182BCC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1719837105;
	bh=hyygwZzV0TA9MeTrczY+xfhnsSFmoluW/aMTxSPPF7g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=p4WuN+OEWkTzLvLdVw1yr/pTFAkvQfzlfcJ/o3aj4xdIvJvzS5rRPOoYLS0Gbalhy
	 s/tx7h8rEAGZ76wGxXyaLJlknoOjfjnZJCmFg2P1iwP+v6cWlSbffZo1LOjRu+GUc/
	 xk6dJkNCHNc6o5+dlJry0jERcBsdbQVP6lA0H8rE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CCCD2F8992D; Mon,  1 Jul 2024 14:22:28 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2054CF89939;
	Mon,  1 Jul 2024 14:22:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A4D0DF80423; Tue, 25 Jun 2024 23:12:32 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E2871F800ED
	for <alsa-devel@alsa-project.org>; Tue, 25 Jun 2024 23:12:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E2871F800ED
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=ArcIuk0u
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 4626CCE1F2C;
	Tue, 25 Jun 2024 21:12:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54F61C32781;
	Tue, 25 Jun 2024 21:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719349937;
	bh=hyygwZzV0TA9MeTrczY+xfhnsSFmoluW/aMTxSPPF7g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ArcIuk0uRfsESHfkGfkKUOWRPGGQRoYshDAKXgfL7RAidYC2yoPUOF4EOIWRth/zx
	 ykHnbRshuPVKR4UsTmEqJpfbjR7Lxb1MgohaxTO7sN4G186OXUULYfjTSoMk/JACVy
	 rDH4YFTTQFVhxEeWdIOOD5ronHyHYn5GlVnw+3JtZFiKhbLmGLU7w1aHq4GtR8VqXx
	 zOrwlDLRr/Fxt5QON7ooh6qk8zgpeQFn4BGJ4f8p9B/da2ub1m3VU/0NxxHk78cBsC
	 Ylf78UIPjF87TiTkhrpWjEAnrqweWrfQoiMdjHdFmTSchTgaZPSVi6dGjUTTadSf7V
	 tnFI4Gu0p7ohg==
Date: Tue, 25 Jun 2024 23:12:12 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	"J.M.B. Downing" <jonathan.downing@nautel.com>,
 Vladimir Zapolskiy <vz@mleia.com>,
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
 Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Arnd Bergmann <arnd@arndb.de>,
	Yangtao Li <frank.li@vivo.com>, Li Zetao <lizetao1@huawei.com>,
	Chancel Liu <chancel.liu@nxp.com>, Michael Ellerman <mpe@ellerman.id.au>,
 dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
 linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-i2c@vger.kernel.org,
	linux-mtd@lists.infradead.org, Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [Patch v4 10/10] i2x: pnx: Use threaded irq to fix warning from
 del_timer_sync()
Message-ID: <73yvglxha45d5ft74m3y5fdmkgatm2yftvhza2msg4ombjz42f@wz43pubhbpdz>
References: <20240620175657.358273-1-piotr.wojtaszczyk@timesys.com>
 <20240620175657.358273-11-piotr.wojtaszczyk@timesys.com>
 <jgqhlnysuwajlfxjwetas53jzdk6nnmewead2xzyt3xngwpcvl@xbooed6cwlq4>
 <CAG+cZ04suU53wR5f0PhudgNmkxTRtwEXTS1cWH1o9_rTNM94Cg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: 
 <CAG+cZ04suU53wR5f0PhudgNmkxTRtwEXTS1cWH1o9_rTNM94Cg@mail.gmail.com>
X-MailFrom: andi.shyti@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: FMGT5RDJTSUCURA6USZDZR7N4Y3QKMID
X-Message-ID-Hash: FMGT5RDJTSUCURA6USZDZR7N4Y3QKMID
X-Mailman-Approved-At: Mon, 01 Jul 2024 12:22:21 +0000
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/FMGT5RDJTSUCURA6USZDZR7N4Y3QKMID/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi Piotr,

On Fri, Jun 21, 2024 at 02:08:03PM GMT, Piotr Wojtaszczyk wrote:
> On Fri, Jun 21, 2024 at 12:57 AM Andi Shyti <andi.shyti@kernel.org> wrote:
> > On Thu, Jun 20, 2024 at 07:56:41PM GMT, Piotr Wojtaszczyk wrote:
> > > When del_timer_sync() is called in an interrupt context it throws a warning
> > > because of potential deadlock. Threaded irq handler fixes the potential
> > > problem.
> > >
> > > Signed-off-by: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
> >
> > did you run into a lockdep splat?
> >
> > Anything against using del_timer(), instead? Have you tried?
> 
> I didn't get a lockdep splat but console was flooded with warnings from
> https://github.com/torvalds/linux/blob/v6.10-rc4/kernel/time/timer.c#L1655
> In the linux kernel v5.15 I didn't see these warnings.
> 
> I'm not a maintainer of the driver and I didn't do any research on
> what kind of impact
> would have using del_timer() instad. Maybe Vladimir Zapolskiy will know that.

Your patch is definitely correct, no doubt about that.

And I don't have anything aginast changing irq handlers to
threaded handlers. But I would be careful at doing that depending
on the use of the controller and for accepting such change I
would need an ack from someone who knows the device. Vladimir,
perhaps?

There are cases where using threaded handlers are not totally
right, for example when the controller is used at early boot for
power management handling. I don't think it's the case for this
driver, but I can't be 100% sure.

If you were able to see the flood of WARN_ON's, would be
interesting to know how it behaves with del_timer(). Mind
giving it a test?

Thanks,
Andi
