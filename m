From: "Jonathan Gage" <chimera@darkscape.net>
Subject: correction: audiophile USB stream0 output
Date: Fri, 23 May 2003 01:58:54 +1000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <003801c3207b$0c70a140$3700a8c0@jono>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0035_01C320CE.DD591320"
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

------=_NextPart_000_0035_01C320CE.DD591320
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

agh, many apologies for my stupidity. posting cat /proc/asound/stream0 =
with nothing playing back was a silly, useless excercise :) here is =
stream0 while playing back, the problem seems to be that the later =
drivers (0.9.3c) are running the card at 96khz (which results it digital =
noise) while the older drivers (0.9.0rc5) are running it at 48khz. I =
guess this is what the difference in the "momentary frequency" between =
the two tests means... is there a way to make the card run at 48khz? =
(.asoundrc?)

here are the results:

_________alsa driver 0.9.3c

bash-2.05a# cat stream0=20
M-Audio Audiophile USB (tm) at 002/003 : USB Audio=20
=20
Playback:=20
  Status: Running=20
    Interface =3D 2=20
    Altset =3D 4=20
    URBs =3D 2 [ 1 1 ]=20
    Packet Size =3D 200=20
    Momentary freq =3D 95,999 Hz=20
  Interface 2=20
    Altset 1=20
    Format: S24_3LE=20
    Channels: 2=20
    Endpoint: 3 OUT (ADAPTIVE)=20
    Rates: 48001 - 96000 (continuous)=20
  Interface 2=20
    Altset 2=20
    Format: S24_3LE=20
    Channels: 2=20
    Endpoint: 3 OUT (ASYNC)=20
    Rates: 8000 - 48000 (continuous)=20
  Interface 2=20
    Altset 3=20
    Format: S24_3LE=20
    Channels: 2=20
    Endpoint: 3 OUT (ADAPTIVE)=20
    Rates: 8000 - 48000 (continuous)=20
  Interface 2=20
    Altset 4=20
    Format: S16_LE=20
    Channels: 2=20
    Endpoint: 3 OUT (ASYNC)=20
    Rates: 8000 - 48000 (continuous)=20
  Interface 2=20
    Altset 5=20
    Format: S16_LE=20
    Channels: 2=20
    Endpoint: 3 OUT (ADAPTIVE)=20
    Rates: 8000 - 48000 (continuous)=20
=20
Capture:=20
  Status: Running=20
    Interface =3D 5=20
    Altset =3D 3=20
    URBs =3D 2 [ 1 1 ]=20
    Packet Size =3D 200=20
    Momentary freq =3D 44,099 Hz=20
  Interface 5=20
    Altset 1=20
    Format: S24_3LE=20
    Channels: 2=20
    Endpoint: 6 IN (ASYNC)=20
    Rates: 48001 - 96000 (continuous)=20
  Interface 5=20
    Altset 2=20
    Format: S24_3LE=20
    Channels: 2=20
    Endpoint: 6 IN (ASYNC)=20
    Rates: 8000 - 48000 (continuous)=20
  Interface 5=20
    Altset 3=20
    Format: S16_LE=20
    Channels: 2=20
    Endpoint: 6 IN (ASYNC)=20
    Rates: 8000 - 48000 (continuous)=20


_________alsa driver 0.9.0rc5

bash-2.05a# cat stream0=20
M-Audio Audiophile USB (tm) : USB Audio=20
=20
Playback:=20
  Status: Running=20
    Interface =3D 2=20
    Altset =3D 4=20
    URBs =3D 2 [ 1 1 ]=20
    Packet Size =3D 200=20
    Momentary freq =3D 48,001 Hz=20
  Interface 2=20
    Altset 1=20
    Format: S24_3LE=20
    Channels: 2=20
    Endpoint: 3 OUT (ADAPTIVE)=20
    Rates: 48001 - 96000 (continous)=20
  Interface 2=20
    Altset 2=20
    Format: S24_3LE=20
    Channels: 2=20
    Endpoint: 3 OUT (ASYNC)=20
    Rates: 8000 - 48000 (continous)=20
  Interface 2=20
    Altset 3=20
    Format: S24_3LE=20
    Channels: 2=20
    Endpoint: 3 OUT (ADAPTIVE)=20
    Rates: 8000 - 48000 (continous)=20
  Interface 2=20
    Altset 4=20
    Format: S16_LE=20
    Channels: 2=20
    Endpoint: 3 OUT (ASYNC)=20
    Rates: 8000 - 48000 (continous)=20
  Interface 2=20
    Altset 5=20
    Format: S16_LE=20
    Channels: 2=20
    Endpoint: 3 OUT (ADAPTIVE)=20
    Rates: 8000 - 48000 (continous)=20
