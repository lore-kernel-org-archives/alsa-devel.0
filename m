From: Fengguang Wu <fengguang.wu@intel.com>
Subject: sound/pci/hda/patch_sigmatel.c:2219:24: warning:
 unused variable 'spec'
Date: Tue, 15 Jan 2013 17:57:41 +0800
Message-ID: <20130115095741.GB21850@localhost>
References: <50f520b9.cfhzbR31VpCmN1oz%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 8B36C2616EF
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2013 10:57:46 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <50f520b9.cfhzbR31VpCmN1oz%fengguang.wu@intel.com>
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

FYI, there are new compile warnings show up in

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-unstable.git master
head:   629965377895ebe6a546184911d588fd29596dc8
commit: 8018ee4e722f6c408d475262b54dc8a73fdd349f ALSA: hda - Use standard fixup table for IDT92HD71Bxx
date:   2 hours ago
config: make ARCH=i386 defconfig

All warnings:

   sound/pci/hda/patch_sigmatel.c: In function 'stac92hd71bxx_fixup_hp':
>> sound/pci/hda/patch_sigmatel.c:2219:24: warning: unused variable 'spec' [-Wunused-variable]

vim +/spec +2219 sound/pci/hda/patch_sigmatel.c

8018ee4e Takashi Iwai 2013-01-14  2216  static void stac92hd71bxx_fixup_hp(struct hda_codec *codec,
8018ee4e Takashi Iwai 2013-01-14  2217  				   const struct hda_fixup *fix, int action)
8018ee4e Takashi Iwai 2013-01-14  2218  {
8018ee4e Takashi Iwai 2013-01-14 @2219  	struct sigmatel_spec *spec = codec->spec;
8018ee4e Takashi Iwai 2013-01-14  2220  
8018ee4e Takashi Iwai 2013-01-14  2221  	if (action != HDA_FIXUP_ACT_PRE_PROBE)
8018ee4e Takashi Iwai 2013-01-14  2222  		return;
8018ee4e Takashi Iwai 2013-01-14  2223  
8018ee4e Takashi Iwai 2013-01-14  2224  	if (hp_blike_system(codec->subsystem_id)) {
8018ee4e Takashi Iwai 2013-01-14  2225  		unsigned int pin_cfg = snd_hda_codec_get_pincfg(codec, 0x0f);
8018ee4e Takashi Iwai 2013-01-14  2226  		if (get_defcfg_device(pin_cfg) == AC_JACK_LINE_OUT ||
8018ee4e Takashi Iwai 2013-01-14  2227  			get_defcfg_device(pin_cfg) == AC_JACK_SPEAKER  ||

---
0-DAY kernel build testing backend              Open Source Technology Center
http://lists.01.org/mailman/listinfo/kbuild                 Intel Corporation
