From: thomas schorpp <t.schorpp@gmx.de>
Subject: Re: CMI8768 patch, CMI9761A
Date: Sat, 19 Feb 2005 06:07:14 +0100
Message-ID: <4216C982.4090205@gmx.de>
References: <92C0412E07F63549B2A2F2345D3DB515F7D63F@cm-msg-02.cmedia.com.tw>
Reply-To: t.schorpp@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=Big5
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <92C0412E07F63549B2A2F2345D3DB515F7D63F@cm-msg-02.cmedia.com.tw>
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

hi,

Tien, C.L. - =A5=D0=A9=D3=C2=A7 wrote:
> Hi,
>=20
> I made a patch for CM8768, which has the same PCI ID but there are
> several HW diffecece, aas listed:

same with the 9761A i assume?

>=20
> 1. 8768 has no PCM volume control.

all model policy? strange cost optimation, driver software should be
more expensive... for customers.

> 2. The ADC of 8768 can only record in 44.1kHz or 48kHz.
> 3. 8768 can support up to 8 channels.
>=20
> I made change for item 2 and 3, I want to use the softvol plugin but
> don't know how to. The driver just don't generate the PCM volume slider
>  for now.

i want it too and at least 2 dxs sliders. so i could play loud mp3
without getting my speakers blown by knotify beeps.

lee stated, it cant be used by apps needing oss-mixer. anyway. most
newer apps like xine + xmms have conf options for using alsa or oss.

>=20
> The patch file is attached.
>=20
> Sincerely,
> ChenLi Tien
>=20
>=20

y
tom


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=3D6595&alloc_id=3D14396&op=3Dclick
