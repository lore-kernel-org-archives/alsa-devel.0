From: "Seth Forshee" <seth.forshee@gmail.com>
Subject: Re: [PATCH] fix typo/compilation error on soc-dapm and
	at91-i2s
Date: Fri, 29 Dec 2006 08:21:33 -0600
Message-ID: <d35cec70612290621r7e02ccb7x559090e4a658440b@mail.gmail.com>
References: <200612281832.23268.rss@barracuda.es>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <200612281832.23268.rss@barracuda.es>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: =?ISO-8859-1?Q?Ra=FAl_S=E1nchez_Siles?= <rss@barracuda.es>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 12/28/06, Ra=FAl S=E1nchez Siles <rss@barracuda.es> wrote:
>   Hello all:
>
>   I'm trying to use asoc for an at91 custom board and I had some problem
> compiling the kernel with the v1.0.14rc1 alsa patch. The problem were in =
the
> debug sections in two files.
>
>   I attach a patch to correct this problems. I'm new sending patches to a=
lsa,
> so if you think I did something wrong just let me know and I'll do my bes=
t.
>

I think that the line you modified in soc-dapm.c can be removed
completely, since the loop is list_for_each_entry() and not
list_for_each().  The assignment to p in the loop is redundant.

Cheers,
Seth

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
