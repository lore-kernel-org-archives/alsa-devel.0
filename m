From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH v4 0/3] McPDM driver patch series
Date: Tue, 23 Feb 2010 10:08:25 +0000
Message-ID: <1266919705.3156.0.camel@odin>
References: <2256F256009DAA4CBE661E9F41EAC84B8FA52A10@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f220.google.com (mail-fx0-f220.google.com
	[209.85.220.220])
	by alsa0.perex.cz (Postfix) with ESMTP id 146B81038CE
	for <alsa-devel@alsa-project.org>; Tue, 23 Feb 2010 11:08:31 +0100 (CET)
Received: by fxm20 with SMTP id 20so8694465fxm.32
	for <alsa-devel@alsa-project.org>; Tue, 23 Feb 2010 02:08:29 -0800 (PST)
In-Reply-To: <2256F256009DAA4CBE661E9F41EAC84B8FA52A10@dlee01.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Candelaria Villareal, Jorge" <jorge.candelaria@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 2010-02-22 at 15:09 -0600, Candelaria Villareal, Jorge wrote:
> McPDM module is the interface between the OMAP and TWL6030 audio codec.
> 
> The interface supports the following:
> * Up to 5 downlink channels and 3 uplink channels
> * 88.2 and 96 KHz
> * 32 bit sample size
> 
> Currently, driver is set to support up to 4 downlink channels. If 2
> channels are selected, output will go to the headset, and if 4 channels
> are selected, output will go to the headset and speakers. Functionality
> to select the output at runtime will be added afterwards.
> 
> Command and status mode is not supported in current patches.
> 
> Changes from v3:
> - Implemented changes based on comments from Liam Girdwood.
> 
> --
> 
> Jorge Eduardo Candelaria (1):
>       ASoC: OMAP4: Add support for McPDM
> 
> Misael Lopez Cruz (2):
>       ASoC: OMAP: data_type and sync_mode configurable in audio dma
>       ASoC: OMAP4: Add McPDM platform driver
> 
>  sound/soc/omap/Kconfig      |    3 +
>  sound/soc/omap/Makefile     |    2 +
>  sound/soc/omap/mcpdm.c      |  486 +++++++++++++++++++++++++++++++++++++++++++
>  sound/soc/omap/mcpdm.h      |  151 +++++++++++++
>  sound/soc/omap/omap-mcbsp.c |    2 +
>  sound/soc/omap/omap-mcpdm.c |  251 ++++++++++++++++++++++
>  sound/soc/omap/omap-mcpdm.h |   29 +++
>  sound/soc/omap/omap-pcm.c   |   15 +-
>  sound/soc/omap/omap-pcm.h   |    4 +-
>  9 files changed, 935 insertions(+), 8 deletions(-)
>  create mode 100644 sound/soc/omap/mcpdm.c
>  create mode 100644 sound/soc/omap/mcpdm.h
>  create mode 100644 sound/soc/omap/omap-mcpdm.c
>  create mode 100644 sound/soc/omap/omap-mcpdm.h
> _______________________________________________

All Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
