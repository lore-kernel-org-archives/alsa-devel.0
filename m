From: "Pete Barnard" <petebarnard@tiscali.co.uk>
Subject: Broken pipe mystery
Date: Sat, 8 Feb 2003 10:21:23 -0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <058801c2cf5b$d4f1dfb0$0100a8c0@Pblaptop>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0585_01C2CF5B.D463D080"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

------=_NextPart_000_0585_01C2CF5B.D463D080
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I am using ALSA 0.9.0rc7 and Red Hat Linux 7.2.  My sound card is a =
CS461x.
My computer is a reasonably powerful beast with 512M of RAM and 1Gig =
clock
speed.
I have written a simple capture program which reads interleaved samples =
from
the sound card and goes around in a continuous while(1) loop.  My =
program
works perfectly - until it crashes after several hours with the message:

"read from audio interface failed: broken pipe".

I have narrowed it down to the following piece of code.  The size of buf =
is 256 (shorts). Why would the snd_pcm_readi suddenly (randomly?) fail =
with a broken pipe???  Any ideas or suggestions would be greatly =
appreciated as I'm struggling with this
annoying (and difficult to debug)  problem.

Regards,

Pete

while (1)
{
    if ((err =3D snd_pcm_readi(capture_handle,buf,128)) !=3D 128
    {
        // this is where it fails after several hours of working
successfully
        cout << "read from audio interface failed: " << =
snd_strerror(err) <<
endl;
        exit(1);
    }
}


------=_NextPart_000_0585_01C2CF5B.D463D080
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2600.0" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2><FONT face=3D"Times New Roman" =
size=3D3>I am using ALSA=20
0.9.0rc7 and Red Hat Linux 7.2.&nbsp; My sound card is a CS461x.<BR>My =
computer=20
is a reasonably powerful beast with 512M of RAM and 1Gig =
clock<BR>speed.<BR>I=20
have written a simple capture program which reads interleaved samples=20
from<BR>the sound card and goes around in a continuous while(1) =
loop.&nbsp; My=20
program<BR>works perfectly - until it crashes after several hours with =
the=20
message:<BR><BR>"read from audio interface failed: broken =
pipe".<BR><BR>I have=20
narrowed it down to the following piece of code.&nbsp; The size of buf =
is 256=20
(shorts). Why would the snd_pcm_readi suddenly (randomly?) fail with a =
broken=20
pipe???&nbsp; Any ideas or suggestions would be greatly appreciated as =
I'm=20
struggling with this<BR>annoying (and difficult to debug)&nbsp;=20
problem.<BR><BR>Regards,<BR><BR>Pete<BR><BR>while =
(1)<BR>{<BR>&nbsp;&nbsp;&nbsp;=20
if ((err =3D snd_pcm_readi(capture_handle,buf,128)) !=3D =
128<BR>&nbsp;&nbsp;&nbsp;=20
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // this is where it =
fails after=20
several hours of=20
working<BR>successfully<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
cout=20
&lt;&lt; "read from audio interface failed: " &lt;&lt; snd_strerror(err) =

&lt;&lt;<BR>endl;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
exit(1);<BR>&nbsp;&nbsp;&nbsp; =
}<BR>}</FONT><BR></FONT></DIV></BODY></HTML>

------=_NextPart_000_0585_01C2CF5B.D463D080--



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
