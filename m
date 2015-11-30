From: kbuild test robot <fengguang.wu@intel.com>
Subject: [asoc:topic/da7218 2/2]
 sound/soc/codecs/da7218.c:3214:9-10: WARNING: return of 0/1 in function
 'da7218_volatile_register' with return type bool
Date: Tue, 1 Dec 2015 02:40:51 +0800
Message-ID: <201512010249.CKNe08uI%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 438C7261721
 for <alsa-devel@alsa-project.org>; Mon, 30 Nov 2015 19:41:39 +0100 (CET)
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
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git topic/da7218
head:   4d50934abd2261fd467320d52c470efff309fd74
commit: 4d50934abd2261fd467320d52c470efff309fd74 [2/2] ASoC: da7218: Add da7218 codec driver


coccinelle warnings: (new ones prefixed by >>)

>> sound/soc/codecs/da7218.c:3214:9-10: WARNING: return of 0/1 in function 'da7218_volatile_register' with return type bool

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
