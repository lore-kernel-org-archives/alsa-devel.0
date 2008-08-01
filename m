From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: WM9712 Not Giving output
Date: Fri, 1 Aug 2008 17:02:19 +0100
Message-ID: <20080801160213.GB11735@sirena.org.uk>
References: <859267.14717.qm@web50109.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id E959B2448F
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Aug 2008 18:09:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <859267.14717.qm@web50109.mail.re2.yahoo.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Nitin Mahajan <nitinm76@yahoo.com>
Cc: alsa-devel@alsa-project.org, Manuel <mano@roarinelk.homelinux.net>
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 01, 2008 at 08:31:03AM -0700, Nitin Mahajan wrote:

> I am using a WM9712 codec chip with the AC97 controller on AMD AU1250.
> Linux kernel version 2.6.24.2.

> On AC97 controller's side, I can see the DMA happening on the host
> processor, interrupts also coming.

This suggests a mixer configuration problem.

> On the mixer front, I did unmute and set the vol to max for PCM and
> Headphone. I did not find any Master control with this chip. Isn't
> there any master control with this chip?

No.

> Can some one please throw more light on the Mixer part, specific to
> this chip. 

> What Mixer controls do I need to set with what values for playback and
> capture respectively with this chip? 

Check the configuration of the Left HP Mixer and Right HP Mixer PCM
Playback switches.  These should be enabled in order to play back via
the headphone output.

If you still can't get audio output with that please send a copy of your
mixer configuration - run the command

	alsactl store -f mixer-config

to write a file 'mixer-config' with this information in it.  Please
also check your kernel log from when the driver is loaded and when you
configure the mixer.

There is documentation of the audio paths supported by the chip in the
datasheet, available from:

	http://www.wolfsonmicro.com/products/WM9712/

and you may find the audio route mappings in the WM9712 driver useful to
refer to - the 'audio_map' table in the driver which shows how the parts
of the device are connected.  The format is { destination, control,
source }.
