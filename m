From: Ryan Mallon <rmallon@gmail.com>
Subject: Re: [PATCH 0/7] ASoC: ep93xx: convert to use snd_soc_register_card()
Date: Mon, 12 Sep 2011 09:15:12 +1000
Message-ID: <4E6D4100.7060007@gmail.com>
References: <cover.1315732452.git.mika.westerberg@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.1315732452.git.mika.westerberg@iki.fi>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mika Westerberg <mika.westerberg@iki.fi>
Cc: hsweeten@visionengravers.com, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On 11/09/11 19:28, Mika Westerberg wrote:

> Here is a series of patches which convert ep93xx ASoC drivers to use
> snd_soc_register_card(). This has the advantage that the machine drivers get
> loaded automatically by udev. Also this gets rid of machine_is_xxx() from the
> machine drivers.
> 
> Tested on Sim.One. The edb93xx and snappercl15 changes are compile tested
> only.


Thanks for doing this. Unfortunately I don't have any hardware to test
any more, but the code looks correct to me.

Whole series:
Reviewed-by: Ryan Mallon <rmallon@gmail.com>

> 
> Mika Westerberg (7):
>   ASoC: ep93xx-pcm: add MODULE_ALIAS
>   ASoC: simone: convert to use snd_soc_register_card()
>   ASoC: edb93xx: convert to use snd_soc_register_card()
>   ASoC: snappercl15: convert to use snd_soc_register_card()
>   ARM: ep93xx: simone: register audio platform device
>   ARM: ep93xx: edb93xx: register audio platform device
>   ARM: ep93xx: snappercl15: register audio platform device
> 
>  arch/arm/mach-ep93xx/edb93xx.c     |    6 +++
>  arch/arm/mach-ep93xx/simone.c      |   13 +++++++-
>  arch/arm/mach-ep93xx/snappercl15.c |   13 +++++++-
>  sound/soc/ep93xx/edb93xx.c         |   60 ++++++++++++++++++---------------
>  sound/soc/ep93xx/ep93xx-pcm.c      |    1 +
>  sound/soc/ep93xx/simone.c          |   64 ++++++++++++++++++++----------------
>  sound/soc/ep93xx/snappercl15.c     |   53 ++++++++++++++++++++---------
>  7 files changed, 136 insertions(+), 74 deletions(-)
> 
