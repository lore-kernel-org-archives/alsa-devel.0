From: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH] ASoC: fsl_ssi: No need call
	of_device_is_available()
Date: Thu, 07 May 2015 22:16:20 -0500
Message-ID: <554C2A84.3010508@tabi.org>
References: <1431051856-22476-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 by alsa0.perex.cz (Postfix) with ESMTP id 96D572612D2
 for <alsa-devel@alsa-project.org>; Fri,  8 May 2015 05:16:23 +0200 (CEST)
In-Reply-To: <1431051856-22476-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>, broonie@kernel.org
Cc: nicoleotsuka@gmail.com, Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Fabio Estevam wrote:
> The comment and the call to of_device_is_available() are not really
> needed.
>
> It is the expected behaviour to probe only the ssi nodes that are
> enabled in the device tree.
>
> Signed-off-by: Fabio Estevam<fabio.estevam@freescale.com>

Acked-by: Timur Tabi <timur@tabi.org>
