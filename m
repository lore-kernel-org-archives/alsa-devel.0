From: "Bo Henriksen" <bo.henriksen@nordicid.com>
Subject: snd_pcm_lib_preallocate_pages_for_all
Date: Mon, 5 Jul 2004 10:03:32 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <A6991F0FA073F34C94E97976CAC0323116F8BC@server2.nordicid.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C4625E.2EFEF448"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Class: urn:content-classes:message
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

------_=_NextPart_001_01C4625E.2EFEF448
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

=20

I am writing an ALSA driver for the Wolfson AC97 codec family
(WM9703/11) for the SHARP LH7A404 processor on the LPD SDK-LH7A404
development board. The driver is written using the 2.6.7 kernel. I
followed the document by Takashi Iwai, "Writing an ALSA Driver" and got
stuck where I have to pre-allocate the DMA buffer (in the
snd_mychip_new_pcm function). I am confused about the second and third
parameter in the snd_pcm_lib_preallocate_pages_for_all function. I used
the sa11xx-uda1341.c as reference on how to allocate the buffer. The
problem is that I am no longer able to allocated ISA buffers using the
SNDRV_DMA_TYPE_ISA as the second parameter. I looked at an updated
version of the uda1341 from handhelds.org and saw they were using
snd_pcm_lib_preallocate_isa_pages_for_all. However, this function is
also not available in ALSA anymore. I then tried to allocate=20

like this:

=20

snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,

                                        NULL,

                                        64*1024, 64*1024);
with the third parameter set to NULL. This crashes the kernel with
following backtrace:

=20

-SNIP-

Backtrace:

[<bf025040>] (mark_pages+0x0/0xa8 [snd_page_alloc]) from [<bf0252b8>]
(snd_mallo

c_dev_pages+0x4c/0x54 [snd_page_alloc])

 r4 =3D FFC14000

[<bf02526c>] (snd_malloc_dev_pages+0x0/0x54 [snd_page_alloc]) from
[<bf025438>]

(snd_dma_alloc_pages+0x64/0xb4 [snd_page_alloc])

 r5 =3D 00000000  r4 =3D C1C6F48C

[<bf0253d4>] (snd_dma_alloc_pages+0x0/0xb4 [snd_page_alloc]) from
[<bf0355ec>] (

preallocate_pcm_pages+0x58/0x9c [snd_pcm])

...

..

-SNIP-

=20

If I insert "_dev" on the third parameter the function completes with
following output 6 times:

=20

            lh7a40x-aac lh7a40x-aac0: coherent DMA mask is unset

           =20

=20

I looked at the __dma_alloc function for arm (arch/arm/mm/consisten.c)
and saw that it returns NULL because the corherent_dma_mask is not set.

=20

