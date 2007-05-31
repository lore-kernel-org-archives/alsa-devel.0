From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: Alsa-OSS Duplex bug (revisited)
Date: Thu, 31 May 2007 22:00:25 +0100
Message-ID: <200705312200.25483.gineera@aspect135.co.uk>
References: <200705272323.13056.gineera@aspect135.co.uk>
	<200705292316.17947.gineera@aspect135.co.uk>
	<1180507634.27605.1192457693@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.talktalk.net (wmsmtp.opaltelecom.net [62.24.128.253])
	by alsa0.perex.cz (Postfix) with ESMTP id 039BA2460C
	for <alsa-devel@alsa-project.org>;
	Thu, 31 May 2007 22:51:16 +0200 (CEST)
In-Reply-To: <1180507634.27605.1192457693@webmail.messagingengine.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <cladisch@fastmail.net>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wednesday 30 May 2007 07:47, you wrote:
> Alan Horstmann wrote:
> > On Tuesday 29 May 2007 17:55, you wrote:
> > > While I see the advantage by your hack (small and backward
> > > compatible), I feel that it's too hackish -- it introduces an
> > > incompatible way of the existing ioctl.
> >
> > Do you mean in that ioctls in general are not meant to work like that, in
> > effect passing 2 numbers rather than one?
>
> No, packing two values into one numbers is done with other ioctls too,
> e.g., SNDCTL_DSP_SETFRAGMENT.
>
> The problem I see is that your patch changes the OSS API in a way that
> is incompatible with every implementation other than ALSA's.  The whole
> purpose of providing the OSS API in the first place is to be compatible
> with other implementations.
>
> > > After a quick thought, another possible fix would be to let apps open
> > > each direction separately.  For that,
> > >
> > > - add some way to make the given PCM stream to non-fullduplex
> > >   (proc or module options?)
> >
> > Are you thinking that if an option were set, Alsa-OSS would create
> > separate devices for capture and playback rather than a single duplex
> > device?
>
> No; just a way to disable DSP_CAP_DUPLEX and/or SNDCTL_DSP_SETDUPLEX.
> When these do not work, applications are forced to open the playback
> and capture devices separately, e.g.:
>
> fd_playback = open("/dev/dsp", O_WRONLY);
> fd_capture = open("/dev/dsp", O_RDONLY);
>
> > > - change portaudio to open each direction separately, O_RDONLY and
> > >   O_WRONLY at first, then use O_RDWR as fallback
>
> This would be the preferred way.  After all, this is the only way that
> is possible with the existing OSS API when you want to use different
> sample formats, and it is recommended in all cases (see
> <http://manuals.opensound.com/developer/full_duplex.html>).

My reading of the 4Front info is different.  I read that they recommend best 
opening SEPARATE devices, one O_RDONLY and the other O_WRONLY, in their 
scheme called 'twodevice'.  It also states in fulldup.c:-

"... The one device full duplex scheme requires that the device file is opened 
with O_RDWR."

Whereas what is being suggested here is to open /dev/dsp twice simultaneously, 
O_RDONLY and O_WRONLY which 4Front definitely doesn't propose.

The crutial point is that Alsa-OSS at present isn't really compatible with 
4Front etc BECAUSE they implement separate NON-duplex devices for each 
capture and playback channel pair, whereas Alsa-OSS just has one, duplex!  If 
for example I use the 4Front driver for my DMX6fire, then 
(-see:	http://manuals.opensound.com/developer/oss_devices.html)

I would have 11 non-duplex devices, which can be opened separately to record 
and play to the card without the channels-set problem.  With Alsa-OSS I have 
just one!  Even if Alsa-OSS had just the 'all outputs' and 'all inputs' 
devices that would be fine.

It seems odd that an OSS emulated device is provided to an audio card that 
could have differing numbers of capture and playback channels, eg 4 capture 
and 2 playback, but it is impossible to set 4C and 2P when opening it for 
simultaneous capture and playback.  The underlying stream has no problem with 
doing so, it is just there is no way to pass the numbers.  My workaround is 
to solve an incompatibility that already exists.  It seems 4Front avoids this 
by creating non-duplex devices.  The patch extends the functionality of the 
ioctl in a way that only Alsa-OSS may need, (or perhaps all OSS should 
adopt?).

Alan
