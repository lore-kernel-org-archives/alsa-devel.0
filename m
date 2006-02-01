From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001724]: au88x0 PCM configuration problem - buffer_size constraint
Date: Wed, 1 Feb 2006 10:32:28 +0100
Message-ID: <70371f8c2fddf6f9251dac3500419cbd@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E0AA219A
	for <alsa-devel@alsa-project.org>; Wed,  1 Feb 2006 10:32:28 +0100 (MET)
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
Assigned To:                mjander
======================================================================
Project:                    ALSA - driver
Issue ID:                   1724
Category:                   PCI - au88x0
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             01-07-2006 05:10 CET
Last Modified:              02-01-2006 10:32 CET
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
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0001766 jackd : ALSA: cannot set period size to...
======================================================================

----------------------------------------------------------------------
 perex - 02-01-06 07:35 
----------------------------------------------------------------------
The error message should be fixed now. Could you enable RULES_DEBUG to see
what's going wrong?

----------------------------------------------------------------------
 Raymond - 02-01-06 10:32 
----------------------------------------------------------------------
Rule 4 [e1cfb980]: FRAME_BITS = [8 8] -> [8 8]
Rule 7 [e1cfb980]: RATE = [48000 48000] -> [48000 48000]
Rule 9 [e1cfb890]: PERIODS = [6 22] -> empty
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
Rule 0 [e1cfba00]: FORMAT = 300006 -> 300006
Rule 1 [e1cfbb30]: SAMPLE_BITS = [0 4294967295] -> [8 16]
Rule 2 [e1cfb890]: SAMPLE_BITS = [8 16] -> [8 16]
Rule 3 [e1cfb820]: FRAME_BITS = [0 4294967295] -> [8 64]
Rule 4 [e1cfb980]: FRAME_BITS = [8 64] -> [8 64]
Rule 5 [e1cfb980]: FRAME_BITS = [8 64] -> [8 64]
Rule 6 [e1cfb890]: CHANNELS = [1 4] -> [1 4]
Rule 7 [e1cfb980]: RATE = [5000 48000] -> [5000 48000]
Rule 8 [e1cfb980]: RATE = [5000 48000] -> [5000 48000]
Rule 9 [e1cfb890]: PERIODS = [2 32] -> [2 32]
Rule 10 [e1cfb890]: PERIOD_SIZE = [0 4294967295] -> [0 2147483647]
Rule 11 [e1cfb980]: PERIOD_SIZE = [0 2147483647] -> [1 4096]
Rule 12 [e1cfb900]: PERIOD_SIZE = [1 4096] -> [1 4096]
Rule 13 [e1cfb820]: BUFFER_SIZE = [0 4294967295] -> [2 131072]
Rule 14 [e1cfb980]: BUFFER_SIZE = [2 131072] -> [2 65536]
Rule 15 [e1cfb900]: BUFFER_SIZE = [2 65536] -> [2 65536]
Rule 16 [e1cfb900]: PERIOD_BYTES = [1 4096] -> [1 4096]
Rule 17 [e1cfb900]: BUFFER_BYTES = [1 65536] -> [2 65536]
Rule 18 [e1cfb980]: PERIOD_TIME = [0 4294967295] -> (20 819200]
Rule 19 [e1cfb980]: BUFFER_TIME = [0 4294967295] -> (41 13107200]
Rule 20 [e1d007b0]: PERIOD_BYTES = [1 4096] -> [1 4096]
Rule 21 [e1cfbc20]: BUFFER_BYTES = [2 65536] -> [2 65536]
Rule 0 [e1cfba00]: FORMAT = 300006 -> 300006
Rule 2 [e1cfb890]: SAMPLE_BITS = [8 16] -> [8 16]
Rule 4 [e1cfb980]: FRAME_BITS = [8 64] -> [8 64]
Rule 5 [e1cfb980]: FRAME_BITS = [8 64] -> [8 64]
Rule 7 [e1cfb980]: RATE = [5000 48000] -> [5000 48000]
Rule 8 [e1cfb980]: RATE = [5000 48000] -> [5000 48000]
Rule 9 [e1cfb890]: PERIODS = [2 32] -> [2 32]
Rule 10 [e1cfb890]: PERIOD_SIZE = [1 4096] -> [1 4096]
Rule 12 [e1cfb900]: PERIOD_SIZE = [1 4096] -> [1 4096]
Rule 14 [e1cfb980]: BUFFER_SIZE = [2 65536] -> [2 65536]
Rule 15 [e1cfb900]: BUFFER_SIZE = [2 65536] -> [2 65536]
RATE = [48000 48000] -> [48000 48000]
Rule 12 [e1cfb900]: PERIOD_SIZE = [1 4096] -> [1 4096]
Rule 15 [e1cfb900]: BUFFER_SIZE = [2 65536] -> [2 65536]
Rule 18 [e1cfb980]: PERIOD_TIME = (20 819200] -> (20 85334)
Rule 19 [e1cfb980]: BUFFER_TIME = (41 13107200] -> (41 1365334)
Rule 7 [e1cfb980]: RATE = [48000 48000] -> [48000 48000]
Rule 8 [e1cfb980]: RATE = [48000 48000] -> [48000 48000]
Rule 12 [e1cfb900]: PERIOD_SIZE = [1 4096] -> [1 4096]
Rule 15 [e1cfb900]: BUFFER_SIZE = [2 65536] -> [2 65536]
CHANNELS = [1 1] -> [1 1]
Rule 2 [e1cfb890]: SAMPLE_BITS = [8 16] -> [8 16]
Rule 3 [e1cfb820]: FRAME_BITS = [8 64] -> [8 16]
Rule 6 [e1cfb890]: CHANNELS = [1 1] -> [1 1]
Rule 11 [e1cfb980]: PERIOD_SIZE = [1 4096] -> [1 4096]
Rule 14 [e1cfb980]: BUFFER_SIZE = [2 65536] -> [2 65536]
Rule 16 [e1cfb900]: PERIOD_BYTES = [1 4096] -> [1 4096]
Rule 17 [e1cfb900]: BUFFER_BYTES = [2 65536] -> [2 65536]
Rule 2 [e1cfb890]: SAMPLE_BITS = [8 16] -> [8 16]
FORMAT = 0000000000000002 -> 0000000000000002
Rule 1 [e1cfbb30]: SAMPLE_BITS = [8 16] -> [8 8]
Rule 3 [e1cfb820]: FRAME_BITS = [8 16] -> [8 8]
Rule 6 [e1cfb890]: CHANNELS = [1 1] -> [1 1]
Rule 11 [e1cfb980]: PERIOD_SIZE = [1 4096] -> [1 4096]
Rule 14 [e1cfb980]: BUFFER_SIZE = [2 65536] -> [2 65536]
Rule 16 [e1cfb900]: PERIOD_BYTES = [1 4096] -> [1 4096]
Rule 17 [e1cfb900]: BUFFER_BYTES = [2 65536] -> [2 65536]
Rule 0 [e1cfba00]: FORMAT = 2 -> 2
Rule 2 [e1cfb890]: SAMPLE_BITS = [8 8] -> [8 8]
PERIOD_TIME = (42666 42667) -> (42666 42667)
PERIOD_SIZE = [2048 2048] -> [2048 2048]
BUFFER_SIZE = [24000 24000] -> [24000 24000]
Rule 4 [e1cfb980]: FRAME_BITS = [8 8] -> [8 8]
Rule 5 [e1cfb980]: FRAME_BITS = [8 8] -> [8 8]
Rule 7 [e1cfb980]: RATE = [48000 48000] -> [48000 48000]
Rule 8 [e1cfb980]: RATE = [48000 48000] -> [48000 48000]
Rule 9 [e1cfb890]: PERIODS = [2 32] -> empty


alsa-lib/test/pcm_min
ALSA lib pcm.c:7148:(snd_pcm_set_params) Unable to set period time 125000
for PLAYBACK: Invalid argument
Playback open error: Invalid argument

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
01-31-06 11:06 Raymond        Note Added: 0007848                          
01-31-06 13:48 perex          Status                   new => assigned     
01-31-06 13:48 perex          Assigned To               => mjander         
01-31-06 13:49 perex          Relationship added       related to 0001766  
01-31-06 15:59 Raymond        Note Added: 0007852                          
02-01-06 07:35 perex          Note Added: 0007857                          
02-01-06 10:32 Raymond        Note Added: 0007858                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
