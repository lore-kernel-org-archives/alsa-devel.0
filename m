From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [alsa-devel] [PATCH 00/14] SPDIF support
Date: Sat, 31 Aug 2013 20:19:56 +0100
Message-ID: <20130831191956.GH6617@n2100.arm.linux.org.uk>
References: <20130831123458.GF6617@n2100.arm.linux.org.uk>
 <52220B9A.9000007@metafoo.de> <20130831172853.GL18608@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20130831172853.GL18608@sirena.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Brown <broonie@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Jason Cooper <jason@lakedaemon.net>, Jean-Francois Moine <moinejf@free.fr>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Sat, Aug 31, 2013 at 06:28:53PM +0100, Mark Brown wrote:
> On Sat, Aug 31, 2013 at 05:28:26PM +0200, Lars-Peter Clausen wrote:
> 
> > Then connect the SPDIF AIF widgets to the SPDIF streams and the I2S AIF
> > widgets to the I2S streams. In your machine driver setup the link config to
> > use DAI 0 if the board uses I2S and DAI 1 if the board uses SPDIF. The ASoC
> > framework will then create the necessary routes all by itself. Of course
> > this won't work on a platform where both the SPDIF and I2S controller are
> > used at the same time, but neither does your current solution.
> 
> This is the either/or approach I've been suggesting.

Ah, here we go again.  This is precisely why I can't work with you.
Nothing I say seems to stick in your mind.  I've been telling you for the
last four weeks that it doesn't work - and I've shown you the oopses and
warnings I get from trying it.  Your response to date: nothing of any
real use.

If you're not going to provide any useful responses on bug reports, it is
totally unreasonable that you even suggest that _that_ is how it should
be done when I've already proved that it's impossible at present.
