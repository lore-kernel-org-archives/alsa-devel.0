From: "Daniel Schnell" <daniel.schnell@gmx.net>
Subject: Bug: Alsa-lib 1.05 doesn't work with dmix plugin and noninterleaved mmap'ed access and regions-buffer ?
Date: Fri, 30 Jul 2004 17:27:02 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1b0d01c47649$a9f36f90$2c0aa8c0@lumpidu>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_1B0A_01C4765A.6D145600"
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

------=_NextPart_000_1B0A_01C4765A.6D145600
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

I tried the official most recent version of the alsa-lib (V1.05) =
together with its counterparts alsa-utils and alsa-driver. Apparently =
this seems to be only an issue with alsa-lib, as a downgrade to V1.03 of =
the library alone worked again like a charm.

I write an application which uses a user-defined dmix plugin for sound =
output (and the snd-intel8x0 AC97 low level driver). The output gets =
Non-Interleaved Samples in seperate buffers per channel, floating-point, =
mmaped access and I use the zero-copy mechanism provided by regions. In =
my applications sound loop I use snd_pcm_mmap_begin() / =
snd_pcm_mmap_commit() to detemine how many samples have to be processed. =
I initialized the sound layer with a buffer size of 512 and a period =
size of 256. Sample Rate is 48000Hz.

I use the following device according to the configuration in =
/etc/asound.conf. Nevertheless the problem also exists with the standard =
dmix plugin (plug:dmix). This only triggers the effect a bit later.

pcm.dmixer {
    type dmix
    ipc_key 1027
    slave {
        pcm "hw:0,0"
        period_time 0
        period_size 256
        buffer_size 512
        periods 2
    }
    bindings {
        0 0
        1 1
    }
}


Normally, if I print out the values returned by snd_pcm_avail_update() =
and the chunks processed by snd_pcm_mmap_begin() / snd_pcm_mmap_commit() =
I get the following output:

256 frames available
256 chunked
256 frames available
108 chunked 148 chunked
256 frames available
...

But after some while I get:

...
257 (!) frames avilable
108 chunked 149 chunked
511(!) frames available
363 chunked 148 chunked

This seems to be where the problem arises, as I use the internal regions =
buffers, which are certainly allocated only to 256 frames (1024 bytes) =
and here a buffer overflow occurs. Afterwards the audio output ceases to =
work. I have not debugged into the alsa-lib, so these are only =
assumptions. But by thinking about it, it seems reasonable that this =
should be the problem.

This behaviour does not show for alsa-lib V 1.03.


Best regards,

Daniel.
------=_NextPart_000_1B0A_01C4765A.6D145600
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
<DIV><FONT face=3DArial size=3D2>I tried the official most recent =
version of the=20
alsa-lib (V1.05) together with its counterparts alsa-utils and =
alsa-driver.=20
Apparently this seems to be only an issue with alsa-lib, as a downgrade =
to V1.03=20
of the library alone worked again like a charm.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I write an application which uses a =
user-defined=20
dmix plugin for sound output (and the snd-intel8x0 AC97 low level =
driver). The=20
output gets Non-Interleaved Samples in seperate buffers per channel,=20
floating-point, mmaped access and I use the zero-copy mechanism provided =
by=20
regions. In my applications sound loop I use snd_pcm_mmap_begin() /=20
snd_pcm_mmap_commit() to detemine how many samples have to be processed. =
I=20
initialized the sound layer with a buffer size of&nbsp;512 and a period =
size of=20
256. Sample Rate is 48000Hz.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I use the following device according to =
the=20
configuration in /etc/asound.conf. Nevertheless the problem also exists =
with the=20
standard dmix plugin (plug:dmix). This only triggers the effect a bit=20
later.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>pcm.dmixer {</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>&nbsp;&nbsp;&nbsp; type =
dmix</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>&nbsp;&nbsp;&nbsp; ipc_key =
1027</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>&nbsp;&nbsp;&nbsp; slave {</FONT></DIV>
<DIV><FONT face=3DArial =
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pcm=20
"hw:0,0"</FONT></DIV>
<DIV><FONT face=3DArial =
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
period_time 0</FONT></DIV>
<DIV><FONT face=3DArial =
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
period_size 256</FONT></DIV>
<DIV><FONT face=3DArial =
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
buffer_size 512</FONT></DIV>
<DIV><FONT face=3DArial =
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; periods=20
2</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;}</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>&nbsp;&nbsp;&nbsp; bindings =
{</FONT></DIV>
<DIV><FONT face=3DArial =
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0=20
0</FONT></DIV>
<DIV><FONT face=3DArial =
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1=20
1</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>&nbsp;&nbsp;&nbsp; }</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>}</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;</DIV></FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Normally, if I print out the values =
returned by=20
snd_pcm_avail_update() and the chunks processed by snd_pcm_mmap_begin() =
/=20
snd_pcm_mmap_commit() I get the following output:</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>256 frames available</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>256 chunked</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>256 frames available</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>108 chunked 148 chunked</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>256 frames available</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>...</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>But after some while I =
get:</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>...</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>257 (!) frames avilable</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>108 chunked 149 chunked</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>511(!) frames available</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>363 chunked 148 chunked</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>This seems to be where the problem =
arises, as I use=20
the internal regions buffers, which are certainly allocated only to 256 =
frames=20
(1024 bytes) and here a buffer overflow occurs. Afterwards the audio =
output=20
ceases to work. I have not debugged into the alsa-lib, so these are only =

assumptions. But by thinking about it, it&nbsp;seems reasonable that =
this should=20
be the problem.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>This behaviour does not show for =
alsa-lib V=20
1.03.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Best regards,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Daniel.</FONT></DIV></BODY></HTML>

------=_NextPart_000_1B0A_01C4765A.6D145600--



-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
