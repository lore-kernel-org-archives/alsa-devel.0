From: <pradeep.gane@wipro.com>
Subject: How to use mmap when PCI DMA feature is not available....
Date: Tue, 18 Oct 2005 19:57:15 +0530
Message-ID: <D6DA3A176076B2408E53467FC0B0056B019924CB@BLR-EC-MBX04.wipro.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C5D3F0.0AA7DD8C"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-class: urn:content-classes:message
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

This is a multi-part message in MIME format.

------_=_NextPart_001_01C5D3F0.0AA7DD8C
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi all,
=20
I am in the process of writing ALSA driver for a sound card.
=20
My sound card does not support the PCI DMA feature. It has external
hardware memory, where i will copy the data using copy callback
function.
=20
1. I am planning to allocate Kernel memory for PCM using
snd_malloc_pages.=20
2. I want this memory to be visible to the user so that he can put the
audio data directly onto this buffer.=20
3. I will use copy/silence callback to copy the data.
=20
Now my question is...=20
=20
1. Is my memory allocation strategy correct?
2. How do i mmap the memory to be visible to the user application?=20
=20
Thanks you very in advance.
=20
Best Regards,
Pradeep
=20
=20

------_=_NextPart_001_01C5D3F0.0AA7DD8C
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<TITLE>Message</TITLE>

<META content=3D"MSHTML 5.50.4937.800" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D046212014-18102005>Hi=20
all,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D046212014-18102005></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D046212014-18102005>I am =
in the process=20
of writing ALSA driver for a sound card.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D046212014-18102005></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D046212014-18102005>My =
sound card does=20
not support the PCI DMA feature. It has external hardware memory, where =
i will=20
copy the data using copy callback function.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D046212014-18102005></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D046212014-18102005>1. I =
am planning to=20
allocate Kernel memory for PCM using snd_malloc_pages. =
</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D046212014-18102005>2. I =
want this=20
memory to be visible to the user so that he can put the audio data =
directly onto=20
this buffer. </SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D046212014-18102005>3. I =
will use=20
copy/silence callback to copy the data.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D046212014-18102005></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D046212014-18102005>Now my =
question=20
is... </SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D046212014-18102005></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D046212014-18102005>1. Is =
my memory=20
allocation strategy correct?</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D046212014-18102005>2. How =
do i mmap the=20
memory to be visible to the user application? </SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D046212014-18102005></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D046212014-18102005>Thanks =
you very in=20
advance.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D046212014-18102005></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D046212014-18102005>Best=20
Regards,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D046212014-18102005>Pradeep</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D046212014-18102005></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D046212014-18102005>&nbsp;</SPAN></FONT></DIV></BODY></HTML>

------_=_NextPart_001_01C5D3F0.0AA7DD8C--


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
