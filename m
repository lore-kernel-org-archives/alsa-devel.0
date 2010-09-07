From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Since kernel-2.6.32 alsactl thinks my sound card
	is "Unknown"
Date: Tue, 7 Sep 2010 22:34:54 +0800
Message-ID: <AANLkTinrEAooT1ZUnsxy+bA2CNtSAeOwOT1WSNdTL0o1@mail.gmail.com>
References: <1283357723.8159.4.camel@localhost.localdomain>
	<s5hmxs0zgxs.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 53F2C1038A9
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Sep 2010 16:45:06 +0200 (CEST)
Received: by ewy21 with SMTP id 21so2253408ewy.38
	for <alsa-devel@alsa-project.org>; Tue, 07 Sep 2010 07:45:04 -0700 (PDT)
In-Reply-To: <s5hmxs0zgxs.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/9/2 Takashi Iwai <tiwai@suse.de>

> At Wed, 01 Sep 2010 18:15:23 +0200,
> Pacho Ramos wrote:
> >
> > This is an old problem I am suffering since kernel-2.6.32 and that is
> > still unresolved even with 2.6.35 and alsa-utils-1.0.23:
> > http://www.spinics.net/lists/alsa-devel/msg31422.html
> >
> > If you follow the thread, it got stalled in:
> > http://www.spinics.net/lists/alsa-devel/msg31433.html
> >
> > In summary, I get the following:
> > # alsactl -f /etc/asound.state restore /dev/snd/controlC0
> > Unknown hardware: "VIA8237" "Realtek ALC658D" "AC97a:414c4781" "0x147b"
> > "0x1415"
> > Hardware is initialized using a guess method
> > # echo $?
> > 99
>
> This is no error.  It means that alsactl has no special workaround
> for your hardware.  The return code of alsactl looks strange.
> I thought Jaroslav has already fixed it, though...
>
>
> Takashi
>
> >
> > As you can see, the exit code was solved, but I don't know why my
> > hardware is still shown as "Unknown" even if
> > via82xx.c clearly has some lines for my device:
> >         SND_PCI_QUIRK(0x147b, 0x1415, "ABIT AV8", VIA_DXS_NO_VRA),
> >
> >
>


why "alsactl init" does not select "Mic" as "Capture Source" for AC97 codec
?

it seem "alsactl init" does not set "Mic Boost" too
