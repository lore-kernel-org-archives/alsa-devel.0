From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [asoc:topic/arizona 16/21]
 drivers/input/misc/arizona-haptics.c:164 arizona_haptics_close() warn:
 variable dereferenced before check 'haptics->arizona->dapm' (see line 158)
Date: Thu, 29 Nov 2012 10:31:19 +0300
Message-ID: <20121129073119.GY6186@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 by alsa0.perex.cz (Postfix) with ESMTP id 37337265076
 for <alsa-devel@alsa-project.org>; Thu, 29 Nov 2012 08:31:34 +0100 (CET)
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
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Fengguang Wu <fengguang.wu@intel.com>, alsa-devel@alsa-project.org, kbuild@01.org
List-Id: alsa-devel@alsa-project.org

Hi Mark,

FYI, there are new smatch warnings show up in

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git topic/arizona
head:   cac27cff066cf86c6fefe33d99d935e9d0d9c78c
commit: 9dd555e2f4de1af1bb0f75cc84ed0708fcdb5987 [16/21] Input - arizona-haptics: Add driver haptics module on Arizona CODECs

+ drivers/input/misc/arizona-haptics.c:164 arizona_haptics_close() warn: variable dereferenced before check 'haptics->arizona->dapm' (see line 158)

git remote update asoc
git checkout 9dd555e2f4de1af1bb0f75cc84ed0708fcdb5987
vim +164 drivers/input/misc/arizona-haptics.c

9dd555e2 Mark Brown 2012-11-26  152  	return 0;
9dd555e2 Mark Brown 2012-11-26  153  }
9dd555e2 Mark Brown 2012-11-26  154  
9dd555e2 Mark Brown 2012-11-26  155  static void arizona_haptics_close(struct input_dev *input)
9dd555e2 Mark Brown 2012-11-26  156  {
9dd555e2 Mark Brown 2012-11-26  157  	struct arizona_haptics *haptics = input_get_drvdata(input);
9dd555e2 Mark Brown 2012-11-26 @158  	struct mutex *dapm_mutex = &haptics->arizona->dapm->card->dapm_mutex;
9dd555e2 Mark Brown 2012-11-26  159  
9dd555e2 Mark Brown 2012-11-26  160  	cancel_work_sync(&haptics->work);
9dd555e2 Mark Brown 2012-11-26  161  
9dd555e2 Mark Brown 2012-11-26  162  	mutex_lock_nested(dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
9dd555e2 Mark Brown 2012-11-26  163  
9dd555e2 Mark Brown 2012-11-26 @164  	if (haptics->arizona->dapm)
9dd555e2 Mark Brown 2012-11-26  165  		snd_soc_dapm_disable_pin(haptics->arizona->dapm, "HAPTICS");
9dd555e2 Mark Brown 2012-11-26  166  
9dd555e2 Mark Brown 2012-11-26  167  	mutex_unlock(dapm_mutex);

---
0-DAY kernel build testing backend         Open Source Technology Center
Fengguang Wu, Yuanhan Liu                              Intel Corporation