=20
Capture:=20
  Status: Running=20
    Interface =3D 5=20
    Altset =3D 3=20
    URBs =3D 2 [ 1 1 ]=20
    Packet Size =3D 200=20
    Momentary freq =3D 44,099 Hz=20
  Interface 5=20
    Altset 1=20
    Format: S24_3LE=20
    Channels: 2=20
    Endpoint: 6 IN (ASYNC)=20
    Rates: 48001 - 96000 (continous)=20
  Interface 5=20
    Altset 2=20
    Format: S24_3LE=20
    Channels: 2=20
    Endpoint: 6 IN (ASYNC)=20
    Rates: 8000 - 48000 (continous)=20
  Interface 5=20
    Altset 3=20
    Format: S16_LE=20
    Channels: 2=20
    Endpoint: 6 IN (ASYNC)=20
    Rates: 8000 - 48000 (continous)=20





------=_NextPart_000_0035_01C320CE.DD591320
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META content=3D"text/html; charset=3Diso-8859-1" =
http-equiv=3DContent-Type>
<META content=3D"MSHTML 5.00.3513.900" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>agh, many apologies for my stupidity. =
posting cat=20
/proc/asound/stream0 with nothing playing back was a silly, useless =
excercise :)=20
here is stream0 while playing back, the problem seems to be that the =
later=20
drivers (0.9.3c) are running the card at 96khz (which results it digital =
noise)=20
while the older drivers (0.9.0rc5) are running it at 48khz. I guess this =
is what=20
the difference in the "momentary frequency" between the two tests =
means... is=20
there a way to make the card run at 48khz? (.asoundrc?)</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>here are the results:</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>_________alsa driver =
0.9.3c</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>bash-2.05a# cat stream0 <BR>M-Audio =
Audiophile USB=20
(tm) at 002/003 : USB Audio <BR>&nbsp;<BR>Playback: <BR>&nbsp; Status: =
Running=20
<BR>&nbsp;&nbsp;&nbsp; Interface =3D 2 <BR>&nbsp;&nbsp;&nbsp; Altset =3D =
4=20
<BR>&nbsp;&nbsp;&nbsp; URBs =3D 2 [ 1 1 ] <BR>&nbsp;&nbsp;&nbsp; Packet =
Size =3D 200=20
<BR>&nbsp;&nbsp;&nbsp; Momentary freq =3D 95,999 Hz <BR>&nbsp; Interface =
2=20
<BR>&nbsp;&nbsp;&nbsp; Altset 1 <BR>&nbsp;&nbsp;&nbsp; Format: S24_3LE=20
<BR>&nbsp;&nbsp;&nbsp; Channels: 2 <BR>&nbsp;&nbsp;&nbsp; Endpoint: 3 =
OUT=20
(ADAPTIVE) <BR>&nbsp;&nbsp;&nbsp; Rates: 48001 - 96000 (continuous) =
<BR>&nbsp;=20
Interface 2 <BR>&nbsp;&nbsp;&nbsp; Altset 2 <BR>&nbsp;&nbsp;&nbsp; =
Format:=20
S24_3LE <BR>&nbsp;&nbsp;&nbsp; Channels: 2 <BR>&nbsp;&nbsp;&nbsp; =
Endpoint: 3=20
OUT (ASYNC) <BR>&nbsp;&nbsp;&nbsp; Rates: 8000 - 48000 (continuous) =
<BR>&nbsp;=20
Interface 2 <BR>&nbsp;&nbsp;&nbsp; Altset 3 <BR>&nbsp;&nbsp;&nbsp; =
Format:=20
S24_3LE <BR>&nbsp;&nbsp;&nbsp; Channels: 2 <BR>&nbsp;&nbsp;&nbsp; =
Endpoint: 3=20
OUT (ADAPTIVE) <BR>&nbsp;&nbsp;&nbsp; Rates: 8000 - 48000 (continuous)=20
<BR>&nbsp; Interface 2 <BR>&nbsp;&nbsp;&nbsp; Altset 4 =
<BR>&nbsp;&nbsp;&nbsp;=20
Format: S16_LE <BR>&nbsp;&nbsp;&nbsp; Channels: 2 <BR>&nbsp;&nbsp;&nbsp; =

