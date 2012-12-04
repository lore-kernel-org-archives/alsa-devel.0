From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: sound/usb/midi.c:1088 substream_open() warn:
 inconsistent returns mutex:&umidi->mutex: locked (1058) unlocked (1048,
 1088)
Date: Tue, 4 Dec 2012 13:57:18 +0300
Message-ID: <20121204105718.GC22569@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 by alsa0.perex.cz (Postfix) with ESMTP id 404D02625FF
 for <alsa-devel@alsa-project.org>; Tue,  4 Dec 2012 11:57:32 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: kbuild@01.org, Fengguang Wu <fengguang.wu@intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

FYI, there are new smatch warnings show up in

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-unstable.git master
head:   d34bb8cb0b61e91a036aa516dc6f9ced5af2adc4
commit: 6e28507b716f16618070517dbfcaafe2ca7e9cbe ALSA: usb-audio: Fix missing autopm for MIDI input
date:   6 hours ago

+ sound/usb/midi.c:1088 substream_open() warn: inconsistent returns mutex:&umidi->mutex: locked (1058) unlocked (1048,1088)
  sound/usb/midi.c:2166 snd_usbmidi_create() error: we previously assumed 'quirk' could be null (see line 2155)

git remote update sound-unstable
git checkout 6e28507b716f16618070517dbfcaafe2ca7e9cbe
vim +1088 sound/usb/midi.c

