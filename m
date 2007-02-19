From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Persistant naming of Terratec Aureon 5.1 USB MK.2
Date: Mon, 19 Feb 2007 09:25:35 +0100
Message-ID: <1171873535.9378.1175320411@webmail.messagingengine.com>
References: <1171719407.5843.5.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <1171719407.5843.5.camel@localhost>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: =?ISO-8859-1?Q?Jean-Michel=20Pour=E9?= <jmpoure@free.fr>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Jean-Michel Pour=E9 wrote:
> I have a Terratec Aureon 5.1 USB MK.2 device.
> =

> Presently, Alsa displays:
> =

>  1 [Audio          ]: USB-Audio - USB Audio
>                       USB Audio at usb-0000:00:0b.1-4.4.3, full speed
> =

> The name for the "Aureon 5.1 USB MK.2" is simply "Audio".
> Is there a solution to name it Aureon 5.1 USB MK.2?

The driver uses the device's name, and this device claims that its name
is "USB Audio".

Use the id parameter of the snd-usb-audio module; add something like
this to /etc/modprobe.conf:

options snd-usb-audio vid=3D0x0ccd pid=3D0x0028 id=3DAureon51USBMk2


HTH
Clemens

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
