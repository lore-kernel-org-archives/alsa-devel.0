From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Alsa-OSS Duplex bug (revisited)
Date: Wed, 30 May 2007 08:47:14 +0200
Message-ID: <1180507634.27605.1192457693@webmail.messagingengine.com>
References: <200705272323.13056.gineera@aspect135.co.uk>
	<s5hodk3zi09.wl%tiwai@suse.de>
	<200705292316.17947.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id CC6A824409
	for <alsa-devel@alsa-project.org>;
	Wed, 30 May 2007 08:47:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200705292316.17947.gineera@aspect135.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alan Horstmann <gineera@aspect135.co.uk>, ALSA devel <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Alan Horstmann wrote:
> On Tuesday 29 May 2007 17:55, you wrote:
> > While I see the advantage by your hack (small and backward
> > compatible), I feel that it's too hackish -- it introduces an
> > incompatible way of the existing ioctl.
> 
> Do you mean in that ioctls in general are not meant to work like that, in 
> effect passing 2 numbers rather than one?

No, packing two values into one numbers is done with other ioctls too,
e.g., SNDCTL_DSP_SETFRAGMENT.

The problem I see is that your patch changes the OSS API in a way that
is incompatible with every implementation other than ALSA's.  The whole
purpose of providing the OSS API in the first place is to be compatible
with other implementations.

> > After a quick thought, another possible fix would be to let apps open
> > each direction separately.  For that,
> >
> > - add some way to make the given PCM stream to non-fullduplex
> >   (proc or module options?)
> 
> Are you thinking that if an option were set, Alsa-OSS would create separate 
> devices for capture and playback rather than a single duplex device? 

No; just a way to disable DSP_CAP_DUPLEX and/or SNDCTL_DSP_SETDUPLEX.
When these do not work, applications are forced to open the playback
and capture devices separately, e.g.:

fd_playback = open("/dev/dsp", O_WRONLY);
fd_capture = open("/dev/dsp", O_RDONLY);

> > - change portaudio to open each direction separately, O_RDONLY and
> >   O_WRONLY at first, then use O_RDWR as fallback

This would be the preferred way.  After all, this is the only way that
is possible with the existing OSS API when you want to use different
sample formats, and it is recommended in all cases (see
<http://manuals.opensound.com/developer/full_duplex.html>).


Regards,
Clemens
