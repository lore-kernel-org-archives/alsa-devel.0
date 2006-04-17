From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH] ALSA driver for Yamaa AICA on Sega Dreamcast
Date: Mon, 17 Apr 2006 13:04:12 +0300
Message-ID: <20060417100412.GB8910@linux-sh.org>
References: <1145232784.12804.2.camel@localhost.localdomain> <20060417012913.GA16821@linux-sh.org> <1145267096.9238.6.camel@localhost.localdomain> <20060417095226.GA8910@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20060417095226.GA8910@linux-sh.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Adrian McMenamin <adrian@mcmen.demon.co.uk>, Alsa-devel <alsa-devel@lists.sourceforge.net>, linux-sh <linuxsh-dev@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 17, 2006 at 12:52:26PM +0300, Paul Mundt wrote:
> Then the G2 DMA ->get_residue() op needs to be fixed, as it's broken.
> Don't work against the subsystem, it knows what it's doing.
> 
> You might be better off getting rid of it entirely and seeing about
> getting the TEI working, you can check for completion and wake up
> accordingly in this case, which is what you ideally want anyways. The
> busy-loop in the generic dma_wait_for_completion() is a stupid hack for
> people that haven't fixed up their TEI handling yet, it's not intended
> for widespread use..
> 
What about something like this?

diff --git a/arch/sh/drivers/dma/dma-g2.c b/arch/sh/drivers/dma/dma-g2.c
index 5afab6f..277581e 100644
--- a/arch/sh/drivers/dma/dma-g2.c
+++ b/arch/sh/drivers/dma/dma-g2.c
@@ -49,7 +49,14 @@ static volatile struct g2_dma_info *g2_d
 
 static irqreturn_t g2_dma_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
-	/* FIXME: Do some meaningful completion work here.. */
+	struct dma_channel *chan = dev_id;
+	unsigned int chan_nr = chan->chan;
+	unsigned int bytes;
+
+	bytes = g2_dma->channel[chan_nr].size - g2_dma->status[chan_nr].size;
+	if (likely(bytes == 0))
+		wake_up(&chan->wait_queue);
+
 	return IRQ_HANDLED;
 }
 
@@ -133,10 +140,17 @@ static int g2_xfer_dma(struct dma_channe
 		 g2_dma->channel[chan_nr].xfer_enable);
 
 	return 0;
+}
+
+static int g2_get_dma_residue(struct dma_channel *chan)
+{
+	unsigned int chan_nr = chan->chan;
+	return g2_dma->channel[chan_nr].size - g2_dma->status[chan_nr].size;
 }
 
 static struct dma_ops g2_dma_ops = {
 	.xfer		= g2_xfer_dma,
+	.get_residue	= g2_get_dma_residue,
 };
 
 static struct dma_info g2_dma_info = {


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
