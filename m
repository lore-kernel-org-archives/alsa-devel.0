From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH 0/3] ALSA: pxa27x: ac97 reset fixes
Date: Tue, 08 Jan 2013 10:44:55 +0200
Message-ID: <50EBDC87.1030207@compulab.co.il>
References: <1357595714-13698-1-git-send-email-mikedunn@newsguy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1357595714-13698-1-git-send-email-mikedunn@newsguy.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mike Dunn <mikedunn@newsguy.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Marek Vasut <marex@denx.de>, Eric Miao <eric.y.miao@gmail.com>, alsa-devel@alsa-project.org, Robert Jarzmik <robert.jarzmik@free.fr>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On 01/07/13 23:55, Mike Dunn wrote:
> AC97 reset is broken on the pxa27x.  These patches fix it by addressing multiple
> problems:
>   - cold reset fails because the GCR register is not set correctly
>   - warm reset fails because some code used to work around a hardware bug is
>     broken
>   - the intent of the work-around code is obfuscated by unfortunate function
>     naming
> 
> This patch set replaces some earlier individual patches that had some problems.
> Thanks Robert and Igor.
> 
> Changelog:
> v2:
>   - don't specify the LPM flag DRIVE_HIGH in #define for the mfp config
>   - patches 2 and 3 are combined into one patch
>   - mfp level and direction are set only once, during driver initialization
> 
> Mike Dunn (3):
>   ALSA: pxa2xx: fix ac97 cold reset
>   ALSA: pxa27x: fix ac97 warm reset
>   ALSA: pxa27x: rename pxa27x_assert_ac97reset()

I believe all three patches should go through Mark's tree.
Mark, at least patches 1 and 2 are also stable material,
can you please, add stable tags?

Thanks.

> 
>  arch/arm/mach-pxa/include/mach/mfp-pxa27x.h |    3 ++
>  arch/arm/mach-pxa/pxa27x.c                  |   24 ++++++++++++------
>  sound/arm/pxa2xx-ac97-lib.c                 |   34 +++++++++++++++++++++-----
>  3 files changed, 46 insertions(+), 15 deletions(-)
> 

-- 
Regards,
Igor.
