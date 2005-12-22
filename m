From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
Subject: Re: [RFC: 2.6 patch] Makefile: sound/ must come before drivers/
Date: Thu, 22 Dec 2005 14:06:57 -0200
Message-ID: <1135267618.1609.8.camel__37906.3252745711$1135267705$gmane$org@localhost>
References: <Pine.LNX.4.64.0512181641580.4827@g5.osdl.org>
	 <20051220131810.GB6789@stusta.de>
	 <20051220155216.GA19797@master.mivlgu.local>
	 <Pine.LNX.4.64.0512201018000.4827@g5.osdl.org>
	 <20051220191412.GA4578@stusta.de>
	 <Pine.LNX.4.64.0512201156250.4827@g5.osdl.org>
	 <20051220202325.GA3850@stusta.de>
	 <Pine.LNX.4.64.0512201240480.4827@g5.osdl.org>
	 <43A86DCD.8010400@superbug.co.uk> <20051220211359.GA5359@stusta.de>
	 <Pine.LNX.4.64.0512201405550.4827@g5.osdl.org>
	 <s5hslsmzg2y.wl%tiwai@suse.de> <1135198140.7419.9.camel@localhost>
	 <s5hfyolxi3r.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp4.brturbo.com.br (smtp4.brturbo.com.br [200.199.201.180])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 77C53185
	for <alsa-devel@alsa-project.org>; Thu, 22 Dec 2005 17:07:10 +0100 (MET)
In-Reply-To: <s5hfyolxi3r.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Adrian Bunk <bunk@stusta.de>, James Courtier-Dutton <James@superbug.co.uk>, Sergey Vlasov <vsu@altlinux.ru>, Ricardo Cerqueira <v4l@cerqueira.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, video4linux-list@redhat.com, perex@suse.cz, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Em Qui, 2005-12-22 =E0s 16:32 +0100, Takashi Iwai escreveu:
> At Wed, 21 Dec 2005 18:49:00 -0200,
> Mauro Carvalho Chehab wrote:
> >=20
> > > Another workaround is to move the relevant module to sound/* direct=
ory
> > > in order to get a sane initialization order.  It's nothing but a
> > > workaround, though.=20
> > hmmm... this may break saa7134 code, since alsa stuff is dependent of
> > saa7134.ko.
>=20
> If I understand correctly, it must be OK.  Suppose that saa7134-alsa
> is moved to sound (only saa7134-alsa, other saa7134 stuff remains in
> drivers/media/video), the initialization order will be:=20
> saa7134 -> sound core -> saa7134-alsa.
>=20
> Or am I missing something else?
	saa7134-oss.
>=20
>=20
> Takashi
>=20
Cheers,=20
Mauro.



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
