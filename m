From: =?ISO-8859-1?Q?Fr=E9d=E9ric_DALLEAU?= <frederic.dalleau@palmsource.com>
Subject: Various question about alsa plugins
Date: Wed, 09 Aug 2006 15:44:04 +0200
Message-ID: <44D9E6A4.2060803@palmsource.com>
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi all,

I'm working on the bluetooth-alsa plugin. It is a plugin for alsa that =

allows to send sound to an A2DP bluetooth headset. It features a pcm =

plugin and a ctl plugin, it works pretty good with any application that =

do not use mmap transfer. see http://bluetooth-alsa.sourceforge.net

My questions are :
How to make my plugins appear in my media player (for instance xmms)?

I also need more informations about the ctl plugin events, specially the =

part that is used to received device events. Samples are welcome!

Last, why do my plugin works well with non-mmap plugins, but not with =

mmap plugins. I have sound, but not with the right timing (gaps, noise, =

the media player becomes crazy) and I don't understand why. Any ideas?

Thanks
Fr=E9d=E9ric


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
