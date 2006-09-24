From: "=?ISO-8859-2?Q?Stanis=B3aw_Raczy=F1ski?=" <sutashu@gmail.com>
Subject: hda_intel ATI SB450 - unknown subsystem ID 1025:009f
Date: Sun, 24 Sep 2006 16:02:30 +0200
Message-ID: <ab3226c20609240702q16d4a4f1x2c88fd9faf983b75@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0980968892=="
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

--===============0980968892==
Content-Type: multipart/alternative;
	boundary="----=_Part_12438_23586814.1159106550159"

------=_Part_12438_23586814.1159106550159
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

It seems to me that the Intel HDA-based audio card on my new Turion64 X2
laptop (Acer Aspire 5102WLMi) is not yet properly
supported. I can't make the alsamixer to start (I tried many different model
settings infor the snd-hda-intel module):

alsamixer: function snd_mixer_load failed: Invalid argument

I was searching through alsa-kernel/pci/hda/patch_realtek.c and
alsa-kernel/Documentation/ALSA-Configuration.txt files and could not find my
model there, but the second file instructed me to post here. Here's the
lspci -nv snippet:

00:14.2 0403: 1002:437b (rev 01)
  Subsystem: 1025:009f
  Flags: bus master, slow devsel, latency 64, IRQ 18
  Memory at c0000000 (64-bit, non-prefetchable) [size=16K]
  Capabilities: [50] Power Management version 2
  Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-

Best wishes,
Stanislaw Raczynski

------=_Part_12438_23586814.1159106550159
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,<br><br>It seems to me that the Intel HDA-based audio card on my new Turion64 X2 laptop (Acer Aspire 5102WLMi) is not yet properly supported.&nbsp;I&nbsp;can't&nbsp;make&nbsp;the&nbsp;alsamixer&nbsp;to&nbsp;start (I tried many different model settings infor the snd-hda-intel module):
<br> <br>alsamixer: function snd_mixer_load failed: Invalid argument<br><br>I was searching through alsa-kernel/pci/hda/patch_realtek.c and alsa-kernel/Documentation/ALSA-Configuration.txt files and could not find my model there, but the second file instructed me to post here. Here's the lspci -nv snippet:
<br><br>00:14.2 0403: 1002:437b (rev 01)<br>        &nbsp;&nbsp;Subsystem: 1025:009f<br>        &nbsp;&nbsp;Flags: bus master, slow devsel, latency 64, IRQ 18<br>        &nbsp;&nbsp;Memory at c0000000 (64-bit, non-prefetchable) [size=16K]<br>        &nbsp;&nbsp;Capabilities: [50] Power Management version 2
<br>        &nbsp;&nbsp;Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-<br><br>Best wishes,<br>Stanislaw Raczynski<br>

------=_Part_12438_23586814.1159106550159--


--===============0980968892==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0980968892==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0980968892==--
