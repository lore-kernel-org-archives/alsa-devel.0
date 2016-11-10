From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 16/30] ALSA: doc: ReSTize timestamping document
Date: Thu, 10 Nov 2016 22:06:27 +0100
Message-ID: <20161110210641.5907-17-tiwai@suse.de>
References: <20161110210641.5907-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 6CA392673BD
 for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2016 22:06:55 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id B113AADE6
 for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2016 21:06:53 +0000 (UTC)
In-Reply-To: <20161110210641.5907-1-tiwai@suse.de>
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

A simple conversion from a plain text file.
Put to designs subdirectory.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 Documentation/sound/designs/index.rst              |   1 +
 .../timestamping.txt => designs/timestamping.rst}  | 143 ++++++++++++---------
 2 files changed, 80 insertions(+), 64 deletions(-)
 rename Documentation/sound/{alsa/timestamping.txt => designs/timestamping.rst} (56%)

diff --git a/Documentation/sound/designs/index.rst b/Documentation/sound/designs/index.rst
index f7ca11307033..798b1a44bbbd 100644
--- a/Documentation/sound/designs/index.rst
+++ b/Documentation/sound/designs/index.rst
@@ -7,6 +7,7 @@ Designs and Implementations
    control-names
    channel-mapping-api
    compress-offload
+   timestamping
    procfile
    powersave
    oss-emulation
diff --git a/Documentation/sound/alsa/timestamping.txt b/Documentation/sound/designs/timestamping.rst
similarity index 56%
rename from Documentation/sound/alsa/timestamping.txt
rename to Documentation/sound/designs/timestamping.rst
index 9d579aefbffd..2b0fff503415 100644
--- a/Documentation/sound/alsa/timestamping.txt
+++ b/Documentation/sound/designs/timestamping.rst
@@ -1,18 +1,22 @@
+=====================
+ALSA PCM Timestamping
+=====================
+
 The ALSA API can provide two different system timestamps:
 
 - Trigger_tstamp is the system time snapshot taken when the .trigger
-callback is invoked. This snapshot is taken by the ALSA core in the
-general case, but specific hardware may have synchronization
-capabilities or conversely may only be able to provide a correct
-estimate with a delay. In the latter two cases, the low-level driver
-is responsible for updating the trigger_tstamp at the most appropriate
-and precise moment. Applications should not rely solely on the first
-trigger_tstamp but update their internal calculations if the driver
-provides a refined estimate with a delay.
+  callback is invoked. This snapshot is taken by the ALSA core in the
+  general case, but specific hardware may have synchronization
+  capabilities or conversely may only be able to provide a correct
+  estimate with a delay. In the latter two cases, the low-level driver
+  is responsible for updating the trigger_tstamp at the most appropriate
+  and precise moment. Applications should not rely solely on the first
+  trigger_tstamp but update their internal calculations if the driver
+  provides a refined estimate with a delay.
 
 - tstamp is the current system timestamp updated during the last
-event or application query.
-The difference (tstamp - trigger_tstamp) defines the elapsed time.
+  event or application query.
+  The difference (tstamp - trigger_tstamp) defines the elapsed time.
 
 The ALSA API provides two basic pieces of information, avail
 and delay, which combined with the trigger and current system
@@ -22,15 +26,15 @@ the ring buffer and the amount of queued samples.
 The use of these different pointers and time information depends on
 the application needs:
 
-- 'avail' reports how much can be written in the ring buffer
-- 'delay' reports the time it will take to hear a new sample after all
-queued samples have been played out.
+- ``avail`` reports how much can be written in the ring buffer
+- ``delay`` reports the time it will take to hear a new sample after all
+  queued samples have been played out.
 
 When timestamps are enabled, the avail/delay information is reported
 along with a snapshot of system time. Applications can select from
-CLOCK_REALTIME (NTP corrections including going backwards),
-CLOCK_MONOTONIC (NTP corrections but never going backwards),
-CLOCK_MONOTIC_RAW (without NTP corrections) and change the mode
+``CLOCK_REALTIME`` (NTP corrections including going backwards),
+``CLOCK_MONOTONIC`` (NTP corrections but never going backwards),
+``CLOCK_MONOTIC_RAW`` (without NTP corrections) and change the mode
 dynamically with sw_params
 
 
@@ -38,17 +42,18 @@ The ALSA API also provide an audio_tstamp which reflects the passage
 of time as measured by different components of audio hardware.  In
 ascii-art, this could be represented as follows (for the playback
 case):
+::
 
