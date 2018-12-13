From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v2] ASoC: fsl: Fix SND_SOC_EUKREA_TLV320
 build error on i.MX8M
Date: Thu, 13 Dec 2018 15:12:41 +0800
Message-ID: <20181213071240.GA12458@dragon>
References: <1544666918-10783-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by alsa0.perex.cz (Postfix) with ESMTP id AB7F9267C0C
 for <alsa-devel@alsa-project.org>; Thu, 13 Dec 2018 08:13:40 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1544666918-10783-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, linux-imx@nxp.com
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 13, 2018 at 12:08:38AM -0200, Fabio Estevam wrote:
> eukrea-tlv320.c machine driver runs on non-DT platforms
> and include <asm/mach-types.h> header file in order to be able
> to use some machine_is_eukrea_xxx() macros.
> 
> Building it for ARM64 causes the following build error:
> 
> sound/soc/fsl/eukrea-tlv320.c:28:10: fatal error: asm/mach-types.h: No such file or directory
> 
> Avoid this error by not allowing to build the SND_SOC_EUKREA_TLV320
> driver when ARM64 is selected.
> 
> This is needed in preparation for the i.MX8M support.
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Acked-by: Shawn Guo <shawnguo@kernel.org>
