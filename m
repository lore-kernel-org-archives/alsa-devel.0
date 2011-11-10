From: anish kumar <anish198519851985@gmail.com>
Subject: Playback and capture synchronization
Date: Thu, 10 Nov 2011 23:57:28 +0900
Message-ID: <1320937048.7078.27.camel@anish-Inspiron-N5050>
References: <mailman.1622.1320881582.2097.alsa-devel@alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 6205B2414E
	for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2011 15:57:39 +0100 (CET)
Received: by yenm9 with SMTP id m9so2160092yen.38
	for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2011 06:57:36 -0800 (PST)
In-Reply-To: <mailman.1622.1320881582.2097.alsa-devel@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: plai@codeaurora.org
Cc: linux@audioscience.com, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmciro.com, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org


> > Patrick Lai wrote:
> >> I have a use case requiring playback and capture starting at the same
> >> time. Latency between starting of playback and capture streams need to
> >> be less than few PCM samples. Base on my understanding on ALSA which
> >> does not have the concept of grouping multiple streams,

Is this use case for loopback?Right now i am doing loopback with two
terminals with one terminal running aplay and other arecord and before
running aplay and arecord we use couple of mixer controls to set the
paths but we want to do all this from user space i.e. ALSA UCM(use case
manager) & Android Audio Flinger.We are not using snd-aloop for
loopback.
After reading this thread looks like I need to implement support in
driver to trigger playback and capture at the same time using the api's
mentioned in this thread.
Is my understanding correct?Or am I completely off track here?
Kernel used is:3.0 

> > snd_pcm_link()
> Awesome! I will look into this API
> 
> > If the driver doesn't actually implement starting of linked streams
> > (which would be pointless if the hardware doesn't support it), ALSA
> > calls the second trigger callback after the first one.
> >
> > It might be possible to implement simultaneous starting of two streams.
> > What hardware (driver) are you using?
> It's Qualcomm hardware. As far as I know, HW has this synchronization 
> support but I would have to build driver to make use of this functionality

> To see examples of drivers that support HW linking, search for
> snd_pcm_group_for_each_entry
