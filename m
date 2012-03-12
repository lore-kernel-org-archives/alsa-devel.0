From: javier Martin <javier.martin@vista-silicon.com>
Subject: Re: [PATCH v2] ASoC: mx27vis-aic32x4: Convert it to
	platform driver
Date: Mon, 12 Mar 2012 12:41:27 +0100
Message-ID: <CACKLOr0x3cGGLc7vF4gyP1XCBSJkOR1S3P2eYuuhJZ+EmX8zPQ@mail.gmail.com>
References: <1331499423-9761-1-git-send-email-festevam@gmail.com>
	<CACKLOr2j-Apnno+-h6B6Rax2-H7ZTuQ=RzyeyB7pOsqJ=xUJuA@mail.gmail.com>
	<CAOMZO5BkK0m8vhH8i1x2f049YUT0_4OOiOXrGL5pPUzMo9p8xA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id B3830103EEA
	for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2012 12:41:30 +0100 (CET)
Received: by iakh37 with SMTP id h37so7418500iak.38
	for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2012 04:41:29 -0700 (PDT)
In-Reply-To: <CAOMZO5BkK0m8vhH8i1x2f049YUT0_4OOiOXrGL5pPUzMo9p8xA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

Hi Fabio,

On 12 March 2012 12:11, Fabio Estevam <festevam@gmail.com> wrote:
> Hi Javier.
>
> On Mon, Mar 12, 2012 at 5:03 AM, javier Martin
> <javier.martin@vista-silicon.com> wrote:
>>
>> I agree with the patch. However, I think another patch, which
>> registers this platform device for the visstrim_m10 board file
>> (http://lxr.linux.no/#linux+v3.2.9/arch/arm/mach-imx/mach-imx27_visstrim=
_m10.c)
>> should be applied at the same time. Otherwise, audio would stop
>> working on this platform and that would be a regression.
>
> The first hunk of this patch does register the audio device inside
> arch/arm/mach-imx/mach-imx27_visstrim_m10.c:
>
> diff --git a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
> b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
> index 0a1643c..ed6023f 100644
> --- a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
> +++ b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
> @@ -397,6 +397,7 @@ static void __init visstrim_m10_board_init(void)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &=
iclink_tvp5150, sizeof(iclink_tvp5150));
> =A0 =A0 =A0 gpio_led_register_device(0, &visstrim_m10_led_data);
> =A0 =A0 =A0 visstrim_camera_init();
> + =A0 =A0 =A0 imx_add_platform_device("mx27vis", 0, NULL, 0, NULL, 0);
> =A0}
>
> Did I miss anything?

Sorry, I missed it, it was quite early in the morning...

Could you please provide a git repository and a branch for me to test
this patch?

Regards.
-- =

Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
