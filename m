From: =?big5?B?IlRpZW4sICBDLkwuIC0gpdCp08KnIg==?= <cltien@cmedia.com.tw>
Subject: RE: CMI8768 patch
Date: Mon, 21 Feb 2005 07:20:55 +0800
Message-ID: <92C0412E07F63549B2A2F2345D3DB515F7D646@cm-msg-02.cmedia.com.tw>
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

Should it be instide the patch or just like:

Signed-off-by: ChenLi Tien <cltien@cmedia.com.tw>

I still cannot use the softvol with 8768, but softvol works with the =
8739 so I don't
know if anything need to do except not setting PCM Playback Volume item =
for mixer.

Sincerely,
ChenLi Tien

-----Original Message-----
From:	Takashi Iwai [mailto:tiwai@suse.de]
Sent:	2005/2/18 [=ACP=B4=C1=A4=AD] =A4W=A4=C8 05:27
To:	Tien,  C.L. - =A5=D0=A9=D3=C2=A7
Cc:	alsa-devel@lists.sourceforge.net
Subject:	Re: [Alsa-devel] CMI8768 patch
At Fri, 18 Feb 2005 06:11:03 +0800,
Tien, C.L. wrote:
>=20
> Hi,
>=20
> I made a patch for CM8768, which has the same PCI ID but there are
> several HW diffecece, aas listed:
>=20
> 1. 8768 has no PCM volume control.
> 2. The ADC of 8768 can only record in 44.1kHz or 48kHz.
> 3. 8768 can support up to 8 channels.
>=20
> I made change for item 2 and 3, I want to use the softvol plugin but
> don't know how to. The driver just don't generate the PCM volume =
slider
>  for now.

Thanks for the patch.  It looks fine.

Could you provide a "Signed-off-by" line to keep your credit in
changelog, such as

	Signed-off-by: Foo Bar <foo@bar.com>

This is required to submit to linux-kernel.


thanks,

Takashi





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
