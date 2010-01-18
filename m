From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: DaVinci: Voice Codec Support
Date: Mon, 18 Jan 2010 18:13:04 +0000
Message-ID: <29508.5184662186$1263853724@news.gmane.org>
References: <1262902691-15059-1-git-send-email-miguel.aguilar@ridgerun.com>
	<20100108112521.GA10128@sirena.org.uk>
	<4B54A155.3090504@ridgerun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 27C8E103843
	for <alsa-devel@alsa-project.org>; Mon, 18 Jan 2010 23:28:28 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4B54A155.3090504@ridgerun.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Miguel Aguilar <miguel.aguilar@ridgerun.com>
Cc: davinci-linux-open-source@linux.davincidsp.com, clark.becker@ridgerun.com, santiago.nunez@ridgerun.com, diego.dompe@ridgerun.com, alsa-devel@alsa-project.org, nsnehaprabha@ti.com, todd.fischer@ridgerun.com, sameo@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 18, 2010 at 11:58:45AM -0600, Miguel Aguilar wrote:
> Hi Mark,

> >>+	(*pdev)->dev.parent = davinci_vc->dev;
> >>+	platform_set_drvdata(*pdev, davinci_vc);

> >Newer drivers are tending to do this by looking at dev->parent in the
> >child device rather than using the

> Can you tell me what is driver that is using this new tend? Is this
> a wrong way to register the clients?

wm831x is one example, but there's others.

> >>+#include <linux/delay.h>
> >>+#include <linux/pm.h>
> >>+#include <linux/i2c.h>

> >Not needed.
> What headers are not needed?

linux/i2c.h

> >>+				  snd_soc_cnew(&cq93vc_snd_controls[i],
> >>+					       codec, NULL));
> >>+		if (err < 0)
> >>+			return err;
> >>+	}

> >This is snd_soc_add_controls().

> So I can call directly snd_soc_add_controls instead of using the function above?

Yes, your code above is just an open coded version of that function so
you can just replace your function with a call to snd_soc_add_controls().

> >These are actually mostly redundant with this hardware - the core will
> >bring the driver down to _STANDBY before suspending the driver and your
> >_STANDBY and _OFF states are equivalent.  This means that both functions
> >should end up being noops.  On the other hand they do no harm.

> This means that I can get rid of the function suspend?

Yup.

> >>+	/* Set the DAC digital attenuation to 0 dB */
> >>+	cq93vc_write(codec, DAVINCI_VC_REG09, DAVINCI_VC_REG09_DIG_ATTEN);

> >The standard thing for things like this is to leave the defaults in the
> >driver as whatever the hardware default is then let either the machine
> >driver or (better) userspace override it.  This avoids issues with
> >defaults being good for one system and not another.

> So, Should I remove the values that I seeting above, and let the
> hardware use its default values?

Yes.

> >This has been removed in favour of relying on more generic kernel
> >mechanisms (hopefully).\

> What was exactly removed here the NULL version of the functions or
> the functions itself.

The functions themselves.
