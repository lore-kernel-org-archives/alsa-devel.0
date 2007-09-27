From: Anders =?UTF-8?Q?Bostr=C3=B6m?= <anders@netinsight.se>
Subject: Bug#438118: [alsa-devel] [Pkg-alsa-devel] Bug#438118: alsa-utils: aplay non-blocking mode isn't working
Date: Thu, 27 Sep 2007 14:16:29 +0200 (CEST)
Message-ID: <20070927.141629.1300548182.anders@netinsight.se>
References: <s5hsl5dco8l.wl%tiwai@suse.de>
	<20070918.094148.-529052212.anders@netinsight.se>
	<s5hzlzkrn8r.wl%tiwai@suse.de>
Reply-To: Anders =?UTF-8?Q?Bostr=C3=B6m?= <anders@netinsight.se>,
	438118@bugs.debian.org
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <bounce-debian-bugs-dist=glddb-debian-bugs-dist=m.gmane.org@lists.debian.org>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-Message-ID: <handler.438118.B438118.119089543318998@bugs.debian.org>
In-Reply-To: <s5hzlzkrn8r.wl%tiwai@suse.de>
List-Post: <mailto:debian-bugs-dist@lists.debian.org>
List-Help: <mailto:debian-bugs-dist-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=unsubscribe>
To: tiwai@suse.de
Cc: riesebie@lxtec.de, alsa-devel@alsa-project.org, 438118@bugs.debian.org
List-Id: alsa-devel@alsa-project.org

>>>>> "TI" =3D=3D Takashi Iwai <tiwai@suse.de> writes:

 TI> At Tue, 18 Sep 2007 09:41:48 +0200 (CEST),
 TI> Anders Bostr=F6m wrote:
 >> =

 >> >>>>> "TI" =3D=3D Takashi Iwai <tiwai@suse.de> writes:
 >> =

 >> >> can one please have a lokk at this? aplay -N isn't working for t=
he
 >> >> OP.
 >> =

 TI> Cannot reproduce here.  Could you _post_ more details?
 >> =

 >> OK, I've tested more, and discovered that the problem seems to be t=
hat
 >> the end of the sound is cut in non-blocking mode. And if I play a v=
ery
 >> short sound-file, I can't hear anything. Blocking mode works fine.
 >> =

 >> When using non-blocking mode, an strace contains "ioctl(4, 0x4144,
 >> 0x2b9f785d8000)        =3D -1 EAGAIN (Resource temporarily
 >> unavailable)". Blocking mode never contains the EAGAIN response.
 >> =

 >> I attach two files. When playing halt.au, I can only hear the start=
,
 >> about as much as "ha". When playing metal.au, I can't hear anything=
.=


 TI> OK, thanks, I see the problem now.

 TI> I don't remember whether it's a feature or a bug.  The drain ioctl=

 TI> rejects the non-block mode.

I can understand the idea here, that in non-blocking mode, no call
should block, ever. But on the other hand, if you call the drain
ioctl, you probably expect it to work, even in non-blocking mode. Why
would you otherwise call it?

 TI> Anyway, a simple patch is below.  Let me know if it works.

It works fine! Thanks!

/ Anders

 TI> diff -r 0028e39ead78 core/pcm_native.c
 TI> --- a/core/pcm_native.c	Tue Sep 18 00:52:38 2007 +0200
 TI> +++ b/core/pcm_native.c	Tue Sep 18 17:44:31 2007 +0200
 TI> @@ -1368,8 +1368,6 @@ static int snd_pcm_prepare(struct snd_pc
 =

 TI>  static int snd_pcm_pre_drain_init(struct snd_pcm_substream *subst=
ream, int state)
 TI>  {
 TI> -	if (substream->f_flags & O_NONBLOCK)
 TI> -		return -EAGAIN;
 substream-> runtime->trigger_master =3D substream;
 TI>  	return 0;
 TI>  }
