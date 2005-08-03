From: Chow Raymond <usher_raymond82@yahoo.com>
Subject: Re: Problem in testing ALSA
Date: Tue, 2 Aug 2005 18:21:25 -0700 (PDT)
Message-ID: <20050803012126.87440.qmail@web54607.mail.yahoo.com>
References: <1122955779.3847.0.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1122955779.3847.0.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Basically I want to test whether ALSA is working on my
board or not. I got the ALSA driver built in to the
kernel and then installed ALSA libraries and utils.
When I perform aplay, I get this error.

[root@ARMCore /]$ aplay /home/test/decoded_4350.wav
ALSA lib pcm.c:1962:(snd_pcm_open_noupdate) Unknown
PCM default
aplay: main:507: audio open error: No such file or
directory

I suspect that I need the snd_pcm module loaded before
aplay could work. Thus, I need to modprobe soundcore
module before I can modprobe snd_pcm module.

Hope you get a clearer picture. Willing to clarify
more if you need more information. Hope to hear from
you soon.=20

Thanks.

Regards

--- Lee Revell <rlrevell@joe-job.com> wrote:

> On Mon, 2005-08-01 at 18:12 -0700, Chow Raymond
> wrote:
> > Hi,
> >=20
> > I encounter this problem.
> >=20
> > [root@ARMCore user]$ modprobe soundcore
> > modprobe: /lib/libc.so.6: version `GLIBC_2.2.3'
> not
> > found (required by mod)
> >=20
> > Do I need GLIBC? If yes, where do I get it and
> where
> > shall I install it?
>=20
> You can't link a kernel module against glibc.
>=20
> What are you trying to do?
>=20
> Lee
>=20
>=20
>=20
>
-------------------------------------------------------
> SF.Net email is sponsored by: Discover Easy Linux
> Migration Strategies
> from IBM. Find simple to follow Roadmaps,
> straightforward articles,
> informative Webcasts and more! Get everything you
> need to get up to
> speed, fast.
>
http://ads.osdn.com/?ad_id=3D7477&alloc_id=3D16492&op=3Dclick
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
>
https://lists.sourceforge.net/lists/listinfo/alsa-devel
>=20


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around=20
http://mail.yahoo.com=20


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=3D7477&alloc_id=3D16492&op=3Dclic=
k
