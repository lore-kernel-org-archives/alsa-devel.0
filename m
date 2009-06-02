From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: Please help in adding ams-delta support to ASoC
Date: Tue, 2 Jun 2009 20:32:14 +0300
Message-ID: <20090602203214.9edb786d.jhnikula__37548.5242730521$1243963946$gmane$org@gmail.com>
References: <4A1BEBE3.8010306@tis.icnet.pl>
	<20090527095949.51ed4b83.jhnikula@gmail.com>
	<200905272058.55404.jkrzyszt@tis.icnet.pl>
	<4A23CC97.1020209@tis.icnet.pl>
	<20090601210413.7678bf42.jhnikula@gmail.com>
	<20090602092252.10a57fda.jhnikula@gmail.com>
	<4A252A8E.9060602@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <4A252A8E.9060602@tis.icnet.pl>
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
Cc: linux-omap@vger.kernel.org, alsa-devel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, 02 Jun 2009 15:35:10 +0200
Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> wrote:

> I am not sure if this is of any importance, but with the old working 
> code, playing /dev/urandom to /dev/dsp I get only 3-4 DMA interrupts
> per second, while doing the same on a x86_64 via82cxxx results in
> 40-50 device interrupts per second.
> 
Looks like via specific since both OMAP3 Beagle and my desktop are
generating about 4 audio interrupts per second.

> I did not find any documentation on the codec itself, only on its 
> "master" modem chip cx81801. Regarding modem<->codec interface, there 
> were only pins with breif description specified for both chips,
> nothing more, as this interface was probably not intended for access
> from outside. From the codec side, it looks like this:
> 
> - Sleep (SLEEP); input
> - Master Clock (M_CLKIN); input
> - Serial Clock (M_SCK); output
> - Control (M_CNTRLSIN); input
> - Serial Frame Sync (M_STROBE); output
> - Serial Transmit Data (M_TXSIN); input
> - Serial Receive Data (M_RXOUT); output
> - Reset (POR); input
> 
> However, I can't tell which lines are switched from modem to mcbsp
> and which are kept connected to the modem chip all the time.
> Anyway, it looks like we can be sure that both bit clock and frame
> sync should come from codec to mcbsp. It is not clear for me if MCLK
> is really used by the codec, or it is possible that it gets its
> master clock from an other, modem related source, and if this does
> really matter.
> 
Hmm. Are there any possibility that ams_delta_latch2_write requires
working MCLK for latch change? I noticed that older implementation was
activating MCLK before latch and your ASoC patch does opposite. Sounds
a bit far but worth to try.

Probably you could use also older implementation to find out is the
MCLK required for codec by commenting out vc_mclk control.

> > At least one difference is that omap-mcbsp.c is constructing McBSP
> > register bits itself while older implementation was passing raw
> > register configuration from the board files. Probably you could try
> > to hack omap_mcbsp_dai_hw_params and pass the same register
> > settings there to see are there some missing bit in omap-mcbsp.c.
> 
> OK, I'll see if I know how to do this.
> 
Just hack the same "static struct omap_mcbsp_reg_cfg mcbsp_regs =
{ ..." in omap-mcbsp.c and pass that structure instead of
&mcbsp_data->regs to omap_mcbsp_config in omap_mcbsp_dai_hw_params.


-- 
Jarkko
