From: =?big5?B?IlRpZW4sICBDLkwuIC0gpdCp08KnIg==?= <cltien@cmedia.com.tw>
Subject: RE: Sound Card Driver
Date: Mon, 20 Dec 2004 17:47:23 +0800
Message-ID: <92C0412E07F63549B2A2F2345D3DB515F7D5C9@cm-msg-02.cmedia.com.tw>
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
To: kshriyan@redhat.com
Cc: rlrevell@joe-job.com, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

9880 is a Azalia codec, but it can also be used as an AC97 codec, please =
check if your system has AC97 controller (PCI ID 266E) or azalia =
controller (2668).

ChenLi Tien
-----Original Message-----
From:	Kaushal Shriyan [mailto:kshriyan@redhat.com]
Sent:	2004/12/20 [=ACP=B4=C1=A4@] =A4W=A4=C8 01:55
To:	Tien,  C.L. - =A5=D0=A9=D3=C2=A7
Cc:	rlrevell@joe-job.com; alsa-devel@lists.sourceforge.net
Subject:	RE: [Alsa-devel] Sound Card Driver




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