Endpoint: 3 OUT (ASYNC) <BR>&nbsp;&nbsp;&nbsp; Rates: 8000 - 48000 =
(continuous)=20
<BR>&nbsp; Interface 2 <BR>&nbsp;&nbsp;&nbsp; Altset 5 =
<BR>&nbsp;&nbsp;&nbsp;=20
Format: S16_LE <BR>&nbsp;&nbsp;&nbsp; Channels: 2 <BR>&nbsp;&nbsp;&nbsp; =

Endpoint: 3 OUT (ADAPTIVE) <BR>&nbsp;&nbsp;&nbsp; Rates: 8000 - 48000=20
(continuous) <BR>&nbsp;<BR>Capture: <BR>&nbsp; Status: Running=20
<BR>&nbsp;&nbsp;&nbsp; Interface =3D 5 <BR>&nbsp;&nbsp;&nbsp; Altset =3D =
3=20
<BR>&nbsp;&nbsp;&nbsp; URBs =3D 2 [ 1 1 ] <BR>&nbsp;&nbsp;&nbsp; Packet =
Size =3D 200=20
<BR>&nbsp;&nbsp;&nbsp; Momentary freq =3D 44,099 Hz <BR>&nbsp; Interface =
5=20
<BR>&nbsp;&nbsp;&nbsp; Altset 1 <BR>&nbsp;&nbsp;&nbsp; Format: S24_3LE=20
<BR>&nbsp;&nbsp;&nbsp; Channels: 2 <BR>&nbsp;&nbsp;&nbsp; Endpoint: 6 IN =
(ASYNC)=20
<BR>&nbsp;&nbsp;&nbsp; Rates: 48001 - 96000 (continuous) <BR>&nbsp; =
Interface 5=20
<BR>&nbsp;&nbsp;&nbsp; Altset 2 <BR>&nbsp;&nbsp;&nbsp; Format: S24_3LE=20
<BR>&nbsp;&nbsp;&nbsp; Channels: 2 <BR>&nbsp;&nbsp;&nbsp; Endpoint: 6 IN =
(ASYNC)=20
<BR>&nbsp;&nbsp;&nbsp; Rates: 8000 - 48000 (continuous) <BR>&nbsp; =
Interface 5=20
<BR>&nbsp;&nbsp;&nbsp; Altset 3 <BR>&nbsp;&nbsp;&nbsp; Format: S16_LE=20
<BR>&nbsp;&nbsp;&nbsp; Channels: 2 <BR>&nbsp;&nbsp;&nbsp; Endpoint: 6 IN =
(ASYNC)=20
<BR>&nbsp;&nbsp;&nbsp; Rates: 8000 - 48000 (continuous) =
<BR></FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>
<DIV><FONT face=3DArial size=3D2>_________alsa driver =
0.9.0rc5</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV>bash-2.05a# cat stream0 <BR>M-Audio Audiophile USB (tm) : USB Audio =

