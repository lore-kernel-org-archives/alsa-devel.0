From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Which project to choose?
Date: Tue, 20 Jul 2010 09:23:38 +0800
Message-ID: <AANLkTinIcGY_OwOftiZwICap7r_4VviWKqE-2zOZrgQM@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 666F11037F8
	for <alsa-devel@alsa-project.org>;
	Tue, 20 Jul 2010 03:23:40 +0200 (CEST)
Received: by vws9 with SMTP id 9so5385544vws.38
	for <alsa-devel@alsa-project.org>; Mon, 19 Jul 2010 18:23:39 -0700 (PDT)
In-Reply-To: <1279579946.18063.26.camel@localhost.localdomain>
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

2010/7/20 Chris <cpollock@embarqmail.com>

> On Mon, 2010-07-19 at 08:53 +0100, Colin Guthrie wrote:
> > 'Twas brillig, and Raymond Yau at 19/07/10 07:35 did gyre and gimble:
> > > 2010/7/19 Chris <cpollock@embarqmail.com>
> > >
> > >> On Mon, 2010-07-19 at 09:44 +0800, Raymond Yau wrote:
> > >>
> > >>>>
> > >>> Refer to https://qa.mandriva.com/show_bug.cgi?id=56473#c10
> > >>>
> > >>> I have installed mandriva 2010 on virtual box
> > >>>
> > >>> when using xmms and libao output plugin to play system sound
> startup3.wav
> > >>>
> > >>> xmms hang at the end of the playback only when enable buffering in
> libao
> > >>> output plugin.(configure output plugin in xmms, unfortunately default
> is
> > >>> enable buffering buffer size 3000 chunk size 1000)  ,
> > >>>
> > >>> xmms does not hang when you disable the buffer or using
> liboss/libALSA
> > >>> output plugin
> > >>>
> > >>> The last message in the pulseaudio server is
> > >>> D: protocol-native.c  'underrun on libao[xmms] playback stream' , 0
> bytes
> > >> in
> > >>> queue.
> > >>>
> > >>> The sound card seem running since hw_ptr and appl_ptr are increasing
> when
> > >>> cat /proc/asound/card0/pcm0p/sub0/status
> > >>>
> > >>> After a while , the following message appear
> > >>>
> > >>> E:alsa-sink.c : ALSA woke us up to write new data , but there was
> > >> actually
> > >>> nothing to write!
> > >> The above is exactly what I see periodically Raymond, so, what, if
> any,
> > >> is the fix?
> > >>
> > >> Chris
> > >>
> > >>
> > > Do you mean that you cannot reproduce the xmms hang bug on your ens1371
> or
> > > via8237 ?
> > >
> > > xmms always hang/freeze at 4 second as xmms display the total length of
> > > startup3.wav is 5 seconds
> > >
> > > you have to ask mandriva 's maintainer why enable buffering is the
> default
> > > option since xmms did not hang when I disable buffering in libao plugin
> > >
> > > For fefora 10 and 13 , they only provide liboss, libALSA and libpulse
> plugin
> > > for xmms
> > > I have no idea about the chunk size in libao plugin
> >
> >
> > With a clean user account, I could not reproduce either problem with the
> > default settings.
> >
> > FWIW, running PA under virtualbox is quite different to running it under
> > a real system. For example PA will enable the non-timer based mode
> > automatically when under a virtual machine.
> >
> > Col
> >
> >
>
> Colin, I've just re-enabled PA using the Ensoniq/Creative AudioPCI
> ES1371+ driver, this is according to the Mandriva Control Center sound
> setup. However, it also shows the VIA VT82xx audio driver when initially
> loaded, when I click on 'ok' it shows the Ensoniq driver. I've again run
> pulseaudio -k ; pulseaudio -vvvvv while playing a cd with mplayer. I've
> uploaded the output here:
>
> http://ez-files.net/953712
>
> Does this have any meaning?
>
> Thanks for any assistance.
>
> Chris
>
>

Please note that alsaplayer is not aplay

you can easily make underrun/overrun occur on pulse device by specify a
buffer size which is smaller than PA server used

aplay -Dpulse -v --buffer-size=128 /usr/share/sounds/*.wav

arecord -v -Dpulse -f cd -d 60 --buffer-size=128 test.wav

can you provide pulseaudio log  for the underrun/overrun by aplay/arecord ?

mandriva 2010 seem still support ALSA OSS emulation

unless you have a hardware mixing sound card , you have to configure your
gmplayer to use alsa or pulse

more .mplayer/gui.conf
ao_driver = "oss"   <--------pulse or alsa
ao_alsa_device = "hw:0,0"    <----- pulse or default
