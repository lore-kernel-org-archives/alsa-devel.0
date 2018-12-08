From: Andre Guedes <andre.guedes@intel.com>
Subject: [PATCH - AAF PCM plugin 0/7] Follow-up improvements
Date: Fri,  7 Dec 2018 17:55:43 -0800
Message-ID: <20181208015550.20268-1-andre.guedes@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 50CC2267D20
 for <alsa-devel@alsa-project.org>; Sat,  8 Dec 2018 03:02:21 +0100 (CET)
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
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Hi all,

This patch series provides some follow-up improvements to the AVTP Audio
Format (AAF) plugin. The highlight of this series is the implementation of
a transmission offload mechanism which improves the plugin performance
considerably. Details are provided in the following paragraphs.

Currently, the AVTPDU transmission interval is controlled by the AAF plugin, in
software. At every timer expiration, the plugin transmits one AVTPDU.  This has
some implications in terms of task scheduling. For instance, in class A
streams, AVTPDUs are transmitted at every 125 us which means the application
task should be scheduled-in at every 125 us. In a general purpose Linux system,
such scheduling interval can be hard to cope with in the long-run.

To mitigate that issue, this series introduces a transmission offload mechanism
that leverages the SO_TXTIME sockopt and ETF qdisc features recently introduced
to kernel 4.19. Instead of sending one AVTPDU at every timer expiration, the
plugin sends several AVTPDUs at once to the kernel, configuring their Tx time
so the transmission interval is maintained. The kernel can then offload packet
transmission to the hardware (if the network controller supports it), providing
more transmission time accuracy.  This offloading mechanism enables the
application to sleep for longer times, easing on task scheduling.  

To illustrate the improvements provided by this series, I ran a before-after
experiment. The experiment setup consisted in 2 PCs with Intel i210 card
connected back-to-back running an up-to-date Archlinux with kernel 4.19.4.  I
ran 'aplay' for 5 minutes on one PC and captured the AVTPDUs on the other PC.
The metric under evaluation is the transmission interval and it is measured by
checking the 'time_delta' information from ethernet frames captured at the
receiving side. If you're interested in reproducing the experiments, let me
know and I can share my helper scripts.

The table below shows the experiment outcome for a Class A, stereo, 16-bit
sample, 48 kHz stream. The unit is nanoseconds.

       |   Mean |   Stdev |     Min |     Max |   Range |
-------+--------+---------+---------+---------+---------+
Before | 125000 |    1154 |   75311 |  172144 |   96833 |
After  | 125000 |      18 |  124960 |  125048 |      88 |


Before this patchset, the transmission interval mean is equal to the optimal
value (Class A stream -> 125 us interval), and it is kept the same after the
patchset. However, the dispersion measurements had improved considerably,
meaning the system is consistently transmitting AVTPDUs at the correct
interval.

Finally, to help the review process, here follows a quick summary of the
patches within this series:
	* PATCH 1: fixes a type in the plugin documentation.
	* PATCH 2: enables the user to configure the presentation time
	  tolerance.
	* PATCH 3-5: refactor the code in order to land the offload mechanism
	  code smoothly.
	* PATCH 6-7: implement the transmission offload mechanism.

This series can also be found in my alsa-plugins tree in github [1].

Regards,

Andre

[1] https://github.com/aguedes/alsa-plugins

Andre Guedes (7):
  doc: Fix typo in AAF doc
  aaf: Add presentation time tolerance
  aaf: Refactor AVTPDU transmission routines
  aaf: Refactor AVTPDU reception routines
  aaf: Refactor timeout routines
  aaf: Tx multiple AVTPDUs per media clock tick
  aaf: AVTPDU transmission periodicity

 aaf/pcm_aaf.c | 600 +++++++++++++++++++++++++++++++++-----------------
 configure.ac  |   2 +-
 doc/aaf.txt   |  40 +++-
 3 files changed, 429 insertions(+), 213 deletions(-)

-- 
2.19.1
