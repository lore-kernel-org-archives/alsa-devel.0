From: "Arve Knudsen" <aknuds-1@broadpark.no>
Subject: Problem writing to PCM plugin
Date: Wed, 11 Aug 2004 15:33:45 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <opscklaj0ufmr65f@mail.broadpark.no>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

I'm currently trying to implement support for user defined pcm plugins in=
 =20
PortAudio ALSA (ALSA-lib 1.05), and I've got as far as discovering the =20
pcms. In order to test I defined a routing plugin, which moves data from =
=20
channel 0/1 to 16/17 (S/PDIF) on my Hammerfall Lite. With aplay this =20
plugin works just fine, but when I open it with PortAudio the same way as=
 =20
with any hardware device, the output is simply silent (I can't listen to =
=20
any of the ADAT channels since I lack ADAT gear). Defining a simple plugi=
n =20
which does nothing but drive my onboard nForce2 (routing fails with this =
=20
assertion: 'pcm_plug.c:363: snd_pcm_plug_change_channels: Assertion =20
`snd_pcm_format_linear(slv->format)' failed') works the same as if I open=
 =20
the hw device.

The obvious difference to aplay I can think of is that we use floating =20
point format in the PortAudio tests, so there is an intermediate =20
conversion before the audio gets to the routing plugin. Could this be the=
 =20
cause of the problem? If you wish I can provide output from snd_pcm_dump.

Thanks

Arve Knudsen


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
