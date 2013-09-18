From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] ASoC: rt5640: ifdef for ACPI module table
Date: Wed, 18 Sep 2013 08:13:14 -0700
Message-ID: <CAOesGMj52_xcKS4q54i_gw_T2xWt=c6rwBtP9Ds2LbytjRuNKQ@mail.gmail.com>
References: <1379484624-11029-1-git-send-email-olof@lixom.net>
 <20130918094158.GL21013@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f179.google.com (mail-we0-f179.google.com
 [74.125.82.179])
 by alsa0.perex.cz (Postfix) with ESMTP id AAECA2610A6
 for <alsa-devel@alsa-project.org>; Wed, 18 Sep 2013 17:13:15 +0200 (CEST)
Received: by mail-we0-f179.google.com with SMTP id x55so6563888wes.38
 for <alsa-devel@alsa-project.org>; Wed, 18 Sep 2013 08:13:15 -0700 (PDT)
In-Reply-To: <20130918094158.GL21013@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: liam.r.girdwood@linux.intel.com, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 18, 2013 at 2:41 AM, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Sep 17, 2013 at 11:10:24PM -0700, Olof Johansson wrote:
>
> Please send things to the advertised maintainer addresses.

I sent it to the person signing off on the patch that this fixes up,
you should probably use your maintainer address for that.

>> Commit 02b80773de37 (ASoC: rt5640: Add ACPI probing support.) causes
>> a warning due to unreferenced variable on non-ACPI configs such as
>> tegra_defconfig on ARM:
>
>>   sound/soc/codecs/rt5640.c:2085:30: warning: 'rt5640_acpi_match' defined but not used [-Wunused-variable]
>
>> +#if CONFIG_ACPI
>>  static struct acpi_device_id rt5640_acpi_match[] = {
>>       { "INT33CA", 0 },
>>       { },
>>  };
>>  MODULE_DEVICE_TABLE(acpi, rt5640_acpi_match);
>> +#endif
>
> Shouldn't the fix for this be to do the same as we're doing for the OF
> tables and have an acpi_match_ptr()?  It seems like we're doing the same
> thing so we should be handling it in a similar fashion.

There's already ACPI_PTR(), which is exactly why this warning shows
up. of_match_ptr() and ACPI_PTR() will evaluate to NULL if
CONFIG_OF/ACPI aren't set, which is the case here -- which in turn is
why there's a warning that the match table is defined but never used.

So, the solution is either to not define the table, i.e. ifdef, or to
not use the ACPI_PTR() macro. It makes sense to not advertise the
driver as capable of probing on ACPI if ACPI is not enabled in the
kernel config, which in turn means ifdef.

Unless I'm missing something here, of course. :)


-Olof
