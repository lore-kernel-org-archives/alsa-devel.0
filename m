From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001724]: au88x0 PCM configuration problem - buffer_size constraint
Date: Tue, 31 Jan 2006 10:49:31 +0100
Message-ID: <4765598c977020144819ee5d03d25167@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id DB41A193
	for <alsa-devel@alsa-project.org>; Tue, 31 Jan 2006 10:49:31 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been UPDATED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1724> 
======================================================================
Reported By:                Raymond
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1724
Category:                   PCI - au88x0
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             01-07-2006 05:10 CET
Last Modified:              01-31-2006 10:49 CET
======================================================================
Summary:                    au88x0 PCM configuration problem - buffer_size
constraint
Description: 
/cvs/alsa-lib/test/pcm_min

ALSA lib pcm.c:7127:(snd_pcm_set_params) Unable to set buffer time
(latency) 500000 for PLAYBACK: Invalid argument
Playback open error: Invalid argument

sound card is au8830, the au88x0 driver only accept period size in power
of 2.
======================================================================

----------------------------------------------------------------------
 Raymond - 01-28-06 07:58 
----------------------------------------------------------------------
define RULES_DEBUG in /core/pcm_native.c

alsa-lib/test/pcm_min


vortex_pcm_open substream->stream=0
ACCESS = 00000000ffffffffffffffff -> 0000000000000009
FORMAT = 00000000ffffffffffffffff -> 000000000000300006
SUBFORMAT = 00000000ffffffffffffffff -> 0000000000000001
SAMPLE_BITS = [0 4294967295] -> [0 4294967295]
FRAME_BITS = [0 4294967295] -> [0 4294967295]
CHANNELS = [0 4294967295] -> [1 4]
RATE = [0 4294967295] -> [5000 48000]
PERIOD_TIME = [0 4294967295] -> [0 4294967295]
PERIOD_SIZE = [0 4294967295] -> [0 4294967295]
PERIOD_BYTES = [0 4294967295] -> [1 4096]
PERIODS = [0 4294967295] -> [2 32]
BUFFER_TIME = [0 4294967295] -> [0 4294967295]
BUFFER_SIZE = [0 4294967295] -> [0 4294967295]
BUFFER_BYTES = [0 4294967295] -> [1 65536]
TICK_TIME = [0 4294967295] -> [10000 10000]
Rule 0 [e1cff010]: FORMAT = 300006 -> 300006
Rule 1 [e1cff140]: SAMPLE_BITS = [0 4294967295] -> [8 16]
Rule 2 [e1cfeea0]: SAMPLE_BITS = [8 16] -> [8 16]
Rule 3 [e1cfee30]: FRAME_BITS = [0 4294967295] -> [8 64]
Rule 4 [e1cfef90]: FRAME_BITS = [8 64] -> [8 64]
Rule 5 [e1cfef90]: FRAME_BITS = [8 64] -> [8 64]
Rule 6 [e1cfeea0]: CHANNELS = [1 4] -> [1 4]
Rule 7 [e1cfef90]: RATE = [5000 48000] -> [5000 48000]
Rule 8 [e1cfef90]: RATE = [5000 48000] -> [5000 48000]
Rule 9 [e1cfeea0]: PERIODS = [2 32] -> [2 32]
Rule 10 [e1cfeea0]: PERIOD_SIZE = [0 4294967295] -> [0 2147483647]
Rule 11 [e1cfef90]: PERIOD_SIZE = [0 2147483647] -> [1 4096]
Rule 12 [e1cfef10]: PERIOD_SIZE = [1 4096] -> [1 4096]
Rule 13 [e1cfee30]: BUFFER_SIZE = [0 4294967295] -> [2 131072]
Rule 14 [e1cfef90]: BUFFER_SIZE = [2 131072] -> [2 65536]
Rule 15 [e1cfef10]: BUFFER_SIZE = [2 65536] -> [2 65536]
Rule 16 [e1cfef10]: PERIOD_BYTES = [1 4096] -> [1 4096]
Rule 17 [e1cfef10]: BUFFER_BYTES = [1 65536] -> [2 65536]
Rule 18 [e1cfef90]: PERIOD_TIME = [0 4294967295] -> (20 819200]
Rule 19 [e1cfef90]: BUFFER_TIME = [0 4294967295] -> (41 13107200]
Rule 20 [e1d047f0]: PERIOD_BYTES = [1 4096] -> [1 4096]
Rule 21 [e1cff230]: BUFFER_BYTES = [2 65536] -> [2 65536]
Rule 0 [e1cff010]: FORMAT = 300006 -> 300006
Rule 2 [e1cfeea0]: SAMPLE_BITS = [8 16] -> [8 16]
Rule 4 [e1cfef90]: FRAME_BITS = [8 64] -> [8 64]
Rule 5 [e1cfef90]: FRAME_BITS = [8 64] -> [8 64]
Rule 7 [e1cfef90]: RATE = [5000 48000] -> [5000 48000]
Rule 8 [e1cfef90]: RATE = [5000 48000] -> [5000 48000]
Rule 9 [e1cfeea0]: PERIODS = [2 32] -> [2 32]
Rule 10 [e1cfeea0]: PERIOD_SIZE = [1 4096] -> [1 4096]
Rule 12 [e1cfef10]: PERIOD_SIZE = [1 4096] -> [1 4096]
Rule 14 [e1cfef90]: BUFFER_SIZE = [2 65536] -> [2 65536]
Rule 15 [e1cfef10]: BUFFER_SIZE = [2 65536] -> [2 65536]
TS = [0 4294967295] -> [8 64]
Rule 4 [e1cfef90]: FRAME_BITS = [8 64] -> [8 64]
Rule 5 [e1cfef90]: FRAME_BITS = [8 64] -> [8 64]
Rule 6 [e1cfeea0]: CHANNELS = [1 4] -> [1 4]
Rule 7 [e1cfef90]: RATE = [5000 48000] -> [5000 48000]
Rule 8 [e1cfef90]: RATE = [5000 48000] -> [5000 48000]
Rule 9 [e1cfeea0]: PERIODS = [2 32] -> [2 32]
Rule 10 [e1cfeea0]: PERIOD_SIZE = [0 4294967295] -> [0 2147483647]
Rule 11 [e1cfef90]: PERIOD_SIZE = [0 2147483647] -> [1 4096]
Rule 12 [e1cfef10]: PERIOD_SIZE = [1 4096] -> [1 4096]
Rule 13 [e1cfee30]: BUFFER_SIZE = [0 4294967295] -> [2 131072]
Rule 14 [e1cfef90]: BUFFER_SIZE = [2 131072] -> [2 65536]
Rule 15 [e1cfef10]: BUFFER_SIZE = [2 65536] -> [2 65536]
Rule 16 [e1cfef10]: PERIOD_BYTES = [1 4096] -> [1 4096]
Rule 17 [e1cfef10]: BUFFER_BYTES = [1 65536] -> [2 65536]
Rule 18 [e1cfef90]: PERIOD_TIME = [0 4294967295] -> (20 819200]
Rule 19 [e1cfef90]: BUFFER_TIME = [0 4294967295] -> (41 13107200]
Rule 20 [e1d047f0]: PERIOD_BYTES = [1 4096] -> [1 4096]
Rule 21 [e1cff230]: BUFFER_BYTES = [2 65536] -> [2 65536]
Rule 0 [e1cff010]: FORMAT = 300006 -> 300006
Rule 2 [e1cfeea0]: SAMPLE_BITS = [8 16] -> [8 16]
Rule 4 [e1cfef90]: FRAME_BITS = [8 64] -> [8 64]
Rule 5 [e1cfef90]: FRAME_BITS = [8 64] -> [8 64]
Rule 7 [e1cfef90]: RATE = [5000 48000] -> [5000 48000]
Rule 8 [e1cfef90]: RATE = [5000 48000] -> [5000 48000]
Rule 9 [e1cfeea0]: PERIODS = [2 32] -> [2 32]
Rule 10 [e1cfeea0]: PERIOD_SIZE = [1 4096] -> [1 4096]
Rule 12 [e1cfef10]: PERIOD_SIZE = [1 4096] -> [1 4096]
Rule 14 [e1cfef90]: BUFFER_SIZE = [2 65536] -> [2 65536]
Rule 15 [e1cfef10]: BUFFER_SIZE = [2 65536] -> [2 65536]
RATE = [48000 48000] -> [48000 48000]
Rule 12 [e1cfef10]: PERIOD_SIZE = [1 4096] -> [1 4096]
Rule 15 [e1cfef10]: BUFFER_SIZE = [2 65536] -> [2 65536]
Rule 18 [e1cfef90]: PERIOD_TIME = (20 819200] -> (20 85334)
Rule 19 [e1cfef90]: BUFFER_TIME = (41 13107200] -> (41 1365334)
Rule 7 [e1cfef90]: RATE = [48000 48000] -> [48000 48000]
Rule 8 [e1cfef90]: RATE = [48000 48000] -> [48000 48000]
Rule 12 [e1cfef10]: PERIOD_SIZE = [1 4096] -> [1 4096]
Rule 15 [e1cfef10]: BUFFER_SIZE = [2 65536] -> [2 65536]
CHANNELS = [1 1] -> [1 1]
Rule 2 [e1cfeea0]: SAMPLE_BITS = [8 16] -> [8 16]
Rule 3 [e1cfee30]: FRAME_BITS = [8 64] -> [8 16]
Rule 6 [e1cfeea0]: CHANNELS = [1 1] -> [1 1]
Rule 11 [e1cfef90]: PERIOD_SIZE = [1 4096] -> [1 4096]
Rule 14 [e1cfef90]: BUFFER_SIZE = [2 65536] -> [2 65536]
Rule 16 [e1cfef10]: PERIOD_BYTES = [1 4096] -> [1 4096]
Rule 17 [e1cfef10]: BUFFER_BYTES = [2 65536] -> [2 65536]
Rule 2 [e1cfeea0]: SAMPLE_BITS = [8 16] -> [8 16]
FORMAT = 0000000000000002 -> 0000000000000002
Rule 1 [e1cff140]: SAMPLE_BITS = [8 16] -> [8 8]
Rule 3 [e1cfee30]: FRAME_BITS = [8 16] -> [8 8]
Rule 6 [e1cfeea0]: CHANNELS = [1 1] -> [1 1]
Rule 11 [e1cfef90]: PERIOD_SIZE = [1 4096] -> [1 4096]
Rule 14 [e1cfef90]: BUFFER_SIZE = [2 65536] -> [2 65536]
Rule 16 [e1cfef10]: PERIOD_BYTES = [1 4096] -> [1 4096]
Rule 17 [e1cfef10]: BUFFER_BYTES = [2 65536] -> [2 65536]
Rule 0 [e1cff010]: FORMAT = 2 -> 2
Rule 2 [e1cfeea0]: SAMPLE_BITS = [8 8] -> [8 8]
ACCESS = 00000000ffffffffffffffff -> 0000000000000009
FORMAT = 00000000ffffffffffffffff -> 000000000000300006
SUBFORMAT = 00000000ffffffffffffffff -> 0000000000000001
SAMPLE_BITS = [0 4294967295] -> [0 4294967295]
FRAME_BITS = [0 4294967295] -> [0 4294967295]
CHANNELS = [0 4294967295] -> [1 4]
RATE = [0 4294967295] -> [5000 48000]
PERIOD_TIME = [0 4294967295] -> [0 4294967295]
PERIOD_SIZE = [0 4294967295] -> [0 4294967295]
PERIOD_BYTES = [0 4294967295] -> [1 4096]
PERIODS = [0 4294967295] -> [2 32]
BUFFER_TIME = [0 4294967295] -> [0 4294967295]
BUFFER_SIZE = [0 4294967295] -> [0 4294967295]
BUFFER_BYTES = [0 4294967295] -> [1 65536]
TICK_TIME = [0 4294967295] -> [10000 10000]
Rule 0 [e1cff010]: FORMAT = 300006 -> 300006
Rule 1 [e1cff140]: SAMPLE_BITS = [0 4294967295] -> [8 16]
Rule 2 [e1cfeea0]: SAMPLE_BITS = [8 16] -> [8 16]
Rule 3 [e1cfee30]: FRAME_BITS = [0 4294967295] -> [8 64]
Rule 4 [e1cfef90]: FRAME_BITS = [8 64] -> [8 64]
Rule 5 [e1cfef90]: FRAME_BITS = [8 64] -> [8 64]
Rule 6 [e1cfeea0]: CHANNELS = [1 4] -> [1 4]
Rule 7 [e1cfef90]: RATE = [5000 48000] -> [5000 48000]
Rule 8 [e1cfef90]: RATE = [5000 48000] -> [5000 48000]
Rule 9 [e1cfeea0]: PERIODS = [2 32] -> [2 32]
Rule 10 [e1cfeea0]: PERIOD_SIZE = [0 4294967295] -> [0 2147483647]
Rule 11 [e1cfef90]: PERIOD_SIZE = [0 2147483647] -> [1 4096]
Rule 12 [e1cfef10]: PERIOD_SIZE = [1 4096] -> [1 4096]
Rule 13 [e1cfee30]: BUFFER_SIZE = [0 4294967295] -> [2 131072]
Rule 14 [e1cfef90]: BUFFER_SIZE = [2 131072] -> [2 65536]
Rule 15 [e1cfef10]: BUFFER_SIZE = [2 65536] -> [2 65536]
Rule 16 [e1cfef10]: PERIOD_BYTES = [1 4096] -> [1 4096]
Rule 17 [e1cfef10]: BUFFER_BYTES = [1 65536] -> [2 65536]
Rule 18 [e1cfef90]: PERIOD_TIME = [0 4294967295] -> (20 819200]
Rule 19 [e1cfef90]: BUFFER_TIME = [0 4294967295] -> (41 13107200]
Rule 20 [e1d047f0]: PERIOD_BYTES = [1 4096] -> [1 4096]
Rule 21 [e1cff230]: BUFFER_BYTES = [2 65536] -> [2 65536]
Rule 0 [e1cff010]: FORMAT = 300006 -> 300006
Rule 2 [e1cfeea0]: SAMPLE_BITS = [8 16] -> [8 16]
Rule 4 [e1cfef90]: FRAME_BITS = [8 64] -> [8 64]
Rule 5 [e1cfef90]: FRAME_BITS = [8 64] -> [8 64]
Rule 7 [e1cfef90]: RATE = [5000 48000] -> [5000 48000]
Rule 8 [e1cfef90]: RATE = [5000 48000] -> [5000 48000]
Rule 9 [e1cfeea0]: PERIODS = [2 32] -> [2 32]
Rule 10 [e1cfeea0]: PERIOD_SIZE = [1 4096] -> [1 4096]
Rule 12 [e1cfef10]: PERIOD_SIZE = [1 4096] -> [1 4096]
Rule 14 [e1cfef90]: BUFFER_SIZE = [2 65536] -> [2 65536]
Rule 15 [e1cfef10]: BUFFER_SIZE = [2 65536] -> [2 65536]
RATE = [48000 48000] -> [48000 48000]
Rule 12 [e1cfef10]: PERIOD_SIZE = [1 4096] -> [1 4096]
Rule 15 [e1cfef10]: BUFFER_SIZE = [2 65536] -> [2 65536]
Rule 18 [e1cfef90]: PERIOD_TIME = (20 819200] -> (20 85334)
Rule 19 [e1cfef90]: BUFFER_TIME = (41 13107200] -> (41 1365334)
Rule 7 [e1cfef90]: RATE = [48000 48000] -> [48000 48000]
Rule 8 [e1cfef90]: RATE = [48000 48000] -> [48000 48000]
Rule 12 [e1cfef10]: PERIOD_SIZE = [1 4096] -> [1 4096]
Rule 15 [e1cfef10]: BUFFER_SIZE = [2 65536] -> [2 65536]
CHANNELS = [1 1] -> [1 1]
Rule 2 [e1cfeea0]: SAMPLE_BITS = [8 16] -> [8 16]
Rule 3 [e1cfee30]: FRAME_BITS = [8 64] -> [8 16]
Rule 6 [e1cfeea0]: CHANNELS = [1 1] -> [1 1]
Rule 11 [e1cfef90]: PERIOD_SIZE = [1 4096] -> [1 4096]
Rule 14 [e1cfef90]: BUFFER_SIZE = [2 65536] -> [2 65536]
Rule 16 [e1cfef10]: PERIOD_BYTES = [1 4096] -> [1 4096]
Rule 17 [e1cfef10]: BUFFER_BYTES = [2 65536] -> [2 65536]
Rule 2 [e1cfeea0]: SAMPLE_BITS = [8 16] -> [8 16]
FORMAT = 0000000000000002 -> 0000000000000002
Rule 1 [e1cff140]: SAMPLE_BITS = [8 16] -> [8 8]
Rule 3 [e1cfee30]: FRAME_BITS = [8 16] -> [8 8]
Rule 6 [e1cfeea0]: CHANNELS = [1 1] -> [1 1]
Rule 11 [e1cfef90]: PERIOD_SIZE = [1 4096] -> [1 4096]
Rule 14 [e1cfef90]: BUFFER_SIZE = [2 65536] -> [2 65536]
Rule 16 [e1cfef10]: PERIOD_BYTES = [1 4096] -> [1 4096]
Rule 17 [e1cfef10]: BUFFER_BYTES = [2 65536] -> [2 65536]
Rule 0 [e1cff010]: FORMAT = 2 -> 2
Rule 2 [e1cfeea0]: SAMPLE_BITS = [8 8] -> [8 8]
BUFFER_SIZE = [24000 65536] -> [24000 65536]
Rule 5 [e1cfef90]: FRAME_BITS = [8 8] -> [8 8]
Rule 8 [e1cfef90]: RATE = [48000 48000] -> [48000 48000]
Rule 9 [e1cfeea0]: PERIODS = [2 32] -> [6 32]
Rule 10 [e1cfeea0]: PERIOD_SIZE = [1 4096] -> [750 4096]
Rule 13 [e1cfee30]: BUFFER_SIZE = [24000 65536] -> [24000 65536]
Rule 16 [e1cfef10]: PERIOD_BYTES = [1 4096] -> [750 4096]
Rule 17 [e1cfef10]: BUFFER_BYTES = [2 65536] -> [24000 65536]
Rule 18 [e1cfef90]: PERIOD_TIME = (20 85334) -> [15625 85334)
Rule 19 [e1cfef90]: BUFFER_TIME = (41 1365334) -> [500000 1365334)
Rule 20 [e1d047f0]: PERIOD_BYTES = [750 4096] -> [1024 4096]
Rule 21 [e1cff230]: BUFFER_BYTES = [24000 65536] -> [24000 65536]
Rule 4 [e1cfef90]: FRAME_BITS = [8 8] -> [8 8]
Rule 5 [e1cfef90]: FRAME_BITS = [8 8] -> [8 8]
Rule 7 [e1cfef90]: RATE = [48000 48000] -> [48000 48000]
Rule 8 [e1cfef90]: RATE = [48000 48000] -> [48000 48000]
Rule 9 [e1cfeea0]: PERIODS = [6 32] -> [6 32]
Rule 11 [e1cfef90]: PERIOD_SIZE = [750 4096] -> [1024 4096]
Rule 12 [e1cfef10]: PERIOD_SIZE = [1024 4096] -> [1024 4096]
Rule 13 [e1cfee30]: BUFFER_SIZE = [24000 65536] -> [24000 65536]
Rule 14 [e1cfef90]: BUFFER_SIZE = [24000 65536] -> [24000 65536]
Rule 15 [e1cfef10]: BUFFER_SIZE = [24000 65536] -> [24000 65536]
Rule 16 [e1cfef10]: PERIOD_BYTES = [1024 4096] -> [1024 4096]
Rule 18 [e1cfef90]: PERIOD_TIME = [15625 85334) -> (21333 85334)
Rule 4 [e1cfef90]: FRAME_BITS = [8 8] -> [8 8]
Rule 7 [e1cfef90]: RATE = [48000 48000] -> [48000 48000]
Rule 9 [e1cfeea0]: PERIODS = [6 32] -> [6 32]
Rule 12 [e1cfef10]: PERIOD_SIZE = [1024 4096] -> [1024 4096]
ACCESS = 00000000ffffffffffffffff -> 0000000000000009
FORMAT = 00000000ffffffffffffffff -> 000000000000300006
SUBFORMAT = 00000000ffffffffffffffff -> 0000000000000001
SAMPLE_BITS = [0 4294967295] -> [0 4294967295]
FRAME_BITS = [0 4294967295] -> [0 4294967295]
CHANNELS = [0 4294967295] -> [1 4]
RATE = [0 4294967295] -> [5000 48000]
PERIOD_TIME = [0 4294967295] -> [0 4294967295]
PERIOD_SIZE = [0 4294967295] -> [0 4294967295]
PERIOD_BYTES = [0 4294967295] -> [1 4096]
PERIODS = [0 4294967295] -> [2 32]
BUFFER_TIME = [0 4294967295] -> [0 4294967295]
BUFFER_SIZE = [0 4294967295] -> [0 4294967295]
BUFFER_BYTES = [0 4294967295] -> [1 65536]
TICK_TIME = [0 4294967295] -> [10000 10000]
Rule 0 [e1cff010]: FORMAT = 300006 -> 300006
Rule 1 [e1cff140]: SAMPLE_BITS = [0 4294967295] -> [8 16]
Rule 2 [e1cfeea0]: SAMPLE_BITS = [8 16] -> [8 16]
Rule 3 [e1cfee30]: FRAME_BITS = [0 4294967295] -> [8 64]
Rule 4 [e1cfef90]: FRAME_BITS = [8 64] -> [8 64]
Rule 5 [e1cfef90]: FRAME_BITS = [8 64] -> [8 64]
Rule 6 [e1cfeea0]: CHANNELS = [1 4] -> [1 4]
Rule 7 [e1cfef90]: RATE = [5000 48000] -> [5000 48000]
Rule 8 [e1cfef90]: RATE = [5000 48000] -> [5000 48000]
Rule 9 [e1cfeea0]: PERIODS = [2 32] -> [2 32]
Rule 10 [e1cfeea0]: PERIOD_SIZE = [0 4294967295] -> [0 2147483647]
Rule 11 [e1cfef90]: PERIOD_SIZE = [0 2147483647] -> [1 4096]
Rule 12 [e1cfef10]: PERIOD_SIZE = [1 4096] -> [1 4096]
Rule 13 [e1cfee30]: BUFFER_SIZE = [0 4294967295] -> [2 131072]
Rule 14 [e1cfef90]: BUFFER_SIZE = [2 131072] -> [2 65536]
Rule 15 [e1cfef10]: BUFFER_SIZE = [2 65536] -> [2 65536]
Rule 16 [e1cfef10]: PERIOD_BYTES = [1 4096] -> [1 4096]
Rule 17 [e1cfef10]: BUFFER_BYTES = [1 65536] -> [2 65536]
Rule 18 [e1cfef90]: PERIOD_TIME = [0 4294967295] -> (20 819200]
Rule 19 [e1cfef90]: BUFFER_TIME = [0 4294967295] -> (41 13107200]
Rule 20 [e1d047f0]: PERIOD_BYTES = [1 4096] -> [1 4096]
Rule 21 [e1cff230]: BUFFER_BYTES = [2 65536] -> [2 65536]
Rule 0 [e1cff010]: FORMAT = 300006 -> 300006
Rule 2 [e1cfeea0]: SAMPLE_BITS = [8 16] -> [8 16]
Rule 4 [e1cfef90]: FRAME_BITS = [8 64] -> [8 64]
Rule 5 [e1cfef90]: FRAME_BITS = [8 64] -> [8 64]
Rule 7 [e1cfef90]: RATE = [5000 48000] -> [5000 48000]
Rule 8 [e1cfef90]: RATE = [5000 48000] -> [5000 48000]
Rule 9 [e1cfeea0]: PERIODS = [2 32] -> [2 32]
Rule 10 [e1cfeea0]: PERIOD_SIZE = [1 4096] -> [1 4096]
Rule 12 [e1cfef10]: PERIOD_SIZE = [1 4096] -> [1 4096]
Rule 14 [e1cfef90]: BUFFER_SIZE = [2 65536] -> [2 65536]
Rule 15 [e1cfef10]: BUFFER_SIZE = [2 65536] -> [2 65536]
RATE = [48000 48000] -> [48000 48000]
Rule 12 [e1cfef10]: PERIOD_SIZE = [1 4096] -> [1 4096]
Rule 15 [e1cfef10]: BUFFER_SIZE = [2 65536] -> [2 65536]
Rule 18 [e1cfef90]: PERIOD_TIME = (20 819200] -> (20 85334)
Rule 19 [e1cfef90]: BUFFER_TIME = (41 13107200] -> (41 1365334)
Rule 7 [e1cfef90]: RATE = [48000 48000] -> [48000 48000]
Rule 8 [e1cfef90]: RATE = [48000 48000] -> [48000 48000]
Rule 12 [e1cfef10]: PERIOD_SIZE = [1 4096] -> [1 4096]
Rule 15 [e1cfef10]: BUFFER_SIZE = [2 65536] -> [2 65536]
CHANNELS = [1 1] -> [1 1]
Rule 2 [e1cfeea0]: SAMPLE_BITS = [8 16] -> [8 16]
Rule 3 [e1cfee30]: FRAME_BITS = [8 64] -> [8 16]
Rule 6 [e1cfeea0]: CHANNELS = [1 1] -> [1 1]
Rule 11 [e1cfef90]: PERIOD_SIZE = [1 4096] -> [1 4096]
Rule 14 [e1cfef90]: BUFFER_SIZE = [2 65536] -> [2 65536]
Rule 16 [e1cfef10]: PERIOD_BYTES = [1 4096] -> [1 4096]
Rule 17 [e1cfef10]: BUFFER_BYTES = [2 65536] -> [2 65536]
Rule 2 [e1cfeea0]: SAMPLE_BITS = [8 16] -> [8 16]
FORMAT = 0000000000000002 -> 0000000000000002
Rule 1 [e1cff140]: SAMPLE_BITS = [8 16] -> [8 8]
Rule 3 [e1cfee30]: FRAME_BITS = [8 16] -> [8 8]
Rule 6 [e1cfeea0]: CHANNELS = [1 1] -> [1 1]
Rule 11 [e1cfef90]: PERIOD_SIZE = [1 4096] -> [1 4096]
Rule 14 [e1cfef90]: BUFFER_SIZE = [2 65536] -> [2 65536]
Rule 16 [e1cfef10]: PERIOD_BYTES = [1 4096] -> [1 4096]
Rule 17 [e1cfef10]: BUFFER_BYTES = [2 65536] -> [2 65536]
Rule 0 [e1cff010]: FORMAT = 2 -> 2
Rule 2 [e1cfeea0]: SAMPLE_BITS = [8 8] -> [8 8]
PERIOD_TIME = (21333 85334) -> (21333 85334)
PERIOD_SIZE = [1024 4096] -> [1024 4096]
BUFFER_SIZE = [24000 65536] -> [24000 65536]
Rule 4 [e1cfef90]: FRAME_BITS = [8 8] -> [8 8]
Rule 5 [e1cfef90]: FRAME_BITS = [8 8] -> [8 8]
Rule 7 [e1cfef90]: RATE = [48000 48000] -> [48000 48000]
Rule 8 [e1cfef90]: RATE = [48000 48000] -> [48000 48000]
Rule 9 [e1cfeea0]: PERIODS = [2 32] -> [6 32]
Rule 10 [e1cfeea0]: PERIOD_SIZE = [1024 4096] -> [1024 4096]
Rule 12 [e1cfef10]: PERIOD_SIZE = [1024 4096] -> [1024 4096]
Rule 13 [e1cfee30]: BUFFER_SIZE = [24000 65536] -> [24000 65536]
Rule 16 [e1cfef10]: PERIOD_BYTES = [1 4096] -> [1024 4096]
Rule 17 [e1cfef10]: BUFFER_BYTES = [2 65536] -> [24000 65536]
Rule 18 [e1cfef90]: PERIOD_TIME = (21333 85334) -> (21333 85334)
Rule 19 [e1cfef90]: BUFFER_TIME = (41 1365334) -> [500000 1365334)
Rule 20 [e1d047f0]: PERIOD_BYTES = [1024 4096] -> [1024 4096]
Rule 21 [e1cff230]: BUFFER_BYTES = [24000 65536] -> [24000 65536]
Rule 4 [e1cfef90]: FRAME_BITS = [8 8] -> [8 8]
Rule 5 [e1cfef90]: FRAME_BITS = [8 8] -> [8 8]
Rule 8 [e1cfef90]: RATE = [48000 48000] -> [48000 48000]
Rule 11 [e1cfef90]: PERIOD_SIZE = [1024 4096] -> [1024 4096]
Rule 14 [e1cfef90]: BUFFER_SIZE = [24000 65536] -> [24000 65536]
Rule 15 [e1cfef10]: BUFFER_SIZE = [24000 65536] -> [24000 65536]
BUFFER_SIZE = [24000 24000] -> [24000 24000]
Rule 5 [e1cfef90]: FRAME_BITS = [8 8] -> [8 8]
Rule 8 [e1cfef90]: RATE = [48000 48000] -> [48000 48000]
Rule 9 [e1cfeea0]: PERIODS = [6 32] -> [6 23]
Rule 10 [e1cfeea0]: PERIOD_SIZE = [1024 4096] -> [1044 4000]
Rule 13 [e1cfee30]: BUFFER_SIZE = [24000 24000] -> [24000 24000]
Rule 16 [e1cfef10]: PERIOD_BYTES = [1024 4096] -> [1044 4000]
Rule 17 [e1cfef10]: BUFFER_BYTES = [24000 65536] -> [24000 24000]
Rule 18 [e1cfef90]: PERIOD_TIME = (21333 85334) -> [21750 83334)
Rule 19 [e1cfef90]: BUFFER_TIME = [500000 1365334) -> [500000 500000]
Rule 20 [e1d047f0]: PERIOD_BYTES = [1044 4000] -> [2048 2048]
Rule 21 [e1cff230]: BUFFER_BYTES = [24000 24000] -> [24000 24000]
Rule 4 [e1cfef90]: FRAME_BITS = [8 8] -> [8 8]
Rule 5 [e1cfef90]: FRAME_BITS = [8 8] -> [8 8]
Rule 7 [e1cfef90]: RATE = [48000 48000] -> [48000 48000]
Rule 8 [e1cfef90]: RATE = [48000 48000] -> [48000 48000]
Rule 9 [e1cfeea0]: PERIODS = [6 23] -> [6 22]
Rule 10 [e1cfeea0]: PERIOD_SIZE = [1044 4000] -> [1091 4000]
Rule 11 [e1cfef90]: PERIOD_SIZE = [1091 4000] -> [2048 2048]
Rule 12 [e1cfef10]: PERIOD_SIZE = [2048 2048] -> [2048 2048]
Rule 13 [e1cfee30]: BUFFER_SIZE = [24000 24000] -> [24000 24000]
Rule 14 [e1cfef90]: BUFFER_SIZE = [24000 24000] -> [24000 24000]
Rule 15 [e1cfef10]: BUFFER_SIZE = [24000 24000] -> [24000 24000]
Rule 16 [e1cfef10]: PERIOD_BYTES = [2048 2048] -> [2048 2048]
Rule 18 [e1cfef90]: PERIOD_TIME = [21750 83334) -> (42666 42667)
Rule 4 [e1cfef90]: FRAME_BITS = [8 8] -> [8 8]
Rule 7 [e1cfef90]: RATE = [48000 48000] -> [48000 48000]
Rule 9 [e1cfeea0]: PERIODS = [6 22] -> empty
vortex_pcm_hw_free substream->stream=0
vortex_pcm_close substream->stream=0

