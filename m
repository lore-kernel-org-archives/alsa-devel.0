From: Jean Delvare <khali@linux-fr.org>
Subject: Re: snd-soc-cs4270: Convert to a new-style i2c driver
 (work in progress)
Date: Wed, 3 Sep 2008 22:44:02 +0200
Message-ID: <20080903224402.4d794c95@hyperion.delvare>
References: <20080831161843.227b31f3@hyperion.delvare>
	<ed82fe3e0808310928v18eed8bdh98faa6796a516142@mail.gmail.com>
	<20080831190928.2931b0ed@hyperion.delvare>
	<ed82fe3e0809031247t3085e409x3141f9712ad962a9@mail.gmail.com>
	<ed82fe3e0809031330s5036e9d0g1c2b3e73096f2a6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	by alsa0.perex.cz (Postfix) with ESMTP id E49FE10380D
	for <alsa-devel@alsa-project.org>;
	Wed,  3 Sep 2008 22:44:15 +0200 (CEST)
In-Reply-To: <ed82fe3e0809031330s5036e9d0g1c2b3e73096f2a6@mail.gmail.com>
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

On Wed, 3 Sep 2008 15:30:33 -0500, Timur Tabi wrote:
> On Wed, Sep 3, 2008 at 2:47 PM, Timur Tabi <timur@freescale.com> wrote:
> > I'm working on a fix for this, but there's something you need to know.
> >  I don't think ASoC V1 modules can be unloaded.
> 
> Correction: ASoC drivers can't be compiled as modules, not even the
> codec drivers.  I had to hack up the Kconfigs to get this to work, but
> there is no way to compile the drivers as modules.  If you try, you
> get this:
> 
>   CC [M]  sound/soc/codecs/cs4270.o
>   LD [M]  sound/soc/codecs/snd-soc-cs4270.o
> ...
> sound/built-in.o: In function `mpc8610_hpcd_probe':
> /temp/alsa.1994/sound/soc/fsl/mpc8610_hpcd.c:455: undefined reference
> to `cs4270_dai'
> /temp/alsa.1994/sound/soc/fsl/mpc8610_hpcd.c:455: undefined reference
> to `cs4270_dai'
> /temp/alsa.1994/sound/soc/fsl/mpc8610_hpcd.c:469: undefined reference
> to `soc_codec_device_cs4270'
> /temp/alsa.1994/sound/soc/fsl/mpc8610_hpcd.c:469: undefined reference
> to `soc_codec_device_cs4270'
> make: *** [.tmp_vmlinux1] Error 1
> 
> So I don't see how an I2C 'remove' function would ever be called
> anyway.  If you can show me how, I'll add it.

By writing to the unbind file that the i2c driver in question exposes
in /sys? I didn't try it but it should cause the driver to unbind from
the device in question and thus ->remove would be called.

Note that I do not care much myself. I mentioned the lack of a remove
function merely because the driver could be build as a module and
because the original code did have an equivalent function. If you are
confident that the code isn't needed or you decide that you don't care,
up to you. I am really not familiar with the ASoC drivers so I don't
think my view really matters.

> Now, the ASoC V2 driver can be loaded and unloaded, and I'm pretty
> sure I have bugs there.


-- 
Jean Delvare
