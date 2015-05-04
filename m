From: Inha Song <ideal.song-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [alsa-devel] [PATCH v5 0/2] Add support for select accessory detect
 mode to HPDETL or HPDETR
Date: Mon, 04 May 2015 13:42:12 +0900
Message-ID: <1430714534-28772-1-git-send-email-ideal.song@samsung.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, rf-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, Inha Song <ideal.song-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

This set of patches adds support for select accessory detect mode to HPDETL or HPDETR.

Changes in v5:
  - Rebased on extcon-next branch.

Changes in v4:
  - Set the hpdet_channel default value to HPDETL in variable declaration.
  - Fix the indentation in binding documentation.

Changes in v3:
  - Set the hpdet_channel default value to HPDETL If the value is unknown or invalid.

Changes in v2:
  - Use the value in pdata instead of hpdet_channel in extcon_info.
  - Wrap arizona_extcon_of_get in IS_ENABLED(CONFIG_OF).
  - Change hpdet_channel type to unsigned from signed in pdata.
  - Move ARIZONA_ACCDET_MODE_* define to dt-binding header and directly set it to pdata.


Inha Song (2):
  extcon: arizona: Add support for select accessory detect mode when
    headphone detection
  mfd: arizona: Update DT binding to support hpdet channel

 Documentation/devicetree/bindings/mfd/arizona.txt |  6 ++++
 drivers/extcon/extcon-arizona.c                   | 38 ++++++++++++++++++-----
 include/dt-bindings/mfd/arizona.h                 |  4 +++
 include/linux/mfd/arizona/pdata.h                 |  3 ++
 4 files changed, 43 insertions(+), 8 deletions(-)

-- 
2.0.0.390.gcb682f8

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
