From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3 1/3] x86: add support for Huawei WMI hotkeys.
Date: Thu, 8 Nov 2018 21:58:44 +0200
Message-ID: <CAHp75Vev_0ObO=KLHfON8JAco=a9MURycH9uk-a+h1JqrSSQFA@mail.gmail.com>
References: <20181108171701.4444-1-ayman.bagabas@gmail.com> <20181108171701.4444-2-ayman.bagabas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181108171701.4444-2-ayman.bagabas@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ayman Bagabas <ayman.bagabas@gmail.com>
Cc: Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Kailang Yang <kailang@realtek.com>, Hui Wang <hui.wang@canonical.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 8, 2018 at 7:17 PM Ayman Bagabas <ayman.bagabas@gmail.com> wrote:
>
> This driver adds support for missing hotkeys on some Huawei laptops.
> Currently, only Huawei Matebook X and Matebook X Pro is supported.
>

Thanks for an update, my comments below.


> +config HUAWEI_LAPTOP
> +       tristate "Huawei WMI hotkeys driver"

> +       depends on ACPI

Do you need an ACPI dependency be explicit here?

> +       depends on ACPI_WMI
> +       depends on INPUT
> +       select INPUT_SPARSEKMAP
> +       help
> +         This driver provides support for Huawei WMI hotkeys.
> +         It enables the missing keys and adds support to the micmute
> +         LED found on some of these laptops.


> +/*
> + *  Huawei WMI hotkeys
> + *
> + *  Copyright (C) 2018       Ayman Bagabas <ayman.bagabas@gmail.com>

> + *
> + *  This program is free software: you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation, either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program.  If not, see <https://www.gnu.org/licenses/>.
> + *

Please, replace this boilerplate text with appropriate SPDX identifier.

> + */

> +#include <linux/init.h>
> +#include <linux/module.h>

One of them should be chosen.

> +static char *event_guid;
> +static struct input_dev *inputdev;

> +int huawei_wmi_micmute_led_set(bool on)
> +{
> +       acpi_handle handle = ACPI_HANDLE(&inputdev->dev);
> +       char *method;
> +       union acpi_object args[3];

> +       args[0].type = args[1].type = args[2].type = ACPI_TYPE_INTEGER;
> +       args[1].integer.value = 0x04;

Please, don't mix definitions and code.

> +       struct acpi_object_list arg_list = {
> +               .pointer = args,
> +               .count = ARRAY_SIZE(args),
> +       };
> +
> +       if (acpi_has_method(handle, method = "\\_SB.PCI0.LPCB.EC0.SPIN")) {
> +               args[0].integer.value = 0;
> +               args[2].integer.value = on ? 1 : 0;
> +       } else if (acpi_has_method(handle, method = "\\_SB.PCI0.LPCB.EC0.WPIN")) {
> +               args[0].integer.value = 1;
> +               args[2].integer.value = on ? 0 : 1;
> +       } else {
> +               pr_err("Unable to find ACPI method\n");

dev_err() here.

> +               return -1;

Return appropriate error code.

> +       }
> +
> +       acpi_evaluate_object(handle, method, &arg_list, NULL);
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(huawei_wmi_micmute_led_set);
> +
> +static void huawei_wmi_process_key(struct input_dev *inputdev, int code)
> +{

> +               acpi_status status;
> +               unsigned long long result;
> +               const char *method = "\\WMI0.WQ00";
> +               union acpi_object args[] = {
> +                               { .type = ACPI_TYPE_INTEGER  },
> +               };

> +               args[0].integer.value = 0;

Don't mix definitions and code.

> +               struct acpi_object_list arg_list = {
> +                       .pointer = args,
> +                       .count = ARRAY_SIZE(args),
> +               };

> +       if ((key->sw.code == KEY_BRIGHTNESSUP
> +                       || key->sw.code == KEY_BRIGHTNESSDOWN)

I believe this can fit one line.

> +                       && strcmp(event_guid, MBXP_EVENT_GUID) == 0)
> +               return;
> +
> +       sparse_keymap_report_entry(inputdev, key, 1, true);
> +}

> +static int __init huawei_wmi_init(void)
> +{
> +       int err;
> +
> +       if (wmi_has_guid(MBX_EVENT_GUID)) {
> +               event_guid = MBX_EVENT_GUID;
> +       } else if (wmi_has_guid(MBXP_EVENT_GUID)) {
> +               event_guid = MBXP_EVENT_GUID;
> +       } else {

> +               pr_warn("No known WMI GUID found\n");

Simple "Compatible WMI GUID not found\n".

> +               return -ENODEV;
> +       }
> +

> +       err = huawei_wmi_input_init();
> +       if (err) {

> +               pr_err("Failed to setup input device\n");

Noise.

> +               return err;
> +       }
> +
> +       return 0;

...just do

return huawei_wmi_input_init();

> +}

-- 
With Best Regards,
Andy Shevchenko
