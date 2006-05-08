From: "Markus Rechberger" <mrechberger@gmail.com>
Subject: au600 usb phone bridge development
Date: Mon, 8 May 2006 20:16:07 +0200
Message-ID: <d9def9db0605081116q7f88657cyf580bf04bd5cd041@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

Hi all,

I started to develop a driver for the au600 usb phone bridge, so far
capturing the wav stream, ringing the phone, switching from PSTN to
VoIP mode already works.

There seems to be a small problem with the capturing part:
arecord -D hw:2,0 --format=3DS16_LE --rate=3D9600 | aplay
Recording WAVE 'stdout' : Signed 16 bit Little Endian, Rate 9600 Hz, Mono
Playing WAVE 'stdin' : Signed 16 bit Little Endian, Rate 9600 Hz, Mono
underrun!!! (at least 0,028 ms long)
underrun!!! (at least 0,008 ms long)
underrun!!! (at least 0,008 ms long)
etc.
What could cause such a problem? - The device works well with windows
so the machine should be fine.

The project website:
http://alsa.opensrc.org/au600

Another question is it possible to host the project on alsaproject.org
like I host my project on linuxtv (http://linuxtv.org/hg/)?

Thanks,
Markus


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
