From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: Re: [PATCH] sound/sgtl5000: fix codec register initial
 values and mask
Date: Tue, 11 Jun 2013 09:20:24 -0300
Message-ID: <51B71608.3000302@freescale.com>
References: <1370938320-6554-1-git-send-email-oskar@scara.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe003.messaging.microsoft.com [207.46.163.26])
 by alsa0.perex.cz (Postfix) with ESMTP id A0670261A93
 for <alsa-devel@alsa-project.org>; Tue, 11 Jun 2013 14:21:06 +0200 (CEST)
In-Reply-To: <1370938320-6554-1-git-send-email-oskar@scara.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oskar Schirmer <oskar@scara.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Wolfram Sang <w.sang@pengutronix.de>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Zeng Zhaoming <zengzm.kernel@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: alsa-devel@alsa-project.org

Hi Oskar,

On 06/11/2013 05:12 AM, Oskar Schirmer wrote:
> According to documentation bit 3:2 in register SSS_CTRL are
> reserved and zero, so initially setting the register to 0x0008
> does not make much sense. Instead, bit 4 should be marked set,
> as this is the power up default.
>
> Further, mask computation in declarative part is obviously wrong:
> Fix FRAC DIVISOR to provide an 11 bit mask correctly.
>
> Signed-off-by: Oskar Schirmer <oskar@scara.com>

Please rebase your patch against Mark Brown's topic/sgtl5000 branch:

https://git.kernel.org/cgit/linux/kernel/git/broonie/sound.git/log/?h=topic/sgtl5000

After that, you can add my:

Tested-by: Fabio Estevam <fabio.estevam@freescale.com>
