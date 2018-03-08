From: <Mario.Limonciello@dell.com>
Subject: RE: [PATCH 1/2] dell-led: Change dell-led.h to dell-common.h
Date: Thu, 8 Mar 2018 07:31:54 +0000
Message-ID: <50d4e281b7644399bc85aa16a1eacb8f@ausx13mpc124.AMER.DELL.COM>
References: <20180308071207.19850-1-kai.heng.feng@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180308071207.19850-1-kai.heng.feng@canonical.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: kai.heng.feng@canonical.com, mjg59@srcf.ucam.org, pali.rohar@gmail.com, dvhart@infradead.org, andy@infradead.org, tiwai@suse.com
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Kai-Heng Feng [mailto:kai.heng.feng@canonical.com]
> Sent: Thursday, March 8, 2018 3:12 PM
> To: mjg59@srcf.ucam.org; pali.rohar@gmail.com; dvhart@infradead.org;
> andy@infradead.org; Limonciello, Mario <Mario_Limonciello@Dell.com>;
> tiwai@suse.com
> Cc: platform-driver-x86@vger.kernel.org; linux-kernel@vger.kernel.org; al=
sa-
> devel@alsa-project.org; Kai-Heng Feng <kai.heng.feng@canonical.com>
> Subject: [PATCH 1/2] dell-led: Change dell-led.h to dell-common.h
>=20
> This header will be used for more than just led. Change it to a more
> generic name.
>=20
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Reviewed-by: Mario Limonciello <mario.limonciello@dell.com>

> ---
>  drivers/platform/x86/dell-laptop.c          | 2 +-
>  include/linux/{dell-led.h =3D> dell-common.h} | 4 ++--
>  sound/pci/hda/dell_wmi_helper.c             | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
>  rename include/linux/{dell-led.h =3D> dell-common.h} (61%)
>=20
> diff --git a/drivers/platform/x86/dell-laptop.c b/drivers/platform/x86/de=
ll-laptop.c
> index c52c6723374b..8ba820e6c3d0 100644
> --- a/drivers/platform/x86/dell-laptop.c
> +++ b/drivers/platform/x86/dell-laptop.c
> @@ -29,7 +29,7 @@
>  #include <linux/mm.h>
>  #include <linux/i8042.h>
>  #include <linux/debugfs.h>
> -#include <linux/dell-led.h>
> +#include <linux/dell-common.h>
>  #include <linux/seq_file.h>
>  #include <acpi/video.h>
>  #include "dell-rbtn.h"
> diff --git a/include/linux/dell-led.h b/include/linux/dell-common.h
> similarity index 61%
> rename from include/linux/dell-led.h
> rename to include/linux/dell-common.h
> index 92521471517f..37e4b614dd74 100644
> --- a/include/linux/dell-led.h
> +++ b/include/linux/dell-common.h
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef __DELL_LED_H__
> -#define __DELL_LED_H__
> +#ifndef __DELL_COMMON_H__
> +#define __DELL_COMMON_H__
>=20
>  int dell_micmute_led_set(int on);
>=20
> diff --git a/sound/pci/hda/dell_wmi_helper.c b/sound/pci/hda/dell_wmi_hel=
per.c
> index 1b48a8c19d28..56050cc3c0ee 100644
> --- a/sound/pci/hda/dell_wmi_helper.c
> +++ b/sound/pci/hda/dell_wmi_helper.c
> @@ -4,7 +4,7 @@
>   */
>=20
>  #if IS_ENABLED(CONFIG_DELL_LAPTOP)
> -#include <linux/dell-led.h>
> +#include <linux/dell-common.h>
>=20
>  enum {
>  	MICMUTE_LED_ON,
> --
> 2.15.1
