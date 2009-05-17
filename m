From: =?ISO-8859-1?Q?Emilio_L=F3pez?= <buhitoescolar@gmail.com>
Subject: Re: Regarding Sound on Acer Aspire 6935G
Date: Sun, 17 May 2009 17:48:08 -0300
Message-ID: <d54969c50905171348v12a58613sa8425f450e843eea@mail.gmail.com>
References: <4b8c423b0905152051w7443e1b4u4080514a560fbb6c@mail.gmail.com>
	<s5h4ovj7hva.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.146])
	by alsa0.perex.cz (Postfix) with ESMTP id A07C8245C8
	for <alsa-devel@alsa-project.org>;
	Sun, 17 May 2009 22:48:09 +0200 (CEST)
Received: by qw-out-1920.google.com with SMTP id 4so1871485qwk.56
	for <alsa-devel@alsa-project.org>; Sun, 17 May 2009 13:48:08 -0700 (PDT)
In-Reply-To: <s5h4ovj7hva.wl%tiwai@suse.de>
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
Cc: Karthik Ramgopal <applefreakpeeps@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I seem to have the same card looking at lspci -v, and I experience the same
problems. My laptop is an Acer Aspire 6930, so maybe the Acer bioses are
broken? I got the sound to work (with the controls mapped uncorrectly), but
I still can't make the mic work. I'll try with that model, I also tried with
acer and acer-aspire with no luck.

Emilio

2009/5/17 Takashi Iwai <tiwai@suse.de>

> At Sat, 16 May 2009 11:51:36 +0800,
> Karthik Ramgopal wrote:
> >
> > Hi,
> >        Even after enabling DEBUG using --with-debug option with configure
> when
> > compiling the alsa-driver snapshot leaves no more error messages in the
> dmesg
> > logs. The only message relating to HDA is:
> >
> > [   41.104817] hda-intel: IRQ timing workaround is activated for card #0.
> > Suggest a bigger bdl_pos_adj.
> >
> > I just got the line-out output to work by toggling the surround volume. I
> > still think it's a mapping problem. The headphone switch is turning the
> > subwoofer on and off, and the surround volume is controlling the line-out
> > volume.
>
> OK, this implies that the BIOS setup is broken.
> Did you try model=acer-aspire-4930g, BTW?
>
>
> Takashi
>
> > None of the line-in devices function and all of the amp-ins 0x0b to
> > 0x0f are muted. Cannot find any verb to unmute them. hda-verb with
> > SET_EAPD_BTLENABLE 2 at 0x15 is still needed at startup to fire up the
> amps.
> >
> > Please help.
> >
> > Regards,
> > Karthik
> >
> >
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
