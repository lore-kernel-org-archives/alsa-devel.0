From: Eric Nelson <eric.nelson@boundarydevices.com>
Subject: Re: [PATCH RFC 0/6] ASoC: sgtl5000: fix use of
 regulators and internal LDO
Date: Fri, 06 Mar 2015 15:49:39 -0700
Message-ID: <54FA2F03.2060804@boundarydevices.com>
References: <1424991273-10081-1-git-send-email-eric.nelson@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f169.google.com (mail-pd0-f169.google.com
 [209.85.192.169])
 by alsa0.perex.cz (Postfix) with ESMTP id BF48C26609F
 for <alsa-devel@alsa-project.org>; Fri,  6 Mar 2015 23:49:44 +0100 (CET)
Received: by pdev10 with SMTP id v10so32050476pde.0
 for <alsa-devel@alsa-project.org>; Fri, 06 Mar 2015 14:49:43 -0800 (PST)
In-Reply-To: <1424991273-10081-1-git-send-email-eric.nelson@boundarydevices.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: fabio.estevam@freescale.com, alsa-devel@alsa-project.org, lars@metafoo.de, tiwai@suse.de, lgirdwood@gmail.com, rmk+kernel@arm.linux.org.uk, jean-michel.hautbois@vodalys.com, troy.kisky@boundarydevices.com
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On 02/26/2015 03:54 PM, Eric Nelson wrote:
> This patch set addresses a structural problem in the handling of regulators
> for VDDIO, VDDA, and VDDD in the SGTL5000 driver.
> 
> The first two of these power rails must be powered on prior to any I2C
> communication, and yet the regulators were tied to the codec, which is
> instantiated only after a fair amount of I2C communication takes place.
> 
> In other words, these regulators could never have function, and we can
> surmise that no user of this driver has switched power supply rails
> connected to them.
> 
> The third power rail (VDDD) can be derived internally (by using I2C registers)
> though the data sheet says that if an external VDDD is used, it should be
> enabled before MCLK is started and I2C activity begins.
> 
> Patch 1 moves the regulators to the I2C device and initializes them before
> 	I2C activity.
> Patch 2 addresses an issue found during development of the patch and is
>         somewhat unrelated to regulators. It is included for discussion
> Patch 3 removes the root cause of patch 2
> Patch 4 adds return value checks when setting the LINREG and ANA_POWER
> 	registers
> Patch 5 addresses the cause of follow-on failures and the source of the
> 	error in patch 3.
> Patch 6 removes the naive use of the supplies to lower power consumption
> 	and replaces it with something more modest.
> 
> The patch set is being sent as an RFC for discussion, and should probably
> be squashed into two or three patches covering the regulator updates
> (patches 1, 3-5 and perhaps 6), initialization error handling (patch 2).
> 
> Eric Nelson (6):
>   ASoC: sgtl5000: fix regulator support
>   ASoC: sgtl5000: write all default registers
>   ASoC: sgtl5000: initialize CHIP_ANA_POWER to power-on defaults
>   ASoC: sgtl5000: check return values
>   ASoC: sgtl5000: disable internal PLL early
>   ASoC: sgtl5000: Don't disable regulators in SND_SOC_BIAS_OFF
> 

Based on your review, it seems like the following is needed for a
V2 patch (set):

- Move call to sgtl5000_fill_defaults() earlier in the
  sgtl5000_i2c_probe routine, before adjusting ANA_POWER.
  This will allow registers LINEREG_CTRL, CLK_CTRL, and even ANA_POWER
  back into the default	register list.
- Move regulators from codec to I2C device
- switch to devm_regulator api
- various code cleanups to simplify logic
- Adjust regulator usage in SND_SOC_BIAS_OFF

I'll leave out the "write all default" registers for the moment.

Let me know if you'd like to see this in multiple patches or a
single patch.

I'll wait to see if there's other feedback before prepping V2.

Regards,


Eric
