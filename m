From: =?iso8859-15?Q?Nicolas_H=FCppelsh=E4user?= <nh@emlix.com>
Subject: Re: snd_pcm_commit asserts
Date: Fri, 11 Jun 2004 12:15:00 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E1BYj3t-0001eU-00@mailer.emlix.com>
References: <Pine.LNX.4.58.0406111146060.1785@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0406111146060.1785@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: =?iso8859-15?Q?Nicolas_H=FCppelsh=E4user?= <nh@emlix.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


On Fri, 11 Jun 2004, Jaroslav Kysela wrote:

> On Fri, 11 Jun 2004, Nicolas H=FCppelsh=E4user wrote:
>
> > Hello!
> >
> > Using alsa 1.0.4 the following problem occurs.
> >
> > If in between a snd_pcm_mmap_begin and snd_pcm_mmap_commit a xrun occur=
ed
> > I'm not (always) able to do a successful commit.
> >
> > If in XRUN state the snd_pcm_mmap_commit returns error code -32 (broken
> > pipe). Getting this I do xrun recovery with bringing alsa into state
> > PREPARED and repeating the snd_pcm_mmap_commit call. Some times this ma=
y
> > succeed but most of the time it fails again, this time with an assertio=
n:
> >
> > pcm.c:5945: snd_pcm_mmap_commit: Assertion `offset =3D=3D *pcm->appl.pt=
r %
> > pcm->buffer_size' failed.
>
> Did you call snd_pcm_mmap_begin() after xrun recovery again?

No I did not.  If I need to it takes me to the following questions:

(1) Does this mean in case of an xrun my mmap region got "unmapped"?

(2) Why does my second snd_pcm_mmap_commit call not fail every time then
    but only "most of the time"?

(3) The mmap region obtained via the "re-begin" - does it match the region
    previously obtained --- is it the same as before?

(4) In playback case - do I have to rewrite the data?

(5) What happens to the application frame pointer in xrun case?

Thanks in advance
=09Nicolas



-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the
one installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
