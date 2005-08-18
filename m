From: Philip Prindeville <philipp_subx@redfish-solutions.com>
Subject: Re: Last set of diffs for vt1617, etc.
Date: Wed, 17 Aug 2005 18:06:58 -0600
Message-ID: <4303D122.2090806@redfish-solutions.com>
References: <42FE649B.70805@redfish-solutions.com>	<s5hpssf1i9d.wl%tiwai@suse.de>	<4300E835.5000608@redfish-solutions.com> <s5hd5oexkfo.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hd5oexkfo.wl%tiwai@suse.de>
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

Takashi Iwai wrote:

>At Mon, 15 Aug 2005 13:08:37 -0600,
>Philip Prindeville wrote:
>  
>
>>Even though I've run "aclocal" and "autoconf" previously.  It seems it needs
>>to be run every time???
>>    
>>
>
>No, once you update the tree and run cvscompile, you need to run only
>make after that.
>
>  
>
>> And the version of /usr/share/gettext/gettext.h on
>>FC3 isn't compatible with alsa-utils/include/gettext.h because the N_ macro
>>isn't defined.
>>    
>>
>
>It's not that package.  Did you install gettext-devel.rpm?
>
>  
>
>>Not sure what the first paragraph is about.
>>
>>So I've tried all of this, with the diffs attached, and I still have 
>>problems
>>playing 44.1kHz sound.
>>
>>The next question is, how do we go about figuring out if the codec doesn't
>>like 44.1kHz, or if there really is a bug in 
>>snd_ac97_determine_spdif_rates()?
>>    
>>
>
>Needs a datasheet.
>
>As a test, you can add the line to force to reset the SPDIF_RATES
>value after the line calling snd_ac97_determine_spdif_rates(), and try
>aplay again.
>
>
>  
>
>>Thanks,
>>
>>-Philip
>>
>>P.S. I've turned off "oss" in the diffs just because I'm trying to 
>>isolate ALSA.
>>    
>>
>
>Use "cvs diff".  Also, use -u option to get the unified diff style.
>
>
>Takashi
>  
>

I applied the following "patch":

[root@media alsa]# diff -u alsa-driver/pci/ac97/ac97_codec.c.bak 
alsa-driver/pci/ac97/ac97_codec.c
--- alsa-driver/pci/ac97/ac97_codec.c.bak       2005-08-15 
10:27:41.000000000 -0600
+++ alsa-driver/pci/ac97/ac97_codec.c   2005-08-17 17:57:01.000000000 -0600
@@ -1521,6 +1521,8 @@
                        /* consumer,PCM audio,no copyright,no 
preemphasis,PCM coder,original,48000Hz */
                        snd_ac97_write_cache(ac97, AC97_SPDIF, 0x2a20);
                        ac97->rates[AC97_RATES_SPDIF] = 
snd_ac97_determine_spdif_rates(ac97);
+// tweak...
+ac97->rates[AC97_RATES_SPDIF] = SNDRV_PCM_RATE_44100;
                }
                ac97->spdif_status = SNDRV_PCM_DEFAULT_CON_SPDIF;
        }
[root@media alsa]#

and when I ran "aplay", this is what I got:

[root@media alsa]# aplay -v -D spdif 
/usr/share/system-config-soundcard/sound-sample.wav
Playing WAVE '/usr/share/system-config-soundcard/sound-sample.wav' : 
Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
Hooks PCM
Its setup is:
stream       : PLAYBACK
access       : RW_INTERLEAVED
format       : S16_LE
subformat    : STD
channels     : 2
rate         : 44100
exact rate   : 44100 (44100/1)
msbits       : 16
buffer_size  : 16384
period_size  : 4096
period_time  : 92879
tick_time    : 1000
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 0
avail_min    : 4096
xfer_align   : 4096
start_threshold  : 16384
stop_threshold   : 16384
silence_threshold: 0
silence_size : 0
boundary     : 4611686018427387904
Slave: Hardware PCM card 0 'VIA 8237' device 0 subdevice 3

Its setup is:
stream       : PLAYBACK
access       : RW_INTERLEAVED
format       : S16_LE
subformat    : STD
channels     : 2
rate         : 44100
exact rate   : 44100 (44100/1)
msbits       : 16
buffer_size  : 16384
period_size  : 4096
period_time  : 92879
tick_time    : 1000
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 0
avail_min    : 4096
xfer_align   : 4096
start_threshold  : 16384
stop_threshold   : 16384
silence_threshold: 0
silence_size : 0
boundary     : 4611686018427387904
[root@media alsa]#

However my receiver says "PCM [48kHz]" in the LED display.

I'm wondering if there might be other things that need to be changed
as well...  Config files?

-Philip



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