96f61d9a sound/usb/usbmidi.c Clemens Ladisch 2009-10-22  1042  	struct snd_kcontrol *ctl;
6e28507b sound/usb/midi.c    Takashi Iwai    2012-12-03  1043  	int err;
96f61d9a sound/usb/usbmidi.c Clemens Ladisch 2009-10-22  1044  
cea1c011 sound/usb/midi.c    Takashi Iwai    2012-12-03  1045  	down_read(&umidi->disc_rwsem);
cea1c011 sound/usb/midi.c    Takashi Iwai    2012-12-03  1046  	if (umidi->disconnected) {
cea1c011 sound/usb/midi.c    Takashi Iwai    2012-12-03  1047  		up_read(&umidi->disc_rwsem);
6e28507b sound/usb/midi.c    Takashi Iwai    2012-12-03 @1048  		return open ? -ENODEV : 0;
cea1c011 sound/usb/midi.c    Takashi Iwai    2012-12-03  1049  	}
cea1c011 sound/usb/midi.c    Takashi Iwai    2012-12-03  1050  
96f61d9a sound/usb/usbmidi.c Clemens Ladisch 2009-10-22  1051  	mutex_lock(&umidi->mutex);
96f61d9a sound/usb/usbmidi.c Clemens Ladisch 2009-10-22  1052  	if (open) {
6e28507b sound/usb/midi.c    Takashi Iwai    2012-12-03  1053  		if (!umidi->opened[0] && !umidi->opened[1]) {
6e28507b sound/usb/midi.c    Takashi Iwai    2012-12-03  1054  			err = usb_autopm_get_interface(umidi->iface);
6e28507b sound/usb/midi.c    Takashi Iwai    2012-12-03  1055  			umidi->autopm_reference = err >= 0;
6e28507b sound/usb/midi.c    Takashi Iwai    2012-12-03  1056  			if (err < 0 && err != -EACCES) {
6e28507b sound/usb/midi.c    Takashi Iwai    2012-12-03  1057  				up_read(&umidi->disc_rwsem);
6e28507b sound/usb/midi.c    Takashi Iwai    2012-12-03 @1058  				return -EIO;
6e28507b sound/usb/midi.c    Takashi Iwai    2012-12-03  1059  			}
6e28507b sound/usb/midi.c    Takashi Iwai    2012-12-03  1060  			if (umidi->roland_load_ctl) {
6e28507b sound/usb/midi.c    Takashi Iwai    2012-12-03  1061  				ctl = umidi->roland_load_ctl;
6e28507b sound/usb/midi.c    Takashi Iwai    2012-12-03  1062  				ctl->vd[0].access |= SNDRV_CTL_ELEM_ACCESS_INACTIVE;
6e28507b sound/usb/midi.c    Takashi Iwai    2012-12-03  1063  				snd_ctl_notify(umidi->card,
96f61d9a sound/usb/usbmidi.c Clemens Ladisch 2009-10-22  1064  				       SNDRV_CTL_EVENT_MASK_INFO, &ctl->id);
6e28507b sound/usb/midi.c    Takashi Iwai    2012-12-03  1065  				update_roland_altsetting(umidi);
6e28507b sound/usb/midi.c    Takashi Iwai    2012-12-03  1066  			}
96f61d9a sound/usb/usbmidi.c Clemens Ladisch 2009-10-22  1067  		}
6e28507b sound/usb/midi.c    Takashi Iwai    2012-12-03  1068  		umidi->opened[dir]++;
6e28507b sound/usb/midi.c    Takashi Iwai    2012-12-03  1069  		if (umidi->opened[1])
6e28507b sound/usb/midi.c    Takashi Iwai    2012-12-03  1070  			snd_usbmidi_input_start(&umidi->list);
96f61d9a sound/usb/usbmidi.c Clemens Ladisch 2009-10-22  1071  	} else {
6e28507b sound/usb/midi.c    Takashi Iwai    2012-12-03  1072  		umidi->opened[dir]--;
6e28507b sound/usb/midi.c    Takashi Iwai    2012-12-03  1073  		if (!umidi->opened[1])
6e28507b sound/usb/midi.c    Takashi Iwai    2012-12-03  1074  			snd_usbmidi_input_stop(&umidi->list);
6e28507b sound/usb/midi.c    Takashi Iwai    2012-12-03  1075  		if (!umidi->opened[0] && !umidi->opened[1]) {
6e28507b sound/usb/midi.c    Takashi Iwai    2012-12-03  1076  			if (umidi->roland_load_ctl) {
6e28507b sound/usb/midi.c    Takashi Iwai    2012-12-03  1077  				ctl = umidi->roland_load_ctl;
6e28507b sound/usb/midi.c    Takashi Iwai    2012-12-03  1078  				ctl->vd[0].access &= ~SNDRV_CTL_ELEM_ACCESS_INACTIVE;
6e28507b sound/usb/midi.c    Takashi Iwai    2012-12-03  1079  				snd_ctl_notify(umidi->card,
96f61d9a sound/usb/usbmidi.c Clemens Ladisch 2009-10-22  1080  				       SNDRV_CTL_EVENT_MASK_INFO, &ctl->id);
6e28507b sound/usb/midi.c    Takashi Iwai    2012-12-03  1081  			}
6e28507b sound/usb/midi.c    Takashi Iwai    2012-12-03  1082  			if (umidi->autopm_reference)
6e28507b sound/usb/midi.c    Takashi Iwai    2012-12-03  1083  				usb_autopm_put_interface(umidi->iface);
96f61d9a sound/usb/usbmidi.c Clemens Ladisch 2009-10-22  1084  		}
96f61d9a sound/usb/usbmidi.c Clemens Ladisch 2009-10-22  1085  	}
96f61d9a sound/usb/usbmidi.c Clemens Ladisch 2009-10-22  1086  	mutex_unlock(&umidi->mutex);
cea1c011 sound/usb/midi.c    Takashi Iwai    2012-12-03  1087  	up_read(&umidi->disc_rwsem);
6e28507b sound/usb/midi.c    Takashi Iwai    2012-12-03 @1088  	return 0;
96f61d9a sound/usb/usbmidi.c Clemens Ladisch 2009-10-22  1089  }
96f61d9a sound/usb/usbmidi.c Clemens Ladisch 2009-10-22  1090  
86e07d34 sound/usb/usbmidi.c Takashi Iwai    2005-11-17  1091  static int snd_usbmidi_output_open(struct snd_rawmidi_substream *substream)

---
0-DAY kernel build testing backend         Open Source Technology Center
Fengguang Wu, Yuanhan Liu                              Intel Corporation
