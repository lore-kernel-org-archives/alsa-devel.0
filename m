Return-Path: <SRS0=zi5T=E7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A35C2D0E4
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Nov 2020 00:15:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0A4B206E5
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Nov 2020 00:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="iQ77F7E5";
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLU5QbBu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0A4B206E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3DB281739;
	Wed, 25 Nov 2020 01:14:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3DB281739
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1606263340;
	bh=yiZ84YEeFL0wWYezky6vF3yhpPWjHZ52uDhLhbMfJQM=;
	h=In-Reply-To:References:Subject:From:To:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iQ77F7E5BJ00q0TgPtEjgQhnZ24akZDhGO0sTC5SDyWE38d0qe52Fh92tOl1R5aMV
	 yXQe+QXA/UQ48qFCsp1ynfSN7qpLqu7jiTOU7Pbh9Jk6DHYfQ6C+NTip+JQDVfRpDS
	 LR+j4atx15weXq8AEMjH6Q+lZ5fGwiFsoP8y3CRM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C1B28F80161;
	Wed, 25 Nov 2020 01:14:49 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7B5A8F80165; Wed, 25 Nov 2020 01:14:48 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 35347F8015A
 for <alsa-devel@alsa-project.org>; Wed, 25 Nov 2020 01:14:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 35347F8015A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="eLU5QbBu"
Received: from kernel.org (unknown [104.132.1.79])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DBB86206E5;
 Wed, 25 Nov 2020 00:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1606263283;
 bh=yiZ84YEeFL0wWYezky6vF3yhpPWjHZ52uDhLhbMfJQM=;
 h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
 b=eLU5QbBunDunzGLbn35O61lp48dnCiQcXoMj6ntVLrpCl3D2hSb7EzYMD9E7xCufo
 faLinbGoGYFCtqY3HR9mXHNu5faGJskKKN4nMkiF9Z0YrPcdbgRghR/v20re2SmSD7
 rf5xyq57yHsYQeoFrG1CdVXncecGIlRjpGaTHnF4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201115170950.304460-4-krzk@kernel.org>
References: <20201115170950.304460-1-krzk@kernel.org>
 <20201115170950.304460-4-krzk@kernel.org>
Subject: Re: [RFC 3/3] media: atomisp: do not select COMMON_CLK to fix builds
From: Stephen Boyd <sboyd@kernel.org>
To: Chen-Yu Tsai <wens@csie.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jaroslav Kysela <perex@perex.cz>, Jernej Skrabec <jernej.skrabec@siol.net>,
 Krzysztof Kozlowski <krzk@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 Maxime Ripard <mripard@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, Takashi Iwai <tiwai@suse.com>,
 alsa-devel@alsa-project.org, devel@driverdev.osuosl.org,
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Date: Tue, 24 Nov 2020 16:14:41 -0800
Message-ID: <160626328163.2717324.18098835445527872342@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Cc: Krzysztof Kozlowski <krzk@kernel.org>
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

Quoting Krzysztof Kozlowski (2020-11-15 09:09:50)
> COMMON_CLK is a user-selectable option with its own dependencies.  The
> most important dependency is !HAVE_LEGACY_CLK.  User-selectable drivers
> should not select COMMON_CLK because they will create a dependency cycle
> and build failures.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

This is fallout from making the COMMON_CLK symbol selectable in commit
bbd7ffdbef68 ("clk: Allow the common clk framework to be selectable").
Before then we needed drivers to select the COMMON_CLK config so that
the framework was enabled. Now that isn't necessary and any
user-selectable options should be moved to depends syntax.

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
