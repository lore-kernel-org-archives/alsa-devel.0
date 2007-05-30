From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: Alsa-OSS Duplex bug (revisited)
Date: Wed, 30 May 2007 23:12:13 +0100
Message-ID: <200705302312.13399.gineera@aspect135.co.uk>
References: <200705272323.13056.gineera@aspect135.co.uk>
	<1180507634.27605.1192457693@webmail.messagingengine.com>
	<s5h1wgyz1ha.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.talktalk.net (wmsmtp.opaltelecom.net [62.24.128.253])
	by alsa0.perex.cz (Postfix) with ESMTP id 7FD642452A
	for <alsa-devel@alsa-project.org>;
	Thu, 31 May 2007 00:03:21 +0200 (CEST)
In-Reply-To: <s5h1wgyz1ha.wl%tiwai@suse.de>
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
To: ALSA devel <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

On Wednesday 30 May 2007 18:05, Takashi wrote:
> At Wed, 30 May 2007 08:47:14 +0200,
>
> Clemens Ladisch wrote:
> > Alan Horstmann wrote:
> > > On Tuesday 29 May 2007 17:55, Takashi wrote:
>
> > > > After a quick thought, another possible fix would be to let apps open
> > > > each direction separately.  For that,
> > > >
> > > > - add some way to make the given PCM stream to non-fullduplex
> > > >   (proc or module options?)
> > >
> > > Are you thinking that if an option were set, Alsa-OSS would create
> > > separate devices for capture and playback rather than a single duplex
> > > device?
> >
> > No; just a way to disable DSP_CAP_DUPLEX and/or SNDCTL_DSP_SETDUPLEX.
> > When these do not work, applications are forced to open the playback
> > and capture devices separately, e.g.:
> >
> > fd_playback = open("/dev/dsp", O_WRONLY);
> > fd_capture = open("/dev/dsp", O_RDONLY);

So are you saying that the same device can reliably be opened both O_RDONLY 
and O_WRONLY -AT THE SAME TIME but with different numbers of channels?  That 
is a bit counter-intuitive given the ONLY part, but if true would probably 
provide a workable solution.

> I thought of a similar hack but it seems that many apps don't check /
> set DUPLEX capability.  So, this might not work on many apps.
>
> > > > - change portaudio to open each direction separately, O_RDONLY and
> > > >   O_WRONLY at first, then use O_RDWR as fallback
> >
> > This would be the preferred way.  After all, this is the only way that
> > is possible with the existing OSS API when you want to use different
> > sample formats, and it is recommended in all cases (see
> > <http://manuals.opensound.com/developer/full_duplex.html>).

But note that the 4front OSS creates lots of devices -see 
http://manuals.opensound.com/developer/oss_devices.html
so they can be opened sparately always.

> Right.  For example, in the case of audacity, the change would be like
> the following patch (untested).

Well I quickly hacked something similar to try, and did seem to be able to 
open input_handle and output_handle separately, and have Audacity 'Duplex 
recording' so that could be fine.  I will do more testing and report back!

Alan
