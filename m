From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v2] ASoC: mx27vis-aic32x4: Convert it to
	platform driver
Date: Mon, 12 Mar 2012 08:11:44 -0300
Message-ID: <CAOMZO5BkK0m8vhH8i1x2f049YUT0_4OOiOXrGL5pPUzMo9p8xA@mail.gmail.com>
References: <1331499423-9761-1-git-send-email-festevam@gmail.com>
	<CACKLOr2j-Apnno+-h6B6Rax2-H7ZTuQ=RzyeyB7pOsqJ=xUJuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id A4B0A103D2C
	for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2012 12:11:45 +0100 (CET)
Received: by eaak11 with SMTP id k11so822798eaa.38
	for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2012 04:11:44 -0700 (PDT)
In-Reply-To: <CACKLOr2j-Apnno+-h6B6Rax2-H7ZTuQ=RzyeyB7pOsqJ=xUJuA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: javier Martin <javier.martin@vista-silicon.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

Hi Javier.

On Mon, Mar 12, 2012 at 5:03 AM, javier Martin
<javier.martin@vista-silicon.com> wrote:
>
> I agree with the patch. However, I think another patch, which
> registers this platform device for the visstrim_m10 board file
> (http://lxr.linux.no/#linux+v3.2.9/arch/arm/mach-imx/mach-imx27_visstrim_m10.c)
> should be applied at the same time. Otherwise, audio would stop
> working on this platform and that would be a regression.

The first hunk of this patch does register the audio device inside
arch/arm/mach-imx/mach-imx27_visstrim_m10.c:

diff --git a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
index 0a1643c..ed6023f 100644
--- a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
+++ b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
@@ -397,6 +397,7 @@ static void __init visstrim_m10_board_init(void)
                                     &iclink_tvp5150, sizeof(iclink_tvp5150));
       gpio_led_register_device(0, &visstrim_m10_led_data);
       visstrim_camera_init();
+       imx_add_platform_device("mx27vis", 0, NULL, 0, NULL, 0);
 }

Did I miss anything?

Regards,

Fabio Estevam
