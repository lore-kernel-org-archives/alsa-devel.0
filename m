From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Application supporting forward/rewind APIs
Date: Fri, 2 Oct 2009 11:53:22 +0800
Message-ID: <4f3252890910012053y2e1d10ap4f301c5db0f070eb@mail.gmail.com>
References: <2ee9e08d0909240034t6fdab6aftc24e733621638f09@mail.gmail.com>
	<s5hocp0vlm6.wl%tiwai@suse.de>
	<4f3252890909240057l1a2b5b88m861dea551f69afce@mail.gmail.com>
	<2ee9e08d0909240201l5cf5675m111b6da1434cff60@mail.gmail.com>
	<4f3252890909252059t3d8cc2aaqffc880991d148e56@mail.gmail.com>
	<2ee9e08d0909290213r3ca53b6cq5909bcf79752a26c@mail.gmail.com>
	<4AC1D68E.7040702@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f179.google.com (mail-pz0-f179.google.com
	[209.85.222.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 4B8B91037FF
	for <alsa-devel@alsa-project.org>;
	Fri,  2 Oct 2009 05:53:23 +0200 (CEST)
Received: by pzk9 with SMTP id 9so746706pzk.16
	for <alsa-devel@alsa-project.org>; Thu, 01 Oct 2009 20:53:22 -0700 (PDT)
In-Reply-To: <4AC1D68E.7040702@ladisch.de>
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

Do you mean that the application can use snd_pcm_rewind() to rewind the
application pointer to hardware pointer and rewrite the next sample ( behind
the hardware pointer ) for usb audio driver ? ( real time mixing like
pulseaudio )



2009/9/29 Clemens Ladisch <clemens@ladisch.de>

> Anuj Aggarwal wrote:
> > I found the solution, one can use mplayer to test forward/rewind
> > feature of ALSA library.
>
> mplayer disables ALSA's underrun detection and uses snd_pcm_forward() to
> recover from an underrun, if it happens.
>
> (To force an underrun, press Ctrl+S (then Ctrl+Q) to prevent mplayer
> from updating its status line.)
>
>
> HTH
> Clemens
>
