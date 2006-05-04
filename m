From: "Sam Morris" <sam@robots.org.uk>
Subject: Jointed mixer elements
Date: Thu, 4 May 2006 16:18:50 +0000 (UTC)
Message-ID: <e3d9h9$dst$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

What does it mean if a mixer element is 'joined'? The description of the
following functions:

 snd_mixer_selem_has_playback_volume_joined
 snd_mixer_selem_has_playback_switch_joined
 snd_mixer_selem_has_capture_volume_joined
 snd_mixer_selem_has_capture_switch_joined

is just:

 Return info about playback/capture volume/switch control of a mixer
 simple element

If these functions return true then amixer(1) describes the elements
variously as having the switch-joined, pswitch-joined, cswitch-joined,
volume-joined, pvolume-joined and cvolume-joined capabilities. However, I
can't find out what these capabilities actually mean, nor can I work it
out as elements with these capabilities seems to behave no differently in
alsamixer.

Regards,

--=20
Sam Morris
http://robots.org.uk/

PGP key id 5EA01078
3412 EA18 1277 354B 991B  C869 B219 7FDB 5EA0 1078



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job ea=
sier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronim=
o
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D=
121642
