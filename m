From: Philip Prindeville <philipp_subx@redfish-solutions.com>
Subject: Re: Fixes for identifying VT1617 codec and MSI-7142
 mobo
Date: Fri, 12 Aug 2005 11:08:17 -0600
Message-ID: <42FCD781.3070306@redfish-solutions.com>
References: <42F655E2.5040504@redfish-solutions.com>	<20050807192732.GA3079@procyon.home>	<42F78569.5070604@redfish-solutions.com>	<s5hmzns1iud.wl%tiwai@suse.de>	<42F8F69D.2050302@redfish-solutions.com>	<s5hpssk69ge.wl%tiwai@suse.de>	<42FBA554.3040604@redfish-solutions.com>	<s5h1x4z5ic1.wl%tiwai@suse.de> <s5hzmrn43d1.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hzmrn43d1.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Well, this is what I get when I try the patch:

[root@media ~]# ./foo
Playing WAVE '/usr/share/system-config-soundcard/sound-sample.wav' :
Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
Warning: rate is not accurate (requested = 44100Hz, got = 48000Hz)
please, try the plug plugin (-Dplug:spdif)
Hooks PCM
Its setup is:
stream : PLAYBACK
access : RW_INTERLEAVED
format : S16_LE
subformat : STD
channels : 2
rate : 48000
exact rate : 48000 (48000/1)
msbits : 16
buffer_size : 16384
period_size : 4096
period_time : 85333
tick_time : 1000
tstamp_mode : NONE
period_step : 1
sleep_min : 0
avail_min : 4096
xfer_align : 4096
start_threshold : 16384
stop_threshold : 16384
silence_threshold: 0
silence_size : 0
boundary : 4611686018427387904
Slave: Hardware PCM card 0 'VIA 8237' device 0 subdevice 3

Its setup is:
stream : PLAYBACK
access : RW_INTERLEAVED
format : S16_LE
subformat : STD
channels : 2
rate : 48000
exact rate : 48000 (48000/1)
msbits : 16
buffer_size : 16384
period_size : 4096
period_time : 85333
tick_time : 1000
tstamp_mode : NONE
period_step : 1
sleep_min : 0
avail_min : 4096
xfer_align : 4096
start_threshold : 16384
stop_threshold : 16384
silence_threshold: 0
silence_size : 0
boundary : 4611686018427387904

access: RW_INTERLEAVED
format: S16_LE
subformat: STD
channels: 2
rate: 48000 (48000/1)
period_size: 4096
buffer_size: 16384
tick_time: 1000
[root@media ~]#


I also noticed that it sounds like the first 200ms or so of sound is
being dropped consistently...

-Philip



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
