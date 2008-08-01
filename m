From: Nitin Mahajan <nitinm76@yahoo.com>
Subject: Re: WM9712 Not Giving output
Date: Fri, 1 Aug 2008 10:27:24 -0700 (PDT)
Message-ID: <482977.63508.qm@web50112.mail.re2.yahoo.com>
References: <20080801160213.GB11735@sirena.org.uk>
Reply-To: nitinm76@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web50112.mail.re2.yahoo.com (web50112.mail.re2.yahoo.com
	[206.190.39.149]) by alsa0.perex.cz (Postfix) with SMTP id C040024481
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Aug 2008 19:27:25 +0200 (CEST)
In-Reply-To: <20080801160213.GB11735@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



HI!

--- On Fri, 1/8/08, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> From: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Subject: Re: [alsa-devel] WM9712 Not Giving output
> To: "Nitin Mahajan" <nitinm76@yahoo.com>
> Cc: alsa-devel@alsa-project.org, "Manuel" <mano@roarinelk.homelinux.net>
> Date: Friday, 1 August, 2008, 9:32 PM
> On Fri, Aug 01, 2008 at 08:31:03AM -0700, Nitin Mahajan
> wrote:
> 
> > I am using a WM9712 codec chip with the AC97
> controller on AMD AU1250.
> > Linux kernel version 2.6.24.2.
> 
> > On AC97 controller's side, I can see the DMA
> happening on the host
> > processor, interrupts also coming.
> 
> This suggests a mixer configuration problem.
> 
> > On the mixer front, I did unmute and set the vol to
> max for PCM and
> > Headphone. I did not find any Master control with this
> chip. Isn't
> > there any master control with this chip?
> 
> No.

If Master is not there, logically are the enough for playback?

amixer set 'PCM' 255 unmute
amixer set 'Headphone' 255 unmute

> 
> > Can some one please throw more light on the Mixer
> part, specific to
> > this chip. 
> 
> > What Mixer controls do I need to set with what values
> for playback and
> > capture respectively with this chip? 
> 
> Check the configuration of the Left HP Mixer and Right HP
> Mixer PCM
> Playback switches.  These should be enabled in order to
> play back via
> the headphone output.
>
While writing the reply , the hardware is not with me.
But I wil check these tommorow. 
> If you still can't get audio output with that please
> send a copy of your
> mixer configuration - run the command
> 
> 	alsactl store -f mixer-config
> 
> to write a file 'mixer-config' with this
> information in it.  Please
> also check your kernel log from when the driver is loaded
> and when you
> configure the mixer.
> 
> There is documentation of the audio paths supported by the
> chip in the
I saw the figure in  the datasheet, its quite explainatory, as to which registers are involved in which path.


> datasheet, available from:
> 
> 	http://www.wolfsonmicro.com/products/WM9712/
> 

> and you may find the audio route mappings in the WM9712
> driver useful to
> refer to - the 'audio_map' table in the driver
> which shows how the parts
> of the device are connected.  The format is { destination,
> control,
> source }.
Thanks and regards

-Nitin

Send instant messages to your online friends http://uk.messenger.yahoo.com 
