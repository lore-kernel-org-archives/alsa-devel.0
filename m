From: =?UTF-8?B?T25kcmVqIEl2YW5pxI0=?= <ondrej@kmit.sk>
Subject: Re: Bt87x Audio Capture
Date: Fri, 10 Mar 2006 12:32:02 +0100
Message-ID: <441163B2.4060407@kmit.sk>
References: <440F4F06.4030904@kmit.sk> <20060309074930.GA993@turing.informatik.uni-halle.de> <440FF003.5050106@kmit.sk> <20060309131146.GA4299@turing.informatik.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20060309131146.GA4299@turing.informatik.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch wrote:

> The snd-bt87x driver in the same kernel has a bug that prevents it from
> working with the load_all parameter.  This was fixed with this patch:
> http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blobdiff;h=c840a4c08e9814c197d30b631b782c420e26869a;hp=aaaa2e0d45c22aec11ac2325a488d27e392a0f96;hb=54c63cfc153c6909a5d5dbe6072e8704b091f30e;f=sound/pci/bt87x.c

Yes, my card was detected as an unknown card 0x11bd:0x12. I don't have 
idea how to identify correct digital_rate value for card.

I playing with a tvtime and arecord. In the tvtime I was tuned a tv 
channel and with arecord I was tryied to record some sound from TV card 
capture device.

card 0: AudioPCI [Ensoniq AudioPCI], device 0: ES1371/1 [ES1371 DAC2/ADC]
   Subdevices: 1/1
   Subdevice #0: subdevice #0
card 1: Bt878 [Brooktree Bt878], device 0: Bt87x Digital [Bt87x Digital]
   Subdevices: 1/1
   Subdevice #0: subdevice #0
card 1: Bt878 [Brooktree Bt878], device 1: Bt87x Analog [Bt87x Analog]
   Subdevices: 1/1
   Subdevice #0: subdevice #0

$ arecord -Dhw:1,1 -f S16_LE -r 119466 -d 20 /tmp/out.wav

Output file contains only wav header and 0x7fff values.

BTW, it's possible to create interconnect between sound card and capture 
device in TV card? I would like to live without cable from TV card to 
sound card line in. I was read something about dmix and dsnoop plugins, 
but i have't idea.


-- 
Ondrej Ivanic
(ondrej@kmit.sk)


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
