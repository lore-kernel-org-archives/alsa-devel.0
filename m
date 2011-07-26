From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH V2 0/3] ASoC: au1x: update PSC AC97/I2S code
Date: Tue, 26 Jul 2011 11:58:01 +0100
Message-ID: <4E2E9DB9.5090007@ti.com>
References: <1311594304-31605-1-git-send-email-manuel.lauss@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1311594304-31605-1-git-send-email-manuel.lauss@googlemail.com>
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

On 25/07/11 12:45, Manuel Lauss wrote:
> The following two patches depend on patchset "ASoC for Alchemy Au1000/1500/1100"
> to apply and work.
> Patch #1 moves the DBDMA (PCM) device registration from the AC97/I2S drivers
>   into the board code.
> Patch #2 changes use of "soc-audio" platform device int db1200 machine code to
>   the new way.
> Patch #3 removes the use of custom PCM_TX/RX constants in favour of the
>   established SNDRV_PCM_SUBTREAM_PLAYBACK/CAPTURE.
> 
> Changes since V1:
> - added patch #3
> - tidied patch #1 a bit more.
> 
> Run-tested on DB1200, DB1300 and DB1550 boards.
> 
> Manuel Lauss (3):
>   ASoC: au1x: remove automatic DMA device registration from PSC drivers
>   ASoC: au1x: update db1200 machine to the new way of things
>   ASoC: au1x: use substream stream info directly
> 
>  arch/mips/alchemy/devboards/db1200/platform.c |   16 +++++
>  sound/soc/au1x/db1200.c                       |   64 ++++++++++++------
>  sound/soc/au1x/dbdma2.c                       |   91 +++++--------------------
>  sound/soc/au1x/psc-ac97.c                     |   48 +++++++++-----
>  sound/soc/au1x/psc-i2s.c                      |   42 +++++++----
>  sound/soc/au1x/psc.h                          |   11 ---
>  6 files changed, 133 insertions(+), 139 deletions(-)
> 

Acked-by: Liam Girdwood <lrg@ti.com>
