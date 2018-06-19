From: Vinod <vkoul@kernel.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: qcom: add sdm845 sound card support
Date: Tue, 19 Jun 2018 21:52:30 +0530
Message-ID: <20180619162230.GF13316@vkoul-mobl>
References: <1529320591-22434-1-git-send-email-rohitkr@codeaurora.org>
 <20180619050527.GR25852@vkoul-mobl>
 <8562b574-3738-8983-53e7-64366590fad4@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8562b574-3738-8983-53e7-64366590fad4@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rohit Kumar <rohitkr@codeaurora.org>
Cc: lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, plai@codeaurora.org, bgoswami@codeaurora.org, perex@perex.cz, srinivas.kandagatla@linaro.org, tiwai@suse.com, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi Rohit,

On 19-06-18, 19:20, Rohit Kumar wrote:
> On 6/19/2018 10:35 AM, Vinod wrote:
> > On 18-06-18, 16:46, Rohit kumar wrote:
> > 
> > > +struct sdm845_snd_data {
> > > +	struct snd_soc_card *card;
> > > +	struct regulator *vdd_supply;
> > > +	struct snd_soc_dai_link dai_link[];
> > > +};
> > > +
> > > +static struct mutex pri_mi2s_res_lock;
> > > +static struct mutex quat_tdm_res_lock;
> > any reason why the locks can't be part of sdm845_snd_data?
> > Also why do we need two locks ?
> No specific reason, I will move it to sdm845_snd_data.
> These locks are used to protect enable/disable of bit clocks. We have
> Primary MI2S RX/TX
> and Quaternary TDM RX/TX interfaces. For primary mi2s rx/tx, we have single
> clock which is
> synchronized with pri_mi2s_res_lock. For Quat TDM RX/TX, we are using
> quat_tdm_res_lock.
> We need two locks as we are protecting two different resources.

I think bigger question is why do you need any locks? What is the race
scenario you envision which needs protection

-- 
~Vinod
