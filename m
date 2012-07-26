From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 17/21] ASoC: Ux500: Enable ux500 PCM driver for Device
 Tree
Date: Thu, 26 Jul 2012 14:52:09 +0100
Message-ID: <50114B89.7070100@linaro.org>
References: <1343298534-13611-1-git-send-email-lee.jones@linaro.org> <1343298534-13611-18-git-send-email-lee.jones@linaro.org> <20120726113838.GA3099@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120726113838.GA3099@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, linus.walleij@stericsson.com, arnd@arndb.de, sameo@linux.intel.com, olalilja@yahoo.se, ola.o.lilja@stericsson.com, alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On 26/07/12 12:38, Mark Brown wrote:
> On Thu, Jul 26, 2012 at 11:28:50AM +0100, Lee Jones wrote:
>
>> Here we pass platform registration from platform code over to Device
>> Tree, when DT is enabled.
>
>> -	pr_info("%s: Register platform-device 'ux500-pcm'\n", __func__);
>> -	platform_device_register(&ux500_pcm);
>
> This has the same issue as your last patch...  the way you're doing
> things will break audio on all boards using this driver.

It will, why?

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
