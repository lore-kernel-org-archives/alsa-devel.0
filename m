From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [alsa-devel] [PATCHv1 1/8] ALSA: Add SAI SoC Digital Audio Interface
 driver.
Date: Thu, 17 Oct 2013 14:21:47 +0200
Message-ID: <525FD65B.3040004@metafoo.de>
References: <1382000477-17304-1-git-send-email-Li.Xiubo@freescale.com> <1382000477-17304-2-git-send-email-Li.Xiubo@freescale.com> <525FD4C7.3050806@tabi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <525FD4C7.3050806@tabi.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Timur Tabi <timur@tabi.org>
Cc: Xiubo Li <Li.Xiubo@freescale.com>, r65073@freescale.com, lgirdwood@gmail.com, broonie@kernel.org, mark.rutland@arm.com, alsa-devel@alsa-project.org, linux-doc@vger.kernel.org, tiwai@suse.de, b18965@freescale.com, LW@KARO-electronics.de, linux@arm.linux.org.uk, b42378@freescale.com, oskar@scara.com, grant.likely@linaro.org, devicetree@vger.kernel.org, ian.campbell@citrix.com, pawel.moll@arm.com, swarren@wwwdotorg.org, rob.herring@calxeda.com, linux-arm-kernel@lists.infradead.org, fabio.estevam@freescale.com, linux-kernel@vger.kernel.org, rob@landley.net, r64188@freescale.com, shawn.guo@linaro.org, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

On 10/17/2013 02:15 PM, Timur Tabi wrote:
> Xiubo Li wrote:
>> +    res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +    sai->base = devm_ioremap_resource(&pdev->dev, res);
> 
> Why not use of_iomap()?

Because it won't check for conflicting resource regions.

- Lars
