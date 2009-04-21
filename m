From: Nicola Mfb <nicola.mfb@gmail.com>
Subject: Re: Asterisk 1.4.17 and alsa 1.0.19 dmix plugin
	problem.
Date: Tue, 21 Apr 2009 12:35:28 +0200
Message-ID: <359c5480904210335o25d636a4i14b7fe5f7391c839@mail.gmail.com>
References: <359c5480904201122m7a45dbe8hd1f6b597dea57283@mail.gmail.com>
	<alpine.LNX.2.00.0904202039160.4553@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.147])
	by alsa0.perex.cz (Postfix) with ESMTP id 15E8924636
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Apr 2009 12:35:29 +0200 (CEST)
Received: by ey-out-1920.google.com with SMTP id 26so431282eyw.56
	for <alsa-devel@alsa-project.org>; Tue, 21 Apr 2009 03:35:28 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.0904202039160.4553@eeebox2.perex-int.cz>
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

2009/4/20 Jaroslav Kysela <perex@perex.cz>:
> On Mon, 20 Apr 2009, Nicola Mfb wrote:
[...]
> Asterisk does not use snd_pcm_poll_descriptors_revents to translate events
> returned from poll to correct poll event. Also, only file descriptor numb=
er
> from snd_pcm_poll_descriptors() - asterisk should handle correctly return=
ed
> poll events as well.
>
> See chan_alsa.c - readdev / writedev variables and sound_thread().
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0Jaroslav

Hi Jaroslav!
thanks for quick reply and hints!
I finally understand the inverted POLLIN/POLLOUT in dmix. As a quick
check I added writedev to fds set and it worked, now I'll able to
write a patch using poll and demangling revents...
First level documentation on www.alsa-project.org says that you may
use select or poll as you need, should be this corrected?

Thank you again!

     Nicola
