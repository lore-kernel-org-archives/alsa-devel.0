From: =?big5?B?IlRpZW4sICBDLkwuIC0gpdCp08KnIg==?= <cltien@cmedia.com.tw>
Subject: RE: Sound Card Driver
Date: Mon, 20 Dec 2004 14:08:11 +0800
Message-ID: <92C0412E07F63549B2A2F2345D3DB515F7D5C6@cm-msg-02.cmedia.com.tw>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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
To: Lee Revell <rlrevell@joe-job.com>, kshriyan@redhat.com
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

9880 is the azalia codec so snd-azx is needed here.

ChenLi Tien
-----Original Message-----
From:	Lee Revell [mailto:rlrevell@joe-job.com]
Sent:	2004/12/20 [=ACP=B4=C1=A4@] =A4W=A4=C8 12:43
To:	kshriyan@redhat.com
Cc:	alsa-devel@lists.sourceforge.net
Subject:	Re: [Alsa-devel] Sound Card Driver
On Mon, 2004-12-20 at 11:05 +0530, Kaushal Shriyan wrote:
> Hi All !
>=20
> I have got INTEL915GM Mother Board with onboard sound chip
> C-Media CM9880L with RHEL 3.0 Base kernel Loaded(2.4.21-4.EL).
> I would appreciate if you can guide me how to build driver.
>=20
> I have downloaded alsa-driver-1.0.7,but I am getting the below error
>=20
> 1 out of 8 hunks FAILED -- saving rejects to file pdaudiocf.c.rej

This looks like a bug.

But, you could probably work around the problem by only compiling for
the card you use.  Assuming that chipset requires the intel8x0 driver,
try cvscompile --with-cards=3Dintel8x0, or ./configure
--with-cards=3Dintel8x0 in the alsa-driver directory.

Lee



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.=20
http://productguide.itmanagersjournal.com/
_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
