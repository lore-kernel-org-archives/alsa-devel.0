From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoC: arizona: Improve ultrasonic
	frequency	response
Date: Fri, 31 Jan 2014 16:14:46 +0000
Message-ID: <20140131161446.GB12183@opensource.wolfsonmicro.com>
References: <1391183234-13943-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1391183234-13943-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20140131160644.GJ22609@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 694D7261B19
 for <alsa-devel@alsa-project.org>; Fri, 31 Jan 2014 17:14:47 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20140131160644.GJ22609@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lee.jones@linaro.org, sameo@linux.intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 31, 2014 at 04:06:44PM +0000, Mark Brown wrote:
> On Fri, Jan 31, 2014 at 03:47:14PM +0000, Charles Keepax wrote:
> > Evaluation of the device has given some settings to improve the
> > ultrasonic frequency response. This patch allows the user the option of
> > applying those.
> 
> Why would the user ever not want to do this?
> 
> > +	switch (priv->arizona->type) {
> > +	case WM5102:
> > +		if (priv->arizona->pdata.ultrasonic_response) {
> > +			snd_soc_write(codec, 0x80, 0x3);
> > +			if (params_rate(params) >= 176400)
> > +				snd_soc_write(codec, 0x4dd, 0x1);
> > +			else
> > +				snd_soc_write(codec, 0x4dd, 0x0);
> > +			snd_soc_write(codec, 0x80, 0x0);
> > +		}
> > +		break;
> 
> The code is only changing the configuration when the user is actually
> using ultrasonic sample rates so it doesn't seem like it should have a
> detrimental effect on other configurations.

Apologies I should have included a bit more in the commit message
I think, I will fire out a quick respin.

Thanks,
Charles
