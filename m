From: Daniel Mack <zonque@gmail.com>
Subject: Re: Swapped channels issue on pxa-ssp based platforms
Date: Tue, 08 Nov 2011 12:46:40 +0100
Message-ID: <4EB916A0.6090602@gmail.com>
References: <4EB817FC.4000905@gmail.com> <4EB83D3B.2050906@ladisch.de>
	<20111108113930.GI25591@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id 20B6224399
	for <alsa-devel@alsa-project.org>; Tue,  8 Nov 2011 12:46:47 +0100 (CET)
Received: by bkat8 with SMTP id t8so284410bka.38
	for <alsa-devel@alsa-project.org>; Tue, 08 Nov 2011 03:46:46 -0800 (PST)
In-Reply-To: <20111108113930.GI25591@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Sven Neumann <s.neumann@raumfeld.com>, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>, Liam Girdwood <lrg@ti.com>, Haojian Zhuang <haojian.zhuang@marvell.com>
List-Id: alsa-devel@alsa-project.org

On 11/08/2011 12:39 PM, Mark Brown wrote:
> On Mon, Nov 07, 2011 at 09:19:07PM +0100, Clemens Ladisch wrote:
>> Daniel Mack wrote:
>
>>> I guess this is some sort of a race condition in the stream startup,
>>> and suspected sound/soc/pxa/pxa-ssp.c to lack some locking, so I added
>>> a spinlock around all register read-modify-write cycles. But that doesn't
>>> seem to be the reason.
>
>> I'd guess this is a race in the programming of the L/R clock signals;
>> try putting a lock/mutex about all the stream initialization code, and
>> maybe adding some delay.
>
> That's very unlikely to help, these issues are generally issues with the
> controller not being able to figure out which clock edge to start on
> properly and if there are problems here locking is unlikely to help -
> the issue is the two hardware blocks synchronizing with each other,
> usually with the clocks driven from an asynchronous domain.

Unfortunately, yes. We're currently trying to do some more investigation 
of the exact effects, see if we have swapped channels on both streams 
(which the "aplay | arecord" wouldn't unveil) etc.

Still, I wonder whether locking wouldn't be important in 
sound/soc/pxa/pxa-ssp.c, as all the per-substream functions actually 
operate on the registers of the ssp port that is shared between capture 
and playback. And the code does things like

         u32 sscr0 = pxa_ssp_read_reg(ssp, SSCR0);
         if (cpu_is_pxa25x() && ssp->type == PXA25x_SSP) {
                 sscr0 &= ~0x0000ff00;
                 sscr0 |= ((div - 2)/2) << 8; /* 2..512 */
         } else {
                 sscr0 &= ~0x000fff00;
                 sscr0 |= (div - 1) << 8;     /* 1..4096 */
         }
         pxa_ssp_write_reg(ssp, SSCR0, sscr0);

all over the place. I'm just curious whether there there is anything in 
the ASoC core that cares for this?



Thanks,
Daniel
