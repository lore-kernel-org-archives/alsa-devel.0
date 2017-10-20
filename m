From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [Patch v6 6/7] regmap: add SLIMBUS support
Date: Thu, 19 Oct 2017 22:00:35 -0700
Message-ID: <CAOCOHw5JsXQsPCS31RBTwRHvLg5a2n=3uq=+RFEv-vBNPdjcaQ@mail.gmail.com>
References: <20171006155136.4682-1-srinivas.kandagatla@linaro.org>
 <20171006155136.4682-7-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f182.google.com (mail-pf0-f182.google.com
 [209.85.192.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 8FBA826766A
 for <alsa-devel@alsa-project.org>; Fri, 20 Oct 2017 07:00:37 +0200 (CEST)
Received: by mail-pf0-f182.google.com with SMTP id i5so9336170pfe.6
 for <alsa-devel@alsa-project.org>; Thu, 19 Oct 2017 22:00:36 -0700 (PDT)
In-Reply-To: <20171006155136.4682-7-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, alsa-devel@alsa-project.org, Michael Opdenacker <michael.opdenacker@free-electrons.com>, poeschel@lemonage.de, Andreas Noever <andreas.noever@gmail.com>, gong.chen@linux.intel.com, Arnd Bergmann <arnd@arndb.de>, kheitke@audience.com, Thierry Reding <treding@nvidia.com>, devicetree <devicetree@vger.kernel.org>, james.hogan@imgtec.com, Pawel Moll <pawel.moll@arm.com>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, sharon.dvir1@mail.huji.ac.il, Rob Herring <robh+dt@kernel.org>, Sagar Dharia <sdharia@codeaurora.org>, alan@linux.intel.com, bp@suse.de, Mathieu Poirier <mathieu.poirier@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, lkml <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Daniel Vetter <daniel@ffwll.ch>, Jiri Kosina <jkosina@suse.cz>, joe@perches.com, David Miller <davem@davemloft.net>
List-Id: alsa-devel@alsa-project.org

On Fri 06 Oct 08:51 PDT 2017, srinivas.kandagatla@linaro.org wrote:

> diff --git a/drivers/base/regmap/regmap-slimbus.c b/drivers/base/regmap/regmap-slimbus.c
[..]
> +static int regmap_slimbus_byte_reg_read(void *context, unsigned int reg,
> + unsigned int *val)
> +{
> + struct slim_device *slim = context;
> + struct slim_val_inf msg = {0,};
> +
> + msg.start_offset = reg;
> + msg.num_bytes = 1;
> + msg.rbuf = (void *)val;

Turn rbuf into a void * and you don't need this cast (think I commented
on this on a previous patch as well).

> +
> + return slim_request_val_element(slim, &msg);
> +}
> +
> +static int regmap_slimbus_byte_reg_write(void *context, unsigned int reg,
> + unsigned int val)
> +{
> + struct slim_device *slim = context;
> + struct slim_val_inf msg = {0,};
> +
> + msg.start_offset = reg;
> + msg.num_bytes = 1;
> + msg.wbuf = (void *)&val;

Dito

> +
> + return slim_change_val_element(slim, &msg);
> +}

Regards,
Bjorn
