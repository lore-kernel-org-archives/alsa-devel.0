From: Nitin Mahajan <nitinm76@yahoo.com>
Subject: Re: WM9712 Not Giving output
Date: Fri, 1 Aug 2008 11:26:36 -0700 (PDT)
Message-ID: <808063.227.qm@web50101.mail.re2.yahoo.com>
References: <200808012023.38353.marek.vasut@gmail.com>
Reply-To: nitinm76@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web50101.mail.re2.yahoo.com (web50101.mail.re2.yahoo.com
	[206.190.38.29]) by alsa0.perex.cz (Postfix) with SMTP id A78A224507
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Aug 2008 20:26:37 +0200 (CEST)
In-Reply-To: <200808012023.38353.marek.vasut@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Marek Vasut <marek.vasut@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org




--- On Fri, 1/8/08, Marek Vasut <marek.vasut@gmail.com> wrote:

> From: Marek Vasut <marek.vasut@gmail.com>
> Subject: Re: [alsa-devel] WM9712 Not Giving output
> To: nitinm76@yahoo.com
> Cc: alsa-devel@alsa-project.org
> Date: Friday, 1 August, 2008, 11:53 PM
> Dne Friday 01 of August 2008 19:59:44 Nitin Mahajan
> napsal(a):
> > HI!
> >
> > --- On Fri, 1/8/08, Marek Vasut
> <marek.vasut@gmail.com> wrote:
> > > From: Marek Vasut <marek.vasut@gmail.com>
> > > Subject: Re: [alsa-devel] WM9712 Not Giving
> output
> > > To: alsa-devel@alsa-project.org,
> nitinm76@yahoo.com
> > > Date: Friday, 1 August, 2008, 11:10 PM
> > > Dne Friday 01 of August 2008 19:27:24 Nitin
> Mahajan
> > >
> > > napsal(a):
> > > > HI!
> > > >
> > > > --- On Fri, 1/8/08, Mark Brown
> > >
> > > <broonie@opensource.wolfsonmicro.com>
> wrote:
> > > > > From: Mark Brown
> > >
> > > <broonie@opensource.wolfsonmicro.com>
> > >
> > > > > Subject: Re: [alsa-devel] WM9712 Not
> Giving
> > >
> > > output
> > >
> > > > > To: "Nitin Mahajan"
> > >
> > > <nitinm76@yahoo.com>
> > >
> > > > > Cc: alsa-devel@alsa-project.org,
> > >
> > > "Manuel"
> <mano@roarinelk.homelinux.net>
> > >
> > > > > Date: Friday, 1 August, 2008, 9:32 PM
> > > > > On Fri, Aug 01, 2008 at 08:31:03AM
> -0700, Nitin
> > >
> > > Mahajan
> > >
> > > > > wrote:
> > > > > > I am using a WM9712 codec chip
> with the AC97
> > > > >
> > > > > controller on AMD AU1250.
> > > > >
> > > > > > Linux kernel version 2.6.24.2.
> > > > > >
> > > > > > On AC97 controller's side, I
> can see the
> > >
> > > DMA
> > >
> > > > > happening on the host
> > > > >
> > > > > > processor, interrupts also coming.
> > > > >
> > > > > This suggests a mixer configuration
> problem.
> > > > >
> > > > > > On the mixer front, I did unmute
> and set the
> > >
> > > vol to
> > >
> > > > > max for PCM and
> > > > >
> > > > > > Headphone. I did not find any
> Master control
> > >
> > > with this
> > >
> > > > > chip. Isn't
> > > > >
> > > > > > there any master control with this
> chip?
> > > > >
> > > > > No.
> > > >
> > > > If Master is not there, logically are the
> enough for
> > >
> > > playback?
> > >
> > > > amixer set 'PCM' 255 unmute
> > > > amixer set 'Headphone' 255 unmute
> > > >
> > > > > > Can some one please throw more
> light on the
> > >
> > > Mixer
> > >
> > > > > part, specific to
> > > > >
> > > > > > this chip.
> > > > > >
> > > > > > What Mixer controls do I need to
> set with
> > >
> > > what values
> > >
> > > > > for playback and
> > > > >
> > > > > > capture respectively with this
> chip?
> > > > >
> > > > > Check the configuration of the Left HP
> Mixer and
> > >
> > > Right HP
> > >
> > > > > Mixer PCM
> > > > > Playback switches.  These should be
> enabled in
> > >
> > > order to
> > >
> > > > > play back via
> > > > > the headphone output.
> > > >
> > > > While writing the reply , the hardware is
> not with me.
> > > > But I wil check these tommorow.
> > > >
> > > > > If you still can't get audio output
> with that
> > >
> > > please
> > >
> > > > > send a copy of your
> > > > > mixer configuration - run the command
> > > > >
> > > > > 	alsactl store -f mixer-config
> > > > >
> > > > > to write a file 'mixer-config'
> with this
> > > > > information in it.  Please
> > > > > also check your kernel log from when
> the driver
> > >
> > > is loaded
> > >
> > > > > and when you
> > > > > configure the mixer.
> > > > >
> > > > > There is documentation of the audio
> paths
> > >
> > > supported by the
> > >
> > > > > chip in the
> > > >
> > > > I saw the figure in  the datasheet, its
> quite
> > >
> > > explainatory, as to which
> > >
> > > > registers are involved in which path.
> > > >
> > > > > datasheet, available from:
> > > > >
> > > > >
> 	http://www.wolfsonmicro.com/products/WM9712/
> > > > >
> > > > >
> > > > > and you may find the audio route
> mappings in the
> > >
> > > WM9712
> > >
> > > > > driver useful to
> > > > > refer to - the 'audio_map'
> table in the
> > >
> > > driver
> > >
> > > > > which shows how the parts
> > > > > of the device are connected.  The
> format is {
> > >
> > > destination,
> > >
> > > > > control,
> > > > > source }.
> > > >
> > > > Thanks and regards
> > > >
> > > > -Nitin
> > > >
> > > > Send instant messages to your online friends
> > >
> > > http://uk.messenger.yahoo.com
> > >
> > > >
> _______________________________________________
> > > > Alsa-devel mailing list
> > > > Alsa-devel@alsa-project.org
> > >
> > >
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> > >
> > > Hi,
> > > try searching the mailing list for "[PATCH]
> wm9712
> > > mono mixer". That may help
> > > you.
> >
> > Interesting, do you mean that "Right HP
> Mixer" and "Left HP Mixer" should
> > be "Right Mixer" and "Left Mixer"
> ?
> >
> > thanks and regards
> >
> > -Nitin
> 
> yea, and you should see alsa warning about it in kernel log
> as well.

Do you mean in dmesg?
Unfortunately I don't have hardware with me now to test. I shall do it tommorow morning.
> >
> > > _______________________________________________
> > > Alsa-devel mailing list
> > > Alsa-devel@alsa-project.org
> > >
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> >
> > Send instant messages to your online friends
> http://uk.messenger.yahoo.com
> 
> This message wasnt CCed to alsa-devel, re-adding.
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

Send instant messages to your online friends http://uk.messenger.yahoo.com 
