From: Lu Guanqun <guanqun.lu@intel.com>
Subject: Re: [PATCH V3 1/5] sound: asoc: Adding support for
 STA529 Audio Codec
Date: Thu, 14 Apr 2011 22:19:36 +0800
Message-ID: <20110414141936.GD31985@qtel.sh.intel.com>
References: <1302499804-24386-1-git-send-email-rajeev-dlh.kumar@st.com>
	<1302499804-24386-2-git-send-email-rajeev-dlh.kumar@st.com>
	<20110411145621.GA26769@opensource.wolfsonmicro.com>
	<s5h62qhma4c.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id ADC5D103807
	for <alsa-devel@alsa-project.org>;
	Thu, 14 Apr 2011 16:21:00 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5h62qhma4c.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Rajeev Kumar <rajeev-dlh.kumar@st.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 14, 2011 at 05:54:11PM +0800, Takashi Iwai wrote:
> At Mon, 11 Apr 2011 07:56:22 -0700,
> Mark Brown wrote:
> > 
> > > +static const struct snd_kcontrol_new sta529_new_snd_controls[] = {
> > > +	SOC_ENUM("pwm select", pwm_src_enum),
> > > +	SOC_ENUM("mode select", mode_src_enum),
> > > +};
> > 
> > ALSA control names are idiomatically things like "PWM Select" with
> > capitalisation.
> 
> Actually, the capital words are no mandatory requirement (although
> it's conventionally so).  It's just alsa-mixer grouping rule that
> requires the capital words "Play", "Capture", "Volume", "Switch",
> etc.

Hi Takashi,

Where can I find these alsa-mixer grouping rule?
So that I can obey these rules and make them appear in the right view in
alsamixer.

> 
> You don't have to obey Capitalism :)
> 
> 
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
guanqun
