From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH 2/2] misc: sram: switch to ioremap_wc from ioremap
Date: Thu, 08 Jan 2015 21:56:04 +0100
Message-ID: <2101240.CsKVRjX3M8@phil>
References: <1418266726-12004-1-git-send-email-a.kesavan@samsung.com> <CAL_JsqJwdr7WvzLqPmui3N4H-wVgSURN6wYD=dm1HyU2HUmXOg@mail.gmail.com> <CAM4voakHnwRzVsYYO2Dd2f9_PxZGqvqT8xveA-Y6N4ReOfhdmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAM4voakHnwRzVsYYO2Dd2f9_PxZGqvqT8xveA-Y6N4ReOfhdmw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Abhilash Kesavan <kesavan.abhilash@gmail.com>
Cc: Rob Herring <robherring2@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, Tony Lindgren <tony@atomide.com>, linux-rockchip@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>, "shc_work@mail.ru" <shc_work@mail.ru>, "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>, "arnd@arndb.de" <arnd@arndb.de>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "corbet@lwn.net" <corbet@lwn.net>, "padma.v@samsung.com" <padma.v@samsung.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "shawn.guo@freescale.com" <shawn.guo@freescale.com>, bcousson@baylibre.c
List-Id: alsa-devel@alsa-project.org

Hi Abhilash,

Am Donnerstag, 8. Januar 2015, 21:00:57 schrieb Abhilash Kesavan:
> Thanks for the confirmation regarding the i.MX chips. That leaves
> rockchip, can someone help with it please ?

sorry for being late to this.

The one current sram use-case on Rockchip boards is the SMP bringup, but that 
uses a reserved sram area. Nevertheless I tested your 2 patches on a rk3288 
board and everything still works as expected, including smp bringup,
so on Rockchip

Tested-by: Heiko Stuebner <heiko@sntech.de>


Heiko
