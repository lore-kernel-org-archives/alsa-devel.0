From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 02/13] mfd: wcd9335: add support to wcd9335 core
Date: Mon, 17 Sep 2018 02:08:20 +0100
Message-ID: <20180917010820.GB3900@dell>
References: <20180904102500.30318-1-srinivas.kandagatla@linaro.org>
 <20180904102500.30318-3-srinivas.kandagatla@linaro.org>
 <20180911153340.GY4185@dell>
 <94c68436-b618-40fc-46d6-165799312289@linaro.org>
 <20180912085848.GP4185@dell>
 <b4ddfd10-360c-a844-8542-1f81a1cc9c6b@linaro.org>
 <20180912105941.GS4185@dell>
 <11f213e5-8c93-f75f-1b74-517f00cd9a96@linaro.org>
 <20180912114633.GU4185@dell>
 <ffcf1b3a-b66c-6e0e-3e7a-da092e9d1894@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ffcf1b3a-b66c-6e0e-3e7a-da092e9d1894@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: robh+dt@kernel.org, broonie@kernel.org, mark.rutland@arm.com, lgirdwood@gmail.com, bgoswami@codeaurora.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, vkoul@kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 12 Sep 2018, Srinivas Kandagatla wrote:

> 
> > > 
> > > There are two parts for device to be ready to talk at bus level:
> > > 1> power up and reset,
> > > 2> enumerate and assign a logical address by the slimbus controller.
> > > 
> > > First part as you said is already done in probe.
> > > When second part happens when status callback is invoked, that is when the
> > > slimdevice is ready for any kind of communication at bus level.
> > 
> > I see.  I still think it's hacky to conduct start-up procedures when
> > all the SS requested was status.  Perhaps it needs a new API call
> > init()?
> 
> When we added these callbacks the purpose of this was to allow drivers to do
> specific setup/teardown.
> 
> AFIAU,

What does that mean?

> even-though if we add init(), SLIMbus would still call it just before
> or after status which to me is redundant ATM.
> Its up to slim driver what it exactly whats to do with status, in some cases
> this can involve setting up the device.

If you say so! ;)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
