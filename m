From: "Mathieu Rondonneau" <mathieu.rondonneau@polymtl.ca>
Subject: snd_..._copy
Date: Sat, 7 Feb 2004 12:59:32 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <003401c3edac$885efc30$c4f9cb18@win2K>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0031_01C3ED7A.3AE27AE0"
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

------=_NextPart_000_0031_01C3ED7A.3AE27AE0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,
I'm writing an ALSA driver using no pci or isa preallocation memory (i'm =
using snd_pcm_lib_preallocate_pages_for_all).
I've some questions according to the alsa mecanism to transfert datas.
I'm using ALSA 0.9.6

when i send a wav file to the /dev/audio0 file:=20
dd if=3Dring.wav of=3D/dev/audio0
=20
In my ops function, i've added:
snd_....._playback_copy(snd_pcm_substream_t *substream, int channel, =
snd_pcm_uframes_t pos, void* src, snd_pcm_uframes_t count)
1) Why the src pointer doesn't point to the data source (the ring.wav =
data) when this function is called by ALSA.

2) why the count parameter is always 200? is it possible to change this =
offset in order to copy more data?

3) it seams more complicated to manage memory than using pci or isa =
preallocation.
Could i use one of these structure ethen if i don't have ISA or PCI =
bus/dma on my board?

Thanks in advance.
Mathieu Rondonneau


------=_NextPart_000_0031_01C3ED7A.3AE27AE0
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
<DIV><FONT face=3DArial size=3D2>I'm writing an ALSA driver using no pci =
or isa=20
preallocation memory (i'm using=20
snd_pcm_lib_preallocate_pages_for_all).</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>I've some questions according to the =
alsa mecanism=20
to transfert datas.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>I'm using ALSA 0.9.6</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>when i send&nbsp;a wav file&nbsp;to the =
/dev/audio0=20
file: </FONT></DIV>
<DIV><FONT face=3DArial size=3D2>dd if=3Dring.wav =
of=3D/dev/audio0</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>In&nbsp;my ops&nbsp;function, i've =
added:</DIV>
<DIV>
<DIV><FONT face=3DArial =
size=3D2>snd_....._playback_copy(snd_pcm_substream_t=20
*substream, int channel, snd_pcm_uframes_t pos, void* src, =
snd_pcm_uframes_t=20
count)</FONT></DIV></FONT></DIV>
<DIV><FONT face=3DArial size=3D2>1) Why the src pointer doesn't point to =
the data=20
source (the ring.wav data) when this function is called by =
ALSA.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>2) why the count parameter is always =
200?&nbsp;is=20
it possible to change this offset in order to copy more =
data?</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>3) it seams more complicated to manage =
memory than=20
using&nbsp;pci or isa preallocation.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Could i use one of these structure =
ethen if i don't=20
have ISA or PCI bus/dma on my board?</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Thanks in advance.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Mathieu Rondonneau</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV></BODY></HTML>

------=_NextPart_000_0031_01C3ED7A.3AE27AE0--



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
