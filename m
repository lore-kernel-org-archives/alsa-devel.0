From: Arun Raghavan <arun.raghavan@collabora.co.uk>
Subject: Re: Event flood on USB disconnect
Date: Tue, 04 Oct 2011 08:40:43 +0530
Message-ID: <1317697927.31863.21.camel@snowflake>
References: <1317459007.6559.18.camel@snowflake>
	<1317459237.6559.20.camel@snowflake>
	<CAN8cciZi1JYKRU8tWF4gmG_O9vSf88zBrhXyrC1iRNNC3eT12Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [93.93.128.226])
	by alsa0.perex.cz (Postfix) with ESMTP id D2E162439F
	for <alsa-devel@alsa-project.org>;
	Tue,  4 Oct 2011 05:10:39 +0200 (CEST)
In-Reply-To: <CAN8cciZi1JYKRU8tWF4gmG_O9vSf88zBrhXyrC1iRNNC3eT12Q@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 2011-10-04 at 10:30 +0800, Raymond Yau wrote:
> 2011/10/1 Arun Raghavan <arun.raghavan@collabora.co.uk>:
> > On Sat, 2011-10-01 at 14:19 +0530, Arun Raghavan wrote:
> >> Hi folks,
> >> We're seeing a problem when disconnecting USB headsets in PulseAudio.
> >> Steps to reproduce are basically: start PulseAudio, plug in USB device,
> >> wait for it to suspend (pcm is closed but mixer is not), disconnect.
> >> Fairly often, this results in PA getting killed because the polling
> >> thread is realtime and exceeds its rlimit. The problem is not limited to
> >
> > Missed one detail -- I've only seen this happen on the alsa-source
> > thread, not on alsa-sink, but I've only tested with one device which has
> > playback as well as capture.
> >
> > -- Arun
> >
> 
> Cannot reproduced this issue on ubuntu 11.04 Live CD with Logictech WebCam mic

Thanks for trying this out.

> PA server still keep running and Gnome Sound Preference automatically
> change the selected "input device" from USB microphone to on-board
> sound card when usb webcam is unplugged
> 
> Actully Gnome Sound Preference is lying about "no application is using
> the sound card"  since it open the "monitor" at 25Hz (peak-detect" for
> displaying the vumeter of the microphone

Sorry, my bad for not noticing this -- the code that polls the mixer fds
got added in PulseAudio 1.0,. Ubuntu 11.04 runs PA 0.9.23. Could you try
with an updated PA (and just to make sure, without the GNOME Sound
Preferences dialog open, since that'll keep the device open and the
disconnect gets handled earlier while polling the pcm).

Cheers,
Arun
