From: Danny Milosavljevic <dannym-bxPqe3T81XXwRsdMLXbzog@public.gmane.org>
Subject: Re: Re: [PATCH v8 2/2] ASoc: sun4i-codec: Add FM, Line
 and Mic inputs
Date: Sat, 19 Mar 2016 17:13:36 +0100
Message-ID: <20160319171336.6e16eb5a@scratchpost.org>
References: <20151221123148.1ab6480b@dayas>
	<20151221123416.51aa938e@dayas>
	<20151227182157.GI30359@lukather>
	<20151228040649.475a742f@dayas>
	<20160106220908.GE9631@lukather>
	<20160109164832.515d69b0@dayas>
	<20160312085222.226d89bf@scratchpost.org>
	<20160314104939.GL8418@lukather>
	<20160315105802.GN2566@sirena.org.uk>
Reply-To: dannym-bxPqe3T81XXwRsdMLXbzog@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBCPKHTHNWIPBBOHVWW3QKGQEAPTFAOI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20160315105802.GN2566-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Hi Mark,

my question is whether it's possible to group together the left and right c=
hannel into one selem, and also if it's possible to reuse volumes then. For=
 example:

For sun4i-codec Mic there's right now:
- Left Mixer Mic1 Playback Switch
- Left Mixer Mic2 Playback Switch
- Right Mixer Mic1 Playback Switch
- Right Mixer Mic2 Playback Switch
- Mic Playback Volume

If possible, it could also then be collected together as:
- Mic1 Playback:
    Left Mixer Mic1 Playback Switch,=20
    Right Mixer Mic1 Playback Switch,=20
    Mic Playback Volume
- Mic2 Playback:
    Left Mixer Mic2 Playback Switch,=20
    Right Mixer Mic2 Playback Switch,=20
    Mic Playback Volume [note: there it is again]

... where each outer group (f.e. "- Mic1 Playback:") is a selem (slider wit=
h two mutes in alsamixer).

alsamixer has support for seperate left and right channel muting so it woul=
d cut down a lot on the number of visible controls.

But as you can see, Mic Playback Volume is also shared.

Is it possible to group them together like this? How?

Right now, while everything technically works, it's overwhelming to use als=
amixer with sun4i-codec as a user - you have to *scroll* for quite a while.

Additionally, while I'm at it:=20

There's one capture volume right in front of the ADC. Whatever it is you ca=
pture, this tells you the gain for the ADC. But for some inputs, there are =
additional preamps. Right now in the v8 patch we don't distinguish between =
preamps and ADC gains (because I don't think it's possible), although the u=
ser has to kinda distinguish them in his head because for inputs which have=
 preamps only the preamp and the adc gain *together* specify the total gain=
 in the end.

E.g. in the hardware it's

  Mic In -> | Mic Preamp | -> | ADC Gain | -> | ADC |

while in alsamixer it's:

  [Capture Controls:]

  | Mic Preamp |  | Capture Volume | | xyz Preamp | | abc Preamp | | qrs Pr=
eamp |
                    ^--- ADC Gain

Is it possible to somehow distinguish those in alsamixer? Do we want to?

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
