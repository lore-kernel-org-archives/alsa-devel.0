From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 03/12] add a mc13783 codec driver
Date: Wed, 25 Nov 2009 12:30:34 +0100
Message-ID: <20091125113034.GD27548@pengutronix.de>
References: <1258645706-9071-1-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-2-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-3-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-4-git-send-email-s.hauer@pengutronix.de>
	<20091119193008.GC2814@sirena.org.uk>
	<20091125074631.GB27548@pengutronix.de>
	<20091125103959.GB17420@opensource.wolfsonmicro.com>
	<20091125110854.GC27548@pengutronix.de>
	<20091125111037.GE17420@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 5EC8524399
	for <alsa-devel@alsa-project.org>; Wed, 25 Nov 2009 12:30:37 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20091125111037.GE17420@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 25, 2009 at 11:10:37AM +0000, Mark Brown wrote:
> On Wed, Nov 25, 2009 at 12:08:54PM +0100, Sascha Hauer wrote:
> > On Wed, Nov 25, 2009 at 10:39:59AM +0000, Mark Brown wrote:
> 
> > > What are "primary" and "secondary" here?  If they are broadly unrelated
> > > except for the clocking (which is what this sounds like) then they
> > > probably should be handled as separate DAIs.
> 
> > I thought about this, but can I do stereo with two seperate DAIs?
> 
> Again, what are "primary" and "secondary"?

Please have a look at page 3 of:

http://www.freescale.com/files/rf_if/doc/data_sheet/MC13783.pdf

Maybe this explains best the situation we have here.
Right in the middle of the diagram you see the A/D converters in the
Voice Codec. As you see it has two monaural A/D converters. One of them
is the primary, the other is the secondary converter (don't ask me which
of them is which, I'd had to lookup myself)
The input sources of these ADCs can't be controlled completely
independent and they are designed to be used for example with two
microphones in a mobile phone. (I guess that's why they call them
'primary' and 'secondary', not 'left' and 'right'). But of course you
can also do stereo with them.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
