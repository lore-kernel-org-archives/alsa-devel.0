Return-Path: <SRS0=ZrTp=W5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8A6C3A59B
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Sep 2019 09:19:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 288E1217D7
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Sep 2019 09:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Zd4JRvYM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o+EGbYmW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 288E1217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CA5C11697;
	Mon,  2 Sep 2019 11:18:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CA5C11697
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1567415974;
	bh=h41oEBRnX1yhDp3dzyclaX7hp/SDJC2270WK4pqwk20=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Zd4JRvYMj61R4u5x/u8hXZzTG3WK8z0hfR1OtDBAjsOfJ8nkuDsdg6RNt7mihDYUG
	 h6FVI2uZdoCgGxNPvCDp5tG1Pb7llp4vhA1wRbje1n2Fhq+63RdhGrDk88NG+LIiiJ
	 BwjX2SfnEZHThEkvl8AbNYOXtk2w0/LVlaDlByZs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 59F48F80394;
	Mon,  2 Sep 2019 11:18:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D07C7F803D0; Mon,  2 Sep 2019 11:18:42 +0200 (CEST)
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com
 [IPv6:2a00:1450:4864:20::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 84A73F8011E
 for <alsa-devel@alsa-project.org>; Mon,  2 Sep 2019 11:18:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 84A73F8011E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="o+EGbYmW"
Received: by mail-lj1-x241.google.com with SMTP id u14so5599453ljj.11
 for <alsa-devel@alsa-project.org>; Mon, 02 Sep 2019 02:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=i1rIwTW5lY/ZdGEW/DCIV3Xef5lpoy5aMvxo+N6YWuI=;
 b=o+EGbYmWbClNVOF5FrfiRarkq8u7O/SOv3Tqc8HkxefKvGTGFr5yGmFVZgVzF4KJHY
 CHWra0LbiNkLT9xHmuLijrXX39KORN3ID3deC6FQ8DBGcUlMsoylij+E3Jx5ovn6Qffq
 ESR4bM00UWCteTkh8wKjV9WwNnCcnb5zGfLlkWI74rNHuJTi08vQQDOz74v72j10ac5a
 HGo7STadP+l4EVP5N6AqjX9AzXHpTcHyX5GXakjEyolT3/DBI1YYXO4vwfFcBr4+7Wab
 3J9M8fAoicdMhwOFJmU/PvswQOr+a32eGmNT5JUTJKfG2h4jAdGqx/HmMuby9eUVAWuk
 3lpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=i1rIwTW5lY/ZdGEW/DCIV3Xef5lpoy5aMvxo+N6YWuI=;
 b=n2sOPaKKmANAYWfV/xEqnCuTK/eIXSqEjeZ/n7d7WXx71ZPoK8GXtVr+JBNiCb+KIo
 Dfy8GixTfnPSChGLbgAOOKXq5MrwGS0ijyL+cktDGfrtlg4FWb5Mhjrfs678Y3asUdFR
 F92YPoJ76jJGzeCPGQ/d9qJjCSdWCkFFqUW3awlHuxlLsvb/7frhQgf0hD0J4fkCBbmh
 U1JgMEtYPqqCtPD3RYdzg9EMEXbY4ZmK9YVZyWfrZiBY8vJuo+vO0kD4krwkr6BDy7O1
 I0E6VFCR66YtjEpWejWAEm1RCMLkTcMpmXL6nrpG3TOltggWwbXHskLcl62wxABoMVnJ
 H9yA==
X-Gm-Message-State: APjAAAVr5Mr7BFvufOfTJho+m9jqTF9ISuksSfOZLFWick6t4VrXXO0F
 BqVJUgrn1bK4dj8whkErKP8ILtiZAiIqboM8yMs=
X-Google-Smtp-Source: APXvYqw3IH/Qq0DvUycRxdd2c9I/PiYamSvqRnuCLhc7IwJvnx/RN2GPGtuCDma9RE3PFwTSCTchx21P+MgE9MXvuro=
X-Received: by 2002:a2e:1648:: with SMTP id 8mr1242618ljw.194.1567415919395;
 Mon, 02 Sep 2019 02:18:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190821162320.28653-1-codekipper@gmail.com>
 <20190830114457.GB5182@sirena.co.uk>
In-Reply-To: <20190830114457.GB5182@sirena.co.uk>
From: Code Kipper <codekipper@gmail.com>
Date: Mon, 2 Sep 2019 11:18:28 +0200
Message-ID: <CAEKpxB=BnQNraPmTtqj0KWi982OWe0bGQ-6F4N5owPH_OX67=A@mail.gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>,
 linux-sunxi <linux-sunxi@googlegroups.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Maxime Ripard <mripard@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 "Andrea Venturi \(pers\)" <be17068@iperbole.bo.it>,
 Chen-Yu Tsai <wens@csie.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: sun4i-i2s: incorrect regmap for A83t
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Fri, 30 Aug 2019 at 13:45, Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, Aug 21, 2019 at 06:23:20PM +0200, codekipper@gmail.com wrote:
> > From: Marcus Cooper <codekipper@gmail.com>
> >
> > Fixes: 21faaea1343f ("ASoC: sun4i-i2s: Add support for A83T")
> > Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> > ---
>
> This doesn't apply against current code, please check and resend.
This patch is no longer valid and the fix has been done through the reverts,
BR,
CK
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