<BR>&nbsp;<BR>Playback: <BR>&nbsp; Status: Running =
<BR>&nbsp;&nbsp;&nbsp;=20
Interface =3D 2 <BR>&nbsp;&nbsp;&nbsp; Altset =3D 4 =
<BR>&nbsp;&nbsp;&nbsp; URBs =3D 2=20
[ 1 1 ] <BR>&nbsp;&nbsp;&nbsp; Packet Size =3D 200 =
<BR>&nbsp;&nbsp;&nbsp;=20
Momentary freq =3D 48,001 Hz <BR>&nbsp; Interface 2 =
<BR>&nbsp;&nbsp;&nbsp; Altset=20
1 <BR>&nbsp;&nbsp;&nbsp; Format: S24_3LE <BR>&nbsp;&nbsp;&nbsp; =
Channels: 2=20
<BR>&nbsp;&nbsp;&nbsp; Endpoint: 3 OUT (ADAPTIVE) <BR>&nbsp;&nbsp;&nbsp; =
Rates:=20
48001 - 96000 (continous) <BR>&nbsp; Interface 2 <BR>&nbsp;&nbsp;&nbsp; =
Altset 2=20
<BR>&nbsp;&nbsp;&nbsp; Format: S24_3LE <BR>&nbsp;&nbsp;&nbsp; Channels: =
2=20
<BR>&nbsp;&nbsp;&nbsp; Endpoint: 3 OUT (ASYNC) <BR>&nbsp;&nbsp;&nbsp; =
Rates:=20
8000 - 48000 (continous) <BR>&nbsp; Interface 2 <BR>&nbsp;&nbsp;&nbsp; =
Altset 3=20
<BR>&nbsp;&nbsp;&nbsp; Format: S24_3LE <BR>&nbsp;&nbsp;&nbsp; Channels: =
2=20
<BR>&nbsp;&nbsp;&nbsp; Endpoint: 3 OUT (ADAPTIVE) <BR>&nbsp;&nbsp;&nbsp; =
Rates:=20
8000 - 48000 (continous) <BR>&nbsp; Interface 2 <BR>&nbsp;&nbsp;&nbsp; =
Altset 4=20
<BR>&nbsp;&nbsp;&nbsp; Format: S16_LE <BR>&nbsp;&nbsp;&nbsp; Channels: 2 =

<BR>&nbsp;&nbsp;&nbsp; Endpoint: 3 OUT (ASYNC) <BR>&nbsp;&nbsp;&nbsp; =
Rates:=20
8000 - 48000 (continous) <BR>&nbsp; Interface 2 <BR>&nbsp;&nbsp;&nbsp; =
Altset 5=20
<BR>&nbsp;&nbsp;&nbsp; Format: S16_LE <BR>&nbsp;&nbsp;&nbsp; Channels: 2 =

<BR>&nbsp;&nbsp;&nbsp; Endpoint: 3 OUT (ADAPTIVE) <BR>&nbsp;&nbsp;&nbsp; =
Rates:=20
8000 - 48000 (continous) <BR>&nbsp;<BR>Capture: <BR>&nbsp; Status: =
Running=20
<BR>&nbsp;&nbsp;&nbsp; Interface =3D 5 <BR>&nbsp;&nbsp;&nbsp; Altset =3D =
3=20
<BR>&nbsp;&nbsp;&nbsp; URBs =3D 2 [ 1 1 ] <BR>&nbsp;&nbsp;&nbsp; Packet =
Size =3D 200=20
<BR>&nbsp;&nbsp;&nbsp; Momentary freq =3D 44,099 Hz <BR>&nbsp; Interface =
5=20
<BR>&nbsp;&nbsp;&nbsp; Altset 1 <BR>&nbsp;&nbsp;&nbsp; Format: S24_3LE=20
<BR>&nbsp;&nbsp;&nbsp; Channels: 2 <BR>&nbsp;&nbsp;&nbsp; Endpoint: 6 IN =
(ASYNC)=20
<BR>&nbsp;&nbsp;&nbsp; Rates: 48001 - 96000 (continous) <BR>&nbsp; =
Interface 5=20
<BR>&nbsp;&nbsp;&nbsp; Altset 2 <BR>&nbsp;&nbsp;&nbsp; Format: S24_3LE=20
<BR>&nbsp;&nbsp;&nbsp; Channels: 2 <BR>&nbsp;&nbsp;&nbsp; Endpoint: 6 IN =
(ASYNC)=20
<BR>&nbsp;&nbsp;&nbsp; Rates: 8000 - 48000 (continous) <BR>&nbsp; =
Interface 5=20
<BR>&nbsp;&nbsp;&nbsp; Altset 3 <BR>&nbsp;&nbsp;&nbsp; Format: S16_LE=20
<BR>&nbsp;&nbsp;&nbsp; Channels: 2 <BR>&nbsp;&nbsp;&nbsp; Endpoint: 6 IN =
(ASYNC)=20
<BR>&nbsp;&nbsp;&nbsp; Rates: 8000 - 48000 (continous) </DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;</DIV></DIV></FONT>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;</DIV></BODY></HTML>

------=_NextPart_000_0035_01C320CE.DD591320--



-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
