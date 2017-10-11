From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [alsa-devel] [Patch v6 1/7] slimbus: Device management on SLIMbus
Date: Wed, 11 Oct 2017 09:37:41 +0530
Message-ID: <20171011040741.GE30097@localhost>
References: <20171006155136.4682-1-srinivas.kandagatla@linaro.org>
 <20171006155136.4682-2-srinivas.kandagatla@linaro.org>
 <20171010104509.GC30097@localhost>
 <fd966acd-a86c-5021-8a8b-ddf1508ab63e@linaro.org>
 <20171010164930.GD30097@localhost>
 <9e2bb2fa-b391-055e-407e-c93f43428840@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9e2bb2fa-b391-055e-407e-c93f43428840@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: gregkh@linuxfoundation.org, broonie@kernel.org, alsa-devel@alsa-project.org, mark.rutland@arm.com, michael.opdenacker@free-electrons.com, poeschel@lemonage.de, andreas.noever@gmail.com, gong.chen@linux.intel.com, arnd@arndb.de, kheitke@audience.com, bp@suse.de, devicetree@vger.kernel.org, james.hogan@imgtec.com, pawel.moll@arm.com, linux-arm-msm@vger.kernel.org, sharon.dvir1@mail.huji.ac.il, robh+dt@kernel.org, sdharia@codeaurora.org, alan@linux.intel.com, treding@nvidia.com, mathieu.poirier@linaro.org, jkosina@suse.cz, linux-kernel@vger.kernel.org, daniel@ffwll.ch, joe@perches.com, davem@davemloft.net
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 10, 2017 at 06:21:34PM +0100, Srinivas Kandagatla wrote:
> On 10/10/17 17:49, Vinod Koul wrote:

> >>>>+static int slim_device_probe(struct device *dev)
> >>>>+{
> >>>>+	struct slim_device	*sbdev;
> >>>>+	struct slim_driver	*sbdrv;
> >>>>+	int status = 0;
> >>>>+
> >>>>+	sbdev = to_slim_device(dev);
> >>>>+	sbdrv = to_slim_driver(dev->driver);
> >>>>+
> >>>>+	sbdev->driver = sbdrv;
> >>>>+
> >>>>+	if (sbdrv->probe)
> >>>>+		status = sbdrv->probe(sbdev);
> >>>>+
> >>>>+	if (status)
> >>>>+		sbdev->driver = NULL;
> >>>>+	else if (sbdrv->device_up)
> >>>>+		schedule_slim_report(sbdev->ctrl, sbdev, true);
> >>>
> >>>can you please explain what this is trying to do?
> >>
> >>It is scheduling a device_up() callback in workqueue for reporting
> >>discovered device.
> >
> >any reason for that? Would the device not announce itself on the bus and
> >then you can synchronously update the device.
> You are correct,  Device should announce itself in all cases. core should
> only call this callback only when device is announced, it does not make
> sense for this call in slim_device_probe(). Will remove it from here in next
> version.

Okay great. Btw do you need a notify being scheduled in those cases? I guess
your controller would get an interrupt and you will handle that in bottom
half and then cll this, so why not call in the bottom half?

> >>>>+/**
> >>>>+ * slim_register_controller: Controller bring-up and registration.
> ...
> >>>>+
> >>>>+	mutex_init(&ctrl->m_ctrl);
> >>>>+	ret = device_register(&ctrl->dev);
> >>>
> >>>one more device_register?? Can you explain why
> >>>
> >>
> >>This is a device for each controller.
> >
> >wont the controller have its own platform_device?
> 
> Reason could be that slim_register controller can be called from any code
> not just platform devices..

ah which cases would those be. I was expecting that you would have a
platform_device as a slimbus controller which would call slim_register?

-- 
~Vinod
