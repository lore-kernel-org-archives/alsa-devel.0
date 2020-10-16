Return-Path: <SRS0=z+9C=DX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2BFBC433DF
	for <alsa-devel@archiver.kernel.org>; Fri, 16 Oct 2020 13:33:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D40BB20848
	for <alsa-devel@archiver.kernel.org>; Fri, 16 Oct 2020 13:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Gj7hoJ8L";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uI2me769"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D40BB20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9EEBC172E;
	Fri, 16 Oct 2020 15:32:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9EEBC172E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1602855177;
	bh=jHgolZn+yVwazInZpUXsUIXLz+WFq+LCgt1cjWpEkcA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Gj7hoJ8LjzRYxow+ntGsR2ihaZILAns1JXX3pEyKxVh+pNAnk83MCkEKXJgA7PXSg
	 Vt3DkkylzJ8b2PGcv3R3TQ0e5r8KBAiC3eu6hlwXmtaabYVO2gIoErRrvpyyZWRE7C
	 +ovDqlsZc+SV6ZPfqvEHo4oT1YWSWbEMP6wH0GA0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 37199F800B8;
	Fri, 16 Oct 2020 15:32:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B9590F80115; Fri, 16 Oct 2020 15:32:05 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D31E4F80115
 for <alsa-devel@alsa-project.org>; Fri, 16 Oct 2020 15:32:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D31E4F80115
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="uI2me769"
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com
 [209.85.167.170])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E11AC2158C
 for <alsa-devel@alsa-project.org>; Fri, 16 Oct 2020 13:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1602855120;
 bh=jHgolZn+yVwazInZpUXsUIXLz+WFq+LCgt1cjWpEkcA=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=uI2me769AwM75eyyDkh95DsmJO9h6Qvu8z0Ayc7beFMa6u/y6sPTX58dfz9663RqB
 2zP0XAvHzdeE75ZAtl270HHG5NqWq89oDsrxpoLa+652g3AM6k+qlqenzQba0AHyAX
 Fk5C7pqNZ14YtAy/k6zL/cWuHXg3qD5gkOKP2phA=
Received: by mail-oi1-f170.google.com with SMTP id s81so2394090oie.13
 for <alsa-devel@alsa-project.org>; Fri, 16 Oct 2020 06:31:59 -0700 (PDT)
X-Gm-Message-State: AOAM530BT7VpjJmVhZ0P2Kzlke3tyQ64xQyS9ChijlsBKHM+5k7z+Tv1
 6jsMbOOuYHzeu5OMZ8XatHN0bhw3LAq+PNmMQw==
X-Google-Smtp-Source: ABdhPJxDzoh5TQYux51VfrCvIKr2H0fC6EMtKmXq9osyCrsQpVXMppGQGpG8GNPS7dXZ2wVY+84RyeI4fqmJDgomP0U=
X-Received: by 2002:a54:4f89:: with SMTP id g9mr2514377oiy.106.1602855119044; 
 Fri, 16 Oct 2020 06:31:59 -0700 (PDT)
MIME-Version: 1.0
References: <20201014145418.31838-1-rf@opensource.cirrus.com>
 <20201014145418.31838-2-rf@opensource.cirrus.com>
 <CAL_Jsq+qdcHc9H7qUVwLieHrLM8E20HZXa8DkarMiuXfCh8WOQ@mail.gmail.com>
 <90600a67-25e4-7933-35c3-f515deaee94f@arm.com>
In-Reply-To: <90600a67-25e4-7933-35c3-f515deaee94f@arm.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Fri, 16 Oct 2020 08:31:47 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKAvJ9fv9pm82iv5YjWVCJu1fmP-t+Fyc95pzUaCEL3XQ@mail.gmail.com>
Message-ID: <CAL_JsqKAvJ9fv9pm82iv5YjWVCJu1fmP-t+Fyc95pzUaCEL3XQ@mail.gmail.com>
Subject: Re: [PATCH 1/7] of: base: Add of_count_phandle_with_fixed_args()
To: Robin Murphy <robin.murphy@arm.com>,
 Richard Fitzgerald <rf@opensource.cirrus.com>
Content-Type: text/plain; charset="UTF-8"
Cc: devicetree@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>,
 - <patches@opensource.cirrus.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Mark Brown <broonie@kernel.org>,
 Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>
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

On Thu, Oct 15, 2020 at 11:52 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2020-10-14 19:39, Rob Herring wrote:
> > On Wed, Oct 14, 2020 at 9:54 AM Richard Fitzgerald
> > <rf@opensource.cirrus.com> wrote:
> >>
> >> Add an equivalent of of_count_phandle_with_args() for fixed argument
> >> sets, to pair with of_parse_phandle_with_fixed_args().
> >>
> >> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> >> ---
> >>   drivers/of/base.c  | 42 ++++++++++++++++++++++++++++++++++++++++++
> >>   include/linux/of.h |  9 +++++++++
> >>   2 files changed, 51 insertions(+)
> >>
> >> diff --git a/drivers/of/base.c b/drivers/of/base.c
> >> index ea44fea99813..45d8b0e65345 100644
> >> --- a/drivers/of/base.c
> >> +++ b/drivers/of/base.c
> >> @@ -1772,6 +1772,48 @@ int of_count_phandle_with_args(const struct device_node *np, const char *list_na
> >>   }
> >>   EXPORT_SYMBOL(of_count_phandle_with_args);
> >>
> >> +/**
> >> + * of_count_phandle_with_fixed_args() - Find the number of phandles references in a property
> >> + * @np:                pointer to a device tree node containing a list
> >> + * @list_name: property name that contains a list
> >> + * @cell_count: number of argument cells following the phandle
> >> + *
> >> + * Returns the number of phandle + argument tuples within a property. It
> >> + * is a typical pattern to encode a list of phandle and variable
> >> + * arguments into a single property.
> >> + */
> >> +int of_count_phandle_with_fixed_args(const struct device_node *np,
> >> +                                    const char *list_name,
> >> +                                    int cells_count)
> >> +{
> >
> > Looks to me like you can refactor of_count_phandle_with_args to handle
> > both case and then make this and of_count_phandle_with_args simple
> > wrapper functions.
>
> Although for just counting the number of phandles each with n arguments
> that a property contains, isn't that simply a case of dividing the
> property length by n + 1? The phandles themselves will be validated by
> any subsequent of_parse_phandle*() call anyway, so there doesn't seem
> much point in doing more work then necessary here.
>
> >> +       struct of_phandle_iterator it;
> >> +       int rc, cur_index = 0;
> >> +
> >> +       if (!cells_count) {
> >> +               const __be32 *list;
> >> +               int size;
> >> +
> >> +               list = of_get_property(np, list_name, &size);
> >> +               if (!list)
> >> +                       return -ENOENT;
> >> +
> >> +               return size / sizeof(*list);
>
> Case in point - if it's OK to do exactly that for n == 0, then clearly
> we're *aren't* fussed about validating anything, so the n > 0 code below
> is nothing more than a massively expensive way to check for a nonzero
> remainder :/

Indeed. We should just generalize this. It can still be refactored to
shared code.

It's probably worthwhile to check for a remainder here IMO.

Rob
