From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: snd_soc_set_dmi_name - Shouldn't it use SYS_VENDOR?
Date: Thu, 27 Apr 2017 14:28:28 -0500
Message-ID: <5aa36e3b-49f9-d7f6-df58-18dcfcda08e5@linux.intel.com>
References: <CAD8Lp454-BRKu7GZxpbO+4qgFfSTF0DviUcaUDtgNOVrzb2jLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 912EA266C0A
 for <alsa-devel@alsa-project.org>; Thu, 27 Apr 2017 21:28:31 +0200 (CEST)
In-Reply-To: <CAD8Lp454-BRKu7GZxpbO+4qgFfSTF0DviUcaUDtgNOVrzb2jLw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Drake <drake@endlessm.com>, alsa-devel@alsa-project.org
Cc: liam.r.girdwood@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On 4/27/17 1:00 PM, Daniel Drake wrote:
> Hi,
>
> Nice to see DMI info being attached to SoC sound devices so that we
> can differentiate between differerent products in userspace, thanks
> for the effort there.
>
> However I just noticed that it using DMI_BOARD_VENDOR. Is this intentional?
>
> I have several examples of products here where DMI_BOARD_VENDOR is not
> set to a meaningful value, but DMI_SYS_VENDOR is just fine. DMI quirks
> in the kernel ordinarily tend to match products by combining
> DMI_SYS_VENDOR with DMI_PRODUCT_NAME.
>
> In the SMBIOS data format, Type 1 (System information) includes
> DMI_SYS_VENDOR and DMI_PRODUCT_NAME. Type 2 (Base board information)
> includes DMI_BOARD_VENDOR and DMI_BOARD_NAME. See dmi_decode() in
> drivers/firmware/dmi_scan.c
>
> It seems strange that ASoC is pulling the product name from Type 1 but
> the vendor from type 2. Can we make it instead just use Type 1 data,
> DMI_SYS_VENDOR and DMI_PRODUCT_NAME?

There is a bit of variability here, the quirks we use are based on:

DMI_BOARD_VENDOR
DMI_SYS_VENDOR
DMI_PRODUCT_NAME
DMI_PRODUCT_VERSION (typically for Lenovo programs)
DMI_BOARD_NAME (for reference designs)

Not sure if we can really limit the conventions to type1 or type2 if we 
want the names to be somewhat meaningful.

I can't recall why we selected DMI_BOARD_VENDOR instead of 
DMI_SYS_VENDOR though.

>
> Thanks
> Daniel
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
