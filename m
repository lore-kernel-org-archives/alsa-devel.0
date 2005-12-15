From: Paulo Marcel Coelho Aragao <pmcaragao-ag@yahoo.com>
Subject: Re: Tips on debugging ALSA driver snd_es18xx
Date: Thu, 15 Dec 2005 09:12:13 -0200
Message-ID: <20051215111213.GA3636@cortazar>
References: <20051215013411.GK7983@cortazar> <1134635237.43a128e5e75fa@webmail.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <1134635237.43a128e5e75fa@webmail.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch wrote on Dec, 15:
> > I recently switched from OSS to ALSA and I'm baffled by this: aplay 
> > produces
> > sound when playing wav files, but gxine and xmms produce no sound when
> > playing streaming audio.
> 
> What are the contents of /proc/asound/card0/pcm0p/sub0/hw_params and sw_params
> in either case?

Hey, this is interesting. Thanks for answering. I'm not clear about what this 
means but it feels pointing to a promising direction.

This was curious: the wav files I tried with aplay ended too quickly, so I 
looked for longer ones. My surprise: no sound from the longer ones. It gave me 
the impression to be related to the sound source being coded for 16 or 8-bits, 
if I'm not speaking just plain nonsense. I ran aplay -v which seemed to 
display the same info you asked.

Thanks, Clemens, for taking the time with my predicament
Paulo

PS: Would have at hand a reference to some document that describes 
/proc/asound ?

[SOUND]

aplay -v /usr/share/sounds/KDE_Beep_Honk.wav
--------------------------------------------
Playing WAVE '/usr/share/sounds/KDE_Beep_Honk.wav' : Unsigned 8 bit, Rate 
11127 Hz, Mono
Plug PCM: Rate conversion PCM (11130, sformat=U8)
Its setup is:
stream       : PLAYBACK
access       : RW_INTERLEAVED
format       : U8
subformat    : STD
channels     : 1
rate         : 11127
exact rate   : 11127 (11127/1)
msbits       : 8
buffer_size  : 5564
period_size  : 1391
period_time  : 124977
tick_time    : 1000
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 0
avail_min    : 1391
xfer_align   : 1391
start_threshold  : 5564
stop_threshold   : 5564
silence_threshold: 0
silence_size : 0
boundary     : 1458569216
Slave: Hardware PCM card 0 'ESS AudioDrive ES1879' device 0 subdevice 0

Its setup is:
stream       : PLAYBACK
access       : MMAP_INTERLEAVED
format       : U8
subformat    : STD
channels     : 1
rate         : 11130
exact rate   : 11130.4 (768000/69)
msbits       : 8
buffer_size  : 5567
period_size  : 1391
period_time  : 124977
tick_time    : 1000
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 0
avail_min    : 1391
xfer_align   : 1391
start_threshold  : 5564
stop_threshold   : 5567
silence_threshold: 0
silence_size : 0
boundary     : 1459355648

[NO SOUND]

gxine rtsp://128.59.222.11:554/broadcast/wkcr.rm?cloakport=80,554,7070
----------------------------------------------------------------------
/proc/asound/card0/pcm0p/sub0/hw_params
access: RW_INTERLEAVED
format: S16_LE
subformat: STD
channels: 2
rate: 44100 (793800/18)
period_size: 2048
buffer_size: 16384
tick_time: 1000

/proc/asound/card0/pcm0p/sub0/sw_params
tstamp_mode: NONE
period_step: 1
sleep_min: 0
avail_min: 2048
xfer_align: 1
start_threshold: 2048
stop_threshold: 16384
silence_threshold: 0
silence_size: 0
boundary: 1073741824

xmms http://64.236.34.67:80/stream/1018
---------------------------------------
/proc/asound/card0/pcm0p/sub0/hw_params
access: RW_INTERLEAVED
format: S16_LE
subformat: STD
channels: 2
rate: 44100 (793800/18)
period_size: 2205
buffer_size: 16384
tick_time: 1000

/proc/asound/card0/pcm0p/sub0/sw_params
tstamp_mode: NONE
period_step: 1
sleep_min: 0
avail_min: 2205
xfer_align: 2205
start_threshold: 14179
stop_threshold: 16384
silence_threshold: 0
silence_size: 0
boundary: 1073741824

aplay -v /usr/share/sounds/alsa/Front_Right.wav
-----------------------------------------------
Playing WAVE '/usr/share/sounds/alsa/Front_Right.wav' : Signed 16 bit Little 
Endian, Rate 48000 Hz, Mono
Plug PCM: Hardware PCM card 0 'ESS AudioDrive ES1879' device 0 subdevice 0

Its setup is:
stream       : PLAYBACK
access       : RW_INTERLEAVED
format       : S16_LE
subformat    : STD
channels     : 1
rate         : 48000
exact rate   : 48000 (768000/16)
msbits       : 16
buffer_size  : 24000
period_size  : 6000
period_time  : 125000
tick_time    : 1000
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 0
avail_min    : 6000
xfer_align   : 6000
start_threshold  : 24000
stop_threshold   : 24000
silence_threshold: 0
silence_size : 0
boundary     : 1572864000


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
