From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: snd_pcm_commit asserts
Date: Fri, 11 Jun 2004 11:47:31 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0406111146060.1785@pnote.perex-int.cz>
References: <E1BYiMf-0006Oc-00@mailer.emlix.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E1BYiMf-0006Oc-00@mailer.emlix.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: =?iso8859-15?Q?Nicolas_H=FCppelsh=E4user?= <nh@emlix.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, 11 Jun 2004, Nicolas H=FCppelsh=E4user wrote:

> Hello!
>=20
> Using alsa 1.0.4 the following problem occurs.
>=20
> If in between a snd_pcm_mmap_begin and snd_pcm_mmap_commit a xrun occured
> I'm not (always) able to do a successful commit.
>=20
> If in XRUN state the snd_pcm_mmap_commit returns error code -32 (broken
> pipe). Getting this I do xrun recovery with bringing alsa into state
> PREPARED and repeating the snd_pcm_mmap_commit call. Some times this may
> succeed but most of the time it fails again, this time with an assertion:
>=20
> pcm.c:5945: snd_pcm_mmap_commit: Assertion `offset =3D=3D *pcm->appl.ptr =
%
> pcm->buffer_size' failed.

Did you call snd_pcm_mmap_begin() after xrun recovery again?

=09=09=09=09=09=09Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the
one installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
