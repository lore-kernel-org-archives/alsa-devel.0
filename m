From: "Juan Carlos Granda" <granda@telecable.es>
Subject: Audio and Video sync. Getting Timestamps
Date: Tue, 27 Apr 2004 20:36:29 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <002901c42c86$902cc730$38b36153@palmian>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0026_01C42C97.5167AF90"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

This is a multi-part message in MIME format.

------=_NextPart_000_0026_01C42C97.5167AF90
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

I'm developing a Multi-thread app for capturing audio+video and i have a =
few questions. The app is based on 3 threads:

 - 1 thread for capturing audio using ALSA lib.
 - 1 thread for capturing video using V4L2.
 - 1 thread for saving audio+video into an AVI file.

Both of capturing threads store captured data into a queue and the last =
thread picks the data and sync A/V.

I start audio capturing and then the video. So, i need to known the =
point of the stream of audio the video begins.=20
I'm readings frames by period size times. My prob is how to get valid =
ALSA timestamps to eliminate the previous frames of the period the video =
starts. I've tried snd_pcm_status_get_trigger_tstamp but it returns the =
same timestamp for a long period of time (13 secs) (is it related to the =
period or buffer time?). I've tried snd_pcm_status_get_tstamp too but i =
obtain a delay of several microseconds from the period time (50 - 100 =
more or less) (is it because the clock resolution?).

Thanks

pd. Sorry for my little knowledge of english.
------=_NextPart_000_0026_01C42C97.5167AF90
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2800.1400" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>Hi,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I'm developing a Multi-thread app for =
capturing=20
audio+video and i have a few questions. The app is based on 3=20
threads:</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>&nbsp;- 1 thread for capturing audio =
using ALSA=20
lib.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>&nbsp;- 1 thread for capturing video =
using=20
V4L2.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>&nbsp;- 1 thread for saving audio+video =
into an AVI=20
file.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Both of capturing threads store =
captured data into=20
a queue and the last thread picks the data and sync A/V.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I start audio capturing and then the =
video. So, i=20
need to known the point of the stream of audio the video begins. =
</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>
<DIV><FONT face=3DArial size=3D2>I'm readings frames by period size =
times. </FONT>My=20
prob is how to get valid ALSA timestamps to eliminate the previous =
frames of the=20
period the video starts. I've tried snd_pcm_status_get_trigger_tstamp =
but it=20
returns the same timestamp for a long period of time (13 secs) (is it =
related to=20
the period or buffer time?). I've tried snd_pcm_status_get_tstamp too =
but i=20
obtain a delay of several microseconds from the period time (50 - 100 =
more or=20
less) (is it because the clock resolution?).</FONT></DIV></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Thanks</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>pd. Sorry for my little knowledge of=20
english.</FONT></DIV></BODY></HTML>

------=_NextPart_000_0026_01C42C97.5167AF90--




-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297
