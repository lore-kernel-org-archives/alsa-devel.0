From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: snd-soc-cs4270: Convert to a new-style i2c
	driver	(work in progress)
Date: Sun, 31 Aug 2008 18:17:41 +0100
Message-ID: <20080831171741.GA6790@sirena.org.uk>
References: <20080831161843.227b31f3@hyperion.delvare>
	<ed82fe3e0808310928v18eed8bdh98faa6796a516142@mail.gmail.com>
	<20080831190928.2931b0ed@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id C4FB924369
	for <alsa-devel@alsa-project.org>;
	Sun, 31 Aug 2008 19:17:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080831190928.2931b0ed@hyperion.delvare>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jean Delvare <khali@linux-fr.org>
Cc: alsa-devel@alsa-project.org, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Sun, Aug 31, 2008 at 07:09:28PM +0200, Jean Delvare wrote:
> On Sun, 31 Aug 2008 11:28:08 -0500, Timur Tabi wrote:

> > I don't know why this commit hasn't been pushed upstream, though.

> As I understand it, without that patch the mpc8610_hpcd doesn't work,
> as the I2C address of the sound codec will be made busy by the platform
> code and thus the snd-soc-cs4270 driver won't be able to attach to it.
> If I am correct then I suggest that you ask Takashi to push the patch
> to Linus now to fix that.

Yeah, AFAICR it wasn't made clear when this was posted that it was a bug
fix.

> > That's correct.  I've never seen any interest in the CS4270 outside of
> > Freescale.

That's not entirely suprising - the vast majority of embedded devices
never go anywhere near mainline so it tends to only be reference boards
and devices with some sort of public community that have activity that's
visible upstream.

> Very good point indeed. I'll make sure to check Takashi's sound-2.6
> tree before attempting to convert any other SoC codec driver. Do you
> know off the top of your head if other drivers have already been
> converted?

None - the only other one is Takashi's current tree is WM8903.
