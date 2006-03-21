From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Adding controls
Date: Tue, 21 Mar 2006 23:39:20 +0000
Message-ID: <1142984360.9284.33.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from sc-outsmtp2.homechoice.co.uk (sc-outsmtp2.homechoice.co.uk [81.1.65.36])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id DE8611DE
	for <alsa-devel@alsa-project.org>; Wed, 22 Mar 2006 00:39:26 +0100 (MET)
Received: from bossclass ([192.168.62.105])
	by localhost.localdomain (8.13.4/8.13.4/Debian-3) with ESMTP id k2LNdMCc014527
	for <alsa-devel@alsa-project.org>; Tue, 21 Mar 2006 23:39:23 GMT
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

When I try to compile my driver I get loads of messages like this...

/home/adrian/aica/aica/snd_card_aica.c:489: warning: "struct
snd_ctl_elem_info" declared inside parameter list
/home/adrian/aica/aica/snd_card_aica.c:489: warning: its scope is only
this definition or declaration, which is probably not what you want
/home/adrian/aica/aica/snd_card_aica.c:489: warning: "struct
snd_kcontrol" declared inside parameter list
/home/adrian/aica/aica/snd_card_aica.c:494: warning: "struct
snd_ctl_elem_value" declared inside parameter list
/home/adrian/aica/aica/snd_card_aica.c:494: warning: "struct
snd_kcontrol" declared inside parameter list
/home/adrian/aica/aica/snd_card_aica.c:499: warning: "struct
snd_ctl_elem_value" declared inside parameter list
/home/adrian/aica/aica/snd_card_aica.c:499: warning: "struct
snd_kcontrol" declared inside parameter list


The code in question is this:

/* Mixer controls */
static int aica_controls_info(struct snd_kcontrol *kcontrol, struct
snd_ctl_elem_info *uinfo)
{
	return 0;
}

static int aica_controls_get(struct snd_kcontrol *kcontrol, struct
snd_ctl_elem_value *ucontrol)
{
	return 0;
}

static int aica_controls_put(struct snd_kcontrol *kcontrol, struct
snd_ctl_elem_value *ucontrol)
{
	return 0;
}

static struct snd_kcontrol_new snd_aica_controls __devinitdata = {
	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
	.name = "PCM Playback Volume",
	.index = 0,
	.access = SND_CTL_ELEM_ACCESS_READWRITE,
	.private_values = 0xffff,
	.info = aica_controls_info,
	.get = aica_controls_get,
	.put = aica_controls_put
};


And the includes are these:

#include <linux/init.h>
#include <linux/jiffies.h>
#include <linux/slab.h>
#include <linux/time.h>
#include <linux/wait.h>
#include <linux/moduleparam.h>
#include <linux/platform_device.h>
#include <linux/firmware.h>
#include <linux/timer.h>
#include <linux/delay.h>
#include <asm-sh/io.h>
#include <asm-sh/dma.h>
#include <asm-sh/dreamcast/sysasic.h>
#include <sound/driver.h>
#include <sound/core.h>
#include <sound/control.h>
#include <sound/pcm.h>
#include <sound/initval.h>
#include <sound/info.h>
#include "aica.h"



Plainly I have missed something obvious - like a missing header file.
but for the life of me I cannot spot what it is. Can anyone else?



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
