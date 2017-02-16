From: Julia Lawall <julia.lawall@lip6.fr>
Subject: [asoc:topic/intel 79/98]
 sound/soc/codecs/hdac_hdmi.c:1419:5-8: ERROR: invalid reference to the
 index variable of the iterator on line 1397
Date: Thu, 16 Feb 2017 21:35:39 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1702162134050.2121@hadrien>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by alsa0.perex.cz (Postfix) with ESMTP id 5B9D5266D57
 for <alsa-devel@alsa-project.org>; Thu, 16 Feb 2017 21:35:40 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jeeja KP <jeeja.kp@intel.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org

Lists don't end with NULL,  They end with a dummy element.  So pin in line
1419 is always true.  You probably need some other way of detecting how
the loop was exited.

julia

---------- Forwarded message ----------
Date: Fri, 17 Feb 2017 04:31:06 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: kbuild@01.org
Cc: Julia Lawall <julia.lawall@lip6.fr>
Subject: [asoc:topic/intel 79/98] sound/soc/codecs/hdac_hdmi.c:1419:5-8: ERROR:
    invalid reference to the index variable of the iterator on line 1397


tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git topic/intel
head:   e3efb2ad834b50cb9c8625155e3e2674f5bc443b
commit: 2acd8309a3a4e6dc04e72d2db0716825095c02d6 [79/98] ASoC: hdac_hdmi: Add support to handle MST capable pin
:::::: branch date: 2 hours ago
:::::: commit date: 8 days ago

>> sound/soc/codecs/hdac_hdmi.c:1419:5-8: ERROR: invalid reference to the index variable of the iterator on line 1397

git remote add asoc https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git
git remote update asoc
git checkout 2acd8309a3a4e6dc04e72d2db0716825095c02d6
vim +1419 sound/soc/codecs/hdac_hdmi.c

b8a54545 Subhransu S. Prusty 2016-02-12  1391  			SNDRV_CTL_POWER_D0)
b8a54545 Subhransu S. Prusty 2016-02-12  1392  		return;
b8a54545 Subhransu S. Prusty 2016-02-12  1393
b8a54545 Subhransu S. Prusty 2016-02-12  1394  	if (atomic_read(&edev->hdac.in_pm))
b8a54545 Subhransu S. Prusty 2016-02-12  1395  		return;
b8a54545 Subhransu S. Prusty 2016-02-12  1396
b8a54545 Subhransu S. Prusty 2016-02-12 @1397  	list_for_each_entry(pin, &hdmi->pin_list, head) {
754695f9 Jeeja KP            2017-02-06  1398  		if (pin->nid != pin_nid)
754695f9 Jeeja KP            2017-02-06  1399  			continue;
754695f9 Jeeja KP            2017-02-06  1400
754695f9 Jeeja KP            2017-02-06  1401  		/* In case of non MST pin, pipe is -1 */
754695f9 Jeeja KP            2017-02-06  1402  		if (pipe == -1) {
2acd8309 Jeeja KP            2017-02-06  1403  			pin->mst_capable = false;
754695f9 Jeeja KP            2017-02-06  1404  			/* if not MST, default is port[0] */
754695f9 Jeeja KP            2017-02-06  1405  			hport = &pin->ports[0];
2acd8309 Jeeja KP            2017-02-06  1406  			goto out;
2acd8309 Jeeja KP            2017-02-06  1407  		} else {
2acd8309 Jeeja KP            2017-02-06  1408  			for (i = 0; i < pin->num_ports; i++) {
2acd8309 Jeeja KP            2017-02-06  1409  				pin->mst_capable = true;
2acd8309 Jeeja KP            2017-02-06  1410  				if (pin->ports[i].id == pipe) {
2acd8309 Jeeja KP            2017-02-06  1411  					hport = &pin->ports[i];
2acd8309 Jeeja KP            2017-02-06  1412  					goto out;
2acd8309 Jeeja KP            2017-02-06  1413  				}
2acd8309 Jeeja KP            2017-02-06  1414  			}
754695f9 Jeeja KP            2017-02-06  1415  		}
b8a54545 Subhransu S. Prusty 2016-02-12  1416  	}
754695f9 Jeeja KP            2017-02-06  1417
2acd8309 Jeeja KP            2017-02-06  1418  out:
2acd8309 Jeeja KP            2017-02-06 @1419  	if (pin && hport)
754695f9 Jeeja KP            2017-02-06  1420  		hdac_hdmi_present_sense(pin, hport);
b8a54545 Subhransu S. Prusty 2016-02-12  1421  }
b8a54545 Subhransu S. Prusty 2016-02-12  1422

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
