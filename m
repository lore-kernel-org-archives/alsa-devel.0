From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH] alsa-lib: Conf: Fix channels of ICE1712 to
	10/12
Date: Mon, 28 Mar 2011 17:24:23 +0800
Message-ID: <AANLkTikQiCUpe=EGxP0ML96L1s+R4hwFftm+mqb2XP8r@mail.gmail.com>
References: <4D904851.7090602@canonical.com>
	<alpine.LNX.2.00.1103281043070.4805@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id BDD611038C9
	for <alsa-devel@alsa-project.org>;
	Mon, 28 Mar 2011 11:24:23 +0200 (CEST)
Received: by fxm5 with SMTP id 5so1984178fxm.38
	for <alsa-devel@alsa-project.org>; Mon, 28 Mar 2011 02:24:23 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1103281043070.4805@eeebox2.perex-int.cz>
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

2011/3/28 Jaroslav Kysela <perex@perex.cz>

> On Mon, 28 Mar 2011, David Henningsson wrote:
>
> > I know this issue has been brought up before, without resolution.
> Basically
> > PulseAudio cannot open cards such as M-Audio 2496 and M-Audio Delta
> 1010LT
> > because it does not try to open "front" with 10 channels, only with 2.
> >
> > I think it is reasonable to assume that a front:x stream should be able
> to
> > open with 2 channels only, therefore I'm proposing this fix, and I'm
> applying
> > it to Ubuntu as well, unless you have a better idea.
>
> I applied your change to our git repo . Perhaps we find a better solution
> in future.
>
>                                        Jaroslav
>

But front device cannot be used for capture

I have used David 's alsamixertest to verify that using "front" device of
HDA intel for playback/capture , the softvol plugin "PCM Playback Volume
affect the dB scale
