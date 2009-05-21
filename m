From: Andreas Mohr <andi@lisas.de>
Subject: bootup message "Control name ... truncated to ..." -
	what to fix?
Date: Thu, 21 May 2009 20:25:53 +0200
Message-ID: <20090521182553.GA31805@rhlx01.hs-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rhlx01.hs-esslingen.de (rhlx01.hs-esslingen.de [129.143.116.10])
	by alsa0.perex.cz (Postfix) with ESMTP id A47F4244D2
	for <alsa-devel@alsa-project.org>;
	Thu, 21 May 2009 20:25:55 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi all,

On my i8k, I'm getting this on bootup (2.6.30-rc5):

ALSA sound/core/control.c:232: Control name 'Sigmatel Surround Phase Inversion Playback Switch' truncated
 to 'Sigmatel Surround Phase Inversion Playback '

I would quickly have submitted a patch for this (and similar items), problem is:
- what to fix: control name or struct definition?
- "Sigmatel Surround" might be a relatively important prefix,
  thus removing "Sigmatel " from relevant names possibly not a good idea


andi@note:/usr/src/linux-2.6.30-rc5/sound$ find . -name "*.c" -o -name "*.h"|xargs grep "Sigmatel Surround"
./pci/ac97/ac97_patch.c:AC97_SINGLE("Sigmatel Surround Phase Inversion Playback Switch", AC97_SIGMATEL_DAC2INVERT, 3, 1, 0);
./pci/ac97/ac97_patch.c:        snd_ac97_rename_vol_ctl(ac97, "Headphone Playback", "Sigmatel Surround Playback");
./pci/ca0106/ca0106_mixer.c:            "Sigmatel Surround Phase Inversion Playback ",
./pci/emu10k1/emu10k1x.c: * the PCM Playback Volume, Sigmatel Surround Playback Volume and




sound/core/control.c/snd_ctl_new1():
        if (ncontrol->name) {
                strlcpy(kctl.id.name, ncontrol->name, sizeof(kctl.id.name));
                if (strcmp(ncontrol->name, kctl.id.name) != 0)
                        snd_printk(KERN_WARNING
                                   "Control name '%s' truncated to '%s'\n",
                                   ncontrol->name, kctl.id.name);
        }


include/sound/asound.h:
struct snd_ctl_elem_id {
        unsigned int numid;             /* numeric identifier, zero = invalid */
        snd_ctl_elem_iface_t iface;     /* interface identifier */
        unsigned int device;            /* device/client number */
        unsigned int subdevice;         /* subdevice (substream) number */
        unsigned char name[44];         /* ASCII name of item */
        unsigned int index;             /* index of item */
};


I suppose (well, DAMN sure) that name is only 44 bytes due to
exactly 64-byte cacheline-compatible struct alignment status.


Note that status quo is pretty bad, since in another file already:
./pci/ca0106/ca0106_mixer.c:            "Sigmatel Surround Phase Inversion Playback ",
.

IOW we already violate official mixer control name specs
(by omitting "Switch" - see ControlNames.txt) simply in order to obey
the 44-byte limit.

Given that snd_ctl_elem_id 64 byte is a rather hard and arguably important limit,
I'd suggest changing the names, but how?

Unfortunately
Sigmatel Surround PhaseInvert Playback Switch
doesn't fit the bill either, since it's one char too long.
Thus it will probably be
Surround Phase Inversion Playback Switch
(and thus changing "Sigmatel Surround" at all affected controls)

Thanks,

Andreas Mohr
