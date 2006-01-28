From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001724]: simple PCM helper function
Date: Sat, 28 Jan 2006 07:58:34 +0100
Message-ID: <bc61cc2a1a075c13a206db9cf9e979dc@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7F17A147
	for <alsa-devel@alsa-project.org>; Sat, 28 Jan 2006 07:58:34 +0100 (MET)
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1724> 
======================================================================
Reported By:                Raymond
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1724
Category:                   0_general
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             01-07-2006 05:10 CET
Last Modified:              01-28-2006 07:58 CET
======================================================================
Summary:                    simple PCM helper function
Description: 
/cvs/alsa-lib/test/pcm_min

ALSA lib pcm.c:7127:(snd_pcm_set_params) Unable to set buffer time
(latency) 500000 for PLAYBACK: Invalid argument
Playback open error: Invalid argument

sound card is au8830, the au88x0 driver only accept period size in power
of 2.
======================================================================

----------------------------------------------------------------------
 Raymond - 01-19-06 15:36 
----------------------------------------------------------------------
How do the latency related to period size, rate and channels ?

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

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-07-06 05:10 Raymond        New Issue                                    
01-09-06 15:19 Raymond        Note Added: 0007537                          
01-19-06 15:04 Raymond        Note Deleted: 0007537                        
01-19-06 15:36 Raymond        Note Added: 0007721                          
01-28-06 07:58 Raymond        Note Added: 0007828                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
