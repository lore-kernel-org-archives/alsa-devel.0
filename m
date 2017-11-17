From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v7 04/13] slimbus: core: Add slim controllers support
Date: Fri, 17 Nov 2017 10:12:22 +0530
Message-ID: <20171117044222.GK3187@localhost>
References: <20171115141043.29202-1-srinivas.kandagatla@linaro.org>
 <20171115141043.29202-5-srinivas.kandagatla@linaro.org>
 <20171116164233.GB3187@localhost>
 <55794ca5-b70a-4866-1e80-bc0e78880c50@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55794ca5-b70a-4866-1e80-bc0e78880c50@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, gregkh@linuxfoundation.org
Cc: broonie@kernel.org, alsa-devel@alsa-project.org, sdharia@codeaurora.org, bp@suse.de, poeschel@lemonage.de, treding@nvidia.com, andreas.noever@gmail.com, alan@linux.intel.com, mathieu.poirier@linaro.org, daniel@ffwll.ch, jkosina@suse.cz, sharon.dvir1@mail.huji.ac.il, joe@perches.com, davem@davemloft.net, james.hogan@imgtec.com, michael.opdenacker@free-electrons.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, arnd@arndb.de
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 16, 2017 at 05:29:35PM +0000, Srinivas Kandagatla wrote:
> thanks for the comments.
> 
> 
> On 16/11/17 16:42, Vinod Koul wrote:
> >On Wed, Nov 15, 2017 at 02:10:34PM +0000, srinivas.kandagatla@linaro.org wrote:
> >
> >>+static void slim_dev_release(struct device *dev)
> >>+{
> >>+	struct slim_device *sbdev = to_slim_device(dev);
> >>+
> >>+	put_device(sbdev->ctrl->dev);
> >
> >which device would that be?
> This is controller device
> 
> >
> >>+static int slim_add_device(struct slim_controller *ctrl,
> >>+			   struct slim_device *sbdev,
> >>+			   struct device_node *node)
> >>+{
> >>+	sbdev->dev.bus = &slimbus_bus;
> >>+	sbdev->dev.parent = ctrl->dev;
> >>+	sbdev->dev.release = slim_dev_release;
> >>+	sbdev->dev.driver = NULL;
> >>+	sbdev->ctrl = ctrl;
> >>+
> >>+	dev_set_name(&sbdev->dev, "%x:%x:%x:%x",
> >>+				  sbdev->e_addr.manf_id,
> >>+				  sbdev->e_addr.prod_code,
> >>+				  sbdev->e_addr.dev_index,
> >>+				  sbdev->e_addr.instance);
> >>+
> >>+	get_device(ctrl->dev);
> >
> >is this controller device and you ensuring it doesnt go away while you have
> >slaves on it?
> 
> Yes.

I thought since you are marking ctrl->dev as parent, the device core should
ensure that parent doesn't go off when you have child device?

Greg, is that understanding correct, if so we may not need these calls.

-- 
~Vinod
