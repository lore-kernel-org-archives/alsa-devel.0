From: Felipe Ferreri Tonello <eu@felipetonello.com>
Subject: Re: Unregister a card from userspace?
Date: Wed, 11 Nov 2015 14:50:17 +0000
Message-ID: <564355A9.9020704@felipetonello.com>
References: <alpine.DEB.2.02.1511041032180.1465@lnxricardw1.se.axis.com>
 <56408259.2030604@felipetonello.com>
 <alpine.DEB.2.02.1511100852180.15344@lnxricardw1.se.axis.com>
 <564319CD.3070305@felipetonello.com>
 <alpine.DEB.2.02.1511111348380.11990@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040901070200010604010204"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f45.google.com (mail-wm0-f45.google.com [74.125.82.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 46F0D26044E
 for <alsa-devel@alsa-project.org>; Wed, 11 Nov 2015 15:50:19 +0100 (CET)
Received: by wmvv187 with SMTP id v187so59391876wmv.1
 for <alsa-devel@alsa-project.org>; Wed, 11 Nov 2015 06:50:19 -0800 (PST)
In-Reply-To: <alpine.DEB.2.02.1511111348380.11990@lnxricardw1.se.axis.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ricard Wanderlof <ricard.wanderlof@axis.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------040901070200010604010204
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

Hi Ricard,

On 11/11/15 12:59, Ricard Wanderlof wrote:
>=20
> On Wed, 11 Nov 2015, Felipe Ferreri Tonello wrote:
>=20
>>> But that is precisely the problem. The framework that manages the=20
>>> insertion and deletion of modules notes that my module has a usage co=
unt=20
>>> that is > 0 (in my case it is 2, which I'm convinced is because the c=
ard=20
>>> has been registered with ALSA), and refuses to free the module. So th=
ere=20
>>> is now way any unregister_card call can be made when my module is fre=
ed,=20
>>> as due to the usage count it would never even be attempted.
>>
>> Do you mean that unbind is never called? Well, the framework should ca=
ll
>> bind/unbind for each user of your module.
>=20
> Ok, I didn't know that. It's the first time I've been writing an ALSA=20
> driver as a loadable module.

Well, this is not ALSA specific, it really depends on which framework
your driver is based on, but they all share similar flow on probe and
remove driver.

>=20
>> How is your architecture? If you use one card for each probe of module
>> then each bind should create one device, right?
>=20
> In this case, it is a device which is located on the SoC. There is only=
=20
> one instance of it. When the module is loaded, it loads a codec driver=20
> with its associated DAI driver, a PCM driver, snd-soc-dummy-dai, and th=
en=20
> a machine driver to tie it all together, finally registering the card w=
ith=20
> ALSA.
>=20
> Looking in /sys/bus/platform/devices, there seems to be one device crea=
ted=20
> for the codec itself, and one for the machine driver. I don't know if=20
> that's right or wrong, the ALSA driver hierarchy works in the sense tha=
t I=20
> can capture audio from it anyway.
>=20

What exactly do you want? If it is driver that register and unregister
cards based on the user interaction of probing and removing that module
from user-space, then you are not looking for a driver. What you are
looking for is just a kernel module. The only way of interacting with it
is dealing with module_init and module_exit.

On the other hand, if in fact you want a driver, then check
sound/drivers/dummy.c for an example. You can also read the
Documentation/driver-model/platform.txt for more info.

--=20
Felipe

--------------040901070200010604010204
Content-Type: application/pgp-keys;
 name="0x92698E6A.asc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="0x92698E6A.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: GnuPG v2

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3D=3D
=3DVNJV
-----END PGP PUBLIC KEY BLOCK-----

--------------040901070200010604010204
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------040901070200010604010204--
