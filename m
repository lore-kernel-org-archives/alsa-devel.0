From: Jean Delvare <khali@linux-fr.org>
Subject: Re: snd-soc-cs4270: Convert to a new-style i2c driver
 (work in progress)
Date: Sun, 31 Aug 2008 19:09:28 +0200
Message-ID: <20080831190928.2931b0ed@hyperion.delvare>
References: <20080831161843.227b31f3@hyperion.delvare>
	<ed82fe3e0808310928v18eed8bdh98faa6796a516142@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	by alsa0.perex.cz (Postfix) with ESMTP id D055124562
	for <alsa-devel@alsa-project.org>;
	Sun, 31 Aug 2008 19:09:35 +0200 (CEST)
In-Reply-To: <ed82fe3e0808310928v18eed8bdh98faa6796a516142@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Timur,

On Sun, 31 Aug 2008 11:28:08 -0500, Timur Tabi wrote:
> On Sun, Aug 31, 2008 at 9:18 AM, Jean Delvare <khali@linux-fr.org> wrote:
> > Hi Tibur,
> 
> It's "Timur"

Oops, apparently I mixed your first name and last name. Sorry about
that.

> > I am in the process of converting your cs4270 codec driver from the
> > legacy i2c model to the new (standard) one.
> 
> It has already been converted.
> 
> http://git.kernel.org/?p=linux/kernel/git/tiwai/sound-2.6.git;a=commit;h=0daa075ea4905823ee7c2375d26bb134e5e74f74

Ah, excellent. One less thing for me to do :) Thanks!

Two comments about your patch:

* Your driver now lacks a remove method. Unless I miss something, if
the snd-soc-cs4270 driver is unloaded, you will leave dangling
resources behind (codec->reg_cache in particular.)

* I2C_DRIVERID_CS4270 must be removed from i2c-id.h.

> I don't know why this commit hasn't been pushed upstream, though.

As I understand it, without that patch the mpc8610_hpcd doesn't work,
as the I2C address of the sound codec will be made busy by the platform
code and thus the snd-soc-cs4270 driver won't be able to attach to it.
If I am correct then I suggest that you ask Takashi to push the patch
to Linus now to fix that.

> > This is work in progress.
> > The patch below converts the cs4270 driver itself. However we also need
> > to convert its users. As far as I can see there's only one user at this
> > point: mpc8610_hpcd.
> 
> That's correct.  I've never seen any interest in the CS4270 outside of
> Freescale.
> 
> > The problem is that this driver doesn't look like the other codec
> > drivers I have already converted. So, we need to add code to
> > instantiate the cs4270 i2c device, but I don't know where this should
> > happen. Given that the mpc8610_hpcd is apparently based on Open
> > Firmware, I guess that the i2c device should be instantiated directly
> > by the platform code. I see that the device is declared in
> > mpc8610_hpcd.dts, so maybe it's already done and my patch should work
> > already? What do you think?
> 
> I think you need to use the right git repository for your development. :-)

Very good point indeed. I'll make sure to check Takashi's sound-2.6
tree before attempting to convert any other SoC codec driver. Do you
know off the top of your head if other drivers have already been
converted?

Thanks,
-- 
Jean Delvare
