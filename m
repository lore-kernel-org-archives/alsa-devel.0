From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
Subject: Re: 2.6.15-rc6: boot failure in saa7134-alsa.c
Date: Thu, 22 Dec 2005 09:15:47 -0200
Message-ID: <1135250147.17758.35.camel__18284.457588061$1135250244$gmane$org@localhost>
References: <Pine.LNX.4.64.0512181641580.4827@g5.osdl.org>
	 <20051220131810.GB6789@stusta.de>
	 <20051220155216.GA19797@master.mivlgu.local>
	 <Pine.LNX.4.64.0512201018000.4827@g5.osdl.org>
	 <20051220191412.GA4578@stusta.de> <1135110930.7822.18.camel@localhost>
	 <20051222005941.GK3917@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp4.brturbo.com.br (smtp4.brturbo.com.br [200.199.201.180])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 07FDF1B9
	for <alsa-devel@alsa-project.org>; Thu, 22 Dec 2005 12:15:55 +0100 (MET)
In-Reply-To: <20051222005941.GK3917@stusta.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Adrian Bunk <bunk@stusta.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Sergey Vlasov <vsu@altlinux.ru>, Ricardo Cerqueira <v4l@cerqueira.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, video4linux-list@redhat.com, perex@suse.cz, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Em Qui, 2005-12-22 =E0s 01:59 +0100, Adrian Bunk escreveu:
=20
> > 	This patch should fix alsa-oss incompatibilities when both are linke=
d
> > as module. It will also require either -oss or -alsa if it is statica=
lly
> > linked.
> >=20
> > 	It doesn't address the OOPS because of sound late init.
> >=20
> > 	Adrian,
> >=20
> > 	Please test and give us some feedback.
>=20
> It works and looks good.
>=20
> Can we get this patch into 2.6.15?
	I've sent today to Linus for him to pull for 2.6.15.

Cheers,=20
Mauro.



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
