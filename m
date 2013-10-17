From: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCHv1 1/8] ALSA: Add SAI SoC Digital Audio
	Interface driver.
Date: Thu, 17 Oct 2013 07:15:03 -0500
Message-ID: <525FD4C7.3050806@tabi.org>
References: <1382000477-17304-1-git-send-email-Li.Xiubo@freescale.com>
 <1382000477-17304-2-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 by alsa0.perex.cz (Postfix) with ESMTP id 2A45A261A61
 for <alsa-devel@alsa-project.org>; Thu, 17 Oct 2013 14:15:08 +0200 (CEST)
In-Reply-To: <1382000477-17304-2-git-send-email-Li.Xiubo@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Xiubo Li <Li.Xiubo@freescale.com>, r65073@freescale.com, lgirdwood@gmail.com, broonie@kernel.org
Cc: mark.rutland@arm.com, alsa-devel@alsa-project.org, linux-doc@vger.kernel.org, tiwai@suse.de, b18965@freescale.com, LW@KARO-electronics.de, linux@arm.linux.org.uk, b42378@freescale.com, oskar@scara.com, grant.likely@linaro.org, devicetree@vger.kernel.org, ian.campbell@citrix.com, pawel.moll@arm.com, swarren@wwwdotorg.org, rob.herring@calxeda.com, linux-arm-kernel@lists.infradead.org, fabio.estevam@freescale.com, linux-kernel@vger.kernel.org, rob@landley.net, r64188@freescale.com, shawn.guo@linaro.org, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

Xiubo Li wrote:
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	sai->base = devm_ioremap_resource(&pdev->dev, res);

Why not use of_iomap()?
