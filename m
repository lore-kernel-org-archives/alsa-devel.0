From: Niklas Werner <bergtroll@gmx.li>
Subject: Re: status of usb audio driver
Date: Thu, 13 Jun 2002 15:21:05 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200206131321.PAA09889@papaschlumpf.wg>
References: <s5hn0tzz5vg.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hn0tzz5vg.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

<SNIP>

Well, now comes the ugly things:

Using the usb-audio-driver leads to system-lockups:

No matter whether I access my emi26 via aplay or via oss-emulation, after 
some time or (more probable) some amount of data my System locks up (hard 
reset ;-() or at least the usb-bus locks absoulety thight up.
I can't reload the driver, not even reconnecting the device helps it 
always gives a timeout message:

Jun 13 12:26:19 Schlumpfine kernel:   0: [cd2c01e0] link (0d2c0210) e0 
Stalled CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=2, PID=2d(SETUP) 
(buf=0d0222c0)
Jun 13 12:26:19 Schlumpfine kernel:   1: [cd2c0210] link (0d2c0240) e3 
SPD Active Length=0 MaxLen=11 DT1 EndPt=0 Dev=2, PID=69(IN) (buf=08a9c000)
Jun 13 12:26:19 Schlumpfine kernel:   2: [cd2c0240] link (00000001) e3 
IOC Active Length=0 MaxLen=7ff DT1 EndPt=0 Dev=2, PID=e1(OUT) 
(buf=00000000)
Jun 13 12:25:03 Schlumpfine kernel: usb_control/bulk_msg: timeout
Jun 13 12:25:03 Schlumpfine kernel: emi26_load_firmware - error loading 
firmware
: error = -110<6>IPv6 v0.8 for NET4.0
Jun 13 12:25:28 Schlumpfine kernel: usb_control/bulk_msg: timeout
Jun 13 12:25:43 Schlumpfine last message repeated 149 times   
Jun 13 12:26:06 Schlumpfine kernel: emi26: set_reset (1) 
failed<3>emi26_load_fir
mware - error loading firmware: error = -110<7>uhci.c: root-hub INT 
complete: po
rt1: 580 port2: 48a data: 4

This doesn't happen with the kernel module (audio).
Unfortunately I can't find any clues in the logfiles, maybe you can...

At least I can reproduce this easily using xmms to playback some 7 
minutes or so of 48kHz mp3s....

Using aplay and waves this effect tends to appear later.
Using xmms' alsa-plugin crashes the sound-driver at once...

right, have fun*

Niklas

_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas - http://devcon.sprintpcs.com/adp/index.cfm?source=osdntextlink
