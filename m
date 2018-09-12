From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 02/13] mfd: wcd9335: add support to wcd9335 core
Date: Wed, 12 Sep 2018 12:46:33 +0100
Message-ID: <20180912114633.GU4185@dell>
References: <20180904102500.30318-1-srinivas.kandagatla@linaro.org>
 <20180904102500.30318-3-srinivas.kandagatla@linaro.org>
 <20180911153340.GY4185@dell>
 <94c68436-b618-40fc-46d6-165799312289@linaro.org>
 <20180912085848.GP4185@dell>
 <b4ddfd10-360c-a844-8542-1f81a1cc9c6b@linaro.org>
 <20180912105941.GS4185@dell>
 <11f213e5-8c93-f75f-1b74-517f00cd9a96@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <11f213e5-8c93-f75f-1b74-517f00cd9a96@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: robh+dt@kernel.org, broonie@kernel.org, mark.rutland@arm.com, lgirdwood@gmail.com, bgoswami@codeaurora.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, vkoul@kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 12 Sep 2018, Srinivas Kandagatla wrote:
> On 12/09/18 11:59, Lee Jones wrote:
> > > On 12/09/18 09:58, Lee Jones wrote:
> > > > > > > +static const struct mfd_cell wcd9335_devices[] = {
> > > > > > > +	{ .name = "wcd9335-codec", },
> > > > > > > +};
> > > > > > Are there more devices to come?
> > > > > > 
> > > > > Yes, that is the plan, we are kind of limited in hardware setup to test few
> > > > > things like soundwire controller. We are exploring other ways to test these.
> > > > I normally don't accept MFDs with just one device enabled.  Since it's
> > > > not really an MFD (M == Multi) until it has more than one function.
> > > > 
> > > WCD9335 Codec hw itself has multiple hw blocks.
> > > 
> > > If the issue is about adding more entries to mfd cells then we should be
> > > able to add below entry:
> > > 
> > > 	{ .name = "wcd9335-soundwire-controller", },
> > > 
> > > Actual driver for soundwire controller is not something We can test with
> > > regular dragon boards, it needs special hw for smart speakers. Once we have
> > > that we can test and post the drivers for that.
> > > 
> > > Otherwise
> > > 
> > > Are you suggesting that I move everything to  sound/soc/codecs and then back
> > > to mfd once soundwire controller driver is added?
> > My preference would be for you to add at least one other (tested)
> > device.  However, in your case I know where you live, so I can throw
> > tomatoes at your house if you don't upstream more device support
> > promptly!;)
> > 
> > When will you be enabling more devices?  If the answer is 'never',
> > then creating an MFD is a waste of time.
> 
> Vinod Koul is exploring this and ATM we are trying to sort out the hw setup.
> Hopefully we should be sorted with Qcom help!

Okay.  Please keep me posted.

> > > > > > > +	ret = wcd9335_bring_up(wcd);
> > > > > > So the device_status call-back brings up the hardware?
> > > > > > 
> > > > > device status reports the device status at runtime. We can not communicate
> > > > > with the device until it is up, enumerated by slimbus and a logical address
> > > > > is assigned to it. So the best place to initialize it is in status callback
> > > > > where all the above are expected to be done.
> > > > Right, I understand what's happening.  I just think the semantics are
> > > > wrong.  The Subsystem (I'm assuming it's a Subsystem) requests for
> > > > status and it ends up initiating a start-up sequence.  Just from a
> > > > purist's point of view (I understand that it "works"), it's not good
> > > > practice.
> > > > 
> > > > > Probe is expected to setup the external configurations like regulators/pins
> > > > > and so on which gets the device out of reset and ready to be enumerated by
> > > > > the slimbus controller.
> > > > I suggest fully starting the device in probe() is a better approach.
> > > > 
> > > Its catch-22 situation, without device being powered up and reset correctly
> > > there is no way to enumerate it.
> > Isn't power-up and reset also done in probe()?
> > 
> > What am I missing?
> 
> There are two parts for device to be ready to talk at bus level:
> 1> power up and reset,
> 2> enumerate and assign a logical address by the slimbus controller.
> 
> First part as you said is already done in probe.
> When second part happens when status callback is invoked, that is when the
> slimdevice is ready for any kind of communication at bus level.

I see.  I still think it's hacky to conduct start-up procedures when
all the SS requested was status.  Perhaps it needs a new API call
init()?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
