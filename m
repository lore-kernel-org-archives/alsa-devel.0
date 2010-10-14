From: Timur Tabi <timur.tabi@gmail.com>
Subject: Re: [PATCH 2/2] [v2] powerpc/85xx: add DIU support to
 the Freecale P1022DS reference board
Date: Thu, 14 Oct 2010 13:21:33 -0500
Message-ID: <AANLkTimWgbJ0oDsQkXxzjQ_pDxm_Vd+PJRhQJzN0BLTc@mail.gmail.com>
References: <1286480203-28227-1-git-send-email-timur@freescale.com>
	<1286480203-28227-2-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51]) by alsa0.perex.cz (Postfix) with ESMTP id 46BCF2442F
	for <alsa-devel@alsa-project.org>;
	Thu, 14 Oct 2010 20:22:06 +0200 (CEST)
Received: by yws5 with SMTP id 5so2793772yws.38
	for <alsa-devel@alsa-project.org>; Thu, 14 Oct 2010 11:22:05 -0700 (PDT)
In-Reply-To: <1286480203-28227-2-git-send-email-timur@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linuxppc-dev@ozlabs.org, kumar.gala@freescale.com, alsa-devel mailing list <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Mark, can you pick up this patch for us?  Because it depends on
"powerpc: rename immap_86xx.h to fsl_guts.h, and add 85xx support", it
will break the build if we apply to powerpc-next.

You can grab the patch from http://patchwork.ozlabs.org/patch/67095/

On Thu, Oct 7, 2010 at 2:36 PM, Timur Tabi <timur@freescale.com> wrote:
> The Freescale P1022DS has an on-chip video controller called the DIU, and=
 a
> driver for this device already exists. =A0Update the platform file for the
> P1022DS reference board to enable the driver, and update the defconfig for
> Freescale MPC85xx boards to add the driver.
>
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---

-- =

Timur Tabi
Linux kernel developer at Freescale