----------------------------------------------------------------------
 Raymond - 01-31-06 08:31 
----------------------------------------------------------------------
Why do Rule 9 [e1cfeea0]: PERIODS = [6 22] -> empty ?



----------------------------------------------------------------------
 Raymond - 01-31-06 09:48 
----------------------------------------------------------------------
It seem that au88x0 is the only driver which use
snd_pcm_hw_constraint_pow2()

	/* Force equal size periods */
	if ((err =
	     snd_pcm_hw_constraint_integer(runtime,
					   SNDRV_PCM_HW_PARAM_PERIODS)) < 0)
		return err;
	/* Avoid PAGE_SIZE boundary to fall inside of a period. */
	if ((err =
	     snd_pcm_hw_constraint_pow2(runtime, 0,
					SNDRV_PCM_HW_PARAM_PERIOD_BYTES)) < 0)
		return err;



----------------------------------------------------------------------
 perex - 01-31-06 10:19 
----------------------------------------------------------------------
Yes and no. It's combination pow2 and periods == integer issue. If the
buffer size is 24000 and period size is 2048, then 24000 / 2048 = 11.7188
which is not integer value and then configuration fails.

In this case depends on the parameter order. Or a better fix maybe to
describe that buffer_size must be N * period_size with pow2 restriction
(create a list with all combinations).

