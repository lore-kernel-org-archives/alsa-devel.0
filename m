From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH V2 4/9] Add a few more mpc5200 PSC defines
Date: Sun, 24 May 2009 08:13:19 -0600
Message-ID: <fa686aa40905240713g2e79367mec0ba185432a94a@mail.gmail.com>
References: <20090523231148.17919.46103.stgit@terra>
	<20090523231303.17919.35877.stgit@terra>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yx-out-1718.google.com (yx-out-1718.google.com [74.125.44.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 12EDC2442C
	for <alsa-devel@alsa-project.org>;
	Sun, 24 May 2009 16:13:39 +0200 (CEST)
Received: by yx-out-1718.google.com with SMTP id 6so2028153yxn.2
	for <alsa-devel@alsa-project.org>; Sun, 24 May 2009 07:13:39 -0700 (PDT)
In-Reply-To: <20090523231303.17919.35877.stgit@terra>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, broonie@sirena.org.uk
List-Id: alsa-devel@alsa-project.org

On Sat, May 23, 2009 at 5:13 PM, Jon Smirl <jonsmirl@gmail.com> wrote:
> Add a few more mpc5200 PSC defines. More bit fields defines for mpc5200 P=
SC registers. This patch is going in via Grant's tree.
>
> Signed-off-by: Jon Smirl <jonsmirl@gmail.com>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
> =A00 files changed, 0 insertions(+), 0 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/mpc52xx_psc.h b/arch/powerpc/includ=
e/asm/mpc52xx_psc.h
> index a218da6..fb84120 100644
> --- a/arch/powerpc/include/asm/mpc52xx_psc.h
> +++ b/arch/powerpc/include/asm/mpc52xx_psc.h
> @@ -28,6 +28,10 @@
> =A0#define MPC52xx_PSC_MAXNUM =A0 =A0 6
>
> =A0/* Programmable Serial Controller (PSC) status register bits */
> +#define MPC52xx_PSC_SR_UNEX_RX 0x0001
> +#define MPC52xx_PSC_SR_DATA_VAL =A0 =A0 =A0 =A00x0002
> +#define MPC52xx_PSC_SR_DATA_OVR =A0 =A0 =A0 =A00x0004
> +#define MPC52xx_PSC_SR_CMDSEND 0x0008
> =A0#define MPC52xx_PSC_SR_CDE =A0 =A0 0x0080
> =A0#define MPC52xx_PSC_SR_RXRDY =A0 0x0100
> =A0#define MPC52xx_PSC_SR_RXFULL =A00x0200
> @@ -61,6 +65,12 @@
> =A0#define MPC52xx_PSC_RXTX_FIFO_EMPTY =A0 =A00x0001
>
> =A0/* PSC interrupt status/mask bits */
> +#define MPC52xx_PSC_IMR_UNEX_RX_SLOT 0x0001
> +#define MPC52xx_PSC_IMR_DATA_VALID =A0 =A0 0x0002
> +#define MPC52xx_PSC_IMR_DATA_OVR =A0 =A0 =A0 0x0004
> +#define MPC52xx_PSC_IMR_CMD_SEND =A0 =A0 =A0 0x0008
> +#define MPC52xx_PSC_IMR_ERROR =A0 =A0 =A0 =A0 =A00x0040
> +#define MPC52xx_PSC_IMR_DEOF =A0 =A0 =A0 =A0 =A0 0x0080
> =A0#define MPC52xx_PSC_IMR_TXRDY =A0 =A0 =A0 =A0 =A00x0100
> =A0#define MPC52xx_PSC_IMR_RXRDY =A0 =A0 =A0 =A0 =A00x0200
> =A0#define MPC52xx_PSC_IMR_DB =A0 =A0 =A0 =A0 =A0 =A0 0x0400
> @@ -117,6 +127,7 @@
> =A0#define MPC52xx_PSC_SICR_SIM_FIR =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x6 << 2=
4)
> =A0#define MPC52xx_PSC_SICR_SIM_CODEC_24 =A0 =A0 =A0 =A0 =A0(0x7 << 24)
> =A0#define MPC52xx_PSC_SICR_SIM_CODEC_32 =A0 =A0 =A0 =A0 =A0(0xf << 24)
> +#define MPC52xx_PSC_SICR_AWR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 3=
0)
> =A0#define MPC52xx_PSC_SICR_GENCLK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0(1 << 23)
> =A0#define MPC52xx_PSC_SICR_I2S =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 <<=
 22)
> =A0#define MPC52xx_PSC_SICR_CLKPOL =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0(1 << 21)
>
>



-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
