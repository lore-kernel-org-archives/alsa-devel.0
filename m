Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4E1EC433EF
	for <alsa-devel@archiver.kernel.org>; Fri, 21 Jan 2022 17:16:07 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C522B2B03;
	Fri, 21 Jan 2022 18:15:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C522B2B03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1642785365;
	bh=l2wDf8lo76oTZDGdh0ocVAU+U5VFdtl5uPFh1akfRaY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vUj9MoEy/oGyaWbqeA1oRIE4gHfSOtagmssBpWhmdbKrOjMEmaWJO4YhVRtQOdBe3
	 aw9MKXwK6es4I/JMr61G76dLaXK3wG1GQydUbY3p6RXjXIUYw+DydcMF+p8St6mu4+
	 XgWHxXI34yHRu5WYcqlvfJ2/PB9TSyltAJCRYksI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 45095F800F8;
	Fri, 21 Jan 2022 18:15:15 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8D69CF8028B; Fri, 21 Jan 2022 18:15:13 +0100 (CET)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com
 [209.85.160.177])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 98D1BF800F8
 for <alsa-devel@alsa-project.org>; Fri, 21 Jan 2022 18:15:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 98D1BF800F8
Received: by mail-qt1-f177.google.com with SMTP id bp39so10613999qtb.6
 for <alsa-devel@alsa-project.org>; Fri, 21 Jan 2022 09:15:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=lmFYJSCcLqyJ3gmEXT1GTQFiLSiARI98tj+Ubi9SZeQ=;
 b=Ub4fvOdu5fnk363AeX3gvU9Gaw9EnJd6DGNQeljGIlBfklnyIbDdsikz91r4mMyIrl
 fHyNPfskvY9DyyE2OYoqWeLXLsUuEYQDbIhLUB3u24xWenkILdCO1LtXtawUeU64wmwU
 ArQM17j0T7CL9bHvL3uWEZXJsYillP4q6Za9HWLaOfRXeCQkaXDCRfXn5RXW9MN+mjFj
 NMO8EHcNiUV/LgOnJFn0xlgxw7E/ZhrX/Ju3keELk5I/zLiVjNZlrCR5j2IY246MCGZC
 gKEXY3Ff0bPOEY5qXwQi22IHYhH9QKlz1qRgG769T3ufu5ewSi7cI867tu9aCE8PxLYM
 QkUw==
X-Gm-Message-State: AOAM531OXyafCSAjAY2qEm5Cxxd4M9f927zV57Exo2U2Zli6T/9IhrmQ
 LDbfGjUjlBjMU+x5zFXEZvizt52kYvbQ8d3HFSw=
X-Google-Smtp-Source: ABdhPJwNokEUfO47u31kWlKtBBs/kxjVwO00ZzdECaIzLyfyZVKBSBi0s0IUukpHMiPYzaal1yKdbyNYkPUNVKxnCs4=
X-Received: by 2002:a05:622a:118b:: with SMTP id
 m11mr4044592qtk.369.1642785305913; 
 Fri, 21 Jan 2022 09:15:05 -0800 (PST)
MIME-Version: 1.0
References: <20220121143254.6432-1-sbinding@opensource.cirrus.com>
 <20220121143254.6432-8-sbinding@opensource.cirrus.com>
 <CAJZ5v0gK=-SXUDekg_2DtOuMsn6Ls4gS+nymei2Qa9ZEFvqGcA@mail.gmail.com>
 <019901d80ee7$a6bf2a90$f43d7fb0$@opensource.cirrus.com>
In-Reply-To: <019901d80ee7$a6bf2a90$f43d7fb0$@opensource.cirrus.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 21 Jan 2022 18:14:55 +0100
Message-ID: <CAJZ5v0j+DkX+-P1XxZ=HAnUzPjdkNFkXRTjJzhSH27KfDFAGDQ@mail.gmail.com>
Subject: Re: [PATCH v5 7/9] platform/x86: serial-multi-instantiate: Add SPI
 support
