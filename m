From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v3 2/3] ALSA SoC: Add mpc5200-psc I2S driver
Date: Tue, 22 Jul 2008 17:23:17 -0400
Message-ID: <20080722212316.GC12412@secretlab.ca>
References: <20080722065352.7306.60679.stgit@trillian.secretlab.ca>
	<20080722065358.7306.9412.stgit@trillian.secretlab.ca>
	<20080722100951.GB2572@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qb-out-1314.google.com (qb-out-1314.google.com [72.14.204.175])
	by alsa0.perex.cz (Postfix) with ESMTP id 2C0051038C4
	for <alsa-devel@alsa-project.org>;
	Tue, 22 Jul 2008 23:23:41 +0200 (CEST)
Received: by qb-out-1314.google.com with SMTP id a29so3949229qbd.44
	for <alsa-devel@alsa-project.org>; Tue, 22 Jul 2008 14:23:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080722100951.GB2572@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, liam.girdwood@wolfsonmicro.com, jonsmirl@gmail.com, timur@freescale.com
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 22, 2008 at 11:09:52AM +0100, Mark Brown wrote:
> On Tue, Jul 22, 2008 at 12:53:58AM -0600, Grant Likely wrote:
> 
> > Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> 
> There's a few issues that were raised on the previous review cycle that
> still need to be addressed but they should be fixable in incremental
> patches (and easier to review that way):
> 
> > +static int psc_i2s_trigger(struct snd_pcm_substream *substream, int cmd)
> 
> > +		spin_lock_irqsave(&psc_i2s->lock, flags);
> > +		/* first make sure it is low */
> > +		while ((in_8(&regs->ipcr_acr.ipcr) & 0x80) != 0)
> > +			;
> > +		/* then wait for the transition to high */
> > +		while ((in_8(&regs->ipcr_acr.ipcr) & 0x80) == 0)
> > +			;
> 
> These loops should really have some sort of time limit on them,
> otherwise they'll lock hard if the expected events don't happen.  Given
> that in slave mode they're synchronising with an externally generated
> clock this is something that might happen in practice and should produce
> better diagnostics.

Yes, I hope to rework these two lines entirely.  I'm not happy with the
current implementation either.

> > +	default:
> > +		dev_dbg(psc_i2s->dev, "invalid command\n");
> > +		return -EINVAL;
> > +	}
> 
> I'd really expect to see the other possible triggers handled, even if
> the appropriate action is to silently ignore them, rather than having
> them generate an error message.

Okay, I'll do that.

g.
