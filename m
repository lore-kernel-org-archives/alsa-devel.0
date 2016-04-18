From: David Binderman <dcb314@hotmail.com>
Subject: linux-4.6-rc4/sound/pci/ens1370.c:1551: possible bad
	expression ?
Date: Mon, 18 Apr 2016 16:17:58 +0000
Message-ID: <DUB128-W43C83AA6E3851834E8340F9C6B0@phx.gbl>
References: <DUB128-W44E71E14CBE4AC54396DFA9C6B0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from DUB004-OMC1S20.hotmail.com (dub004-omc1s20.hotmail.com
 [157.55.0.219]) by alsa0.perex.cz (Postfix) with ESMTP id 8401526154C
 for <alsa-devel@alsa-project.org>; Mon, 18 Apr 2016 18:17:59 +0200 (CEST)
In-Reply-To: <DUB128-W44E71E14CBE4AC54396DFA9C6B0@phx.gbl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hello there,

[linux-4.6-rc4/sound/pci/ens1370.c:1551]: (style) Expression '(X & 0xf0000)=
>=3D 0x4' is always false.

Source code is

=A0=A0=A0 if ((ensoniq->ctrl & ES_1371_GPIO_OUTM)>=3D 4)
=A0=A0=A0=A0=A0=A0=A0 val =3D 1;


Regards

David Binderman

 		 	   		  =
