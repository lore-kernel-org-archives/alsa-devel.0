From: =?ISO-8859-1?Q?Emilio_L=F3pez?= <buhitoescolar@gmail.com>
Subject: Re: Plugging in headphones doesn't mute speakers,
	internal microphone does not work
Date: Tue, 3 Mar 2009 15:28:44 -0200
Message-ID: <d54969c50903030928k52583265keb18ee28c8c987a8@mail.gmail.com>
References: <d54969c50902280727i58fc689dib97a1fe9658b88ab@mail.gmail.com>
	<d54969c50902280838i4f48aa43w6630bfc87105890c@mail.gmail.com>
	<s5hd4czdfv9.wl%tiwai@suse.de>
	<d54969c50903021546t1912e136jab3fb6354c36520b@mail.gmail.com>
	<s5hy6vmokm0.wl%tiwai@suse.de>
	<d54969c50903030918k4de6c626pf2cf6f2675308fc4@mail.gmail.com>
	<s5hzlg24j0e.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yx-out-1718.google.com (yx-out-1718.google.com [74.125.44.154])
	by alsa0.perex.cz (Postfix) with ESMTP id A7BD3103878
	for <alsa-devel@alsa-project.org>; Tue,  3 Mar 2009 18:28:45 +0100 (CET)
Received: by yx-out-1718.google.com with SMTP id 36so1914459yxh.2
	for <alsa-devel@alsa-project.org>; Tue, 03 Mar 2009 09:28:44 -0800 (PST)
In-Reply-To: <s5hzlg24j0e.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Any idea then on what's going on? I can live with having to mute the
speakers manually (the headphones seem to be controllable with 'Subwoofer'),
but having to carry an external mic when I have an integrated one is not
very good :/

I've read on forums and blogs that, for other acer versions, to make the mic
work they use position_fix=3D0, enable_dma=3D1 or things like that, but I t=
ried
them and no luck :( can you suggest anything else?

2009/3/3 Takashi Iwai <tiwai@suse.de>

> At Tue, 3 Mar 2009 15:18:13 -0200,
> Emilio L=F3pez wrote:
> >
> > Hi,
> >
> > 'Side' is the subwoofer on my laptop (my laptop has an integrated
> subwoofer,
> > believe it or not.
>
> Hmm, then it's a wrong assignment.  "Side" shouldn't be LFE.
>
> > Acer calls it "Tuba cinebass" or something like that).
> > Apart from that, the PC has a headphones/SPDIF jack, so I believe it
> supports
> > 7.1?
>
> No, it's totally irrelevant.
> (SPDIF is 2-channel only, BTW.  Multi-channel is done via compressed
>  formats, but the physical channels are only two.)
>
>
> Takashi
>
> >
> > 2009/3/3 Takashi Iwai <tiwai@suse.de>
> >
> >     At Mon, 2 Mar 2009 21:46:04 -0200,
> >     Emilio L=F3pez wrote:
> >     >
> >     > 2009/3/2 Takashi Iwai <tiwai@suse.de>
> >     >
> >     >     At Sat, 28 Feb 2009 14:38:10 -0200,
> >     >     Emilio L=F3pez wrote:
> >     >     >
> >     >     > Hello,
> >     >     >
> >     >     > This is my first mail to the list, I hope you can help me. I
> have
> >     been
> >     >     > talking with people on #alsa, but they couldn't help me, so
> that's
> >     why
> >     >     > I'm writing to you.
> >     >     >
> >     >     > Well, as lspci says, my Acer Aspire 6930 laptop has an "Int=
el
> >     >     > Corporation 82801I (ICH9 Family) HD Audio Controller (rev
> 03)".
> >     With
> >     >     > this card, and without adding any mode=3D... to
> >     >     > /etc/modprobe.d/alsa-base, playback works perfectly, but wh=
en
> I
> >     plug
> >     >     > in headphones, the integrated speakers do not mute. I can
> mute the
> >     >     > speakers muting "front" and "side" and use the headphones,
> but it
> >     >     > should be automatic.
> >     >     >
> >     >     > Setting mode=3Dauto makes the headphones, when plugged, mute
> the
> >     >     > speakers. But the problem with this is, that when using the
> >     speakers,
> >     >     > I only get sound from the speaker that was "front" in the
> other
> >     mode.
> >     >     > The microphone does not work in this mode either.
> >     >     >
> >     >     > I also tried other modes, including (but not limited to)
> acer,
> >     >     > acer-aspire. I ran alsa-info.sh, here is the URL:
> >     >     > http://www.alsa-project.org/db/?f=3D
> >     >     7910da439e8e190a8c2a6f18167d4879c74881c9
> >     >     >
> >     >     > And before I forget, regarding the microphone, if I plug an
> >     external
> >     >     > one on the microphone plug, I can record. And I tried the
> internal
> >     one
> >     >     > on windows, and it works, so I believe it's an alsa problem.
> >     >     >
> >     >     > Looking forward to hearing from you!
> >     >
> >     >     Could you check the very latest sound git tree or alsa-driver
> >     snapshot
> >     >     below, first without model option?
> >     >      git://
> git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git
> >     >      ftp://ftp.kernel.org/pub/linux/kernel/people/tiwai/snapshot/
> >     >     alsa-driver-snapshot.tar.gz
> >     >
> >     > Hi,
> >     >
> >     > I tried with the alsa-driver snapshot without any model option, a=
nd
> now
> >     the
> >     > headphones mute the speakers. But the internal microphone doesn't
> still
> >     work,
> >     > and 'Side' doesn't output sound like it did before, even if it's
> unmuted
> >     and
> >     > with volume at 100% (with the old version and without any model
> option,
> >     it
> >     > worked)
> >
> >     What "Side" volume would do exactly?  It's for 7.1 output.
> >     Does the machine have 7.1 output?
> >
> >     Takashi
> >
> >
>
