From: Kunal Gangakhedkar <kunal.gangakhedkar@gmail.com>
Subject: Re: [PATCH] Recognise and use subdevice 0x3061 found
	in some HP dv6 notebooks.
Date: Thu, 24 Dec 2009 13:07:12 +0530
Message-ID: <200912241307.12332.kunal.gangakhedkar@gmail.com>
References: <200912140029.42677.kunal.gangakhedkar@gmail.com>
	<s5hljh5luat.wl%tiwai@suse.de>
	<200912230002.47741.kunal.gangakhedkar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f196.google.com (mail-yx0-f196.google.com
	[209.85.210.196])
	by alsa0.perex.cz (Postfix) with ESMTP id E075B103882
	for <alsa-devel@alsa-project.org>; Thu, 24 Dec 2009 08:37:22 +0100 (CET)
Received: by yxe34 with SMTP id 34so7225237yxe.16
	for <alsa-devel@alsa-project.org>; Wed, 23 Dec 2009 23:37:22 -0800 (PST)
In-Reply-To: <200912230002.47741.kunal.gangakhedkar@gmail.com>
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

On Wednesday 23 Dec 2009 12:02:47 am Kunal Gangakhedkar wrote:
> On Monday 14 Dec 2009 4:02:58 pm Takashi Iwai wrote:
> > At Mon, 14 Dec 2009 15:53:54 +0530,
> > Kunal Gangakhedkar wrote:
> > > 
> > > On Monday 14 Dec 2009 3:37:14 pm Takashi Iwai wrote:
> > > > At Mon, 14 Dec 2009 00:29:42 +0530,
> > > > Kunal Gangakhedkar wrote:
> > > > > 
> > > > > Obvious patch.
> > > > > Recently bought an HP Pavilion dv6-1110ax notebook. The modparm 'model=hp-dv5'
> > > > > works, but I thought it was better if it were natively supported.
> > > > > 
> > > > > Also, the 'hp_detect=1' hint
> > > > > (echo "hp_detect = 1" > /sys/class/sound/hwC0D0/hints) works nicely to mute the
> > > > > speakers when using the headphone jack(s). Is there any way to automatically
> > > > > enable this?
> > > > 
> > > > This is weird.  hp_detect is basically always set unless you clear
> > > > explicitly.  I guess it's simply a known IRQ problem on HP dv
> > > > laptops.  It requires MSI.
> > > > 
> > > > Anyway, could you test the very latest kernel without your patch and
> > > > confirm that the change is still needed?
> > > > 
> > > 
> > > The patch wasn't about hp_detect. It was to get the subdev recognised natively so that 
> > > you don't need the 'model=hp-dv5' modparm.
> > 
> > Yeah, I know.  But the speaker-muting should work even without
> > hp_detect=1 hints.  The IRQ thingy was only about the auto-muting.
> > 
> > Also, with the latest version, the device might work even without the 
> > extra model option (as the auto-parser got improved).  I'd like to
> > avoid unneeded quirk lines as much as possible, so that's why I asked
> > to check the latest one.
> > 
> > > I'll try with enable_msi modparm as well without trying the hp_detect hint and let you know 
> > > about it. Will also try the latest kernel.
> > 
> > Thanks!
> > 
> > 
> > Takashi
> > 
> 
> Sorry for the late reply - was busy with office work.
> Just built the kernel from your git (sound-2.6.git) master 
> (as of commit 07e23a669544942a9154b64c583bdef014f66a15).
> 
> This new driver didn't require 'model=hp-dv5' modparm - it did detect and 
> use my card properly; so, my patch is not needed anymore, I guess :)
> 
> However, the hp_detect=1 problem still persists :(.
> I had to use the "echo 'hp_detect=1' > /sys/class/sound/hwC0D0/hints" 
> method to get the auto-muting to work. 
> It's also true with enable_msi=1 modparm.
> 
> Anything more you want me to try?
> 
> Thanks,
> Kunal
> 

Also, "spec->gpio_led = 0x08" in patch_sigmatel.c seems to enable the 
colour changing (orange/white) of the mute/unmute button.
I got this info from ubuntu's lucid kernel which somehow 
enabled the behaviour.
But, it was missing from the sound-2.6.git master kernel that I built. 
I'll do more digging to see why it isn't working in the git kernel.

This is the code that I copied from lucid kernel into linux-backports-modules 
that enabled the led behaviour:

	if ((codec->subsystem_id >> 16) == PCI_VENDOR_ID_HP) {
		const struct dmi_device *dev = NULL;
		while ((dev = dmi_find_device(DMI_DEV_TYPE_OEM_STRING,
					      NULL, dev))) {
			if (strcmp(dev->name, "HP_Mute_LED_1")) {
				switch (codec->vendor_id) {
				case 0x111d7608:
					spec->gpio_led = 0x01;
					break;
				case 0x111d7600:
				case 0x111d7601:
				case 0x111d7602:
				case 0x111d7603: /* <-- My codec STAC 92HD75B3X5 */
					spec->gpio_led = 0x08;
					break;
				}
				break;
			}
		}
	}

Thanks, 
Kunal
