From: =?big5?B?IlRpZW4sICBDLkwuIC0gpdCp08KnIg==?= <cltien@cmedia.com.tw>
Subject: RE: no --with-cards parameter in alsa-driver CVS
Date: Wed, 23 Mar 2005 07:31:42 +0800
Message-ID: <92C0412E07F63549B2A2F2345D3DB515F7D6BE@cm-msg-02.cmedia.com.tw>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: quoted-printable
Received: from cm-msg-02.cmedia.com.tw (61-30-17-228.static.tfn.net.tw [61.30.17.228])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id BDA7729A
	for <alsa-devel@alsa-project.org>; Wed, 23 Mar 2005 01:14:20 +0100 (MET)
Content-Class: urn:content-classes:message
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: =?big5?B?IlRpZW4sICBDLkwuIC0gpdCp08KnIg==?= <cltien@cmedia.com.tw>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


I updated the CVS again by co command and the mips directory appear! It =
cannot be created by the update command. There is nothing wrong with the =
alsa-kernel or alsa-driver at all, sorry!

Sincerely,
ChenLi Tien

-----Original Message-----
From:	Tien,  C.L. - =A5=D0=A9=D3=C2=A7
Sent:	2005/3/22 [=ACP=B4=C1=A4G] =A4U=A4=C8 06:04
To:	Takashi Iwai
Cc:	alsa-devel@alsa-project.org
Subject:	RE: [Alsa-devel] no --with-cards parameter in alsa-driver CVS
I found that the command "make ALSAKERNELDIR=3D../alsa-kernel all-deps" =
for CVS build cause problem.

utils/mod-deps --basedir =
/home/cltien/work/alsa-cvs/alsa-driver/alsa-kernel --hiddendir =
/home/cltien/work/alsa-cvs/alsa-driver --acinclude > acinclude.m4
Unable to open file =
/home/cltien/work/alsa-cvs/alsa-driver/alsa-kernel/mips/Kconfig: No such =
file or directory
Error reading Kconfig: No such file or directory
make: *** [acinclude.m4] Error 1

So I create a path for mips and a empty file Kconfig inside it and the =
acinclude.m4 is ok again. Now the --with-cards works again.

There is no mips directory in the CVS.

Sincerely,
ChenLi Tien


-----Original Message-----
From:	Takashi Iwai [mailto:tiwai@suse.de]
Sent:	2005/3/22 [=ACP=B4=C1=A4G] =A4U=A4=C8 03:50
To:	Tien,  C.L. - =A5=D0=A9=D3=C2=A7
Cc:	alsa-devel@alsa-project.org
Subject:	Re: [Alsa-devel] no --with-cards parameter in alsa-driver CVS
At Wed, 23 Mar 2005 03:18:27 +0800,
Tien, C.L. wrote:
>=20
> Hi,
>=20
> I found there is no --with-cards parameter in CVS configure any
> longer, although it is still in 1.0.9rc1, but it disappeared in CVS,
> the document file INSTALL. Is this a mistake or will future version
> find the card in kernel config?=20

It works for me.

Could you tell me what doesn't exactly work?


Takashi






-------------------------------------------------------
This SF.net email is sponsored by: 2005 Windows Mobile Application Contest
Submit applications for Windows Mobile(tm)-based Pocket PCs or Smartphones
for the chance to win $25,000 and application distribution. Enter today at
http://ads.osdn.com/?ad_id=6882&alloc_id=15148&op=click
