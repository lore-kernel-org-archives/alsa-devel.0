From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Which project to choose?
Date: Thu, 22 Jul 2010 19:42:27 +0800
Message-ID: <AANLkTilSb9sdZA5eKK8aw8wqSaCwzQFJnYGPhbtiZsjr@mail.gmail.com>
References: <1279062131.24837.22.camel@localhost.localdomain>
	<AANLkTikEf4gf-oeQf4hNGUEvNi0YVrvutnSMCbxGwtJ8@mail.gmail.com>
	<1279065709.24837.29.camel@localhost.localdomain>
	<AANLkTimdM5__SzYFxrQqwsbOrxdit2uWOvkazPvZ4PND@mail.gmail.com>
	<1279071115.29042.0.camel@localhost.localdomain>
	<AANLkTimNSRELBq7i1Ypi9K2tmFu9NKLvQAOOqPwuU13x@mail.gmail.com>
	<1279074303.29042.3.camel@localhost.localdomain>
	<AANLkTimNYxIm9M6Mglrzh3YtJRiq1C8wdZwx-JUhLk9d@mail.gmail.com>
	<1279145758.29042.11.camel@localhost.localdomain>
	<AANLkTinN15BWNC2cn78rc5xCSXNo79SDE2_WkBNEg5I2@mail.gmail.com>
	<1279157921.2668.1.camel@localhost.localdomain>
	<i1n0mf$87c$1@dough.gmane.org>
	<AANLkTil8Zq_uJrdT2jcVSSDW-LN0OxpnHcGnI9aBR4Zz@mail.gmail.com>
	<1279508164.22741.27.camel@localhost.localdomain>
	<AANLkTilHj1RR50u0kN7cedIuV72qxqvTX1YDriT6ajqi@mail.gmail.com>
	<i210af$6gi$1@dough.gmane.org>
	<1279579946.18063.26.camel@localhost.localdomain>
	<AANLkTinIcGY_OwOftiZwICap7r_4VviWKqE-2zOZrgQM@mail.gmail.com>
	<1279592026.18063.44.camel@localhost.localdomain>
	<AANLkTimcx0Z1pkLJmCrpmBfo2xLA_Dtt-RG4L6V-JTGf@mail.gmail.com>
	<1279664388.18063.51.camel@localhost.localdomain>
	<AANLkTilnHVzNmIOMxkCVjXGwsXdKyC_vI54kpwAFtIh8@mail.gmail.com>
	<1279753075.30218.14.camel@localhost.localdomain>
	<AANLkTiktrlp_FEHO1aF5z9edeugkDyMM4cM0ALBi7Svg@mail.gmail.com>
	<1279760875.7841.1.camel@localhost.localdomain>
	<AANLkTim7iY_w96CPkVIlyB7Z9NGWUIvX2wKwvgu4wdjn@mail.gmail.com>
	<1279766127.7841.11.camel@localhost.localdomain>
	<AANLkTim_FkOXlYihEQikJ8Vpo5zXreCdqQnDW3acsrAu@mail.gmail.com>
	<1279797682.7841.15.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id C56D724390
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Jul 2010 13:42:32 +0200 (CEST)
Received: by vws20 with SMTP id 20so22694vws.38
	for <alsa-devel@alsa-project.org>; Thu, 22 Jul 2010 04:42:31 -0700 (PDT)
In-Reply-To: <1279797682.7841.15.camel@localhost.localdomain>
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

2010/7/22 Chris <cpollock@embarqmail.com>

> On Thu, 2010-07-22 at 11:03 +0800, Raymond Yau wrote:
> >
> >
> > 2010/7/22 Chris <cpollock@embarqmail.com>
> >
> >
> >         >
> >         > AFAIK, the most buggy PA client is pavucontrol because
> >         >
> >         > 1) it has those vumeters which need to get audio data from
> >         the
> >         > playback and capture devices of the sound card ,
> >         > 2) when you move the slider to left ( over 100%) and this
> >         force PA to
> >         > provide software gain
> >         >
> >         > You should notice that the new gnome-volume-control is
> >         actually a
> >         > simplified version of pavucontrol
> >
> >
> >         Hmm, I just pulled up PulseAudio Volume Control and see no
> >         vumeters, I
> >         can't figure out though why the drive thrashing at various
> >         times whether
> >         I have a stream playing or not.
> >
> >
> > Did you click the input device tab page of the gnome volume control ?
> >
> > The vumeter is "Input level"  above the volume control slider ?
> >
> > You should noticed that the following message appear in the pulseaudio
> > log
> >
> > I: source-output.c : Created output 0 "Peak detect" on alsa_input
> >
> > I.source-output:c    application.id = "org.gnome.volume.control"
> > I.source-output:c    media.name = "Peak detect"
> > I.source-output:c    application.name = "GNOME Volume control dialog"
> >
> > when you using mplayer to play music and open pavucontrol to
> >
> > pavucontrol sometime abort suddenly  when you aborte mplayer but this
> > is not 100% reproducible
> >
> > pavucontrol
> > ** ( pavucontrol:3232) : DEBUG: failed to initialize device manager
> > extension: No such extension
> > ** (pavucontrol:3056) : DEBUG: Ignoring sink-input due to it being
> > designated as an event and thuse handled by the event widget
> >
> >
> > The point is after the complete intergration of pulseaudio in to the
> > system ( libcanberra, mixer-applet , ... )
> >
> > I think "pulseaudio -k; pulseaudio -vvvv" is no longer the correct way
> > to debug since there are lots of PA clients running at the desktop
> >
> > You have to ask the mandriva maintainer how to increase the debug
> > level of PA server and have to perform a logout/login to debug the PA
> > server
>
> Thanks Raymond, so I should contact Colin and go from there? I'm not
> sure what to even tell him though. I thank you for all your help.
>
> Chris
>

There are over 15 PA clients running when you are using gnome desktop

running  "pulseaudio -k  " to shutdown PA server , this kill all the PA
clients
restart PA  server by  "pulseaudio -vvvv" , only one or two PA clients (e.g.
consolekit, .. ) can connected back to PA server

This command "pulseaudio -k;pulseaudio -vvvv" cannot  provide a normal
environment to debug PA server since most of PA clients are killed
