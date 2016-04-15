From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFC][PATCH 0/3 v2] firewire-lib: support Linux
	tracing framework to dump a part of packet data
Date: Sat, 16 Apr 2016 01:23:21 +0900
Message-ID: <1460737404-19699-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id DE313265074
 for <alsa-devel@alsa-project.org>; Fri, 15 Apr 2016 18:23:34 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, stefanr@s5r6.in-berlin.de, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi,

This patchset is to update my previous one:
[alsa-devel] [RFC][PATCH] ALSA: firewire-lib: support Linux tracing to dump a part of packet data
http://mailman.alsa-project.org/pipermail/alsa-devel/2016-March/106146.html

Changes:
 - Drop condition statement enabled only on tracing mode.
 - Compute cycle count correctly and report.
 - Add more parameters to report.
  - Node IDs of source/destination.
  - The value of isochronous channel to use.
 - Add parse script written by Python3.


The motivation of this patchset is to check timestamp processing of ALSA
firewire stack, as writing in this message.
http://mailman.alsa-project.org/pipermail/alsa-devel/2016-March/105608.html

As a result, I confirm it compliant to IEC 61883-1/6 in these points:
 - Transfer 8,000 packets per second of presentation timestamp.
 - Transfer the same number of data blocks as sampling transfer frequency
   per second of presentation timestamp.
 - The gap of sequence of calculated presentation timestamp correctly
   describes the elapsed time of data blocks in a packet.
 - The offset between cycle start and presentation timestamp is proper,
   including transfer delay.

Therefore, I believe that issues on dice-based models come from specific
quirks, not due to bugs of ALSA firewire stack. I guess that the
presentation timestamps for the models should be somewhat calculated with
cycle count or the other parameters. Current implementation calculates
it ignoring the cycle count.

Further investigation is required to solve it.


Regards

Takashi Sakamoto (3):
  firewire-lib: compute the value of second field in cycle count for IT
    context
  firewire-lib: compute the value of second field in cycle count for IR
    context
  firewire-lib: support Linux tracing to dump a part of packet data

 sound/firewire/Makefile             |  3 ++
 sound/firewire/amdtp-stream-trace.h | 98 +++++++++++++++++++++++++++++++++++++
 sound/firewire/amdtp-stream.c       | 75 +++++++++++++++++++++-------
 3 files changed, 159 insertions(+), 17 deletions(-)
 create mode 100644 sound/firewire/amdtp-stream-trace.h

-- 
2.7.4
