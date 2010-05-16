From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [patch 5/6] orion/kirkwood: Add i2s support
Date: Sun, 16 May 2010 18:31:09 +0100
Message-ID: <20100516173105.GC9830@opensource.wolfsonmicro.com>
References: <20100515152958.899927802@mandriva.com>
	<20100515153130.937921459@mandriva.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20100515153130.937921459@mandriva.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: apatard@mandriva.com
Cc: alsa-devel@alsa-project.org, nico@fluxnic.net, saeed@marvell.com, tbm@cyrius.com, linux-arm-kernel@lists.infradead.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Sat, May 15, 2010 at 05:30:03PM +0200, apatard@mandriva.com wrote:

> This patch enables support for the i2s controller available on orion/kirkwood platforms
> 
> Signed-off-by: Arnaud Patard <apatard@mandriva.com>

All looks sensible enough, CCing in Liam.  One thing...

> +	if (status & ~(ORION_INT_CAUSE_PLAY_BYTES | \
> +			ORION_INT_CAUSE_REC_BYTES)) {
> +		printk(KERN_WARNING "%s: unexpected interrupt %lx\n",
> +			__func__, status);
> +		return IRQ_HANDLED;
> +	}

Did the driver really handle the interrupt here?  It's not even written
an ack back so IRQ_NONE might be a better response (the problem with
using IRQ_NONE before was that the driver may have handled some transfer
interrupts before it got the empty status).
