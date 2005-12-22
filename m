From: Adrian Bunk <bunk@stusta.de>
Subject: Re: 2.6.15-rc6: boot failure in saa7134-alsa.c
Date: Thu, 22 Dec 2005 01:59:41 +0100
Message-ID: <20051222005941.GK3917__18901.3129020625$1135213214$gmane$org@stusta.de>
References: <Pine.LNX.4.64.0512181641580.4827@g5.osdl.org> <20051220131810.GB6789@stusta.de> <20051220155216.GA19797@master.mivlgu.local> <Pine.LNX.4.64.0512201018000.4827@g5.osdl.org> <20051220191412.GA4578@stusta.de> <1135110930.7822.18.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailout.stusta.mhn.de (mailout.stusta.mhn.de [141.84.69.5])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 5451A1B7
	for <alsa-devel@alsa-project.org>; Thu, 22 Dec 2005 01:59:42 +0100 (MET)
Content-Disposition: inline
In-Reply-To: <1135110930.7822.18.camel@localhost>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
Cc: Linus Torvalds <torvalds@osdl.org>, Sergey Vlasov <vsu@altlinux.ru>, Ricardo Cerqueira <v4l@cerqueira.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, video4linux-list@redhat.com, perex@suse.cz, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 20, 2005 at 06:35:30PM -0200, Mauro Carvalho Chehab wrote:
> Em Ter, 2005-12-20 =E0s 20:14 +0100, Adrian Bunk escreveu:
> > (plus disabling building of saa7134-oss.o because
> > otherwise saa7134-alsa.o wouldn't do anything).=20
>=20
> 	This patch should fix alsa-oss incompatibilities when both are linked
> as module. It will also require either -oss or -alsa if it is staticall=
y
> linked.
>=20
> 	It doesn't address the OOPS because of sound late init.
>=20
> 	Adrian,
>=20
> 	Please test and give us some feedback.

It works and looks good.

Can we get this patch into 2.6.15?

> Cheers,=20
> Mauro.

cu
Adrian

--=20

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
