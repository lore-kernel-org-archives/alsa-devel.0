From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 02/13] mfd: wcd9335: add support to wcd9335 core
Date: Wed, 12 Sep 2018 09:58:48 +0100
Message-ID: <20180912085848.GP4185@dell>
References: <20180904102500.30318-1-srinivas.kandagatla@linaro.org>
 <20180904102500.30318-3-srinivas.kandagatla@linaro.org>
 <20180911153340.GY4185@dell>
 <94c68436-b618-40fc-46d6-165799312289@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <94c68436-b618-40fc-46d6-165799312289@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: robh+dt@kernel.org, broonie@kernel.org, mark.rutland@arm.com, lgirdwood@gmail.com, bgoswami@codeaurora.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, vkoul@kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 12 Sep 2018, Srinivas Kandagatla wrote:
> On 11/09/18 16:33, Lee Jones wrote:
> > On Tue, 04 Sep 2018, Srinivas Kandagatla wrote:
> > 
> > > Qualcomm WCD9335 Codec is a standalone Hi-Fi audio codec IC,
> > > It has mulitple blocks like Soundwire controller, codec,
> > > Codec processing engine, ClassH controller, interrupt mux.
> > > It supports both I2S/I2C and SLIMbus audio interfaces.
> > > 
> > > This patch adds support to SLIMbus audio interface.
> > > 
> > > Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > > Reviewed-by: Vinod Koul <vkoul@kernel.org>
> > > ---
> > >   drivers/mfd/Kconfig                   |  14 +
> > >   drivers/mfd/Makefile                  |   4 +
> > >   drivers/mfd/wcd9335-core.c            | 291 ++++++++++++
> > >   include/linux/mfd/wcd9335/registers.h | 627 ++++++++++++++++++++++++++
> > >   include/linux/mfd/wcd9335/wcd9335.h   |  32 ++
> > >   5 files changed, 968 insertions(+)
> > >   create mode 100644 drivers/mfd/wcd9335-core.c
> > >   create mode 100644 include/linux/mfd/wcd9335/registers.h
> > >   create mode 100644 include/linux/mfd/wcd9335/wcd9335.h
[...]

> > > +static const struct mfd_cell wcd9335_devices[] = {
> > > +	{ .name = "wcd9335-codec", },
> > > +};
> > 
> > Are there more devices to come?
> > 
> Yes, that is the plan, we are kind of limited in hardware setup to test few
> things like soundwire controller. We are exploring other ways to test these.

I normally don't accept MFDs with just one device enabled.  Since it's
not really an MFD (M == Multi) until it has more than one function.

[...]

> > > +	struct device_node *ifc_dev_np;
> > 
> > ifc isn't very forthcoming.  Any way you can improve the name?
> ifc was suggested in dt bindings by Rob,  I can proably rename to
> interface_node.

ifc is a horrible variable name - just sayin'.

[...]

> > > +	ret = wcd9335_bring_up(wcd);
> > 
> > So the device_status call-back brings up the hardware?
> > 
> 
> device status reports the device status at runtime. We can not communicate
> with the device until it is up, enumerated by slimbus and a logical address
> is assigned to it. So the best place to initialize it is in status callback
> where all the above are expected to be done.

Right, I understand what's happening.  I just think the semantics are
wrong.  The Subsystem (I'm assuming it's a Subsystem) requests for
status and it ends up initiating a start-up sequence.  Just from a
purist's point of view (I understand that it "works"), it's not good
practice.

> Probe is expected to setup the external configurations like regulators/pins
> and so on which gets the device out of reset and ready to be enumerated by
> the slimbus controller.

I suggest fully starting the device in probe() is a better approach.

[...]

> > > +struct wcd9335 {
> > > +	int version;
> > > +	int intr1;
> > 
> > What's this?  If I have to ask, it's probably not a good name.
> > 
> This is a hardware pin name for interrupt line 1.

I don't see how this is used, so it's difficult for me to advise
fully, but I find this confusing.  Pin name/number?  Shouldn't this be
handed by Pinctrl?

intr1 could be quite ambiguous.  Especually as the '1' could easily be
read as an 'l'.  Suggest that 'irq1' or 'irq_1' or 'irq_one'.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
