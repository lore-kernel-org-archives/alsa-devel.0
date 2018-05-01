From: Hans de Goede <hdegoede@redhat.com>
Subject: Rationale for BYTCR defaults in the kernel's
 bytcr_rt5640 machine driver ?
Date: Tue, 1 May 2018 21:21:25 +0200
Message-ID: <0b04e03f-7147-fb27-22c3-e81a8cbf3a8f@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f54.google.com (mail-wm0-f54.google.com [74.125.82.54])
 by alsa0.perex.cz (Postfix) with ESMTP id AE353266C1C
 for <alsa-devel@alsa-project.org>; Tue,  1 May 2018 21:21:27 +0200 (CEST)
Received: by mail-wm0-f54.google.com with SMTP id t11so19164528wmt.0
 for <alsa-devel@alsa-project.org>; Tue, 01 May 2018 12:21:27 -0700 (PDT)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Pierre-Louis,

I'm finally wrapping up my rt5640 jack-detect work, as
such I'm currently testing speaker + headphones + internal mic +
headset-mic + jack-detect functionality on the 10 different
x86 devices with a rt5640 codec which I've gathered.

2 of them stand out in that they use the BYTCR SoC, but don't
have the ACPI table for detecting if SSP0 AIF1 or AIF2
should be used. Currently the driver defaults to AIF2
in this case.

As the somewhat wildcard-ish DMI quirk for boards where
the sys_vendor is "Insyde" (which applies to a lot of
generic designs) shows:

         {
                 .callback = byt_rt5640_quirk_cb,
                 .matches = {
                         DMI_MATCH(DMI_SYS_VENDOR, "Insyde"),
                 },
                 .driver_data = (void *)(BYT_RT5640_IN3_MAP |
                                         BYT_RT5640_MCLK_EN |
                                         BYT_RT5640_SSP0_AIF1),

         },

AIF1 seems to be a better default both models without
the ACPI table which I've here, a HP pavilion X2 and a
Toshiba Click Mini L9W-B need a quirk to use AIF1.

So I was wondering if there was a specific rationale for the
AIF2 default and if it would not be better to change the default
to AIF1 (which will unfortunately bring a chance of regressions) ?

Regards,

Hans
