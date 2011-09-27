From: Axel Lin <axel.lin@gmail.com>
Subject: Re: [PATCH] ASoC: fsl: Fix error handling if platform_device_add fails
Date: Tue, 27 Sep 2011 10:21:59 +0800
Message-ID: <CAF+7xWmy6v6XWMwrHSdRTUPBKmtQ1Wf88gBD0LDZCUWwg_Gd_A@mail.gmail.com>
References: <1316502540.4269.1.camel@phoenix> <4E81302B.8060903@freescale.com>
Reply-To: axel.lin@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4E81302B.8060903@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tabi Timur-B04825 <B04825@freescale.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/9/27 Tabi Timur-B04825 <B04825@freescale.com>:
> Axel Lin wrote:
>> Call platform_device_put() instead of platform_device_unregister() if
>> platform_device_add() fails.
>
> What's wrong with calling platform_device_unregister()?

/**
 * platform_device_unregister - unregister a platform-level device
 * @pdev: platform device we're unregistering
 *
 * Unregistration is done in 2 steps. First we release all resources
 * and remove it from the subsystem, then we drop reference count by
 * calling platform_device_put().
 */

platform_device_unregister() actually calls platform_device_del() and
platform_device_put().

If platform_device_add() call fails, we failed to add the platform
device to device hierarchy. Thus we can just call platform_device_put() instead.

>
> --
> Timur Tabi
> Linux kernel developer at Freescale
>
