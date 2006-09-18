From: "Vishwanath T. K." <vishytk@gmail.com>
Subject: snd-hda-intel - 5.1 speakers problem
Date: Tue, 19 Sep 2006 01:36:04 +0530
Message-ID: <55f590609181306h575c9a99wd308f0c554d5a3a3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0084194574=="
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

--===============0084194574==
Content-Type: multipart/alternative;
	boundary="----=_Part_46917_13976428.1158609964523"

------=_Part_46917_13976428.1158609964523
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi All,

I have had this problem for quite a while and could not get any solution so
far. I have tried all possible options mentioned in the
ALSA-configuration.txt and various suggestions from the mailing list but
without any luck, hence finally decided to post the problem here.

Problem:
I am unable to get all (5.1) the speakers working. I get the sound only in
four speakers connected to Line Out and Microphone jacks. Speakers connected
to Line In jack outputs noise instead of the intended sound. This noise
dissapears the moment the pin from this jack is removed.

Details:

Hardware - ASUS A8N-VM motherboard.

Software:
Fedora Core 5
Kernel 2.6.17
Alsa-driver version - 1.0.12
Driver used - snd-hda-intel, CODEC - AD1986A

/etc/modprobe.conf

alias snd-card-0 snd-hda-intel
options snd-hda-intel model=6stack position_fix=1

lspci -s 00:10.1
00:10.1 Audio device: nVidia Corporation MCP51 High Definition Audio (rev
a2)

lspci -s 00:10.1 -nv

00:10.1 0403: 10de:026c (rev a2)
        Subsystem: 10de:cb84
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 11
        Memory at febd8000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: [44] Power Management version 2
        Capabilities: [50] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-
        Capabilities: [6c] HyperTransport: MSI Mapping


Hope someone can help me solve this issue.

Regards,
Vishwanath

------=_Part_46917_13976428.1158609964523
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi All,<br><br>I have had this problem for quite a while and could not get any solution so far. I have tried all possible options mentioned in the ALSA-configuration.txt and various suggestions from the mailing list but without any luck, hence finally decided to post the problem here.
<br><br>Problem:<br>I am unable to get all (5.1) the speakers working. I get the sound only in four speakers connected to Line Out and Microphone jacks. Speakers connected to Line In jack outputs noise instead of the intended sound. This noise dissapears the moment the pin from this jack is removed.
<br><br>Details:<br><br>Hardware - ASUS A8N-VM motherboard.<br><br>Software:<br>Fedora Core 5<br>Kernel 2.6.17<br>Alsa-driver version - 1.0.12<br>Driver used - snd-hda-intel, CODEC - AD1986A<br><br>/etc/modprobe.conf<br><br>
alias snd-card-0 snd-hda-intel<br>options snd-hda-intel model=6stack position_fix=1<br><br>lspci -s 00:10.1 <br>00:10.1 Audio device: nVidia Corporation MCP51 High Definition Audio (rev a2)<br><br>lspci -s 00:10.1 -nv<br>
<br>00:10.1 0403: 10de:026c (rev a2)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Subsystem: 10de:cb84<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 11<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Memory at febd8000 (32-bit, non-prefetchable) [size=16K]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Capabilities: [44] Power Management version 2
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Capabilities: [50] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Capabilities: [6c] HyperTransport: MSI Mapping<br><br><br>Hope someone can help me solve this issue.<br><br>Regards,<br>Vishwanath
<br>

------=_Part_46917_13976428.1158609964523--


--===============0084194574==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0084194574==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0084194574==--