-SNIP at Ln 149 consistent.c:=20

            if (dev) {

                        mask =3D dev->coherent_dma_mask;

                        if (mask =3D=3D 0) {

                                    dev_warn(dev, "coherent DMA mask is
unset\n");

                                    return NULL;

                        }

            }

-SNIP-

=20

Now, I am not totally familiar with the new DMA interface in Linux 2.6
and there is properly something I am missing here. In theory I just need
to allocate some buffer and give the physical buffer address to the DMA
controller so it can start its function. Should I instead try to
preallocate the buffer myself, using dma_alloc_writecombine and then
pre-set the parameters in the substream->dma_buffer before calling
snd_pcm_lib_malloc_pages from snd_mychip_pcm_hw_params?=20

=20

Am I missing DMA interface in the 2.6 kernel that I need to implement
for Linux to work correctly?

=20

=20

Regards,=20

=20

Bo Henriksen


------_=_NextPart_001_01C4625E.2EFEF448
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:st1=3D"urn:schemas-microsoft-com:office:smarttags" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"PersonName"/>
<!--[if !mso]>
<style>
st1\:*{behavior:url(#default#ieooui) }
</style>
<![endif]-->
<style>
<!--
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:Arial;
	color:windowtext;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Hi,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I am writing an ALSA driver for the Wolfson AC97 =
codec
family (WM9703/11) for the SHARP LH7A404 processor on the LPD =
SDK-LH7A404 development
board. The driver is written using the 2.6.7 kernel. I followed the =
document by
</span></font><a name=3DAEN2>Takashi Iwai</a><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>, =
&#8220;</span></font>Writing an
ALSA Driver&#8221; and got stuck where <font size=3D2 face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>I have to pre-allocate the =
DMA
buffer (in the snd_mychip_new_pcm function). I am confused about the =
second and
third parameter in the snd_pcm_lib_preallocate_pages_for_all function. I =
used
the sa11xx-uda1341.c as reference on how to allocate the buffer. The =
problem is
that I am no longer able to allocated ISA buffers using the =
SNDRV_DMA_TYPE_ISA
as the second parameter. I looked at an updated version of the uda1341 =
from
handhelds.org and saw they were using =
snd_pcm_lib_preallocate_isa_pages_for_all.
However, this function is also not available in ALSA anymore. I then =
tried to
allocate <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>like this:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>snd_pcm_lib_preallocate_pages_for_all(pcm,
SNDRV_DMA_TYPE_DEV,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
NULL,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
64*1024, 64*1024);<br>
with the third parameter set to NULL. This crashes the kernel with =
following
backtrace:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>-SNIP-<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Backtrace:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[&lt;bf025040&gt;] (mark_pages+0x0/0xa8 =
[snd_page_alloc])
from [&lt;bf0252b8&gt;] (snd_mallo<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>c_dev_pages+0x4c/0x54 =
[snd_page_alloc])<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;r4 =3D FFC14000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[&lt;bf02526c&gt;] (snd_malloc_dev_pages+0x0/0x54
[snd_page_alloc]) from [&lt;bf025438&gt;]<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>(snd_dma_alloc_pages+0x64/0xb4 =
[snd_page_alloc])<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;r5 =3D 00000000&nbsp; r4 =3D =
C1C6F48C<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[&lt;bf0253d4&gt;] (snd_dma_alloc_pages+0x0/0xb4
[snd_page_alloc]) from [&lt;bf0355ec&gt;] (<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>preallocate_pcm_pages+0x58/0x9c =
[snd_pcm])<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&#8230;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>..<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>-SNIP-<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>If I insert &#8220;_dev&#8221; on the third parameter =
the
function completes with following output 6 =
times:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; lh7a40x-aac
lh7a40x-aac0: coherent DMA mask is unset<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I looked at the __dma_alloc function for arm =
(arch/arm/mm/consisten.c)
and saw that it returns NULL because the corherent_dma_mask is not =
set.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>-SNIP at Ln 149 consistent.c: =
<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; if
(dev) {<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; mask
=3D dev-&gt;coherent_dma_mask;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; if
(mask =3D=3D 0) {<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_warn(dev,
&quot;coherent DMA mask is unset\n&quot;);<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return
NULL;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; }<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; }<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>-SNIP-<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Now, I am not totally familiar with the new DMA =
interface in
Linux 2.6 and there is properly something I am missing here. In theory I =
just
need to allocate some buffer and give the physical buffer address to the =
DMA
controller so it can start its function. Should I instead try to =
preallocate
the buffer myself, using dma_alloc_writecombine and then pre-set the =
parameters
in the substream-&gt;dma_buffer before calling snd_pcm_lib_malloc_pages =
from snd_mychip_pcm_hw_params?
<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Am I missing DMA interface in the 2.6 kernel that I =
need to
implement for Linux to work correctly?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Regards, <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><st1:PersonName
style=3D"BACKGROUND-POSITION: left bottom; BACKGROUND-IMAGE: =
url(res://ietag.dll/#34/#1001); BACKGROUND-REPEAT: repeat-x"
w:st=3D"on"><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:
 Arial'>Bo Henriksen</span></font></st1:PersonName><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'><o:p></o:p></span></font></p=
>

</div>

</body>

</html>

------_=_NextPart_001_01C4625E.2EFEF448--


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
