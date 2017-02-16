From: Julia Lawall <julia.lawall@lip6.fr>
Subject: [asoc:topic/intel 83/98]
 sound/soc/codecs/hdac_hdmi.c:1884:2-21: iterator with update on line 1885
 (fwd)
Date: Thu, 16 Feb 2017 22:04:24 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1702162202330.2121@hadrien>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by alsa0.perex.cz (Postfix) with ESMTP id 65259266D57
 for <alsa-devel@alsa-project.org>; Thu, 16 Feb 2017 22:04:25 +0100 (CET)
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

I don't think that what is done in lines 1884 and 1885 is the right
approach.  port is just a local variable that points to the different list
elements and allows list_for_each_entry to get from one element to the
other.  Setting port to NULL doesn't change the list, and it makes it
impossible for list_for_each_entry to find the next element.

julia

---------- Forwarded message ----------
Date: Fri, 17 Feb 2017 05:00:49 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: kbuild@01.org
Cc: Julia Lawall <julia.lawall@lip6.fr>
Subject: [asoc:topic/intel 83/98] sound/soc/codecs/hdac_hdmi.c:1884:2-21:
    iterator with update on line 1885


tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git topic/intel
head:   e3efb2ad834b50cb9c8625155e3e2674f5bc443b
commit: e0e5d3e5a53b3bc354c18030b78b7ebcb33e004b [83/98] ASoC: hdac_hdmi: Add support for multiple ports to a PCM
:::::: branch date: 2 hours ago
:::::: commit date: 2 hours ago

>> sound/soc/codecs/hdac_hdmi.c:1884:2-21: iterator with update on line 1885

git remote add asoc https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git
git remote update asoc
git checkout e0e5d3e5a53b3bc354c18030b78b7ebcb33e004b
vim +1884 sound/soc/codecs/hdac_hdmi.c

18382ead Subhransu S. Prusty 2015-11-10  1878
4a3478de Jeeja KP            2016-02-12  1879  	list_for_each_entry_safe(pcm, pcm_next, &hdmi->pcm_list, head) {
4a3478de Jeeja KP            2016-02-12  1880  		pcm->cvt = NULL;
e0e5d3e5 Jeeja KP            2017-02-07  1881  		if (list_empty(&pcm->port_list))
e0e5d3e5 Jeeja KP            2017-02-07  1882  			continue;
e0e5d3e5 Jeeja KP            2017-02-07  1883
e0e5d3e5 Jeeja KP            2017-02-07 @1884  		list_for_each_entry(port, &pcm->port_list, head)
e0e5d3e5 Jeeja KP            2017-02-07 @1885  			port = NULL;
e0e5d3e5 Jeeja KP            2017-02-07  1886
4a3478de Jeeja KP            2016-02-12  1887  		list_del(&pcm->head);
4a3478de Jeeja KP            2016-02-12  1888  		kfree(pcm);

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
