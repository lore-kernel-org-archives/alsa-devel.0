From: ayman.bagabas@gmail.com
Subject: Re: [PATCH v3 1/3] x86: add support for Huawei WMI hotkeys.
Date: Thu, 08 Nov 2018 22:52:31 -0500
Message-ID: <d3c913eb8854efbbf6b737cf94edc95179d58f59.camel@gmail.com>
References: <20181108171701.4444-1-ayman.bagabas@gmail.com>
         <20181108171701.4444-2-ayman.bagabas@gmail.com>
         <CAHp75Vev_0ObO=KLHfON8JAco=a9MURycH9uk-a+h1JqrSSQFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75Vev_0ObO=KLHfON8JAco=a9MURycH9uk-a+h1JqrSSQFA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Kailang Yang <kailang@realtek.com>, Hui Wang <hui.wang@canonical.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 2018-11-08 at 21:58 +0200, Andy Shevchenko wrote:
> On Thu, Nov 8, 2018 at 7:17 PM Ayman Bagabas <ayman.bagabas@gmail.com
> > wrote:
> > This driver adds support for missing hotkeys on some Huawei
> > laptops.
> > Currently, only Huawei Matebook X and Matebook X Pro is supported.
> > 
> 
> Thanks for an update, my comments below.
> 
> 
> > +config HUAWEI_LAPTOP
> > +       tristate "Huawei WMI hotkeys driver"
> > +       depends on ACPI
> 
> Do you need an ACPI dependency be explicit here?

Probably don't need it.

> 
> > +       depends on ACPI_WMI
> > +       depends on INPUT
> > +       select INPUT_SPARSEKMAP
> > +       help
> > +         This driver provides support for Huawei WMI hotkeys.
> > +         It enables the missing keys and adds support to the
> > micmute
> > +         LED found on some of these laptops.
> > +/*
> > + *  Huawei WMI hotkeys
> > + *
> > + *  Copyright (C) 2018       Ayman Bagabas <
> > ayman.bagabas@gmail.com>
> > + *
> > + *  This program is free software: you can redistribute it and/or
> > modify
> > + *  it under the terms of the GNU General Public License as
> > published by
> > + *  the Free Software Foundation, either version 2 of the License,
> > or
> > + *  (at your option) any later version.
> > + *
> > + *  This program is distributed in the hope that it will be
> > useful,
> > + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + *  GNU General Public License for more details.
> > + *
> > + *  You should have received a copy of the GNU General Public
> > License
> > + *  along with this program.  If not, see <
> > https://www.gnu.org/licenses/>;.
> > + *
> 
> Please, replace this boilerplate text with appropriate SPDX
> identifier.

Soryy about that. This alright?

// SPDX-License-Identifier: GPL-2.0
/*
 * Huawei WMI hotkeys
 *
 * Copyright (C) 2018		Ayman Bagabas <ayman.bagabas@gmail.com>
 */
