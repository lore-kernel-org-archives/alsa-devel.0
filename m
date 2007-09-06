From: James Pearson <james-p@moving-picture.com>
Subject: Re: Problems with 32 bit apps on 64 bit OS using dmix
 and snd-ioctl32
Date: Thu, 06 Sep 2007 11:26:35 +0100
Message-ID: <46DFD5DB.6030204@moving-picture.com>
References: <46DE8EB0.90208@moving-picture.com>
	<s5hd4wx8ec0.wl%tiwai@suse.de>	<46DEBF69.6070307@moving-picture.com>	<s5hodgh6sqf.wl%tiwai@suse.de>	<46DECCEA.4060306@moving-picture.com>	<s5hk5r56qin.wl%tiwai@suse.de>	<46DEDF4B.7050108@moving-picture.com>
	<s5hbqch6nrf.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moving-picture.com (mpc-26.sohonet.co.uk [193.203.82.251])
	by alsa0.perex.cz (Postfix) with ESMTP id 2635C24424
	for <alsa-devel@alsa-project.org>;
	Thu,  6 Sep 2007 12:26:36 +0200 (CEST)
In-Reply-To: <s5hbqch6nrf.wl%tiwai@suse.de>
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

> Hm, maybe it's better to specify 2.6.16 or so for SND_SOC in
> alsa-driver/kconfig-vers.  Could you check whether it works?

Yes, this works - after I figured out that I needed to regenerate the 
configure script after changing kconfig-vers ...

alsa-driver 1.0.15rc1 now builds OK on RHEL4/CentOS4 (with a patched 
misc/ac97_bus.c and SND_SOC set to 2.6.16 in kconfig-vers)

>>However, with these 1.0.15rc1 modules installed, and using 
>>alsa-lib-1.0.15rc1, I get exactly the same problem with 32 bit apps:
>>
>>Playing WAVE 'test.wav' : Signed 16 bit Little Endian, Rate 48000 Hz, Mono
>>aplay: pcm_write:1268: write error: Invalid argument
>>
>>amd dmesg has:
>>
>>ioctl32(aplay:6228): Unknown cmd fd(3) cmd(40045402){00} arg(ffffac98) 
>>on /dev/snd/timer
>>ioctl32(aplay:6228): Unknown cmd fd(5) cmd(c008551a){00} arg(0806ccd0) 
>>on /dev/snd/controlC0
>>ioctl32(aplay:6228): Unknown cmd fd(5) cmd(c008551b){00} arg(0806ccd0) 
>>on /dev/snd/controlC0
>>ioctl32(aplay:6228): Unknown cmd fd(3) cmd(000054a0){00} arg(00000325) 
>>on /dev/snd/timer
> 
> 
> Do you use the latest alsa-lib, too?
> The old alsa-lib tries only the old ioctl, of course...

Yes, I've installed the 32 bit and 64 bit alsa-lib-1.0.15rc1 packages - 
and I still get the above errors ...

Do I need to build alsa-lib with any special options? I configured 
alsa-lib using:

  configure --enable-static=yes --datadir=/etc

As this is how the 1.0.6 alsa-lib RHEL4 RPM was configured.

Does building alsa-lib depend on the alsa-driver version installed? - as 
I built the 32 bit version on a 'stock' CentOS4/RHEL4 install that 
didn't have the alsa-driver 1.0.15rc1 installed - would this make a 
difference?

Thanks

James Pearson