+  --------------------------------------------------------------> time
+    ^               ^              ^                ^           ^
+    |               |              |                |           |
+   analog         link            dma              app       FullBuffer
+   time           time           time              time        time
+    |               |              |                |           |
+    |< codec delay >|<--hw delay-->|<queued samples>|<---avail->|
+    |<----------------- delay---------------------->|           |
+                                   |<----ring buffer length---->|
 
---------------------------------------------------------------> time
-  ^               ^              ^                ^           ^
-  |               |              |                |           |
- analog         link            dma              app       FullBuffer
- time           time           time              time        time
-  |               |              |                |           |
-  |< codec delay >|<--hw delay-->|<queued samples>|<---avail->|
-  |<----------------- delay---------------------->|           |
-			         |<----ring buffer length---->|
 
 The analog time is taken at the last stage of the playback, as close
 as possible to the actual transducer
@@ -113,11 +118,11 @@ audio applications...
 
 Due to the varied nature of timestamping needs, even for a single
 application, the audio_tstamp_config can be changed dynamically. In
-the STATUS ioctl, the parameters are read-only and do not allow for
+the ``STATUS`` ioctl, the parameters are read-only and do not allow for
 any application selection. To work around this limitation without
-impacting legacy applications, a new STATUS_EXT ioctl is introduced
+impacting legacy applications, a new ``STATUS_EXT`` ioctl is introduced
 with read/write parameters. ALSA-lib will be modified to make use of
-STATUS_EXT and effectively deprecate STATUS.
+``STATUS_EXT`` and effectively deprecate ``STATUS``.
 
 The ALSA API only allows for a single audio timestamp to be reported
 at a time. This is a conscious design decision, reading the audio
@@ -135,36 +140,42 @@ the hardware, there is a risk of misalignment with the avail and delay
 information. To make sure applications are not confused, a
 driver_timestamp field is added in the snd_pcm_status structure; this
 timestamp shows when the information is put together by the driver
-before returning from the STATUS and STATUS_EXT ioctl. in most cases
+before returning from the ``STATUS`` and ``STATUS_EXT`` ioctl. in most cases
 this driver_timestamp will be identical to the regular system tstamp.
 
 Examples of typestamping with HDaudio:
 
 1. DMA timestamp, no compensation for DMA+analog delay
-$ ./audio_time  -p --ts_type=1
-playback: systime: 341121338 nsec, audio time 342000000 nsec, 	systime delta -878662
-playback: systime: 426236663 nsec, audio time 427187500 nsec, 	systime delta -950837
-playback: systime: 597080580 nsec, audio time 598000000 nsec, 	systime delta -919420
-playback: systime: 682059782 nsec, audio time 683020833 nsec, 	systime delta -961051
-playback: systime: 852896415 nsec, audio time 853854166 nsec, 	systime delta -957751
-playback: systime: 937903344 nsec, audio time 938854166 nsec, 	systime delta -950822
+::
+
+  $ ./audio_time  -p --ts_type=1
+  playback: systime: 341121338 nsec, audio time 342000000 nsec, 	systime delta -878662
+  playback: systime: 426236663 nsec, audio time 427187500 nsec, 	systime delta -950837
+  playback: systime: 597080580 nsec, audio time 598000000 nsec, 	systime delta -919420
+  playback: systime: 682059782 nsec, audio time 683020833 nsec, 	systime delta -961051
+  playback: systime: 852896415 nsec, audio time 853854166 nsec, 	systime delta -957751
+  playback: systime: 937903344 nsec, audio time 938854166 nsec, 	systime delta -950822
 
 2. DMA timestamp, compensation for DMA+analog delay
-$ ./audio_time  -p --ts_type=1 -d
-playback: systime: 341053347 nsec, audio time 341062500 nsec, 	systime delta -9153
-playback: systime: 426072447 nsec, audio time 426062500 nsec, 	systime delta 9947
-playback: systime: 596899518 nsec, audio time 596895833 nsec, 	systime delta 3685
-playback: systime: 681915317 nsec, audio time 681916666 nsec, 	systime delta -1349
-playback: systime: 852741306 nsec, audio time 852750000 nsec, 	systime delta -8694
+::
+
+  $ ./audio_time  -p --ts_type=1 -d
+  playback: systime: 341053347 nsec, audio time 341062500 nsec, 	systime delta -9153
+  playback: systime: 426072447 nsec, audio time 426062500 nsec, 	systime delta 9947
+  playback: systime: 596899518 nsec, audio time 596895833 nsec, 	systime delta 3685
+  playback: systime: 681915317 nsec, audio time 681916666 nsec, 	systime delta -1349
+  playback: systime: 852741306 nsec, audio time 852750000 nsec, 	systime delta -8694
 
 3. link timestamp, compensation for DMA+analog delay
