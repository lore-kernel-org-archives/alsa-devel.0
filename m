From: Halim Sahin <halim.sahin@freenet.de>
Subject: Re: trouble using dmix with tts systems (accessibility
	)
Date: Mon, 23 Mar 2009 12:26:42 +0000 (UTC)
Message-ID: <20090323122638.GA4483@halim>
References: <20090320092802.GA8779@halim> <s5hy6uw5z8s.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id AC4781037E3
	for <alsa-devel@alsa-project.org>; Mon, 23 Mar 2009 13:26:54 +0100 (CET)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LljEz-0002A0-7H
	for alsa-devel@alsa-project.org; Mon, 23 Mar 2009 12:26:53 +0000
Received: from pd9e3ca1f.dip.t-dialin.net ([217.227.202.31])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 23 Mar 2009 12:26:53 +0000
Received: from halim.sahin by pd9e3ca1f.dip.t-dialin.net with local (Gmexim
	0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 23 Mar 2009 12:26:53 +0000
Content-Disposition: inline
In-Reply-To: <s5hy6uw5z8s.wl%tiwai@suse.de>
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

Hello Takashi
On Mo, M=E4r 23, 2009 at 11:07:15 +0100, Takashi Iwai wrote:
> At Fri, 20 Mar 2009 09:28:02 +0000 (UTC),
> Halim Sahin wrote:
> > =

> > hello,
> > =

> > I have asked this question to alsa user list but got no useful answer.
> > =

> > I am a blind linux user and need asistive Technology to use my pc.
> > The problem I have experienced with alsa is that it is sometimes too sl=
ow to stop
> > previous output before starting a new one.
> > The result of this ends in several speech outputs at a time.
> > The problem only occurs if the dmix plugin is used.
> =

> Could you elaborate how the previous output is stopped, and how the
> next sample is started?  Are they different processes, open/close
> sequences, or snd_pcm_drop() / prepare / re-start, or what?

It seems that the speech-server is using the following functions to handle =
sound output through alsa:
snd_pcm_drop, snd_pcm_status..., snd_pcm_prepare, snd_pcm_resume ....

The server can be found here:
http://www.freebsoft.org/pub/projects/speechd/speech-dispatcher-0.6.7.tar.gz
The alsa code can be found in file
speechd_0.6.7/src/audio/alsa.c
 =

> It'd be best if you could show a small test-case program to reproduce
> the problem...
 =

Please have a look to speech-dispatcher , which shows the problem.

I can reproduce the mentioned problem with other apps as well like mplayer.
mplayer -ao alsa *.mp3
During playback simply press right/left for forward/backward.
This step uses dmix if it is enabled!
Then try the same with:
mplayer -ao alsa:device=3Dhw=3D0.0 *.mp3

Please ask if you have more questions.
I.ll be happy if we can find a working solution for the speech stuff.
Thanks a lot
for your response.
Regards
halim
