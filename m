From: Daniel Mack <daniel@caiaq.de>
Subject: Re: some questions regarding multichannel devices
Date: Mon, 23 Jan 2006 13:35:27 +0100
Message-ID: <B3B8437F-3C75-479C-9F0B-0C5DB07C1E52@caiaq.de>
References: <43E897D5-9150-4960-8946-F6760B627283@caiaq.de> <1137970009.1354.2.camel@mindpipe> <F3BA2D81-AA5D-4428-B2E9-82F8B52B8193@caiaq.de> <1137974965.1354.12.camel@mindpipe>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1137974965.1354.12.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Lee,

On Jan 23, 2006, at 1:09 AM, Lee Revell wrote:
> Look at some existing drivers for details or the "Writing an ALSA
> driver" document.

I read that. But besides the fact that it seems to be somewhat
outdated ('struct snd_pcm' vs. 'snd_pcm_t' confusion all over
the place), I couldn't find this issue explained. Thanks for
the hint.

> You have to use "aplay -d plughw:0", not "aplay -d hw:0".

I guess you mean '-D', not '-d'? Unfortunately, This also does
not help. I still get:

$ aplay -D plughw:0 test.wav
Playing WAVE 'test.wav' : Signed 16 bit Little Endian, Rate 44100 Hz,  
Stereo
aplay: set_params:935: Unable to install hw params:
ACCESS:  RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 32
CHANNELS: 2
RATE: 44100
PERIOD_TIME: (46439 46440)
PERIOD_SIZE: 2048
PERIOD_BYTES: 8192
PERIODS: 4
BUFFER_TIME: (185759 185760)
BUFFER_SIZE: 8192
BUFFER_BYTES: 32768
TICK_TIME: 4000

and I suspect the S16_LE to be the reason. My snd_pcm_hardware_t looks
like this:

{
         .info           = (SNDRV_PCM_INFO_MMAP |  
SNDRV_PCM_INFO_DOUBLE | SNDRV_PCM_INFO_INTERLEAVED |
                            SNDRV_PCM_INFO_BLOCK_TRANSFER),
         .formats        = SNDRV_PCM_FMTBIT_S24_BE |  
SNDRV_PCM_FMTBIT_S16_BE,
         .rates          = (SNDRV_PCM_RATE_44100 |  
SNDRV_PCM_RATE_48000 |
                            SNDRV_PCM_RATE_96000 |  
SNDRV_PCM_RATE_192000),
         .rate_min       = 44100,
         .rate_max       = 192000,
         .channels_min   = 2,
         .channels_max   = 2,
         .buffer_bytes_max = 32768,
         .period_bytes_min = 4096,
         .period_bytes_max = 32768,
         .periods_min    = 1,
         .periods_max    = 1024,
};

I have *no* ~/.asoundrc and no special entries about my hardware in
/etc/asound* or /usr/share/alsa/*/*.

What do I have to do to get the glue logic working?

Greets,
Daniel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
