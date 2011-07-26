From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH V5 0/3] ASoC for Alchemy Au1000/1500/1100
Date: Tue, 26 Jul 2011 11:48:23 +0100
Message-ID: <4E2E9B77.4060602@ti.com>
References: <1311594287-31576-1-git-send-email-manuel.lauss@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1311594287-31576-1-git-send-email-manuel.lauss@googlemail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Linux-MIPS <linux-mips@linux-mips.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "alsa-devel@vger.kernel.org" <alsa-devel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On 25/07/11 12:44, Manuel Lauss wrote:
> Hello,
> 
> Here's V5 of the AC97/I2S ASoC patchset for early Alchemy
> chips and their respective evaluation boards. 
> The patches are largely based on the old mips/au1x00.c driver which
> they replace.
> 
> AC97 Tested on a Db1500 development board; I2S untested since none
> of the testboards I have actually have an I2S codec (just testpoints).
> 
> Changes since V4:
> - incorporate feedback from Liam Girdwood.
> - rediff against latest ASoC changes
> 
> Changes since V3:
> - dropped the hunk which removed the I2S constants from the au1000.h header
>   to avoid merge conflicts with other patches.
> - use the context structure declared in psc.h.  Follow-up patches for psc* code
>   depend on this.
> 
> Changes since V2:
> - implemented changes after feedback from Lars-Peter Clausen:
> * split patch 1 in two, one for the ASoC drivers, and a separate for
>   DB1000 machine code.
> * get rid of automatic dma device registration
> * tidied the I2S/AC97 sources
> - mark sound/mips/au1x00.c as DEPRECATED instead of removing it outright.
> 
> Changes since V1:
> - added untested I2S controller driver for completeness, removed the audio
>   defines from the au1000 header.
> 
> Manuel Lauss (3):
>   ASoC: Alchemy AC97C/I2SC audio support
>   ASoC: Add a DB1x00 AC97 machine driver
>   ALSA: deprecate MIPS AU1X00 AC97 driver
> 
>  arch/mips/alchemy/devboards/db1x00/platform.c |   48 ++++
>  sound/mips/Kconfig                            |    5 +-
>  sound/soc/au1x/Kconfig                        |   28 ++
>  sound/soc/au1x/Makefile                       |   10 +
>  sound/soc/au1x/ac97c.c                        |  365 ++++++++++++++++++++++++
>  sound/soc/au1x/db1000.c                       |   75 +++++
>  sound/soc/au1x/dma.c                          |  377 +++++++++++++++++++++++++
>  sound/soc/au1x/i2sc.c                         |  347 +++++++++++++++++++++++
>  sound/soc/au1x/psc.h                          |   19 +-
>  9 files changed, 1264 insertions(+), 10 deletions(-)
>  create mode 100644 sound/soc/au1x/ac97c.c
>  create mode 100644 sound/soc/au1x/db1000.c
>  create mode 100644 sound/soc/au1x/dma.c
>  create mode 100644 sound/soc/au1x/i2sc.c
> 

All

Acked-by: Liam Girdwood <lrg@ti.com>
