From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000156]: MIDI fails with "cmd: 0xff failed at 0x300 (status = 0xff, data = 0xff)"
Date: Mon, 28 Mar 2005 04:10:47 +0200
Message-ID: <49f73e25fe22fe794be3b1b269822427@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 95605253
	for <alsa-devel@alsa-project.org>; Mon, 28 Mar 2005 04:10:47 +0200 (MEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=156> 
======================================================================
Reported By:                gwittenburg
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   156
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian testing/unstable
Kernel Version:             2.6.4
======================================================================
Date Submitted:             03-24-2004 06:07 CET
Last Modified:              03-28-2005 04:10 CEST
======================================================================
Summary:                    MIDI fails with "cmd: 0xff failed at 0x300 (status =
0xff, data = 0xff)"
Description: 
MIDI playback with aplaymidi doesn't produce any output with all channels
turned on in alsamixer. While aplaymidi is running a quiet, high-pitched
sound is comming from some part in the laptop. The following two lines
appear in dmesg:

cmd: 0xff failed at 0x300 (status = 0xff, data = 0xff)
cmd: 0x3f failed at 0x300 (status = 0xff, data = 0xff)

The same happens if the snd-intel8x0 module was inserted with
mpu_port=0x330. (btw, usually I would have expected one of these two to
fail...) snd_rawmidi is loaded with midi_map=0.
======================================================================

----------------------------------------------------------------------
 gwittenburg - 03-25-04 02:32 
----------------------------------------------------------------------
Thanks for the clarification and the time you're spending on this.

I've sat down and read the code. In drivers/mpu401/mpu401_uart.c,
snd_mpu401_uart_new() actually does probe the hardware and returns an
error which would cause snd_intel8x0_probe() in pci/intel8x0.c to print
something like "intel8x0: no UART401 device at 0x%x, sk
ipping.\n" If my hardware doesn't support mpu401, I'd definately expect
that line to appear in the syslog.

In my humble and ad-hoc opinion, the problem is that snd_mpu401_uart_new()
doesn't really try to access the hardware. If a snd_mpu401_uart_cmd(mpu,
MPU401_RESET, 0); was performed near the end of that function (and if
snd_mpu401_uart_cmd() had a return value) it would be easy to tell whether
the hardware is actually there or not.

Again, this is of course my very own ad-hoc and uneducated opinion and
feedback from your side if very welcome. If you think the proposed
solution has any merit, I'll try to come up with a patch that addresses
this issue.

----------------------------------------------------------------------
 jdthood - 03-28-05 04:10 
----------------------------------------------------------------------
Submitter: Does this problem still exist with current ALSA versions?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-24-04 06:07 gwittenburg    New Issue                                    
03-24-04 06:07 gwittenburg    Distribution              => Debian
testing/unstable
03-24-04 06:07 gwittenburg    Kernel Version            => 2.6.4           
03-24-04 06:11 gwittenburg    Issue Monitored: gwittenburg                    
03-24-04 10:02 perex          Note Added: 0000696                          
03-24-04 13:10 gwittenburg    Note Added: 0000700                          
03-24-04 15:04 perex          Note Added: 0000701                          
03-25-04 02:32 gwittenburg    Note Added: 0000704                          
03-28-05 04:10 jdthood        Note Added: 0004231                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
