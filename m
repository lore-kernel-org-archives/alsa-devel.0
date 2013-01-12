From: Fengguang Wu <fengguang.wu@intel.com>
Subject: sound/pci/hda/hda_codec.c:3433
 snd_hda_codec_write_cache() error: we previously assumed 'c' could be null
 (see line 3430)
Date: Sat, 12 Jan 2013 10:14:22 +0800
Message-ID: <20130112021422.GB6150@localhost>
References: <50f05d4a.7Hp1BArd1hLUlQ5B%yuanhan.liu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 5507926507F
 for <alsa-devel@alsa-project.org>; Sat, 12 Jan 2013 03:14:28 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <50f05d4a.7Hp1BArd1hLUlQ5B%yuanhan.liu@linux.intel.com>
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
commit: 95836563e7f636fc57732f5e687ca2f170eb674f ALSA: hda - Introduce cache & flush cmd / amp writes
date:   33 hours ago

sound/pci/hda/hda_codec.c:3433 snd_hda_codec_write_cache() error: we previously assumed 'c' could be null (see line 3430)

vim +/c +3433 sound/pci/hda/hda_codec.c

aa2936f5 Takashi Iwai 2009-05-26  3424  	/* parm may contain the verb stuff for get/set amp */
aa2936f5 Takashi Iwai 2009-05-26  3425  	verb = verb | (parm >> 8);
aa2936f5 Takashi Iwai 2009-05-26  3426  	parm &= 0xff;
aa2936f5 Takashi Iwai 2009-05-26  3427  	key = build_cmd_cache_key(nid, verb);
aa2936f5 Takashi Iwai 2009-05-26  3428  	mutex_lock(&codec->bus->cmd_mutex);
aa2936f5 Takashi Iwai 2009-05-26  3429  	c = get_alloc_hash(&codec->cmd_cache, key);
aa2936f5 Takashi Iwai 2009-05-26 @3430  	if (c)
aa2936f5 Takashi Iwai 2009-05-26  3431  		c->val = parm;
95836563 Takashi Iwai 2012-12-13  3432  	if (codec->cached_write)
95836563 Takashi Iwai 2012-12-13 @3433  		c->dirty = 1;
aa2936f5 Takashi Iwai 2009-05-26  3434  	mutex_unlock(&codec->bus->cmd_mutex);
aa2936f5 Takashi Iwai 2009-05-26  3435  	return 0;
b3ac5636 Takashi Iwai 2007-08-10  3436  }

---
0-DAY kernel build testing backend         Open Source Technology Center
Fengguang Wu, Yuanhan Liu                              Intel Corporation
