From: =?big5?B?Qy5MLiBUaWVuIC0gpdCp08Kn?= <cltien@cmedia.com.tw>
Subject: RE: AFMT_AC3 support
Date: Thu, 18 Dec 2003 10:04:26 +0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <92C0412E07F63549B2A2F2345D3DB515F7D31E@cm-msg-02.cmedia.com.tw>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
content-class: urn:content-classes:message
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

The problem is that I need to have my driver work with application that =
already use AFMT_AC3 in OSS. I don't need AC3 API for it because AC3 =
stream will be sent by that application so what I need is just to handle =
the AFMT_AC3 just as other AFMT_S16_LE PCM formats.

Sincerely,
ChenLi Tien


-----Original Message-----
From:	James Courtier-Dutton [mailto:James@superbug.demon.co.uk]
Sent:	2003/12/17 [=ACP=B4=C1=A4T] =A4U=A4=C8 06:04
To:	C.L. Tien - =A5=D0=A9=D3=C2=A7
Cc:	alsa-devel@lists.sourceforge.net
Subject:	Re: [Alsa-devel] AFMT_AC3 support
C.L. Tien - ??? wrote:
> Hi,
>=20
> Can ALSA support AFMT_AC3 to enable xine to play AC3 through S/PDIF =
interface? I check in core/pcm.c and core/oss/pcm_oss.c, neither of them =
has keywork AC3.
>=20
> Sincerely,
> ChenLi Tien
>=20
It works if you use the ALSA API instead of the OSS emulation in the=20
ALSA driver.






-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
