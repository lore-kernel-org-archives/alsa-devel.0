From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: hdsp vs 16bit vs dmix
Date: Fri, 09 Jan 2004 00:49:34 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FFD7C0E.5000505@boosthardware.com>
References: <3FFC41E9.3050501@boosthardware.com> <s5hn08yznzf.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

Takashi Iwai wrote:
> At Thu, 08 Jan 2004 02:29:13 +0900,
> Patrick Shirkey wrote:
> 
>>I am seeing strange things happen while using the hdsp and dmix plugin 
>>and aplay as a test app.
>>
>>JACK works perfectly.
>>
>>I can get sound from aplay if I use this commandline:
>>
>>aplay -f cd -D plughw audio.wav
>>Playing WAVE 'audio.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, 
>>Stereo
>>underrun!!! (at least 40.147 ms long)
>>underrun!!! (at least 86.223 ms long)
>>underrun!!! (at least 145.116 ms long)
>>underrun!!! (at least 79.109 ms long)
>>underrun!!! (at least 248.555 ms long)
>>underrun!!! (at least 180.442 ms long)
>>underrun!!! (at least 96.117 ms long)
>>Aborted by signal Interrupt...	
>>
>>But I get an xrun every second or so which makes the card useless for 
>>native alsa apps .
> 
> 
> i'm not sure which plugin plays wrong yet.
> 
> run aplay with -v option and see which plugins and what configurations
> are used.  for example, if the native hardware requires 32bit samples,
> prepare 32bit samples WAV instead of 16bit, and reduce the plugin.
> i don't think the rate conversion is used, so the plugins are linear,
> route, and copy plugins.
> 
> my rough guess is the copy plugin.  try aplay -M option, so that mmap
> mode is used.
> 

IMO the test case should be a 16bit file because this is the CD standard.

-------
  aplay -v -M -f cd -D plughw audio.wav
Playing WAVE 'audio.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, 
Stereo
Plug PCM: Route conversion PCM (sformat=S32_LE)
Transformation table:
0 <- 0
1 <- 1
2 <- none
3 <- none
4 <- none
5 <- none
6 <- none
7 <- none
8 <- none
9 <- none
10 <- none
11 <- none
12 <- none
13 <- none
14 <- none
15 <- none
16 <- none
17 <- none
Its setup is:
stream       : PLAYBACK
access       : MMAP_INTERLEAVED
format       : S16_LE
subformat    : STD
channels     : 2
rate         : 44100
exact rate   : 44100 (44100/1)
msbits       : 16
buffer_size  : 8192
period_size  : 4096
period_time  : 92879
tick_time    : 10000
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 0
avail_min    : 4096
xfer_align   : 4096
start_threshold  : 8192
stop_threshold   : 8192
silence_threshold: 0
silence_size : 0
boundary     : 1073741824
Slave: Hardware PCM card 0 'Hammerfall DSP' device 0 subdevice 0

Its setup is:
stream       : PLAYBACK
access       : MMAP_NONINTERLEAVED
format       : S32_LE
subformat    : STD
channels     : 18
rate         : 44100
exact rate   : 44100 (44100/1)
msbits       : 24
buffer_size  : 8192
period_size  : 4096
period_time  : 92879
tick_time    : 10000
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 0
avail_min    : 4096
xfer_align   : 4096
start_threshold  : 8192
stop_threshold   : 8192
silence_threshold: 0
silence_size : 0
boundary     : 1073741824
underrun!!! (at least 683.032 ms long)
Status:
state       : XRUN
trigger_time: 1073628220.377968000
tstamp      : 1073628221.60968000
delay       : 0
avail       : 8192
avail_max   : 8192
underrun!!! (at least 280.077 ms long)
Status:
state       : XRUN
trigger_time: 1073628222.812390000
tstamp      : 1073628223.92462000
delay       : 0
avail       : 8192
avail_max   : 8192
underrun!!! (at least 179.903 ms long)
Status:
state       : XRUN
trigger_time: 1073628224.413069000
tstamp      : 1073628224.592968000
delay       : 0
avail       : 8192
avail_max   : 8192
underrun!!! (at least 143.721 ms long)
Status:
state       : XRUN
trigger_time: 1073628225.185560000
tstamp      : 1073628225.329276000
delay       : 0
avail       : 8192
avail_max   : 8192
underrun!!! (at least 9.202 ms long)
Status:
state       : XRUN
trigger_time: 1073628225.729596000
tstamp      : 1073628225.738793000
delay       : 0
avail       : 8192
avail_max   : 8192
underrun!!! (at least 126.904 ms long)
Status:
state       : XRUN
trigger_time: 1073628227.274901000
tstamp      : 1073628227.401799000
delay       : 0
avail       : 8192
avail_max   : 8192
underrun!!! (at least 225.002 ms long)
Status:
state       : XRUN
trigger_time: 1073628227.898006000
tstamp      : 1073628228.123003000
delay       : 0
avail       : 8192
avail_max   : 8192
underrun!!! (at least 163.350 ms long)
Status:
state       : XRUN
trigger_time: 1073628229.57122000
.
.
.
------

>>
>>  aplay -f cd -D default audio.wav
>>ALSA lib pcm.c:1900:(snd_pcm_open_conf) Cannot open shared library 
>>/usr/lib/alsa-lib/libasound_module_pcm_plughw.so
>>aplay: main:502: audio open error: No such file or directory
> 
> 
> this one is clear.  there is no plughw type.
> it's a defined pcm name.
> 

Hmm. This would appear to be a problem. While I'm not ecouraging people 
to use the hdsp as a standard consumer playback device... My customer 
(who runs windows mostly) is expecting to be able to view videos etc 
with this device simply because he can in his windows env. Should I be 
encouraging him to purchase a second card or can this be fixed using ALSA?




-- 
Patrick Shirkey - Boost Hardware Ltd.
Http://www.boosthardware.com
Http://www.djcj.org - The Linux Audio Users guide
========================================


  Apparently upon the beginning of the barrage, the donkey broke 
discipline and panicked, toppling the cart. At that point, the rockets 
disconnected from the timer, leaving them strewn around the street. 
Tethered to the now toppled cart, the donkey was unable to escape before 
the arrival of U.S. troops.

United Press International
Rockets on donkeys hit major Baghdad sites

By P. MITCHELL PROTHERO
Published 11/21/2003 11:13 AM



-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