-$ ./audio_time  -p --ts_type=2 -d
-playback: systime: 341060004 nsec, audio time 341062791 nsec, 	systime delta -2787
-playback: systime: 426242074 nsec, audio time 426244875 nsec, 	systime delta -2801
-playback: systime: 597080992 nsec, audio time 597084583 nsec, 	systime delta -3591
-playback: systime: 682084512 nsec, audio time 682088291 nsec, 	systime delta -3779
-playback: systime: 852936229 nsec, audio time 852940916 nsec, 	systime delta -4687
-playback: systime: 938107562 nsec, audio time 938112708 nsec, 	systime delta -5146
+::
+
+  $ ./audio_time  -p --ts_type=2 -d
+  playback: systime: 341060004 nsec, audio time 341062791 nsec, 	systime delta -2787
+  playback: systime: 426242074 nsec, audio time 426244875 nsec, 	systime delta -2801
+  playback: systime: 597080992 nsec, audio time 597084583 nsec, 	systime delta -3591
+  playback: systime: 682084512 nsec, audio time 682088291 nsec, 	systime delta -3779
+  playback: systime: 852936229 nsec, audio time 852940916 nsec, 	systime delta -4687
+  playback: systime: 938107562 nsec, audio time 938112708 nsec, 	systime delta -5146
 
 Example 1 shows that the timestamp at the DMA level is close to 1ms
 ahead of the actual playback time (as a side time this sort of
@@ -181,20 +192,24 @@ shows how compensating for the delay exposes a 1ms accuracy (due to
 the use of the frame counter by the driver)
 
 Example 3: DMA timestamp, no compensation for delay, delta of ~5ms
-$ ./audio_time -p -Dhw:1 -t1
-playback: systime: 120174019 nsec, audio time 125000000 nsec, 	systime delta -4825981
-playback: systime: 245041136 nsec, audio time 250000000 nsec, 	systime delta -4958864
-playback: systime: 370106088 nsec, audio time 375000000 nsec, 	systime delta -4893912
-playback: systime: 495040065 nsec, audio time 500000000 nsec, 	systime delta -4959935
-playback: systime: 620038179 nsec, audio time 625000000 nsec, 	systime delta -4961821
-playback: systime: 745087741 nsec, audio time 750000000 nsec, 	systime delta -4912259
-playback: systime: 870037336 nsec, audio time 875000000 nsec, 	systime delta -4962664
+::
+
+  $ ./audio_time -p -Dhw:1 -t1
+  playback: systime: 120174019 nsec, audio time 125000000 nsec, 	systime delta -4825981
+  playback: systime: 245041136 nsec, audio time 250000000 nsec, 	systime delta -4958864
+  playback: systime: 370106088 nsec, audio time 375000000 nsec, 	systime delta -4893912
+  playback: systime: 495040065 nsec, audio time 500000000 nsec, 	systime delta -4959935
+  playback: systime: 620038179 nsec, audio time 625000000 nsec, 	systime delta -4961821
+  playback: systime: 745087741 nsec, audio time 750000000 nsec, 	systime delta -4912259
+  playback: systime: 870037336 nsec, audio time 875000000 nsec, 	systime delta -4962664
 
 Example 4: DMA timestamp, compensation for delay, delay of ~1ms
-$ ./audio_time -p -Dhw:1 -t1 -d
-playback: systime: 120190520 nsec, audio time 120000000 nsec, 	systime delta 190520
-playback: systime: 245036740 nsec, audio time 244000000 nsec, 	systime delta 1036740
-playback: systime: 370034081 nsec, audio time 369000000 nsec, 	systime delta 1034081
-playback: systime: 495159907 nsec, audio time 494000000 nsec, 	systime delta 1159907
-playback: systime: 620098824 nsec, audio time 619000000 nsec, 	systime delta 1098824
-playback: systime: 745031847 nsec, audio time 744000000 nsec, 	systime delta 1031847
+::
+
+  $ ./audio_time -p -Dhw:1 -t1 -d
+  playback: systime: 120190520 nsec, audio time 120000000 nsec, 	systime delta 190520
+  playback: systime: 245036740 nsec, audio time 244000000 nsec, 	systime delta 1036740
+  playback: systime: 370034081 nsec, audio time 369000000 nsec, 	systime delta 1034081
+  playback: systime: 495159907 nsec, audio time 494000000 nsec, 	systime delta 1159907
+  playback: systime: 620098824 nsec, audio time 619000000 nsec, 	systime delta 1098824
+  playback: systime: 745031847 nsec, audio time 744000000 nsec, 	systime delta 1031847
-- 
2.10.2
