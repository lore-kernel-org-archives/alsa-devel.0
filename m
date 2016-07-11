From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 3/3] ALSA - hda: Fix timestamping documentation
Date: Mon, 11 Jul 2016 15:43:29 +0530
Message-ID: <1468232009-14130-4-git-send-email-vinod.koul@intel.com>
References: <1468232009-14130-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id ABD4A2654B4
 for <alsa-devel@alsa-project.org>; Mon, 11 Jul 2016 12:06:36 +0200 (CEST)
In-Reply-To: <1468232009-14130-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org

Some typos in the documentation, so fix them up.

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 Documentation/sound/alsa/timestamping.txt | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/sound/alsa/timestamping.txt b/Documentation/sound/alsa/timestamping.txt
index 1b6473f393a8..9d579aefbffd 100644
--- a/Documentation/sound/alsa/timestamping.txt
+++ b/Documentation/sound/alsa/timestamping.txt
@@ -14,7 +14,7 @@ provides a refined estimate with a delay.
 event or application query.
 The difference (tstamp - trigger_tstamp) defines the elapsed time.
 
-The ALSA API provides reports two basic pieces of information, avail
+The ALSA API provides two basic pieces of information, avail
 and delay, which combined with the trigger and current system
 timestamps allow for applications to keep track of the 'fullness' of
 the ring buffer and the amount of queued samples.
@@ -53,21 +53,21 @@ case):
 The analog time is taken at the last stage of the playback, as close
 as possible to the actual transducer
 
-The link time is taken at the output of the SOC/chipset as the samples
+The link time is taken at the output of the SoC/chipset as the samples
 are pushed on a link. The link time can be directly measured if
 supported in hardware by sample counters or wallclocks (e.g. with
 HDAudio 24MHz or PTP clock for networked solutions) or indirectly
 estimated (e.g. with the frame counter in USB).
 
 The DMA time is measured using counters - typically the least reliable
-of all measurements due to the bursty natured of DMA transfers.
+of all measurements due to the bursty nature of DMA transfers.
 
 The app time corresponds to the time tracked by an application after
 writing in the ring buffer.
 
-The application can query what the hardware supports, define which
+The application can query the hardware capabilities, define which
 audio time it wants reported by selecting the relevant settings in
-audio_tstamp_config fields, get an estimate of the timestamp
+audio_tstamp_config fields, thus get an estimate of the timestamp
 accuracy. It can also request the delay-to-analog be included in the
 measurement. Direct access to the link time is very interesting on
 platforms that provide an embedded DSP; measuring directly the link
@@ -169,7 +169,7 @@ playback: systime: 938107562 nsec, audio time 938112708 nsec, 	systime delta -51
 Example 1 shows that the timestamp at the DMA level is close to 1ms
 ahead of the actual playback time (as a side time this sort of
 measurement can help define rewind safeguards). Compensating for the
-DMA-link delay in example 2 helps remove the hardware buffering abut
+DMA-link delay in example 2 helps remove the hardware buffering but
 the information is still very jittery, with up to one sample of
 error. In example 3 where the timestamps are measured with the link
 wallclock, the timestamps show a monotonic behavior and a lower
-- 
1.9.1
