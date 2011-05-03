From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2 v2] ASoC: soc-cache: block based	rbtree
	compression
Date: Tue, 3 May 2011 10:43:20 +0100
Message-ID: <20110503094319.GA27833@sirena.org.uk>
References: <1304339309-28820-1-git-send-email-dp@opensource.wolfsonmicro.com>
	<s5hoc3lrxaq.wl%tiwai@suse.de>
	<20110502144256.GA1656@opensource.wolfsonmicro.com>
	<s5hk4e9rwfm.wl%tiwai@suse.de>
	<20110502145814.GB1844@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id C4073103820
	for <alsa-devel@alsa-project.org>;
	Tue,  3 May 2011 11:43:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110502145814.GB1844@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@ti.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, May 02, 2011 at 03:58:14PM +0100, Dimitris Papastamos wrote:
> On Mon, May 02, 2011 at 04:47:41PM +0200, Takashi Iwai wrote:
> > Dimitris Papastamos wrote:

> > Right.  But does it buy so much, in comparison with the additional
> > complexity of the code?  That's my primary question.

> For some codecs, the register maps group together registers of similar
> functionality.  With an optimal block size or near optimal, there will
> be only one rbtree look up if we continually touch any of those
> registers.  This helps primarily when we sync the register map as well
> as during initialization.  I think the added code complexity is worth
> it.  I could perhaps send patches incrementally to simplify this
> further.

The other thing which Dimitris didn't mention here but which is much
more of a win is that for operations which work on large numbers of
registers like register cache restore having the registers grouped
together then if they're grouped together then you can normally do a
block I/O.  For the common case of I2C CODECs this means you can save
transmitting both the I2C device address and the register address for
the second and subsequent registers in a block you'll usually get more
than 100% bandwidth saving.
