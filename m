From: Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v14 3/8] ASoC: sun4i-codec: Merge
 sun4i_codec_left_mixer_controls and sun4i_codec_right_mixer_controls into sun4i_codec_mixer_controls
Date: Mon, 14 May 2018 16:06:40 +0200
Message-ID: <20180514140640.oig6hqbh5utvzhmd@flea>
References: <20180502210800.1971-1-dannym@scratchpost.org>
 <20180502210800.1971-4-dannym@scratchpost.org>
 <20180503144618.oojhvmey44dtg5fa@flea>
 <20180505085056.6c6011ca@scratchpost.org>
Reply-To: maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nskfsqj542gg4f7l"
Return-path: <linux-sunxi+bncBDSJBYGBRIMBBAVQ43LQKGQEYLUB7KI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <20180505085056.6c6011ca-bxPqe3T81XXwRsdMLXbzog@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Danny Milosavljevic <dannym-bxPqe3T81XXwRsdMLXbzog@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Andrea Bondavalli <andrea.bondavalli74-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>, Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--nskfsqj542gg4f7l
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline

On Sat, May 05, 2018 at 08:51:43AM +0200, Danny Milosavljevic wrote:
> Hi Maxime,
> 
> On Thu, 3 May 2018 16:46:19 +0200
> Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org> wrote:
> 
> > Doesn't that mean that the controls will be shared between the right
> > and left mixers now, which wasn't the case before?
> 
> Yes.  However Chen-Yu said that except for debugfs that cannot be
> observed by user space anyway.
> 
> It's nice to have the NEW controls have multiple channels, which is what
> this does.
> 
> >And also, wouldn't
> > the controls be called "Left Mixer Left Mixer Left DAC Playback
> > Switch" (for the first one) now?
> 
> No.  I checked using "amixer" - the names look fine,
> "Left Mixer Left DAC Playback Switch".
> 
> With the patch series, amixer says:
> 
> numid=10,iface=MIXER,name='FM Playback Switch'
> numid=6,iface=MIXER,name='FM Playback Volume'
> numid=5,iface=MIXER,name='Line Boost Volume'
> numid=9,iface=MIXER,name='Line Playback Switch'
> numid=4,iface=MIXER,name='Line Playback Volume'
> numid=1,iface=MIXER,name='Mic1 Boost Volume'
> numid=11,iface=MIXER,name='Mic1 Playback Switch'
> numid=2,iface=MIXER,name='Mic2 Boost Volume'
> numid=12,iface=MIXER,name='Mic2 Playback Switch'
> numid=7,iface=MIXER,name='Mic Playback Volume'
> numid=18,iface=MIXER,name='Capture Source'
> numid=19,iface=MIXER,name='Differential Line Source'
> numid=8,iface=MIXER,name='Left Mixer Left DAC Playback Switch'
> numid=15,iface=MIXER,name='Power Amplifier DAC Playback Switch'
> numid=16,iface=MIXER,name='Power Amplifier Mixer Playback Switch'
> numid=17,iface=MIXER,name='Power Amplifier Mute Switch'
> numid=3,iface=MIXER,name='Power Amplifier Volume'
> numid=14,iface=MIXER,name='Right Mixer Left DAC Playback Switch'
> numid=13,iface=MIXER,name='Right Mixer Right DAC Playback Switch'

Great then :)

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
--nskfsqj542gg4f7l--