To: Stefan Binding <sbinding@opensource.cirrus.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Cc: Platform Driver <platform-driver-x86@vger.kernel.org>,
 "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
 <alsa-devel@alsa-project.org>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Takashi Iwai <tiwai@suse.com>, Mark Gross <markgross@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>, Mark Brown <broonie@kernel.org>,
 patches@opensource.cirrus.com, linux-spi <linux-spi@vger.kernel.org>,
 Len Brown <lenb@kernel.org>
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

On Fri, Jan 21, 2022 at 5:55 PM Stefan Binding
<sbinding@opensource.cirrus.com> wrote:
>
> Hi,
>
> > -----Original Message-----
> > From: Rafael J. Wysocki <rafael@kernel.org>
> > Sent: 21 January 2022 15:31
> > To: Stefan Binding <sbinding@opensource.cirrus.com>
> > Cc: Mark Brown <broonie@kernel.org>; Rafael J . Wysocki
> > <rafael@kernel.org>; Len Brown <lenb@kernel.org>; Hans de Goede
> > <hdegoede@redhat.com>; Mark Gross <markgross@kernel.org>; Jaroslav
> > Kysela <perex@perex.cz>; Takashi Iwai <tiwai@suse.com>; moderated
> > list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM... <alsa-
> > devel@alsa-project.org>; Linux Kernel Mailing List <linux-
> > kernel@vger.kernel.org>; linux-spi <linux-spi@vger.kernel.org>; ACPI De=
vel
> > Maling List <linux-acpi@vger.kernel.org>; Platform Driver <platform-dri=
ver-
> > x86@vger.kernel.org>; patches@opensource.cirrus.com
> > Subject: Re: [PATCH v5 7/9] platform/x86: serial-multi-instantiate: Add=
 SPI
> > support
> >
>
>
> > > diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kcon=
fig
> > > index 5b65d687f046..28f5bbf0f27a 100644
> > > --- a/drivers/platform/x86/Kconfig
> > > +++ b/drivers/platform/x86/Kconfig
> > > @@ -991,12 +991,12 @@ config TOPSTAR_LAPTOP
> > >           If you have a Topstar laptop, say Y or M here.
> > >
> > >  config SERIAL_MULTI_INSTANTIATE
> > > -       tristate "I2C multi instantiate pseudo device driver"
> > > -       depends on I2C && ACPI
> > > +       tristate "I2C and SPI multi instantiate pseudo device driver"
> > > +       depends on I2C && SPI && ACPI
> >
> > Should this be (I2C || SPI) && ACPI ?
>
> We made it dependent on both I2C and SPI because of how interconnected th=
e
> serial-multi-instantiate driver is with both SPI and I2C. We felt attempt=
ing to make
> the driver compatible with one without the other would end up very compli=
cated.

That's fine IMV, but it would be good to mention it in the changelog.

> > > @@ -146,7 +247,21 @@ static int smi_probe(struct platform_device *pde=
v)
> > >
> > >         platform_set_drvdata(pdev, smi);
> > >
> > > -       return smi_i2c_probe(pdev, adev, smi, inst_array);
> > > +       switch (node->bus_type) {
> > > +       case SMI_I2C:
> > > +               return smi_i2c_probe(pdev, adev, smi, node->instances=
);
> > > +       case SMI_SPI:
> > > +               return smi_spi_probe(pdev, adev, smi, node->instances=
);
> > > +       case SMI_AUTO_DETECT:
> > > +               if (i2c_acpi_client_count(adev) > 0)
> > > +                       return smi_i2c_probe(pdev, adev, smi, node->i=
nstances);
> > > +               else
> > > +                       return smi_spi_probe(pdev, adev, smi, node->i=
nstances);
> > > +       default:
> > > +               break;
> >
> > Why is this needed?
>
> This return code is attempting to ensure that we don=E2=80=99t try to gue=
ss whether we
> expect devices to be I2C or SPI - especially with regards to existing dev=
ices.
> We wanted to maintain compatibility with existing devices, which would al=
l be
> I2C.
> For the device for which we are adding, the same HID is used by both the =
same
> chip for both I2C and SPI, so we also needed a way to support both.

I meant why was the "default" case needed.  Sorry for the confusion.
