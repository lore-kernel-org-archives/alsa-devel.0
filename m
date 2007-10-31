From: Peter Plessas <plessas@mur.at>
Subject: Re: via82xx DC offset at -30dB
Date: Wed, 31 Oct 2007 16:08:23 +0100
Message-ID: <20071031150823.GA30849@mur.at>
References: <20071029004434.GD32311@mur.at> <s5hy7djofdo.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fox.mur.at (fox.mur.at [89.106.208.7])
	by alsa0.perex.cz (Postfix) with ESMTP id 4C5602438D
	for <alsa-devel@alsa-project.org>; Wed, 31 Oct 2007 16:08:28 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hy7djofdo.wl%tiwai@suse.de>
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

* Takashi Iwai <tiwai@suse.de> [2007-10-31 11:47]:
> At Mon, 29 Oct 2007 01:44:34 +0100,
> Peter Plessas wrote:
> > 
> > Dear List,
> > 
> > having a Compaq Presario notebook in front of me, running Debian testing
> > and a 2.6.18-4-686 kernel, i have a strange DC offset when trying to
> > record audio via the mic/line input. As the audacity level meters
> > suggest, it resides at -30dBFS.
> > Audio comes through and gets recorded though, but the offset severely
> > limits the headroom of course.
> > The sensitivity of the line/mic input seems to be quite high, although i
> > have the mic boost setting turned off of course.
> > Setting the module option ac97_quirk=yes did not help either.
> > Can it be that a soundcard of this strange behavior is manufactured, or
> > is it an alsa/driver issue? I really don't want to install another M$
> > operating system to check if it works there, so any help is deeply
> > appreciated.
> > 
> > lspci lists the device as:
> > 00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686
> > AC97 Audio Controller (rev 20)
> 
> AFAIK, there is no specific issue about recording (capture) in via82xx
> driver.  So, it should be likely about AC97 codec, if it really
> matters.
> 
> The first thing is to show your mixer setting.  Run "alsactl -f
> somefile store" and the file contains the mixer status.  You can show
> here together with the contents of /proc/asound/card0/codec97#0/*
> files.
> 
> Also, trying another apps, such as, arecord is a good test.  In
> addition, it's worth to upgrade the ALSA driver version, too.
> 
> 
> Takashio

I just checked with a windows installation, and there the DC is
appearing too. Also with arecord it is the same.
So it might really be the hardware... argh!

alsactl -f file:
http://mona.mur.at/alsactl.txt

cat /proc/asound/card0/codec97#0/:
http://mona.mur.at/ac97_0-0.txt
http://mona.mur.at/ac97_0-0+regs.txt

I might need to get an external soundcard it seems. I wonder how hard it
is to find a working usb stereo card.

Thanks for the help!

Peter
