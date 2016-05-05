From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Dice packet sequence quirk and ALSA firewire stack in
	Linux 4.6
Date: Fri, 6 May 2016 08:59:14 +0900
Message-ID: <572BDE52.1070306@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 16DB92651F0
 for <alsa-devel@alsa-project.org>; Fri,  6 May 2016 01:59:21 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
Cc: Stefan Richter <stefanr@s5r6.in-berlin.de>, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

Hi all,

In this developing cycle for Linux 4.7, I concentrate on working to
check packet sequence of ALSA firewire stack, because I ensure that the
stack causes Dice-based models to generate sound including periodical
noise or to generate no sound in the worst case. As of the end of
developing cycle for Linux 4.6, I assumed that this is a bug of ALSA
firewire stack[1]. However, the assumption is denied by my analysis
with added tracepoints of Linux tracing framework[2]. Then, I concluded
that the issue comes from quirks of Dice in an aspect of processing
presentation timestamp.

I'm under further investigation and have seen some of the quirks. In
this message, I describe the summary of superficial issues from the
quirks, the status of ALSA firewire stack in Linux 4.6 for Dice-based
models and direction of my work for ALSA firewire stack in this
developing cycle.

Besides, resources and my memo for this work is available in this URL.
I wish to upload it to alsa-project.org, not in my server:
http://sakamocchi.jp/media/20160505-dice-packet-dump.tar.xz
(233MB archive file compressed by xz, expands 6.7 GB text files.)


Summary
 - Dice ASICs/firmwares/drivers communicate with packet sequences which
   is partly not compliant to IEC 61883-6.
   - Dice ASICs/firmwares/drivers doesn't sometimes transfer data
     blocks as the same as sampling transfer frequency.
   - Calculation of presentation timestamp is not based on duration of
     data blocks in a packet. This way is different from implementation
     of ALSA firewire stack.
   - The value of estimated 'transfer delay' is against IEEE 1394 spec.

As a result:
 - ALSA dice driver causes these issues. ALSA dice driver in Linux
   kernels since 3.13 have included this issue.
 - To fix this issue, ALSA firewire stack require timestamp generator
   and data block calculator specific for Dice-based models. At least,
   three functions should be changed; amdtp_stream_start(),
   calculate_data_blocks(), calculate_syt() in
   'sound/firewire/amdtp-stream.c'.
 - The work requires much changes, thus it's impossible for Linux 4.6.
   ALSA firewire stack in Linux 4.6 will be shipped with these issues.
 - We have a short time till merge window of Linux 4.7 (Just one week).
   I'll work for merging my proposed patchset[2][3][4], without fixing
   the issues.

[1]
http://mailman.alsa-project.org/pipermail/alsa-devel/2016-March/105608.html
[2]
http://mailman.alsa-project.org/pipermail/alsa-devel/2016-April/106950.html
[3]
http://mailman.alsa-project.org/pipermail/alsa-devel/2016-April/107290.html
[4]
http://mailman.alsa-project.org/pipermail/alsa-devel/2016-April/107531.html


Regards

Takashi Sakamoto
