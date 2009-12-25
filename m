From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH] ASoC: fsi-ak4642: Remove
	ak4642_add_i2c_device
Date: Fri, 25 Dec 2009 09:45:02 +0900
Message-ID: <20091225004502.GA32097@linux-sh.org>
References: <ur5qychhv.wl%morimoto.kuninori@renesas.com>
	<20091214114119.GE21066@rakim.wolfsonmicro.main>
	<uljh59k1j.wl%morimoto.kuninori@renesas.com>
	<6D292CE0-15AA-4990-9042-0381EDC07570@opensource.wolfsonmicro.com>
	<u637wx5nk.wl%morimoto.kuninori@renesas.com>
	<20091224114017.GA11850@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from master.linux-sh.org (124x34x33x190.ap124.ftth.ucom.ne.jp
	[124.34.33.190])
	by alsa0.perex.cz (Postfix) with ESMTP id CA2631037F3
	for <alsa-devel@alsa-project.org>; Fri, 25 Dec 2009 01:45:22 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20091224114017.GA11850@opensource.wolfsonmicro.com>
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
Cc: Kuninori Morimoto <morimoto.kuninori@renesas.com>, Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 24, 2009 at 11:40:18AM +0000, Mark Brown wrote:
> On Thu, Dec 24, 2009 at 03:11:43PM +0900, Kuninori Morimoto wrote:
> 
> > > No problem, feel free to add my ack to the combined patch.
> 
> > I sent patch which is for SuperH platform, and Paul already applied it.
> > I can find it on latest linus git (9f815a1765b0ce766ab1d26ef192d30410f70b2b).
> > So sorry, can you please re-check this email ?
> > [fsi-ak4642: Remove ak4642_add_i2c_device]
> 
> Oh, what a shame.  I'll apply the patch.

I missed the rest of this discussion, but if your conerns are about
bisection, it's not an issue in this case. Board patches that add i2c or
platform device data with no unmet dependencies I usually merge early.
The main rationale for this is that the driver often shows up quite a bit
later, and the board code will likely have had more paches piled up on
top of it and merge conflicts ensue.

For patches that depend on headers and definitions added by the driver
patch, we either apply them together, or I just hold off on the board
patch until the driver is upstream. patchwork helps keep track of the
ones that are still pending at least. These sorts of ordering issues
happen a lot, but are generally always resolved by rc2.
