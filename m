From: Olaf Hering <olaf@aepfle.de>
Subject: Re: oops in snd-powermac due to snd-aoa
Date: Sat, 16 Sep 2006 11:56:03 +0200
Message-ID: <20060916095603.GA5447@aepfle.de>
References: <20060907124256.GA22928@aepfle.de> <s5h64fzltyg.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from natlemon.rzone.de (natlemon.rzone.de [81.169.145.170])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C103C17C
	for <alsa-devel@alsa-project.org>;
	Sat, 16 Sep 2006 11:56:03 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <s5h64fzltyg.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 07, Takashi Iwai wrote:

> At Thu, 7 Sep 2006 14:42:56 +0200,
> Olaf Hering wrote:
> > 
> > I was playing with snd-aoa, maybe the driver would work on a G4/466.
> > mv /lib/modules/*/kernel/sound/ppc/snd-powermac.ko .
> > reboot
> > $insmod /lib/modules/*/kernel/sound/aoa/*/*.ko
> > alsamixer finds nothing.
> > mv snd-powermac.ko /lib/modules/*/kernel/sound/ppc/
> > $insmod snd-powermac.ko -> oops
> > 
> > Using PowerMac machine description
> (snip)
> > ALSA sound/ppc/keywest.c:82: tumbler: cannot attach i2c client
> > read_audio_gpio addr 67 ret 2 av 4
> > headphone: 0, lineout: 0
> > check_audio_gpio addr 70 ret 4 av 4
> > check_audio_gpio addr 6f ret 7 av 4
> > Unable to handle kernel paging request for data at address 0x00000002
> 
> Does the patch below work?

Yes, no oops, but also no sound without reboot. Thats ok.

...
ALSA sound/ppc/keywest.c:82: tumbler: cannot attach i2c client
read_audio_gpio addr 67 ret 2 av 4
headphone: 0, lineout: 0
check_audio_gpio addr 70 ret 4 av 4
check_audio_gpio addr 6f ret 7 av 4
date:~ # 
date:~ # alsamixer 

alsamixer: function snd_ctl_open failed for default: No such device
...


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
