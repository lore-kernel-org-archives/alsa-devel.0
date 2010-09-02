From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Since kernel-2.6.32 alsactl thinks my sound card
	is "Unknown"
Date: Thu, 2 Sep 2010 20:26:24 +0800
Message-ID: <AANLkTi=f0B_MQAQoJkQYJydfQJ_QgJKoWC4K=Ku33BuG@mail.gmail.com>
References: <s5hmxs0zgxs.wl%tiwai@suse.de>
	<1283419574.6497.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id 5CF4D246F9
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Sep 2010 14:26:25 +0200 (CEST)
Received: by ewy21 with SMTP id 21so166706ewy.38
	for <alsa-devel@alsa-project.org>; Thu, 02 Sep 2010 05:26:25 -0700 (PDT)
In-Reply-To: <1283419574.6497.4.camel@localhost.localdomain>
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

2010/9/2 Pacho Ramos <pacho@condmat1.ciencias.uniovi.es>

> El jue, 02-09-2010 a las 10:29 +0200, Takashi Iwai escribi=F3:
> > Rejected by SPF lookup: (recv=3Dllar.net.uniovi.es,
> >  send-ip=3D195.135.220.2) Could not find a valid SPF record
> > User-Agent: Wanderlust/2.15.6 (Almost Unreal) SEMI/1.14.6 (Maruoka)
> FLIM/1.14.9
> >  (=3D?UTF-8?B?R29qxY0=3D?=3D) APEL/10.7 Emacs/23.1 (x86_64-suse-linux-g=
nu)
> MULE/6.0
> >  (HANACHIRUSATO)
> > References: <1283357723.8159.4.camel@localhost.localdomain>
> >
> > At Wed, 01 Sep 2010 18:15:23 +0200,
> > Pacho Ramos wrote:
> > >
> > > This is an old problem I am suffering since kernel-2.6.32 and that is
> > > still unresolved even with 2.6.35 and alsa-utils-1.0.23:
> > > http://www.spinics.net/lists/alsa-devel/msg31422.html
> > >
> > > If you follow the thread, it got stalled in:
> > > http://www.spinics.net/lists/alsa-devel/msg31433.html
> > >
> > > In summary, I get the following:
> > > # alsactl -f /etc/asound.state restore /dev/snd/controlC0
> > > Unknown hardware: "VIA8237" "Realtek ALC658D" "AC97a:414c4781" "0x147=
b"
> > > "0x1415"
> > > Hardware is initialized using a guess method
> > > # echo $?
> > > 99
> >
> > This is no error.  It means that alsactl has no special workaround
> > for your hardware.  The return code of alsactl looks strange.
> > I thought Jaroslav has already fixed it, though...
> >
> >
> > Takashi
> >
>
> Well, Jaroslav fixed it to use "99" instead of "157":
> http://www.spinics.net/lists/alsa-devel/msg31430.html
>
> And, about the message, could it be reworded for preventing to make
> users think their hardware is "Unknown"? Maybe it could simply show "No
> workaround needed for: ..." instead of "Unknown hardware"
>
> Thanks :-)
>
>
It seem to me that the current logic of alsactl try to compare  the number
of controls created by the driver and  the number of controls in the state
file before it restore the controls from the state file.

it assume that it cannot restored the setting from the state file when the
number of controls does not match , so it call the init routine instead of
restore routine.

This create a problem for those drivers which have IFACE_PCM "PCM volume
control" since  alsactl does not need to store the value of the controls in
the state file as those per voice volume controls are always initialised
when the stream is open for those sound cards via82xx and ymfpci

This mean that the number of controls in state file is always less than the
number of controls created by the driver and that is the reason why alsactl
always init instead of restore the setting for both  via82xx  and ymfpci

To solve this bug, alsactl should subtract the number of those IFACE_PCM
"PCM volume control" when comparing the number of control in state file
