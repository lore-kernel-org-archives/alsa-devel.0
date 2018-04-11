From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH 2/2] ASoC: AMD: Enable/Disable auxiliary
 clock via common clock framework
Date: Wed, 11 Apr 2018 18:14:06 +0000
Message-ID: <CAGS+omAzSmUsL5wEkK1WS6u39RxpYY0HYtS7j=-as8gyL02juQ@mail.gmail.com>
References: <1522404297-7555-1-git-send-email-akshu.agrawal@amd.com>
 <1522404297-7555-2-git-send-email-akshu.agrawal@amd.com>
 <CAGS+omDqWEjEm0b3H5-pwd2Nrf_pEbQTAU_dPKVmXi5vsDxKLw@mail.gmail.com>
 <cc2ee422-edf6-5a01-1482-8152d896b1b3@amd.com>
 <CAGS+omCLJnXcqL=r7ijp+csk7_dBko0pyBG9MHtPPGAd2AgJgA@mail.gmail.com>
 <341e4879-ec6b-8ea9-dd97-a79e4508f8e1@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vk0-f68.google.com (mail-vk0-f68.google.com
 [209.85.213.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 97D72266E30
 for <alsa-devel@alsa-project.org>; Wed, 11 Apr 2018 20:14:20 +0200 (CEST)
Received: by mail-vk0-f68.google.com with SMTP id q198so1662397vke.3
 for <alsa-devel@alsa-project.org>; Wed, 11 Apr 2018 11:14:19 -0700 (PDT)
In-Reply-To: <341e4879-ec6b-8ea9-dd97-a79e4508f8e1@amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Akshu Agrawal <Akshu.Agrawal@amd.com>
Cc: tiwai@suse.de, Alexander.Deucher@amd.com, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 11, 2018 at 4:08 AM Agrawal, Akshu <Akshu.Agrawal@amd.com>
wrote:



> On 4/10/2018 11:13 AM, Daniel Kurtz wrote:
> >> On 4/4/2018 12:27 AM, Daniel Kurtz wrote:
> >>> Hi Akshu,
> >>>
> >>> On Fri, Mar 30, 2018 at 4:05 AM Akshu Agrawal <akshu.agrawal@amd.com>
> > wrote:
> >>>
> >>>> This enables/disables and sets auxiliary clock at 25Mhz. It uses
> >>>> common clock framework for proper ref counting. This approach will
> >>>> save power in comparison to keeping it always On in firmware.
> >>>
> >>> I have some general concern with the approach in this patch:
> >>>
> >>> (1) The 25 MHz clock being created here is a general system clock
> >>> resource.  I think it should be created in an SoC clock driver, rather
> > than
> >>> here in an audio machine driver.   This has several advantages:
> >>>      (a) the clock resource would be available for other boards that
use
> > it but
> >>> don't use this particular audio machine driver
> >>>      (b) the clock would be instantiated at boot, rather than at
machine
> > driver
> >>> load.
> >>>      (c) the machine driver would not then need the additional clkdev
> > code
> >>>
> >>> (2) The oscout1 clock is a pretty standard clk_gate with a clk_mux.
We
> > can
> >>> use some standard helpers to better model the clock tree rather than
> >>> rewriting them:
> >>>
> >>> static struct clk *clk_48m;
> >>> static struct clk *clk_25m;
> >>> static struct clk *clk_oscout1_mux;
> >>> static struct clk *clk_oscout1;
> >>>
> >>> static const char *clk_oscout1_parents[] = { "clk48MHz", "clk25MHz" };
> >>>
> >>> {
> >>>       clk_48m = clk_register_fixed_rate(dev, "clk48MHz", NULL, 0,
> > 48000000);
> >>>       clk_25m = clk_register_fixed_rate(dev, "clk25MHz", NULL, 0,
> > 25000000);
> >>>
> >>>       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >>>       res_base = devm_ioremap_nocache(dev, res->start,
> > resource_size(res));
> >>>
> >>>       clk_oscout1_mux = clk_register_mux(dev, "oscout1_mux",
> >>>           clk_oscout1_parents, ARRAY_SIZE(clk_oscout1_parents),
> >>>           0, res_base + CLKDRVSTR2, OSCOUT1CLK25MHZ, 3, 0, NULL);
> >>>
> >>>       clk_set_parent(clk_oscout1_mux, clk_25m);
> >>>
> >>>       clk_oscout1 = clk_register_gate(dev, "oscout1", "oscout1_mux",
0,
> >>>             res_base + MISCCLKCNTL1, OSCCLKENB, 0, NULL);
> >>>
> >>>
> >>> (3) IIUC, the 25 MHz clock (oscout1) is actually the da7219's mclk.
The
> >>> da7219 already
> >>> has infrastructure to enable/disable its mclk as needed.  Once we
> > establish
> >>> the system clock,
> >>> we can then wire this clock up to the da7219 via ACPI / devicetree
> >>> properties.
> >>>
> >> The above design is something used in almost all ARM based platform
> >> where we define all mux, pll, divider and gate and then each device
uses
> >> them though the devicetree.
> >> The clock here are controlled in firmware. Enable/disable is handled in
> >> firmware, where this being the exception case. Hence, I don't think it
> >> will be of much value add.
> >
> > The value add to properly modeling the SoC's clock tree is highlighted
> > above.
> > In addition to making the code more understandable, and the SoC easier
to
> > use for other designs in the future, the clock tree as expressed via
> > debugfs (/sys/kernel/debug/clk/clk_summary) will make more sense.
> > In the particular case of the acp-da7219-max98357a.c machine driver and
> > da7219 codec driver, properly modeling the oscout1 clock tree as a
> > fixed_clks+mux+gate and then passing it to da7219 as its mclk will allow
> > the mclk driver to do what it expects using its existing code - set the
> > mclk rate (via oscout1's parent mux selector) and then enable/disable as
> > needed.
> >
> >> For ST/CZ we have other platforms which do not use this clock. They
have
> >> a dedicated Oscillator for the codec.
> >
> > Exactly, such platforms will just not use this machine driver and this
> > clock will be defined properly, but remain in the state programmed by
> > firmware.
> >
> >> If you think its beneficial for other platform based on ST/CZ then
maybe
> >> we can take this as a separate activity. Where we move the clocks to a
> >> common file and use the same framework.
> >
> > Moving the clock configuration out of acp-da7219-max98357a.c allows this
> > system clock to be available independent of when this machine driver
kernel
> > module is loaded.
> >

> I understand the advantages of having it moved to drivers/clk and also
> connecting it to d7219's mclk. This is good to have feature for other
> ST/CZ platforms. Would take it up this as a separate activity.

I don't think this is a separate activity.  It is an integral part of the
structure of this patch.  Let's fix it up now while we are actively
thinking about this driver.


> >>>
> >>> Enable on hw_params() and disable on hw_free() doesn't sound balanced?
> >>> Will there always be exactly one hw_free() for every hw_params()?
> >>>
> >> Yes, all resources allocated by hw_paramns are freed in hw_free.
> >
> > Right, but is it possible for hw_params() to get called mulitple times
> > *without* hw_free()?
> > This would cause more enables than disables.
> >
> > Documentation/sound/kernel-api/writing-an-alsa-driver.rst says:
> > """
> > Note that this and ``prepare`` callbacks may be called multiple times
> > per initialization. For example, the OSS emulation may call these
> > callbacks at each change via its ioctl.
> >
> > Thus, you need to be careful not to allocate the same buffers many
> > times, which will lead to memory leaks! Calling the helper function
> > above many times is OK. It will release the previous buffer
> > automatically when it was already allocated.
> > """
> >
> I get there is a remote possibility that hw_params maybe called multiple
> times without hw_free (though I haven't come across it in my testing).
> The other option was to use trigger. But, that is not possible as kernel
> crashes when we call clk_prepare_enable(da7219_dai_clk) from trigger
> registered to a non da7219 codec, like of max98357

Using trigger won't work because you are not guaranteed to have symetric
start/stop events.  In fact , there is a comment in the definition of
struct snd_soc_dai_ops that specifically says this:

/*
* NOTE: Commands passed to the trigger function are not necessarily
* compatible with the current state of the dai. For example this
* sequence of commands is possible: START STOP STOP.
* So do not unconditionally use refcounting functions in the trigger
* function, e.g. clk_enable/disable.
*/
int (*trigger)(struct snd_pcm_substream *, int, struct snd_soc_dai *);

Instead, can you try to use startup() / shutdown()?
Those callbacks are non-atomic and should correspond to open()/close() on
the corresponding audio device, which I think is what we want.

-Dan
