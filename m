From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2 0/4] Mark mpc5200 i2s driver BROKEN
Date: Mon, 27 Apr 2009 10:53:34 -0600
Message-ID: <fa686aa40904270953p6e82bea8t6aa8fec2885b94b5@mail.gmail.com>
References: <20090427164108.18211.44680.stgit@terra>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 3063C245E7
	for <alsa-devel@alsa-project.org>;
	Mon, 27 Apr 2009 18:53:50 +0200 (CEST)
Received: by yw-out-1718.google.com with SMTP id 4so18212ywq.2
	for <alsa-devel@alsa-project.org>; Mon, 27 Apr 2009 09:53:49 -0700 (PDT)
In-Reply-To: <20090427164108.18211.44680.stgit@terra>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 27, 2009 at 10:44 AM, Jon Smirl <jonsmirl@gmail.com> wrote:
> Mark the mpc5200 i2s driver BROKEN and lay out a foundation for
> fixing it. Separate out the mpc5200 core DMA routines from
> mpc5200_psc_i2s.c into a standalone mpc5200_dma.c. No intention
> to change how anything works, this is just a code reorg needed for
> later patches to build on.

BTW, you could have added my acked-by lines to the patches which I
acked on the linuxppc-dev list.  Also, for the next version (if there
is one), please post to both the alsa and linuxppc lists.

Thanks,
g.

>
> ---
>
> Jon Smirl (4):
> =A0 =A0 =A0Rename exports in mpc5200_dma.c
> =A0 =A0 =A0Rename the PSC functions to DMA
> =A0 =A0 =A0Basic split of mpc5200 DMA code out from mpc5200_psc_i2s
> =A0 =A0 =A0Set the MPC5200 i2s driver to BROKEN status.
>
>
> =A0sound/soc/fsl/Kconfig =A0 =A0 =A0 =A0 =A0 | =A0 =A06
> =A0sound/soc/fsl/Makefile =A0 =A0 =A0 =A0 =A0| =A0 =A02
> =A0sound/soc/fsl/mpc5200_dma.c =A0 =A0 | =A0463 +++++++++++++++++++++++++=
+++
> =A0sound/soc/fsl/mpc5200_dma.h =A0 =A0 | =A0 81 +++++
> =A0sound/soc/fsl/mpc5200_psc_i2s.c | =A0644 +++++------------------------=
----------
> =A05 files changed, 633 insertions(+), 563 deletions(-)
> =A0create mode 100644 sound/soc/fsl/mpc5200_dma.c
> =A0create mode 100644 sound/soc/fsl/mpc5200_dma.h
>
> --
> Jon Smirl
> jonsmirl@gmail.com
>



-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
