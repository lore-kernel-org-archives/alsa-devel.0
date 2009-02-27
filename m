From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] cs4270: add support for slave mode
	configurations
Date: Fri, 27 Feb 2009 15:51:58 -0600
Message-ID: <ed82fe3e0902271351nc170b16v71b81754f8aeadd3@mail.gmail.com>
References: <1235569041-856-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from el-out-1112.google.com (el-out-1112.google.com [209.85.162.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 665B61037EB
	for <alsa-devel@alsa-project.org>; Fri, 27 Feb 2009 22:52:00 +0100 (CET)
Received: by el-out-1112.google.com with SMTP id r27so1164708ele.2
	for <alsa-devel@alsa-project.org>; Fri, 27 Feb 2009 13:51:59 -0800 (PST)
In-Reply-To: <1235569041-856-1-git-send-email-daniel@caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 25, 2009 at 7:37 AM, Daniel Mack <daniel@caiaq.de> wrote:
> Added support for scenarios where the Cirrus CS4270 audio codec is slave
> to the bitclk and lrclk. Mixed setups are unsupported.
>
> Signed-off-by: Daniel Mack <daniel@caiaq.de>

FYI, it's customary to CC: the author of a driver when posting patches for it.

> +       /* set master/slave audio interface */
> +       switch (format & SND_SOC_DAIFMT_MASTER_MASK) {
> +       case SND_SOC_DAIFMT_CBS_CFS:
> +               cs4270->slave_mode = 1;
> +               break;
> +       case SND_SOC_DAIFMT_CBM_CFM:
> +               cs4270->slave_mode = 0;
> +               break;
> +       case SND_SOC_DAIFMT_CBM_CFS:
> +               /* unsupported - cs4270 can eigther be slave or master to

Typo.  However, I suggest you get rid of the "case
SND_SOC_DAIFMT_CBM_CFS" and in the "default:", just have this:

> +       default:
                   /* all other modes are unsupported by the hardware */
> +               ret = -EINVAL;
> +       }
> +

>
>        reg = snd_soc_read(codec, CS4270_MODE);
>        reg &= ~(CS4270_MODE_SPEED_MASK | CS4270_MODE_DIV_MASK);
> -       reg |= cs4270_mode_ratios[i].speed_mode | cs4270_mode_ratios[i].mclk;
> +       reg |= cs4270_mode_ratios[i].mclk;
> +
> +       if (cs4270->slave_mode)
> +               reg |= CS4270_MODE_SLAVE;
> +       else
> +               reg |= cs4270_mode_ratios[i].speed_mode;

Are you sure that the mclk bits are still correct in slave mode?  I'm
looking at table 5 in the CS4270 manual, and it lists settings for
1x,2x,4x speed even though the register is set to slave mode instead.

-- 
Timur Tabi
Linux kernel developer at Freescale
