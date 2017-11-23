From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v7 08/13] regmap: add SLIMbus support
Date: Thu, 23 Nov 2017 07:49:25 +0000
Message-ID: <20171123074925.hk3omwaqkg7swwmw@localhost.localdomain>
References: <20171115141043.29202-1-srinivas.kandagatla@linaro.org>
 <20171115141043.29202-9-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 17FEB266CFB
 for <alsa-devel@alsa-project.org>; Thu, 23 Nov 2017 08:49:30 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20171115141043.29202-9-srinivas.kandagatla@linaro.org>
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
Cc: mark.rutland@arm.com, alsa-devel@alsa-project.org, michael.opdenacker@free-electrons.com, poeschel@lemonage.de, andreas.noever@gmail.com, arnd@arndb.de, vinod.koul@intel.com, treding@nvidia.com, devicetree@vger.kernel.org, james.hogan@imgtec.com, pawel.moll@arm.com, linux-arm-msm@vger.kernel.org, sharon.dvir1@mail.huji.ac.il, robh+dt@kernel.org, sdharia@codeaurora.org, alan@linux.intel.com, bp@suse.de, mathieu.poirier@linaro.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, broonie@kernel.org, daniel@ffwll.ch, jkosina@suse.cz, joe@perches.com, davem@davemloft.net
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 15, 2017 at 02:10:38PM +0000, srinivas.kandagatla@linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> This patch adds support to read/write slimbus value elements.
> Currently it only supports byte read/write. Adding this support in
> regmap would give codec drivers more flexibility when there are more
> than 2 control interfaces like slimbus, i2c.
> 
> Without this patch each codec driver has to directly call slimbus value
> element apis, and this could would get messy once we want to add i2c
> interface to it.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
> +
> +static int regmap_slimbus_byte_reg_read(void *context, unsigned int reg,
> +					unsigned int *val)
> +{
> +	struct slim_device *sdev = context;
> +	int v;
> +
> +	if (!sdev)
> +		return 0;

Is there a specific reason we are checking the context here? The
other regmap buses don't both and whilst I don't mind checking
shouldn't we return an error if we don't have a context rather
than pretending to succeed?

> +
> +	v = slim_readb(sdev, reg);
> +
> +	if (v < 0)
> +		return v;
> +
> +	*val = v;
> +
> +	return 0;
> +}
> +
> +static int regmap_slimbus_byte_reg_write(void *context, unsigned int reg,
> +					 unsigned int val)
> +{
> +	struct slim_device *sdev = context;
> +
> +	if (!sdev)
> +		return 0;

ditto.

Thanks,
Charles
