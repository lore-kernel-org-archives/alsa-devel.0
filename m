From: =?big5?B?IlRpZW4sICBDLkwuIC0gpdCp08KnIg==?= <cltien@cmedia.com.tw>
Subject: RE: CMI8768 patch
Date: Wed, 23 Feb 2005 06:00:47 +0800
Message-ID: <92C0412E07F63549B2A2F2345D3DB515F7D656@cm-msg-02.cmedia.com.tw>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: quoted-printable
content-class: urn:content-classes:message
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
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org




-----Original Message-----
From:	Takashi Iwai [mailto:tiwai@suse.de]
Sent:	2005/2/22 [=ACP=B4=C1=A4G] =A4U=A4=C8 02:51
To:	Tien,  C.L. - =A5=D0=A9=D3=C2=A7
Cc:	alsa-devel@lists.sourceforge.net
Subject:	Re: [Alsa-devel] CMI8768 patch
At Wed, 23 Feb 2005 03:07:02 +0800,
Tien, C.L. wrote:
>=20

>=20
> I also recmmend that the "Four Channel" switch should be turned off =
for
> surround41 and surround50, as well as surround51 and surround71. The

It is turned off, indeed.  In the configuration:

			{
				name "Four Channel Mode"
				lock true
				preserve true
=3D=3D>				value false
			}

Then I think following lines should be added too:

CMI8738-MC8.pcm.surround41.0 "cards.CMI8738-MC8.pcm.surround40.0"

CMI8738-MC8.pcm.surround50.0 "cards.CMI8738-MC8.pcm.surround40.0"


Takashi





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
