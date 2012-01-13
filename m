From: Ivan Bublikov <ivanbublikov@yahoo.com>
Subject: Hardware-specific IOCTLs
Date: Fri, 13 Jan 2012 08:22:38 -0800 (PST)
Message-ID: <1326471758.45923.YahooMailNeo@web121806.mail.ne1.yahoo.com>
Reply-To: Ivan Bublikov <ivanbublikov@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nm10.bullet.mail.ne1.yahoo.com (nm10.bullet.mail.ne1.yahoo.com
	[98.138.90.73]) by alsa0.perex.cz (Postfix) with SMTP id 8F37A243C4
	for <alsa-devel@alsa-project.org>; Fri, 13 Jan 2012 17:22:40 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Message body
Hello All,
=A0
My question is about how to allocate a new hardware-specific IOCTL code. Fo=
r example, the HDA driver consists of common HDA code and vendor-specific c=
odes for various HDA codecs. As an HDA codec vendor, I want to be able to c=
ontrol some functionality in my codec, that is not present in codecs from o=
ther vendors. For this, I want to implement a special IOCTL in my vendor-sp=
ecific code. I understand that I can register an IOCTL handler using snd_ct=
l_register_ioctl. My difficulty is how to define a code for my IOCTL and av=
oid a conflict with the common code in the future.
=A0
Looking at header files, I see=A0 common "ALSA" audio IOCTLs starting with =
letter 'A', and "HWDEP" IOCTLs starting with letter 'H'. Some of H-IOCTLs a=
re defined in asound.h, starting at offset 0, and some in hda_hwdep.h and s=
b16_csp.h starting at offset 0x10. My guess is that the latter start at 0x1=
0 to give some expansion room for H-IOCTLs in asound.h...?
=A0
I think I need=A0some offset range in H-IOCTLs or a new IOCTL family with a=
nother letter,=A0officially reserved for such codec-specific IOCTLs. Any su=
ggestions?
=A0
Best regards,
Ivan
