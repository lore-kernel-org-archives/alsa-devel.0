From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Re: Re: [PATCH] ALSA driver for Yamaa AICA on Sega
	Dreamcast
Date: Mon, 17 Apr 2006 21:40:29 +0100
Message-ID: <1145306429.9244.30.camel@localhost.localdomain>
References: <1145232784.12804.2.camel@localhost.localdomain>
	 <20060417012913.GA16821@linux-sh.org>
	 <1145267096.9238.6.camel@localhost.localdomain>
	 <20060417095226.GA8910@linux-sh.org>  <20060417100412.GB8910@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linuxsh-dev-admin@lists.sourceforge.net>
In-Reply-To: <20060417100412.GB8910@linux-sh.org>
Sender: linuxsh-dev-admin@lists.sourceforge.net
Errors-To: linuxsh-dev-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linuxsh-dev>,
	<mailto:linuxsh-dev-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:linuxsh-dev@lists.sourceforge.net>
List-Help: <mailto:linuxsh-dev-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linuxsh-dev>,
	<mailto:linuxsh-dev-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linuxsh-dev>
To: Paul Mundt <lethal@linux-sh.org>
Cc: Alsa-devel <alsa-devel@lists.sourceforge.net>, linux-sh <linuxsh-dev@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 2006-04-17 at 13:04 +0300, Paul Mundt wrote:
> On Mon, Apr 17, 2006 at 12:52:26PM +0300, Paul Mundt wrote:
> > Then the G2 DMA ->get_residue() op needs to be fixed, as it's broken.
> > Don't work against the subsystem, it knows what it's doing.
> > 
> > You might be better off getting rid of it entirely and seeing about
> > getting the TEI working, you can check for completion and wake up
> > accordingly in this case, which is what you ideally want anyways. The
> > busy-loop in the generic dma_wait_for_completion() is a stupid hack for
> > people that haven't fixed up their TEI handling yet, it's not intended
> > for widespread use..
> > 
> What about something like this?
> 
> diff --git a/arch/sh/drivers/dma/dma-g2.c b/arch/sh/drivers/dma/dma-g2.c
> index 5afab6f..277581e 100644
> --- a/arch/sh/drivers/dma/dma-g2.c
> +++ b/arch/sh/drivers/dma/dma-g2.c
> @@ -49,7 +49,14 @@ static volatile struct g2_dma_info *g2_d
>  
>  static irqreturn_t g2_dma_interrupt(int irq, void *dev_id, struct pt_regs *regs)
>  {
> -	/* FIXME: Do some meaningful completion work here.. */
> +	struct dma_channel *chan = dev_id;
> +	unsigned int chan_nr = chan->chan;
> +	unsigned int bytes;
> +
> +	bytes = g2_dma->channel[chan_nr].size - g2_dma->status[chan_nr].size;
> +	if (likely(bytes == 0))
> +		wake_up(&chan->wait_queue);
> +
>  	return IRQ_HANDLED;
>  }
>  
> @@ -133,10 +140,17 @@ static int g2_xfer_dma(struct dma_channe
>  		 g2_dma->channel[chan_nr].xfer_enable);
>  
>  	return 0;
> +}
> +
> +static int g2_get_dma_residue(struct dma_channel *chan)
> +{
> +	unsigned int chan_nr = chan->chan;
> +	return g2_dma->channel[chan_nr].size - g2_dma->status[chan_nr].size;
>  }
>  
>  static struct dma_ops g2_dma_ops = {
>  	.xfer		= g2_xfer_dma,
> +	.get_residue	= g2_get_dma_residue,
>  };
>  
>  static struct dma_info g2_dma_info = {
> 
> 

Doesn't appear to be working (though I'll try some adjustments to see if
I can get it to work) ---


/ # cat aine-email.wav > /dev/dsp
Unable to handle kernel NULL pointer dereference at virtual address
00000010
pc = 8c15a466
*pde = 00000000
Oops: 0000 [#1]

Pid : 0, Comm:              swapper
PC is at g2_dma_interrupt+0x6/0x40
PC  : 8c15a466 SP  : 8c255e10 SR  : 400081f0 TEA : c01061c4    Not
tainted
R0  : 8c15a460 R1  : ffffffe3 R2  : 8c220aa8 R3  : 0000001f
R4  : 0000003f R5  : 00000000 R6  : 8c255e50 R7  : 00000005
R8  : 8c220aac R9  : 00000000 R10 : 00000000 R11 : 8c255e50
R12 : 0000003f R13 : 8c275a3c R14 : 8c03ab40
MACH: 0000020e MACL: 147ae314 GBR : 8c000000 PR  : 8c03ab92

Call trace:
[<8c03ab92>] handle_IRQ_event+0x52/0xe0
[<8c03aca0>] __do_IRQ+0x80/0x180
[<8c0081cc>] do_IRQ+0x2c/0x60
[<8c0081a0>] do_IRQ+0x0/0x60
[<8c005098>] ret_from_irq+0x0/0x10
[<8c0f5c4e>] memcpy+0x23a/0x28c
[<8c146a32>] rtl8139_poll+0x132/0x5c0
[<8c168120>] net_rx_action+0x60/0x180
[<8c01b95a>] __do_softirq+0x5a/0xe0
[<8c01ba26>] do_softirq+0x46/0x60
[<8c1e13a0>] schedule+0x0/0x840
[<8c0081a0>] do_IRQ+0x0/0x60
[<8c01bb46>] irq_exit+0x46/0x80
[<8c0081d2>] do_IRQ+0x32/0x60
[<8c005098>] ret_from_irq+0x0/0x10
[<8c0030a0>] default_idle+0x0/0x20
[<8c1e13a0>] schedule+0x0/0x840
[<8c0030aa>] default_idle+0xa/0x20
[<8c0030e4>] cpu_idle+0x24/0x60
[<8c015200>] printk+0x0/0x20
[<8c002028>] _stext+0x28/0x60

Kernel panic - not syncing: Aiee, killing interrupt handler!





-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
