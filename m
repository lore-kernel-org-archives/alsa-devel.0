From: "Morten W. Petersen" <morten@nidelven-it.no>
Subject: Problems recording with CM8738
Date: Sun, 13 Feb 2005 19:17:05 +0100
Message-ID: <420F99A1.4090801@nidelven-it.no>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010503040302030708050406"
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------010503040302030708050406
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I'm having problems recording sound on Linux, and hopefully I'm now
asking on the right list.

I'm having problems recording simple wav files, using 'rec test.wav'
on my Linux box.  dmesg says I've got ALSA running:

Advanced Linux Sound Architecture Driver Version 1.0.4 (Mon May 17 
14:31:44 2004 UTC).
PCI: Found IRQ 10 for device 0000:00:13.0
PCI: Sharing IRQ 10 with 0000:00:10.3
ALSA device list:
 #0: C-Media PCI CMI8738-MC6 (model 55) at 0xe000, irq 10

lspci says:

0000:00:13.0 Multimedia audio controller: C-Media Electronics Inc CM8738 
(rev 10)
       Subsystem: Chaintech Computer Co. Ltd: Unknown device 1100
       Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
       Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
       Latency: 32 (500ns min, 6000ns max)
       Interrupt: pin A routed to IRQ 10
       Region 0: I/O ports at e000 [size=256]
       Capabilities: [c0] Power Management version 2
               Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
               Status: D0 PME-Enable- DSel=0 DScale=0 PME-

I've checked that the microphone has the right input level.
Any suggestions would be much appreciated.

-Morten

-- 
Regards,

Morten

Tlf:  +47 45 44 00 69
Blog: http://www.blogologue.com


--------------010503040302030708050406
Content-Type: text/x-vcard; charset=utf-8;
 name="morten.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="morten.vcf"

begin:vcard
fn:Morten Petersen
n:Petersen;Morten
org:Nidelven IT
adr:;;Postboks 923;Trondheim;;7409;Norway
email;internet:morten@nidelven-it.no
title:Project Manager
tel;work:+47 45 44 00 69
tel;cell:+47 45 44 00 69
x-mozilla-html:FALSE
url:http://www.nidelven-it.no
version:2.1
end:vcard


--------------010503040302030708050406--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
