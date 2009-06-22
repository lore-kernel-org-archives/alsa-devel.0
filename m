From: =?ISO-8859-1?Q?Emilio_L=F3pez?= <buhitoescolar@gmail.com>
Subject: Re: Regarding Sound on Acer Aspire 6935G
Date: Mon, 22 Jun 2009 18:51:50 -0300
Message-ID: <d54969c50906221451o6e92044cj3da24df67e55268b@mail.gmail.com>
References: <4b8c423b0905152051w7443e1b4u4080514a560fbb6c@mail.gmail.com>
	<d54969c50906131915x22c8f30el46ee51faf2fafe20@mail.gmail.com>
	<d54969c50906201723k66b7965and680ffcc798e61de@mail.gmail.com>
	<s5h63eq9cxp.wl%tiwai@suse.de>
	<d54969c50906211501l7c6ae730l1082f8ed3894d196@mail.gmail.com>
	<1245622318.21943.0.camel@localhost>
	<d54969c50906211624w1b701a92xbe1e396356c72a7c@mail.gmail.com>
	<1245628845.13319.10.camel@localhost>
	<d54969c50906221044x1f8070b0s1fe802f08c63e7@mail.gmail.com>
	<s5h3a9sm8oa.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f171.google.com (mail-qy0-f171.google.com
	[209.85.221.171])
	by alsa0.perex.cz (Postfix) with ESMTP id 891F32468D
	for <alsa-devel@alsa-project.org>;
	Mon, 22 Jun 2009 23:51:55 +0200 (CEST)
Received: by qyk1 with SMTP id 1so4158036qyk.16
	for <alsa-devel@alsa-project.org>; Mon, 22 Jun 2009 14:51:51 -0700 (PDT)
In-Reply-To: <s5h3a9sm8oa.wl%tiwai@suse.de>
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
Cc: Karthik Ramgopal <applefreakpeeps@gmail.com>, Tony Vroon <tony@linx.net>, ALSA development ML <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Well, I used alsa-driver-snapshot.tar.gz now. I see less mixers, as tony
said, and now LFE works and is controlled by the "LFE" slider! The bad thing
is, now microphone does not work. I have tried with both "Int Mic" and "Ext
Mic", the internal microphone does not work.

The file Tony requested, just in case, again:
http://files.getdropbox.com/u/553461/codec0new.txt

Thanks for letting me notice I was using the wrong snapshot Takashi!

Emilio



2009/6/22 Takashi Iwai <tiwai@suse.de>

> At Mon, 22 Jun 2009 14:44:09 -0300,
> Emilio L=F3pez wrote:
> >
> > Tony, I don't see less mixer sliders :/
> >
> > Here is that file's output:
> http://files.getdropbox.com/u/553461/codec0.txt
> >
> > And just in case, a new alsa-info with this new model: http://
> > files.getdropbox.com/u/553461/alsainfotony.txt
>
> Check always alsa-driver*/alsa-kernel/HEAD file to see whether the
> changes you want are really included.  If not there, try to re-fetch
> the alsa-driver-snapshot tarball again.  There can be some delay on
> the server until the contents get sync'ed.  The recent changes can be
> tracked from webgit of sound git repository,
>  http://git.kernel.org/?p=3Dlinux/kernel/git/tiwai/sound-2.6.git;a=3Dsumm=
ary
> The changes specific to HD-audio can be found in topic/hda branch.
>
> Also, use alsa-driver-snapshot.tar.gz, not daily snapshots.
>
>
> Takashi
>
> >
> > Thanks!
> >
> > Emilio
> >
> > 2009/6/21 Tony Vroon <tony@linx.net>
> >
> >     On Sun, 2009-06-21 at 20:24 -0300, Emilio L=F3pez wrote:
> >     > Yes, I unmuted and raised up everything.
> >
> >     To confirm, if the 6530g model took effect, you will have
> >     (significantly) less mixer sliders then usual.
> >     Assuming that it did, could you get me /proc/asound/card0/codec#0
> output
> >     with the 6530g model active please.
> >
> >     Based on an earlier report you sent, I think I see the problem.
> However,
> >     I'd rather be sure.
> >
> >     Regards,
> >     Tony V.
> >
> >
>
