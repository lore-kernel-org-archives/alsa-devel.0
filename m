From: Daniel Drake <drake@endlessm.com>
Subject: snd_soc_set_dmi_name - Shouldn't it use SYS_VENDOR?
Date: Thu, 27 Apr 2017 12:00:45 -0600
Message-ID: <CAD8Lp454-BRKu7GZxpbO+4qgFfSTF0DviUcaUDtgNOVrzb2jLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f174.google.com (mail-io0-f174.google.com
 [209.85.223.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 3BD81266909
 for <alsa-devel@alsa-project.org>; Thu, 27 Apr 2017 20:00:48 +0200 (CEST)
Received: by mail-io0-f174.google.com with SMTP id k87so30294839ioi.0
 for <alsa-devel@alsa-project.org>; Thu, 27 Apr 2017 11:00:48 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: liam.r.girdwood@linux.intel.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Hi,

Nice to see DMI info being attached to SoC sound devices so that we
can differentiate between differerent products in userspace, thanks
for the effort there.

However I just noticed that it using DMI_BOARD_VENDOR. Is this intentional?

I have several examples of products here where DMI_BOARD_VENDOR is not
set to a meaningful value, but DMI_SYS_VENDOR is just fine. DMI quirks
in the kernel ordinarily tend to match products by combining
DMI_SYS_VENDOR with DMI_PRODUCT_NAME.

In the SMBIOS data format, Type 1 (System information) includes
DMI_SYS_VENDOR and DMI_PRODUCT_NAME. Type 2 (Base board information)
includes DMI_BOARD_VENDOR and DMI_BOARD_NAME. See dmi_decode() in
drivers/firmware/dmi_scan.c

It seems strange that ASoC is pulling the product name from Type 1 but
the vendor from type 2. Can we make it instead just use Type 1 data,
DMI_SYS_VENDOR and DMI_PRODUCT_NAME?

Thanks
Daniel
