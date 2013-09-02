From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 00/14] SPDIF support
Date: Mon, 2 Sep 2013 15:16:31 +0100
Message-ID: <20130902141631.GV6617@n2100.arm.linux.org.uk>
References: <20130901123433.GR6617@n2100.arm.linux.org.uk>
 <20130902140632.GQ3084@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id 19B4026518A
 for <alsa-devel@alsa-project.org>; Mon,  2 Sep 2013 16:16:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20130902140632.GQ3084@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Jason Cooper <jason@lakedaemon.net>, Jean-Francois Moine <moinejf@free.fr>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 02, 2013 at 03:06:32PM +0100, Mark Brown wrote:
> On Sun, Sep 01, 2013 at 01:34:33PM +0100, Russell King - ARM Linux wrote:
> > This is where those who are using mainline kernels with DT on Dove
> > platforms (like Jean-Francois and Sebastian) need a working solution to
> > this in a form which they can come up with a representative DT solution.
> > This is not a one-person effort - there's multiple efforts working on
> > this, and it's all inter-linked.
> 
> Yes, and this is one of the reasons for suggesting getting either/or
> support merged - it will help things like the binding definition
> progress (as well as being useful for any users with a S/PDIF only
> system).

Sorry, but I believe the exact opposite:

1. The DAI link binding created for a dual-DAI driver is completely
   different from the DAI link binding for a DPCM driver.  The dual
   DAI link binding will have to be completely rewritten when the
   driver is converted to DPCM.

2. When the driver is converted to DPCM, it must use DPCM for
   everything, otherwise it has no way to know which of SPDIF or I2S to
   enable.  The only way I know to work around that is to add additional
   routes to link up the AIF widgets, and that's the solution you're all
   telling me is not acceptable, as per the patch set at the start of
   this thread.
