From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: status of usb audio driver
Date: Wed, 12 Jun 2002 23:55:56 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D0760FC.5060906@boosthardware.com>
References: <s5h7klfdlrn.wl@alsa2.suse.de>	<3D06D91D.1080104@boosthardware.com>	<s5hhek81vgl.wl@alsa2.suse.de>	<3D07564B.4050908@boosthardware.com> <s5hbsag1t5r.wl@alsa2.suse.de>
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
> At Wed, 12 Jun 2002 23:10:19 +0900,
> Patrick Shirkey wrote:
> 
>>Takashi Iwai wrote:
>>
>>>it's on cvs.  please give a try.
>>>btw, now descriptor proc was removed (one can use lsusb anyway).
>>>instead you'll see formats supported on each stream.
>>>
>>
>>Excellent work. I haven't tested the output yet but will soon. One thing 
>>that isn't correct is that this card has 4 channels. Is it me or does 
>>the following only find 3?
> 
> 
> can you check kernel debug (detection) messages?
> perhaps it skipps an audio stream by some reason.
> 
> 

i have been testing the sound and I am getting playback although at this 
point I can get sound out of hw:2,0 and hw:2,2 they are both the left 
channels. The sound is scratchy but it is there :)

This is from the kernel. It seems to be loading the devices unusually.

-----
#dmesg
devfs_register(unknown): could not append to parent, err: -17
devfs_register(unknown): could not append to parent, err: -17
usb.c: registered new driver snd-usb-audio
ALSA usbaudio.c:1756: adding an output interface 3:0:1
ALSA usbaudio.c:1750: adding an input interface 3:0:2
devfs_register(unknown): could not append to parent, err: -17
devfs_register(unknown): could not append to parent, err: -17
devfs_register(unknown): could not append to parent, err: -17
ALSA usbaudio.c:1756: adding an output interface 3:3:4
ALSA usbaudio.c:1750: adding an input interface 3:3:5
ALSA usbaudio.c:1391: 3:4:1 : non-supported sample bit 1 in 3 bytes
ALSA usbaudio.c:1391: 3:4:3 : non-supported sample bit 1 in 3 bytes
ALSA usbaudio.c:1391: 3:5:1 : non-supported sample bit 1 in 3 bytes
ALSA usbaudio.c:1391: 3:5:3 : non-supported sample bit 1 in 3 bytes
devfs_register(unknown): could not append to parent, err: -17
ALSA usbaudio.c:1756: adding an output interface 3:6:7
ALSA usbaudio.c:1750: adding an input interface 3:6:8
ALSA usbaudio.c:1391: 3:7:1 : non-supported sample bit 1 in 3 bytes
ALSA usbaudio.c:1391: 3:7:3 : non-supported sample bit 1 in 3 bytes
ALSA usbaudio.c:1391: 3:8:1 : non-supported sample bit 1 in 3 bytes
ALSA usbaudio.c:1391: 3:8:3 : non-supported sample bit 1 in 3 bytes
-----
/var/log/messages

Jun 12 23:44:24 mahine kernel: usb.c: registered new driver snd-usb-audio
Jun 12 23:44:24 mahine kernel: ALSA usbaudio.c:1756: adding an output 
interface 3:0:1
Jun 12 23:44:24 mahine kernel: ALSA usbaudio.c:1750: adding an input 
interface 3:0:2
Jun 12 23:44:24 mahine kernel: ALSA usbaudio.c:1756: adding an output 
interface 3:3:4
Jun 12 23:44:24 mahine kernel: ALSA usbaudio.c:1750: adding an input 
interface 3:3:5
Jun 12 23:44:24 mahine kernel: ALSA usbaudio.c:1756: adding an output 
interface 3:6:7
Jun 12 23:44:24 mahine kernel: ALSA usbaudio.c:1750: adding an input 
interface 3:6:8
-----

> Takashi
> 
> 



-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.boosthardware.com/LAU/guide/
========================================


_______________________________________________________________

Sponsored by:
ThinkGeek at http://www.ThinkGeek.com/
