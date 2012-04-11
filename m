From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: USB audio devices on Audio 4DJ and similar
Date: Wed, 11 Apr 2012 18:00:11 +0100
Message-ID: <201204111800.11300.gineera@aspect135.co.uk>
References: <201204062209.21564.gineera@aspect135.co.uk>
	<201204111159.18537.gineera@aspect135.co.uk>
	<4F85A083.2020302@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.ip01ir2.opaltelecom.net (out1.ip01ir2.opaltelecom.net
	[62.24.128.237]) by alsa0.perex.cz (Postfix) with ESMTP id F33D3248D4
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Apr 2012 18:58:08 +0200 (CEST)
In-Reply-To: <4F85A083.2020302@gmail.com>
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
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi again Daniel,

On Wednesday 11 April 2012 16:17, Daniel Mack wrote:
> On 11.04.2012 12:59, Alan Horstmann wrote:
> > These are essentially issues in the way Portaudio interfaces; I am not
> > suggesting driver bugs etc, but in summary:
> >
> > a) The Audio 4DJ uses fixed _BE format, almost uniquely AFAICT from
> > grepping driver source tree.  Portaudio at present requests formats in
> > the host platform endianness - so on a x86 PC an acceptable format is not
> > available from the 'hw' device.  Users seem reluctant to use 'plughw'.
>
> Erm. Class compliant USB cards speak _LE formats only, and I'm not aware
> of any hardware that is able to switch endianess on a run-time
> configuration base.

Are you referring to USB cards?  It looked to me like several PCI cards listed 
_BE and _LE variants of some formats in the driver?

> Does that mean PortAudio is unable to feed these 
> cards on BE hosts like PowerPC? Does the host endianess always
> have to match the audio stream format? I certainly doubt that.

Surprisingly, when using the hw device, I think that would be the case at 
present.

> From what I know, PortAudio is just a thin layer on top of ALSA and
> other sound APIs to ease the pain of cross-platform development of audio
> applications, right? What's wrong with letting ALSA convert the samples
> for you then?

That has been my perspective too, to use 'plughw' but some audio users believe 
the plug layer will necessarily give worse latency etc, and always want to 
get "as close as possible to the hardware".

> > b) Subdevices are not enumerated by Portaudio at present, and so only 2
> > of the 4 channels can be accessed.  If the unit had presented a single
> > 4-channel device all the channels would have been available.
>
> Ok, I see your problem, but certainly, PortAudio is the place to get
> this fixed, not the driver.

Yes, but listing all subdevices does have it's own problems, as some cards 
have large numbers of them, for some reason.

> > I am just interested whether you think it would be possible for the
> > driver to be modified to support a single 4-ch device, perhaps through a
> > module option?
>
> Technically, it would certainly. But the problem is that there are quite
> a number of applications out there using these devices and making their
> assumptions about the implementation as it stands. So we won't accept a
> patch that changes the behaviour of these cards for all users.
>
> So clearly, the issues you're seeing are due to missing features in
> PortAudio, and it should be fairly easy to add them there.

Well, I don't think it will be easy in fact, due to the constraints of a 
multi-platform API that is largely shaped by platforms other than Alsa, but 
it should be resolved in Portaudio, one way or another.

Thanks for your assistance,

Alan
