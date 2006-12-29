From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] fix typo/compilation error on	soc-dapm	and
	at91-i2s
Date: Fri, 29 Dec 2006 14:16:10 +0000
Message-ID: <1167401770.11374.67.camel@localhost.localdomain>
References: <200612281832.23268.rss@barracuda.es>
	<1167396924.11374.52.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-oO3SxHiPrUqJufteZcq7"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1167396924.11374.52.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: =?ISO-8859-1?Q?Ra=FAl_S=E1nchez?= Siles <rss@barracuda.es>
Cc: alsa-devel@lists.sourceforge.net, Frank Mandarino <fmandarino@endrelia.com>
List-Id: alsa-devel@alsa-project.org


--=-oO3SxHiPrUqJufteZcq7
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-12-29 at 12:55 +0000, Liam Girdwood wrote:
> On Thu, 2006-12-28 at 18:32 +0100, Ra=C3=BAl S=C3=A1nchez Siles wrote:
> >   Hello all:
> >=20
> >   I'm trying to use asoc for an at91 custom board and I had some prob=
lem=20
> > compiling the kernel with the v1.0.14rc1 alsa patch. The problem were=
 in the=20
> > debug sections in two files.
> >=20
> >   I attach a patch to correct this problems. I'm new sending patches =
to alsa,=20
> > so if you think I did something wrong just let me know and I'll do my=
 best.
> >=20
>=20
> Thanks, this looks fine. Applied to my tree.=20

I've made the following attached alteration the the DAPM debug section
as the list_entry() is not needed. Can you re submit ?

Thanks

Liam




--=-oO3SxHiPrUqJufteZcq7
Content-Disposition: attachment; filename=dapm-debug.patch
Content-Type: text/x-patch; name=dapm-debug.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

diff -r 4eae1a19406e soc/soc-dapm.c
--- a/soc/soc-dapm.c	Thu Dec 28 13:56:48 2006 +0100
+++ b/soc/soc-dapm.c	Fri Dec 29 14:11:27 2006 +0000
@@ -651,7 +651,6 @@ static void dbg_dump_dapm(struct snd_soc
 							p->source->name);
 				}
 				list_for_each_entry(p, &w->sinks, list_source) {
-					p = list_entry(lp, struct snd_soc_dapm_path, list_source);
 					if (p->connect)
 						printk(" out %s %s\n", p->name ? p->name : "static",
 							p->sink->name);

--=-oO3SxHiPrUqJufteZcq7
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--=-oO3SxHiPrUqJufteZcq7
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-oO3SxHiPrUqJufteZcq7--
