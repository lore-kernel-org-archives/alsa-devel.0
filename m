From: Friedrich Ewaldt <friedrich.ewaldt@gmx.de>
Subject: Re: Re: [Alsa-user] fm801 driver status?
Date: Fri, 13 Dec 2002 17:57:10 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DFA1166.2020409@gmx.de>
References: <3DF8A109.2030206@gmx.de>	<s5hel8nuvee.wl@alsa2.suse.de>	<3DF8B8FA.3040009@gmx.de>	<s5h3cp3uorz.wl@alsa2.suse.de>	<m27keexn25.fsf@vador.mandrakesoft.com>	<3DF9C1CD.3090205@gmx.de> <s5hisxxubkx.wl@alsa2.suse.de>
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
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Thierry Vignaud <tvignaud@mandrakesoft.com>, alsa-user@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai schrieb:
[...]
 >>00:0b.0 Multimedia audio controller: Fortemedia, Inc Xwave QS3000A
 >>[FM801] (rev a0)
 >>        Subsystem: Fortemedia, Inc: Unknown device 1319
 >>        Flags: bus master, medium devsel, latency 40, IRQ 10
 >>        I/O ports at ec00 [size=128]
 >>        Capabilities: [dc] Power Management version 1
 >>
 >>00:0b.1 Input device controller: Fortemedia, Inc Xwave QS3000A [FM801]
 >>(rev a0)
 >>        Subsystem: Fortemedia, Inc: Unknown device 1319
 >>        Flags: bus master, medium devsel, latency 40, IRQ 11
 >>        Capabilities: [dc] Power Management version 1
 >
 >
 > i need the pci vendor/device id for them.
 > could you give me the output of "lspci -n" for two devices above?
 > the audio chip should be 0x1319:0x0801.
 >

lspci -n output:

00:0b.0 Class 0401: 1319:0801 (rev a0)
00:0b.1 Class 0980: 1319:0801 (rev a0)

and that's part of the output of 'lspcidrake -v':

snd-fm801       : Fortemedia, Inc|Xwave QS3000A [FM801]
[MULTIMEDIA_AUDIO] (vendor:1319 device:0801 subv:1319 subd:1319)
snd-fm801       : Fortemedia, Inc|Xwave QS3000A [FM801] [INPUT_OTHER]
(vendor:1319 device:0801 subv:1319 subd:1319)

does this information help or do you need any other outputs? thanks!
(The fm801 chip on this card is one of the older models without SPDIF
input. I looked this up some time ago because I saw the possibility to
get an digital input with this card using an soldering iron and some el.
parts for a few cents)
fe




-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
