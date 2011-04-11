From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V3 1/5] sound: asoc: Adding support for
 STA529 Audio Codec
Date: Mon, 11 Apr 2011 06:35:01 -0700
Message-ID: <20110411133500.GA24973@opensource.wolfsonmicro.com>
References: <1302499804-24386-1-git-send-email-rajeev-dlh.kumar@st.com>
	<1302499804-24386-2-git-send-email-rajeev-dlh.kumar@st.com>
	<20110411125318.GA11072@qtel.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 886C410381E
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Apr 2011 16:48:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110411125318.GA11072@qtel.sh.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lu Guanqun <guanqun.lu@intel.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Rajeev Kumar <rajeev-dlh.kumar@st.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 11, 2011 at 08:53:18PM +0800, Lu Guanqun wrote:

Please *always* delete irrelevant context from replies - it makes it
much easier to find the new text.

> On Mon, Apr 11, 2011 at 01:30:00PM +0800, Rajeev Kumar wrote:

> > +config SND_SOC_STA529
> > +       tristate
> > +       depends on I2C

> I see many drivers depend on I2C, but they don't add the line above. Any
> reasons for it?

It won't actually do anything - select ignores depends.

> > +static int __init sta529_modinit(void)
> > +{
> > +       int ret = 0;
> > +
> > +       ret = i2c_add_driver(&sta529_i2c_driver);
> 
> As an idiom, I often see the above code surrounded with an #ifdef, see
> below code snippet from sound/soc/codecs/wm8974.c

This is only for devices that support more than one control interface.
If the device only supports one control interface there is no need to
make anything conditional.
