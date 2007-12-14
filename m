From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [Pkg-alsa-devel] Bug#438118: alsa-utils: aplay
 non-blocking mode isn't working
Date: Fri, 14 Dec 2007 11:53:11 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0712141143320.8243@tm8103.perex-int.cz>
References: <s5hzlzkrn8r.wl%tiwai@suse.de>
	<20070927.141629.1300548182.anders@netinsight.se>
	<s5hsl4ktvxn.wl%tiwai@suse.de>
	<20071214.113736.1254634191.anders@netinsight.se>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-238673580-1197629591=:8243"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id C0D33243EE
	for <alsa-devel@alsa-project.org>; Fri, 14 Dec 2007 11:53:11 +0100 (CET)
In-Reply-To: <20071214.113736.1254634191.anders@netinsight.se>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Anders =?iso-8859-1?Q?Bostr=F6m?= <anders@netinsight.se>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>, 438118@bugs.debian.org
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-238673580-1197629591=:8243
Content-Type: TEXT/PLAIN; charset=iso8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 14 Dec 2007, Anders Bostr=F6m wrote:

> >>>>> "TI" =3D=3D Takashi Iwai <tiwai@suse.de> writes:
>=20
>  TI> OK, thanks, I see the problem now.
>  >>=20
>  TI> I don't remember whether it's a feature or a bug.  The drain ioctl
>  TI> rejects the non-block mode.
>  >>=20
>  >> I can understand the idea here, that in non-blocking mode, no call
>  >> should block, ever. But on the other hand, if you call the drain
>  >> ioctl, you probably expect it to work, even in non-blocking mode. Why
>  >> would you otherwise call it?
>=20
>  TI> Yes, that's my opinion, too.  This particular ioctl is to block the
>  TI> operation, so it should be allowed as long as it's called.
>=20
>  TI> But I vaguely remember that we discussed about it, and the current
>  TI> form is the result of that.  Namely, we can call
>  TI> snd_pcm_nonblock(FALSE) explicitly before calling snd_pcm_drain().
>=20
>  TI> Though, I prefer fixing the behavior in the core side to allow the
>  TI> blocking with this call...  Any reasonable objections in mind?
>=20
> Any progress in including a solotion to this bug in mainstream
> alsa & linux kernel? Has anything been done? The patch works fine for
> me...

I think that this proposal breaks basic posix rules. Application should=20
change blocking state itself. And non-blocking snd_pcm_drain() still makes=
=20
sense - it will return state of stream (-EAGAIN - unfinished) or reset PCM=
=20
state to SETUP in case when all data are played.

=09=09=09=09=09=09Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project
--8323584-238673580-1197629591=:8243
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--8323584-238673580-1197629591=:8243--
