From: Andre Guedes <andre.guedes@intel.com>
Subject: [PATCH - Multiple plugins 0/4] Fix leaks on multiple
	plugins
Date: Fri, 28 Sep 2018 14:27:23 -0700
Message-ID: <20180928212727.15151-1-andre.guedes@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 47004267737
 for <alsa-devel@alsa-project.org>; Fri, 28 Sep 2018 23:27:54 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi all,

While I was working on AAF plugin RFC v2 series [1], I spotted several leaks in
some plugins when handling *_hw_constraint() error cases. This series fixes
these issues.

Regards,

Andre

[1] http://mailman.alsa-project.org/pipermail/alsa-devel/2018-September/140290.html

Andre Guedes (4):
  a52: Fix leaks when a52_set_hw_constraint() fails
  jack: Fix leaks when jack_set_hw_constraint() fails
  oss: Fix leaks when oss_hw_constraint() fails
  usb_stream: Fix leaks when us_set_hw_constraint() fails

 a52/pcm_a52.c               | 2 +-
 jack/pcm_jack.c             | 1 +
 oss/pcm_oss.c               | 2 +-
 usb_stream/pcm_usb_stream.c | 1 +
 4 files changed, 4 insertions(+), 2 deletions(-)

-- 
2.14.4
