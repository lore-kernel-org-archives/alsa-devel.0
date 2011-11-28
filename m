From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: _mmap_playback_avail() short (was: Default device
	XRUNs with perriods=2)
Date: Mon, 28 Nov 2011 11:03:00 +0000
Message-ID: <201111281103.00915.gineera@aspect135.co.uk>
References: <201110311738.52213.gineera@aspect135.co.uk>
	<201111251510.27592.gineera@aspect135.co.uk>
	<CAN8cciZaUPaSt7_L7Yb8K0Ui6y=TSpUokgF_yBTRjb9E9kifvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.ip07ir2.opaltelecom.net (out1.ip07ir2.opaltelecom.net
	[62.24.128.243]) by alsa0.perex.cz (Postfix) with ESMTP id F1C0D243A6
	for <alsa-devel@alsa-project.org>; Mon, 28 Nov 2011 11:56:23 +0100 (CET)
In-Reply-To: <CAN8cciZaUPaSt7_L7Yb8K0Ui6y=TSpUokgF_yBTRjb9E9kifvA@mail.gmail.com>
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
To: alsa-devel@alsa-project.org
Cc: Raymond Yau <superquad.vortex2@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Sunday 27 November 2011 01:40, Raymond Yau wrote:
> 2011/11/25 Alan Horstmann <gineera@aspect135.co.uk>:
> > There's been no take-up on this, but I am seeing a consistent issue, with
> > Alsa from 1.0.12 to 1.0.24, on 2 different machines with different audio
> > hardware which will need to be worked around one way or another, and I
> > wonder which is best?
> >
> > The problem is with poll revents from default device when it includes SR
> > conversion and dmix.

<snip>

Thanks Raymond for avoiding this thread becoming a monologue.

> b0b7d0280f977dee1bbff0a1b4cd0c50068d2371

Thanks; there are a few threads that discuss problems with avail_min, periods 
== 2, and timing inconsistencies.  The more I read over and again it seems 
rather a can-of-worms.

> Do you require the sound card give you accurate playback position ?

No.  Just accurate playback (or capture).  But reliably, on any system, 
without hardware-specific tweaks, 'out-of-the-box'.  Ideally with the 
potential for reasonable latency if the user requests that.  And not 
necessarily only on the 'latest' Alsa versions.

As per this quote from Jaroslav in one of the threads:-

"But it's right that most of simple applications and use cases expect that I/O 
transfers will work even with 2 periods.

That does not work in the 'default' circumstances I am describing here, on 
several hardwares on any Alsa version.

> snd-ymfpci only update hwptr in 5.3ms intervals
>
> it seem that snd-usb-audio update hwptr in 1ms
>
> > It seems the options are:-
> >
> > 1. Use 3 periods and accept worse latency, always filling with
> > avail_frames
>
> snd-ymfpci has periods_min 3
> and there are sound cards with periods_max = 2

Yes, this is the sort of thing that makes it more difficult to create a good 
workaround.

> > 2. Use 3 periods, but only fill partially, so there is, for example,
> > always one period of space after filling, and at a poll nearly 2
> >
> > 3. Ignore the absence of POLLOUT or POLLIN flag, and instead treat the
> > zero revent as good, check avail_frames and fill the buffer

My current thinking (but could change) is for this one; if poll returns 
successfully, and the revent is not POLLERR or POLLHUP, don't check for 
non-zero (POLLIN or POLLOUT) but treat it as a valid period event regardless 
and perform the processing, checking avail_frames etc.

Such an approach effectively removes the check on 
snd_pcm_mmap_playback_avail() in the function snd_pcm_direct_poll_revents().

> > 4. I have misunderstood some detail in the use of Alsa which is causing
> > this, and when corrected the issue will not occur.


Alan
