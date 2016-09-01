From: Danny Milosavljevic <dannym-bxPqe3T81XXwRsdMLXbzog@public.gmane.org>
Subject: Re: [PATCH v9 2/2] Add mixer controls: Line-In, FM-In,
 Mic 2, Capture Source, Differential Line-In.
Date: Thu, 1 Sep 2016 12:56:08 +0200
Message-ID: <20160901125608.72808fac@scratchpost.org>
References: <20160830054403.7878-1-dannym@scratchpost.org>
	<20160830054403.7878-3-dannym@scratchpost.org>
	<CAGb2v64zA3iSOe7ku=pF0RhJkvErxt_tbPWG4H8D6r5UEUJAMQ@mail.gmail.com>
Reply-To: dannym-bxPqe3T81XXwRsdMLXbzog@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCPKHTHNWIPBBTESUC7AKGQE2FGV5IY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <CAGb2v64zA3iSOe7ku=pF0RhJkvErxt_tbPWG4H8D6r5UEUJAMQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Hi Chen-Yu,

> I have a few patches that introduce SOC_DAPM_DOUBLE, so you can share a
> control between left/right channels. IMHO it makes the userspace mixer
> less confusing.

I definitely agree that cutting down on the number of sliders would be good.
I do a double-take every time I open alsamixer - and I *added* these
sun4i widgets :)

It would be good if your patch series was queued and I could use SOC_DAPM_DOUBLE
in a future version of my patch. 

Can you post it?

Since it changes user space-visible API whether I group the widgets or not we
have to be careful about it. So far my patch has not been merged which is good
for API stability I guess.

I wondered about why there's a SOC_DOUBLE_TLV but no SOC_DAPM_DOUBLE before,
so it's good to know there's no deep reason.

That said, I'd have to remove the distinction between Left Mixer and Right
Mixer then. Right now it does distinguish. 

Removing the distinction would remove noteworthy routes like

        { "Right Mixer", "Left DAC Playback Switch", "Left DAC" },

(not a typo). Would that be OK?

Well, let's see how it will work out.

In the mean time I added the second regmap and the quirks and will post another
patch series for comments.

Cheers,
   Danny
