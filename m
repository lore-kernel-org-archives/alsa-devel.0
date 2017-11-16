From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v7 04/13] slimbus: core: Add slim
	controllers support
Date: Thu, 16 Nov 2017 22:12:33 +0530
Message-ID: <20171116164233.GB3187@localhost>
References: <20171115141043.29202-1-srinivas.kandagatla@linaro.org>
 <20171115141043.29202-5-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id AC20C266EE4
 for <alsa-devel@alsa-project.org>; Thu, 16 Nov 2017 17:39:19 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20171115141043.29202-5-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: srinivas.kandagatla@linaro.org
Cc: mark.rutland@arm.com, alsa-devel@alsa-project.org, michael.opdenacker@free-electrons.com, poeschel@lemonage.de, andreas.noever@gmail.com, arnd@arndb.de, treding@nvidia.com, devicetree@vger.kernel.org, james.hogan@imgtec.com, pawel.moll@arm.com, linux-arm-msm@vger.kernel.org, sharon.dvir1@mail.huji.ac.il, robh+dt@kernel.org, sdharia@codeaurora.org, alan@linux.intel.com, bp@suse.de, mathieu.poirier@linaro.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, broonie@kernel.org, daniel@ffwll.ch, jkosina@suse.cz, joe@perches.com, davem@davemloft.net
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 15, 2017 at 02:10:34PM +0000, srinivas.kandagatla@linaro.org wrote:

> +static void slim_dev_release(struct device *dev)
> +{
> +	struct slim_device *sbdev = to_slim_device(dev);
> +
> +	put_device(sbdev->ctrl->dev);

which device would that be?

> +static int slim_add_device(struct slim_controller *ctrl,
> +			   struct slim_device *sbdev,
> +			   struct device_node *node)
> +{
> +	sbdev->dev.bus = &slimbus_bus;
> +	sbdev->dev.parent = ctrl->dev;
> +	sbdev->dev.release = slim_dev_release;
> +	sbdev->dev.driver = NULL;
> +	sbdev->ctrl = ctrl;
> +
> +	dev_set_name(&sbdev->dev, "%x:%x:%x:%x",
> +				  sbdev->e_addr.manf_id,
> +				  sbdev->e_addr.prod_code,
> +				  sbdev->e_addr.dev_index,
> +				  sbdev->e_addr.instance);
> +
> +	get_device(ctrl->dev);

is this controller device and you ensuring it doesnt go away while you have
slaves on it?

> +static struct slim_device *slim_alloc_device(struct slim_controller *ctrl,
> +					     struct slim_eaddr *eaddr,
> +					     struct device_node *node)
> +{
> +	struct slim_device *sbdev;
> +	int ret;
> +
> +	sbdev = kzalloc(sizeof(struct slim_device), GFP_KERNEL);

Usual kernel way of doing is kzalloc(*sbdev)

> +void slim_report_absent(struct slim_device *sbdev)
> +{
> +	struct slim_controller *ctrl = sbdev->ctrl;
> +
> +	if (!ctrl)
> +		return;
> +
> +	/* invalidate logical addresses */
> +	mutex_lock(&ctrl->lock);
> +	sbdev->is_laddr_valid = false;
> +	mutex_unlock(&ctrl->lock);
> +
> +	ida_simple_remove(&ctrl->laddr_ida, sbdev->laddr);
> +	slim_device_update_status(sbdev, SLIM_DEVICE_STATUS_DOWN);
> +}
> +EXPORT_SYMBOL_GPL(slim_report_absent);

Do you have APIs for report present too, if so why not add te status in
argument as you may have common handling

> +static int slim_device_alloc_laddr(struct slim_device *sbdev,
> +				   u8 *laddr, bool report_present)
> +{
> +	struct slim_controller *ctrl = sbdev->ctrl;
> +	int ret;
> +
> +	mutex_lock(&ctrl->lock);
> +	if (ctrl->get_laddr) {
> +		ret = ctrl->get_laddr(ctrl, &sbdev->e_addr, laddr);
> +		if (ret < 0)
> +			goto err;
> +	} else if (report_present) {
> +		ret = ida_simple_get(&ctrl->laddr_ida,
> +				     0, SLIM_LA_MANAGER - 1, GFP_KERNEL);
> +		if (ret < 0)
> +			goto err;
> +
> +		*laddr = ret;
> +	} else {
> +		ret = -EINVAL;
> +		goto err;
> +	}
> +
> +	if (ctrl->set_laddr) {
> +		ret = ctrl->set_laddr(ctrl, &sbdev->e_addr, *laddr);
> +		if (ret) {
> +			ret = -EINVAL;
> +			goto err;
> +		}
> +	}
> +
> +	sbdev->laddr = *laddr;

if you have this in sbdev, then why have this as an arg also?

> +	sbdev->is_laddr_valid = true;

shouldn't non-zero value signify that?

-- 
~Vinod
