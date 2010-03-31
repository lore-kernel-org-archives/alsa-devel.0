From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Handling of the DXS controls in the via82xx driver
Date: Wed, 31 Mar 2010 09:39:14 +0800
Message-ID: <z2x4f3252891003301839kdce78efu170bd4a34d60440c@mail.gmail.com>
References: <4BAE8EF7.20204@gmx.de>
	<1269867371.6760.1367253675@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51])
	by alsa0.perex.cz (Postfix) with ESMTP id CDD43103814
	for <alsa-devel@alsa-project.org>;
	Wed, 31 Mar 2010 03:39:15 +0200 (CEST)
Received: by pwj7 with SMTP id 7so9019778pwj.38
	for <alsa-devel@alsa-project.org>; Tue, 30 Mar 2010 18:39:14 -0700 (PDT)
In-Reply-To: <1269867371.6760.1367253675@webmail.messagingengine.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/3/29 Clemens Ladisch <clemens@ladisch.de>

> Soeren D. Schulze wrote:
>
>
> > mplayer still controls the global PCM volume.  Well,
> > in fact, there is one way.  While an mplayer is running, I can do:
> >
> > amixer cset numid=47,iface=PCM,name='PCM Playback Volume' 24,24
> >
> > When restarting mplayer, the volume is reset to 31,31 (maximum).
>
> The old behaviour was considered buggy: these stream controls are
> logically associated with a stream opened by an application, not with
> a particular hardware stream.
>
> > The bad thing about it is that 31,31 is a really bad setting for my
> > poorly engineered sound card.  It distorts a lot.
>
> If the card cannot handle any loud output, then all outputs from any
> source must be restricted, so the logical place for lower volume would
> be the "Master" or "PCM" controls.
>
>
> Regards,
> Clemens
>
>
Correct me if I am wrong , ac97 codec support 16,18,20 bits resolution and
the ac97 specification mention that if a sample stream of resoultion is less
than 20 bits is transferred through ac97 link, the ac97 controller must
stuff all trailing invalid bits with zero.

This mean that the ac97 controller can provide a maximum of 12 dB gain if
your codec support 20 bits resolution , any gain over 12dB by the ac97
controller will lead to clipping
