From: "Steen, Gerd" <gerd.steen@de.thalesgroup.com>
Subject: independent play(write) on the left/right channel of
	audio devic	e
Date: Wed, 12 Jul 2006 11:09:50 +0200
Message-ID: <C980A03F3B62744E814B843AF92AC6D81ED3E1@tndki007.kiel.thales-naval.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: "'alsa-devel@lists.sourceforge.net'" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi,
=A0
my configuration are 2 total independent Task, which need to write on the
audio device. =

=A0
->Task one needs to write on the right channel of stereo device Task two =

->needs to write on the left channel of stereo device
=A0
Does any one has an idea, how to do this? My first try was jack, but the
library =

works with float operations. My target system is an embedded processor with
no floating point unit.
=A0
Thanks
=A0
Gerd Steen



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
