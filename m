From: Andre Guedes <andre.guedes@intel.com>
Subject: [PATCH v2 - AAF PCM plugin 0/7] Introduce AVTP Audio
	Format (AAF) plugin
Date: Wed, 24 Oct 2018 18:11:09 -0700
Message-ID: <20181025011116.12360-1-andre.guedes@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 2A2D926795C
 for <alsa-devel@alsa-project.org>; Thu, 25 Oct 2018 03:11:49 +0200 (CEST)
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
Cc: tiwai@suse.de, pierre-louis.bossart@linux.intel.com, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

Hi all,

This new version addresses the feedback from v1 and fixes a bug on capture
mode. Code-wise, the changes are very trivial, no major diffs. Below follows
the highlights:

  * Standard headers like linux/if_ether.h are now checked by configure script.
  * The 'static' modifier was added to array variables in aaf_hw_constraint().
  * aaf_close() callback was simplified.
  * aaf_rx_pdu() was modified so it doesn't return an error in case the number
    of bytes read by recv() is different from aaf->pdu_size. This is an
    expected situation and it means the received AVTPDU doesn't belong to the
    AAF stream the plugin is interested in so it should simply drop that
    AVTPDU. This fixes a bug when running multiple streams (with different
    AVPTU sizes) concurrently.

Additionally, this new version improves the instructions in doc/aaf.txt in
order to make it easier to test the plugin. Anyone should be able to test it
just by copying and pasting the instructions.

To recap what has been discussed about the plugin so far, check the comments in
RFC and PATCH series archive [1-3]. All versions of this series can be also
found in my alsa-plugins tree in github [4].

Regards,

Andre

[1] http://mailman.alsa-project.org/pipermail/alsa-devel/2018-August/139494.html
[2] http://mailman.alsa-project.org/pipermail/alsa-devel/2018-September/140290.html
[3] http://mailman.alsa-project.org/pipermail/alsa-devel/2018-October/140667.html
[4] https://github.com/aguedes/alsa-plugins

Andre Guedes (7):
  aaf: Introduce plugin skeleton
  aaf: Load configuration parameters
  aaf: Implement Playback mode support
  aaf: Prepare for Capture mode support
  aaf: Implement Capture mode support
  aaf: Implement dump() ioplug callback
  aaf: Add support for direct read/write transfers

 Makefile.am     |    3 +
 aaf/Makefile.am |    9 +
 aaf/pcm_aaf.c   | 1200 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 configure.ac    |   11 +
 doc/aaf.txt     |  157 ++++++++
 5 files changed, 1380 insertions(+)
 create mode 100644 aaf/Makefile.am
 create mode 100644 aaf/pcm_aaf.c
 create mode 100644 doc/aaf.txt

-- 
2.14.4
