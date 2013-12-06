From: Nicolin Chen <b42378@freescale.com>
Subject: Re: [PATCH 3/3] ASoC: fsl: imx-wm8962: Add headphone and microphone
 jack plugin/out detection
Date: Fri, 6 Dec 2013 22:38:17 +0800
Message-ID: <20131206143817.GB29975@MrMyself>
References: <cover.1386322845.git.b42378@freescale.com>
 <82d3285b7efe1f98dbc3d9c0a423b2e5e454481f.1386322845.git.b42378@freescale.com>
 <20131206144256.GI29268@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20131206144256.GI29268@sirena.org.uk>
Sender: linux-doc-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: lgirdwood@gmail.com, alsa-devel@alsa-project.org, tiwai@suse.de, perex@perex.cz, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, devicetree@vger.kernel.org, rob@landley.net, ijc+devicetree@hellion.org.uk, swarren@wwwdotorg.org, mark.rutland@arm.com, pawel.moll@arm.com, rob.herring@calxeda.com
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 06, 2013 at 02:42:56PM +0000, Mark Brown wrote:
> On Fri, Dec 06, 2013 at 05:48:23PM +0800, Nicolin Chen wrote:
> 
> > Therefore, this patch mainly adds jack event detection feature and switchs I/O
> > routes accordingly. Meanwhile, for those monaural input cases, we also turn on
> > the ADC monomix features of WM8962 if needed.
> 
> No, the kernel shouldn't be doing any route switching or other
> configuration - that should be done by userspace.  This is a policy
> decision, there are situations where for example audio should go to both
> headphones and speaker when headphones are connected in order to make
> sure notifications are audible even if headpones have been removed.

I see...It seems my solution is too specific. I will re-think about it.

> > +	if (hp_status != priv->hp_active_low) {
> > +		snprintf(buf, 32, "STATE=%d", 2);
> > +		snd_soc_dapm_disable_pin(&priv->codec->dapm, "Ext Spk");
> > +		ret = imx_hp_jack_gpio.report;
> > +	} else {
> > +		snprintf(buf, 32, "STATE=%d", 0);
> > +		snd_soc_dapm_enable_pin(&priv->codec->dapm, "Ext Spk");
> > +		ret = 0;
> > +	}
> > +
> > +	envp[0] = "NAME=headphone";
> > +	envp[1] = buf;
> > +	envp[2] = NULL;
> > +	kobject_uevent_env(&pdev->dev.kobj, KOBJ_CHANGE, envp);
> 
> What's this uevent trying to do and why is it open coded in the driver?

That's a requirement from Android team of Freescale. By checking this
event they can determine whether current output is speaker or headphone
so as to place an icon on the notification area.

Sir, if you think this patch is not common enough or non-community style,
I can try to cut it down to an common one or entirely drop it.

Looking forward to your reply,
Nicolin Chen



