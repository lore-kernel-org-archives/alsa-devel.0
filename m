From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/3] ALSA: firewire-lib/firewire-motu: add
	tracepoints for IEC 61883-1/6 variants
Date: Sun,  9 Apr 2017 21:33:26 +0900
Message-ID: <20170409123329.12079-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id 2407B266ADE
 for <alsa-devel@alsa-project.org>; Sun,  9 Apr 2017 14:33:34 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi,

ALSA IEC 61883-1/6 engine already supports some tracepoints to probe events
for a part of parameters about incoming/outgoing packets. The main purpose
of the tracepoints to assists users/developers for further work to the
engine. For example, users can gather the parameters and developers use it
to investigate quirks of actual units. Actually, as I reported [0], some
drivers in ALSA firewire stack seems to have timestamping issue which have
never resolved by any Free Software [1], and further investigation is
required for users/developers to improves the engine.

My recent works add support for some variants of IEC 61883-1/6. Existent
tracepoints are unavailable for a part of the variants. Furthermore,
in a part of the variants, presentation timestamp is transferred by
a different way against IEC 61883-1/6. It's better to trace packet
parameters for the variants, as well as for compliant protocols to
IEC 61883-1/6.

This patchset adds some tracepoints for the purpose, mainly for RME
Fireface series and MOTU FireWire series. Below code/command is a sample to
work with perf(1) for tracepoints on ALSA driver for MOTU FireWire series,
added at third patch. The final command outputs contents of data chunks for
message from units. Please install or build perf command with python 2
support, in advance.

$ cat ./motu.py
import os
import sys

sys.path.append(os.environ['PERF_EXEC_PATH'] + \
    '/scripts/python/Perf-Trace-Util/lib/Perf/Trace')

from perf_trace_context import *
from Core import *

# For a case that several MOTU FireWire units on the same bus.
cycles = {}

def snd_firewire_lib__in_packet(name, context, cpu, secs, nsecs,
                                pid, comm, callchain,
                                second, cycle, channel, src, dest,
                                cip_header0, cip_header1, payload_quadlets,
                                packet_index, irq, index):
    global cycles

    if src not in cycles:
        cycles[src] = {}
    cycles[src]['sec'] = second
    cycles[src]['cycle'] = cycle

def snd_firewire_motu__in_data_block_message(name, context, cpu, secs, nsecs,
                                             pid, comm, callchain,
                                             src, dst, data_blocks, messages):
    global cycles

    if src not in cycles:
        return

    print('{0} sec {1} cycle'.format(cycles[src]['sec'], cycles[src]['cycle']))
    for i in range(data_blocks):
        offset = i * 8
        msg = messages[offset:offset + 8]
        print('    {0}: {1[5]:02x}{1[4]:02x}{1[3]:02x}{1[2]:02x}{1[1]:02x}{1[0]:02x}'.format(i, msg))
$ ~/linux.git/tools/perf/perf record -a -e snd_firewire_motu:in_data_block_message -e snd_firewire_lib:in_packet
^C
$ PERF_EXEC_PATH=~/linux.git/tools/perf/ ~/linux.git/tools/perf/perf script -s ./motu.py
...
7 sec 7999 cycle
    0: 000000805854
    1: 0000008050fc
    2: 0000808050a4
    3: 00003f80504c
    4: 0000008048f4
    5: 00000080489c
    6: 000080804844
    7: 00003f8040ec
0 sec 0 cycle
0 sec 1 cycle
    0: 000000804094
    1: 0000008050fc
    2: 0000808050a4
    3: 00003f80504c
    4: 0000008048f4
    5: 00000080489c
    6: 000080804844
    7: 00003f8058ac
0 sec 2 cycle
    0: 000000805854
    1: 0000008050fc
    2: 0000808050a4
    3: 00003f80504c
    4: 0000008048f4
    5: 00000080605c
    6: 000080806004
    7: 00003f8058ac
...

[0] [alsa-devel] Dice packet sequence quirk and ALSA firewire stack in Linux 4.6
http://mailman.alsa-project.org/pipermail/alsa-devel/2016-May/107715.html
[1] This is not resolved in FFADO, user space library to drive the units, too.
Some workarounds are applied to the library, but it can not work well depending
on units and protocols.

Takashi Sakamoto (3):
  ALSA: firewire_lib: add tracepoints for packets without CIP headers
  ALSA: firewire-motu: add tracepoints for SPH in IEC 61883-1 fashion
  ALSA: firewire-motu: add tracepoints for messages for unique protocol

 sound/firewire/amdtp-stream-trace.h    |  88 +++++++++++++++++++++++
 sound/firewire/amdtp-stream.c          |   8 +++
 sound/firewire/motu/Makefile           |   2 +
 sound/firewire/motu/amdtp-motu-trace.h | 123 +++++++++++++++++++++++++++++++++
 sound/firewire/motu/amdtp-motu.c       |  37 ++++++++++
 5 files changed, 258 insertions(+)
 create mode 100644 sound/firewire/motu/amdtp-motu-trace.h

-- 
2.9.3
