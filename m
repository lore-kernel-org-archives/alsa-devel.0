From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: status of usb audio driver
Date: Thu, 13 Jun 2002 21:54:08 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D0895F0.20904@boosthardware.com>
References: <s5h7klfdlrn.wl@alsa2.suse.de>	<3D06D91D.1080104@boosthardware.com>	<s5hhek81vgl.wl@alsa2.suse.de>	<3D07564B.4050908@boosthardware.com>	<s5hbsag1t5r.wl@alsa2.suse.de>	<3D0760FC.5060906@boosthardware.com>	<3D0772F1.6090009@boosthardware.com>	<3D077B61.7030902@boosthardware.com>	<s5hzny0zb43.wl@alsa2.suse.de>	<3D078560.4030707@boosthardware.com> <s5hr8jbzcml.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> 
> actually the endpoints of the first two pcm streams are identical.
> is the sound only mono?

Yes it *was* just through output 2 or 4 on the card.

> on the description, it's defined as stereo streams.
> so i guess quattro has two stereo streams, corresponding #0 (or #1)
> and #2.
> it seems that the stream #0 has only 16bit 44.1kHz at most, while the
> stream #1 supports 16/24bit 48kHz (although 24bit-3bytes format is not
> supported on alsa yet).
> 

This card is supposed to be 24bit/96Khz. In windows it works like this:

4 i/o channels(2 in, 2 out) at 16bit/48Khz or less
3 i/o channels(2 in, 1 out or 1 in, 2 out) at 24bit/48Khz or less
1 channel at 24bit/96Khz

I understand why the 24 bit is not being registered, is that also the 
probable reason why 96Khz is not being found?


> 
> i've tested usb mic from Labtec, and it works.
> so the problem is specific to the hardware, or multi-channels...
> 

I just remembered that my mouse is a usb mouse too so that is not 
unexpected.

> 
> anyway, could you try the attached patch?
> 

Excellent work. That has enabled stereo playback in hw:2,0 hw:2,1 and 
hw:2,2. I am unsure about a couple of things though. hw:2,0 and hw 2,1 
seem to be doing the same thing.


#dmesg
---
usb.c: registered new driver snd-usb-audio
ALSA usbaudio.c:1833: adding an output interface 3:0:1
ALSA usbaudio.c:1827: adding an input interface 3:0:2
devfs_register(unknown): could not append to parent, err: -17
devfs_register(unknown): could not append to parent, err: -17
devfs_register(unknown): could not append to parent, err: -17
ALSA usbaudio.c:1833: adding an output interface 3:3:4
ALSA usbaudio.c:1827: adding an input interface 3:3:5
ALSA usbaudio.c:1459: 3:4:1 : non-supported sample bit 1 in 3 bytes
ALSA usbaudio.c:1459: 3:4:3 : non-supported sample bit 1 in 3 bytes
ALSA usbaudio.c:1459: 3:5:1 : non-supported sample bit 1 in 3 bytes
ALSA usbaudio.c:1459: 3:5:3 : non-supported sample bit 1 in 3 bytes
devfs_register(unknown): could not append to parent, err: -17
ALSA usbaudio.c:1833: adding an output interface 3:6:7
ALSA usbaudio.c:1827: adding an input interface 3:6:8
ALSA usbaudio.c:1459: 3:7:1 : non-supported sample bit 1 in 3 bytes
ALSA usbaudio.c:1459: 3:7:3 : non-supported sample bit 1 in 3 bytes
ALSA usbaudio.c:1459: 3:8:1 : non-supported sample bit 1 in 3 bytes
ALSA usbaudio.c:1459: 3:8:3 : non-supported sample bit 1 in 3 bytes
---




-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.boosthardware.com/LAU/guide/
========================================


_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas - http://devcon.sprintpcs.com/adp/index.cfm?source=osdntextlink