I've tried to add a workaround to snd_pcm_set_params() to CVS, but it does
not prevent other apps using the hw_params ALSA API directly to fail.

----------------------------------------------------------------------
 perex - 01-31-06 10:26 
----------------------------------------------------------------------
To be sure: I'm talking about SNDRV_PCM_HW_PARAM_BUFFER_BYTES restriction.
See pci/emu10k1/emupcm.c code how you can use the
snd_pcm_hw_constraint_list() for this parameter.



Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-07-06 05:10 Raymond        New Issue                                    
01-09-06 15:19 Raymond        Note Added: 0007537                          
01-19-06 15:04 Raymond        Note Deleted: 0007537                        
01-19-06 15:36 Raymond        Note Added: 0007721                          
01-28-06 07:58 Raymond        Note Added: 0007828                          
01-28-06 07:58 Raymond        Note Deleted: 0007721                        
01-30-06 18:46 Raymond        Note Added: 0007840                          
01-31-06 03:15 Raymond        Note Added: 0007844                          
01-31-06 06:41 Raymond        Note Edited: 0007840                         
01-31-06 07:03 Raymond        Note Edited: 0007840                         
01-31-06 07:08 Raymond        Note Edited: 0007840                         
01-31-06 07:11 Raymond        Note Edited: 0007840                         
01-31-06 08:31 Raymond        Note Edited: 0007840                         
01-31-06 09:48 Raymond        Note Edited: 0007844                         
01-31-06 10:19 perex          Note Added: 0007845                          
01-31-06 10:26 perex          Note Added: 0007847                          
01-31-06 10:26 perex          Note Edited: 0007847                         
01-31-06 10:48 perex          Project                  ALSA - lib => ALSA -
driver
01-31-06 10:49 perex          Category                 0_general => PCI - au88x0
01-31-06 10:49 perex          Summary                  simple PCM helper
function => au88x0 PCM configuration problem - buffer_size constraint
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
