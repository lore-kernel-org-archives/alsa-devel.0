From: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: [PATCH] ASoC: fsl: Fix error handling if platform_device_add
 fails
Date: Tue, 27 Sep 2011 02:08:44 +0000
Message-ID: <4E81302B.8060903@freescale.com>
References: <1316502540.4269.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1316502540.4269.1.camel@phoenix>
Content-Language: en-US
Content-ID: <7A8BFE884E3AD4449E4CCA22377163A6@freescale.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Axel Lin wrote:
> Call platform_device_put() instead of platform_device_unregister() if
> platform_device_add() fails.

What's wrong with calling platform_device_unregister()?

-- 
Timur Tabi
Linux kernel developer at Freescale
