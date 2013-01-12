From: Fengguang Wu <fengguang.wu@intel.com>
Subject: sound/pci/hda/hda_generic.c:1529 indep_hp_put() warn:
 inconsistent returns mutex:&spec->pcm_mutex: locked (1526) unlocked (1517,
 1529)
Date: Sat, 12 Jan 2013 10:16:50 +0800
Message-ID: <20130112021650.GC6150@localhost>
References: <50f05fed.WTL9MFXChbKhBxPs%yuanhan.liu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 79A4E26507F
 for <alsa-devel@alsa-project.org>; Sat, 12 Jan 2013 03:16:55 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <50f05fed.WTL9MFXChbKhBxPs%yuanhan.liu@linux.intel.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Hi Takashi,

FYI, there are new smatch warnings show up in

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-unstable.git master
head:   02e5aa7b459f69538d4ec88658d064816a7692d6
commit: a5de6f4d021608c50ff5ff51d208b5030da92957 ALSA: hda - Implement independent HP control
date:   33 hours ago

sound/pci/hda/hda_generic.c:1529 indep_hp_put() warn: inconsistent returns mutex:&spec->pcm_mutex: locked (1526) unlocked (1517,1529)

vim +1529 sound/pci/hda/hda_generic.c

a5de6f4d Takashi Iwai 2012-12-21  1511  	struct hda_gen_spec *spec = codec->spec;
a5de6f4d Takashi Iwai 2012-12-21  1512  	unsigned int select = ucontrol->value.enumerated.item[0];
a5de6f4d Takashi Iwai 2012-12-21  1513  
a5de6f4d Takashi Iwai 2012-12-21  1514  	mutex_lock(&spec->pcm_mutex);
a5de6f4d Takashi Iwai 2012-12-21  1515  	if (spec->active_streams) {
a5de6f4d Takashi Iwai 2012-12-21  1516  		mutex_unlock(&spec->pcm_mutex);
a5de6f4d Takashi Iwai 2012-12-21 @1517  		return -EBUSY;
a5de6f4d Takashi Iwai 2012-12-21  1518  	}
a5de6f4d Takashi Iwai 2012-12-21  1519  
a5de6f4d Takashi Iwai 2012-12-21  1520  	if (spec->indep_hp_enabled != select) {
a5de6f4d Takashi Iwai 2012-12-21  1521  		spec->indep_hp_enabled = select;
a5de6f4d Takashi Iwai 2012-12-21  1522  		if (spec->indep_hp_enabled)
a5de6f4d Takashi Iwai 2012-12-21  1523  			spec->multiout.hp_out_nid[0] = 0;
a5de6f4d Takashi Iwai 2012-12-21  1524  		else
a5de6f4d Takashi Iwai 2012-12-21  1525  			spec->multiout.hp_out_nid[0] = spec->alt_dac_nid;
a5de6f4d Takashi Iwai 2012-12-21 @1526  		return 1;
a5de6f4d Takashi Iwai 2012-12-21  1527  	}
a5de6f4d Takashi Iwai 2012-12-21  1528  	mutex_unlock(&spec->pcm_mutex);
a5de6f4d Takashi Iwai 2012-12-21 @1529  	return 0;
a5de6f4d Takashi Iwai 2012-12-21  1530  }
a5de6f4d Takashi Iwai 2012-12-21  1531  
a5de6f4d Takashi Iwai 2012-12-21  1532  static const struct snd_kcontrol_new indep_hp_ctl = {

---
0-DAY kernel build testing backend         Open Source Technology Center
Fengguang Wu, Yuanhan Liu                              Intel Corporation
