From: Karthik Ramgopal <applefreakpeeps@gmail.com>
Subject: Re: Regarding Sound on Acer Aspire 6935G
Date: Mon, 18 May 2009 14:06:52 +0800
Message-ID: <4b8c423b0905172306g34beeb8focaa5c36422dd0f4e@mail.gmail.com>
References: <4b8c423b0905152051w7443e1b4u4080514a560fbb6c@mail.gmail.com>
	<s5h4ovj7hva.wl%tiwai@suse.de>
	<d54969c50905171348v12a58613sa8425f450e843eea@mail.gmail.com>
	<4b8c423b0905171952w5a28c6b3pe8d16fc6e9ccef50@mail.gmail.com>
	<s5h63fzeypa.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.251])
	by alsa0.perex.cz (Postfix) with ESMTP id 93A072444B
	for <alsa-devel@alsa-project.org>;
	Mon, 18 May 2009 08:06:53 +0200 (CEST)
Received: by rv-out-0708.google.com with SMTP id k29so1320725rvb.32
	for <alsa-devel@alsa-project.org>; Sun, 17 May 2009 23:06:52 -0700 (PDT)
In-Reply-To: <s5h63fzeypa.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, =?ISO-8859-1?Q?Emilio_L=F3pez?= <buhitoescolar@gmail.com>
List-Id: alsa-devel@alsa-project.org

How to get this pin configuration information from Windows? I have a list of
Pin Config Override verbs which i obtained from the registry using regedit.
Are they of any use?

Regards,
Karthik

On Mon, May 18, 2009 at 2:01 PM, Takashi Iwai <tiwai@suse.de> wrote:

> At Mon, 18 May 2009 10:52:44 +0800,
> Karthik Ramgopal wrote:
> >
> > Yes I did try model=acer-aspire-4930g. That gives me even lesser
> functionality
> > than model=auto (Surround volume can no longer be used to adjust line-out
> > volume) I think the 4930G uses a ALC888 and the 6935/6920/8920/8930 use a
> > ALC889 (0x10ec0889) codec. Any way of obtaining the verbs from the
> Windows
> > driver?
>
> The most important information is rather the pin configuration.
> This could be obtained from some text file in Windows.
>
> > Some more info (obtained by generally trying out verbs)
> >
> > 0x15 SET_EAPD_BTLENABLE 2 and 0x14 SET_EAPD_BTLENABLE 2 are both needed
> to get
> > the amps fired
> >
> > 0x14 SET_CONNECT_SEL 0x00 connects the laptop speakers and disconnects
> > line-out
> > 0x14 SET_CONNECT_SEL 0x01 connects the line-out but laptop speakers
> continue
> > to function
> >
> > 0x15 SET_CONNECT_SEL 0x00 connects the laptop speakers and disconnects
> the
> > subwoofer
> > 0x14 SET_CONNECT_SEL 0x01 connects the subwoofer but laptop speakers
> continue
> > to function
> > 0x15 SET_PIN_WIDGET_CONTROL 0x00 turns off the line-out
> > 0x15 SET_PIN_WIDGET_CONTROL 0x40 turns on the line-out but
> laptop-speakers
> > stay on
> > 0x15 SET_PIN_WIDGET_CONTROL 0xc0 Same as above but line-out volume is
> much
> > higher
> >
> > 0x0c SET_AMP_GAIN_MUTE 0x7080 (Mutes all channels)
> > 0x0c SET_AMP_GAIN_MUTE 0x7000 (Un-mutes all channels)
>
> OK, then we'd need a proper mixer and init verb list to make it
> working...
>
> Takashi
>
>
>
