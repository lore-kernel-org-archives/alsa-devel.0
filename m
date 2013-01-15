From: Fengguang Wu <fengguang.wu@intel.com>
Subject: sound/pci/hda/patch_sigmatel.c:2260:26: sparse:
 obsolete array initializer, use C99 syntax
Date: Tue, 15 Jan 2013 17:57:00 +0800
Message-ID: <20130115095700.GA21850@localhost>
References: <50f51e93.S/mFy4LpeGQ6WQfE%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 986832615E1
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2013 10:57:15 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <50f51e93.S/mFy4LpeGQ6WQfE%fengguang.wu@intel.com>
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

FYI, there are new sparse warnings show up in

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-unstable.git master
head:   629965377895ebe6a546184911d588fd29596dc8
commit: 8018ee4e722f6c408d475262b54dc8a73fdd349f ALSA: hda - Use standard fixup table for IDT92HD71Bxx
date:   2 hours ago

>> sound/pci/hda/patch_sigmatel.c:2260:26: sparse: obsolete array initializer, use C99 syntax
   sound/pci/hda/patch_sigmatel.c:2266:26: sparse: obsolete array initializer, use C99 syntax

vim +2260 sound/pci/hda/patch_sigmatel.c

8018ee4e Takashi Iwai 2013-01-14  2249  static const struct hda_fixup stac92hd71bxx_fixups[] = {
8018ee4e Takashi Iwai 2013-01-14  2250  	[STAC_92HD71BXX_REF] = {
8018ee4e Takashi Iwai 2013-01-14  2251  		.type = HDA_FIXUP_FUNC,
8018ee4e Takashi Iwai 2013-01-14  2252  		.v.func = stac92hd71bxx_fixup_ref,
8018ee4e Takashi Iwai 2013-01-14  2253  	},
8018ee4e Takashi Iwai 2013-01-14  2254  	[STAC_DELL_M4_1] = {
8018ee4e Takashi Iwai 2013-01-14  2255  		.type = HDA_FIXUP_PINS,
8018ee4e Takashi Iwai 2013-01-14  2256  		.v.pins = dell_m4_1_pin_configs,
8018ee4e Takashi Iwai 2013-01-14  2257  		.chained = true,
8018ee4e Takashi Iwai 2013-01-14  2258  		.chain_id = STAC_92HD71BXX_NO_SMUX,
8018ee4e Takashi Iwai 2013-01-14  2259  	},
8018ee4e Takashi Iwai 2013-01-14 @2260  	[STAC_DELL_M4_2] {
8018ee4e Takashi Iwai 2013-01-14  2261  		.type = HDA_FIXUP_PINS,
8018ee4e Takashi Iwai 2013-01-14  2262  		.v.pins = dell_m4_2_pin_configs,
8018ee4e Takashi Iwai 2013-01-14  2263  		.chained = true,
8018ee4e Takashi Iwai 2013-01-14  2264  		.chain_id = STAC_92HD71BXX_NO_DMIC,
8018ee4e Takashi Iwai 2013-01-14  2265  	},
8018ee4e Takashi Iwai 2013-01-14  2266  	[STAC_DELL_M4_3] {
8018ee4e Takashi Iwai 2013-01-14  2267  		.type = HDA_FIXUP_PINS,
8018ee4e Takashi Iwai 2013-01-14  2268  		.v.pins = dell_m4_3_pin_configs,

---
0-DAY kernel build testing backend              Open Source Technology Center
http://lists.01.org/mailman/listinfo/kbuild                 Intel Corporation
