From: AKIK Frankfurt <info@akik-ffm.de>
Subject: SiS 7012 / 963L chipset
Date: Fri, 17 Dec 2004 11:32:33 +0100
Message-ID: <41C2B5C1.8030305@akik-ffm.de>
Mime-Version: 1.0
Content-Type: multipart/alternative;
 boundary="------------090100020208020704000106"
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

This is a multi-part message in MIME format.
--------------090100020208020704000106
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I'm having huge problems with getting a SiS 7012 on-board sound 
controller up and running. I've tracked the problem down to an apparent 
mismatch between the ICHx specification as issued by Intel and the 
behaviour of the controller itself. The environment
is a Fujitsu-Siemens Scaleo 600 with a SiS 648FX northbridge and an 
apparent SiS 963L southbridge.

There seems to be a difference regarding the specification of register 
access and contents. The specification I have is Intel's ICH2 document; 
the PCI subsystem as reported by the bus is 1734:1030. More 
specifically, the contents of the global status register (dword at 
offset 0x30) apparently doesn't contain the codecs' status information 
as defined by Intel. Thus, ALSA can't init the primary AC 97 codec and 
refuses to drive the soundchip. BTW: Am I right in assuming that ALSA 
uses ICHx by default to drive 7012s?

Does anybody by any chance have a spec. for the 963L? I've asked FSC and 
SiS, but needless to say without much luck. I'm quite happy to give ALSA 
a hand here & modify the driver accordingly so that owners of said 
computer can use the on-board audio facility without having to buy new 
audio hardware.

Any comments, clues or hints welcome.

      Cheers, Christoph

--------------090100020208020704000106
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
<small><font face="Helvetica, Arial, sans-serif">I&#8217;m having huge
problems with getting a SiS 7012 on-board sound controller up and
running. I&#8217;ve tracked the problem down to an apparent mismatch between
the ICHx specification as issued by Intel and the behaviour of the
controller itself. The environment<br>
is a Fujitsu-Siemens Scaleo 600 with a SiS 648FX northbridge and an
apparent SiS 963L southbridge. <br>
<br>
There seems to be a difference regarding the specification of register
access and contents. The specification I have is Intel&#8217;s ICH2 document;
the PCI subsystem as reported by the bus is 1734:1030. More
specifically, the contents of the global status register (dword at
offset 0x30) apparently doesn&#8217;t contain the codecs&#8217; status information
as defined by Intel. Thus, ALSA can&#8217;t init the primary AC 97 codec and
refuses to drive the soundchip. BTW: Am I right in assuming that ALSA
uses ICHx by default to drive 7012s?<br>
<br>
Does anybody by any chance have a spec. for the 963L? I've asked FSC
and SiS, but needless to say without much luck. I'm quite happy to give
ALSA a hand here &amp; modify the driver accordingly so that owners of
said computer can use the on-board audio facility without having to buy
new audio hardware.<br>
<br>
Any comments, clues or hints welcome.<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Cheers, Christoph<br>
</font></small>
</body>
</html>

--------------090100020208020704000106--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
