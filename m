From: James Pearson <james-p@moving-picture.com>
Subject: Re: Problems with 32 bit apps on 64 bit OS using dmix
 and snd-ioctl32
Date: Thu, 06 Sep 2007 12:56:05 +0100
Message-ID: <46DFEAD5.7040806@moving-picture.com>
References: <46DE8EB0.90208@moving-picture.com>
	<s5hd4wx8ec0.wl%tiwai@suse.de>	<46DEBF69.6070307@moving-picture.com>	<s5hodgh6sqf.wl%tiwai@suse.de>	<46DECCEA.4060306@moving-picture.com>	<s5hk5r56qin.wl%tiwai@suse.de>	<46DEDF4B.7050108@moving-picture.com>	<s5hbqch6nrf.wl%tiwai@suse.de>	<46DFD5DB.6030204@moving-picture.com>
	<s5h642o6p8h.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moving-picture.com (mpc-26.sohonet.co.uk [193.203.82.251])
	by alsa0.perex.cz (Postfix) with ESMTP id 143F824370
	for <alsa-devel@alsa-project.org>;
	Thu,  6 Sep 2007 13:56:06 +0200 (CEST)
In-Reply-To: <s5h642o6p8h.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> 
> You shouldn't use --enable-static for the dynamic library.
> Yes, usually it's OK, but alsa-lib has some special handling for
> static binding, so it cannot be built with dynamic lib together.
> 
> Thus, for 64bit version,
> 
> 	% ./configure --datadir=/etc --libdir=/usr/lib64
> 
> for 32bit version,
> 
> 	% ./configure --datadir=/etc
> 
> And make sure that all sound apps are killed once (otherwise the old
> configured dmix instance may remain undead and conflict with the new
> setting).
> 
>>Does building alsa-lib depend on the alsa-driver version installed? - as 
>>I built the 32 bit version on a 'stock' CentOS4/RHEL4 install that 
>>didn't have the alsa-driver 1.0.15rc1 installed - would this make a 
>>difference?
> 
> 
> alsa-lib has backward compatibility, so it should work with the older
> drivers.  The kernel ABI is usually kept, but some exceptional cases
> like this timer ioctl changes can be supported only by the newer
> alsa-lib.  But, in principle, it's safer to update both alsa-driver
> and alsa-lib.
> 
> Also, it's recommended to keep the same version for both 32 and 64bit
> alsa-lib, too, especially about dmix stuff.

Rebuilt alsa-lib 1.0.15rc1 for both 32 and 64 bit as above, installed 
and rebooted - however, I still can't get it to play with 32 bit apps - 
I still get:

% aplay test.wav
Playing WAVE 'test.wav' : Signed 16 bit Little Endian, Rate 48000 Hz, Mono
aplay: pcm_write:1268: write error: Invalid argument

dmesg:

ioctl32(aplay:5957): Unknown cmd fd(3) cmd(40045402){00} arg(ffffacb8) 
on /dev/snd/timer
ioctl32(aplay:5957): Unknown cmd fd(5) cmd(c008551a){00} arg(0807a140) 
on /dev/snd/controlC0
ioctl32(aplay:5957): Unknown cmd fd(5) cmd(c008551b){00} arg(0807a140) 
on /dev/snd/controlC0
ioctl32(aplay:5957): Unknown cmd fd(3) cmd(000054a0){00} arg(00000325) 
on /dev/snd/timer

Thanks

James Pearson
