From: Reimar =?utf-8?b?RMO2ZmZpbmdlcg==?= <Reimar.Doeffinger@stud.uni-karlsruhe.de>
Subject: Re: Memleak with mixer? Or incorrect code?
Date: Tue, 18 Jan 2005 20:15:15 +0000 (UTC)
Message-ID: <loom.20050118T211231-999@post.gmane.org>
References: <20050112112320.GA5411@rz.uni-karlsruhe.de> <s5hpt09i7fp.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai <tiwai <at> suse.de> writes:
> At Wed, 12 Jan 2005 12:23:20 +0100,
> Reimar D=C3=B6ffinger wrote:
> > the attached code consumes more and more memory when I run it (with a=
lsa
> > 1.0.3 as included in SuSE 9.1).
[...]
> > Any hints on that??
>=20
> Yep, it hits a memory leak bug.
> The patch below should fix it.

Saw it is in CVS now. Thanks for fixing.

Greetings,
Reimar D=C3=B6ffinger




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
