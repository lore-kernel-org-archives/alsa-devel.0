From: John Anderson <panic-alsa@semiosix.com>
Subject: Problems with USB driver and Swissonic USB Studio
Date: 19 Jul 2002 12:20:21 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1027074021.1203.15.camel@groovious>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I'm using a Swissonic USB Studio.

With an older CVS version (from around 29th June), playback and capture
were pretty much OK, except for a ticking (the repetitive peaks issue?)
and some noise. Using the latest CVS version:

aplay -D studio /mnt/spare/music/test.wav 
Playing WAVE '/mnt/spare/music/test.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
aplay: set_params:737: Broken configuration for this PCM: no configurations available

ecasound and jackd die with less descriptive error messages.

The error comes from a call

err = snd_pcm_hw_params_any(handle, params);

on line 735 of aplay.c

The output from /proc/asound/card1/stream0 is

Creative Technology Ltd Creative USB Speaker : USB Audio

Playback:
  Status: Stop
  Altset 1
    Format: U8
    Channels: 1
    Endpoint: 4 OUT (ADAPTIVE)
    Rates: 4990 - 55010 (continous)
  Altset 2
    Format: U8
    Channels: 2
    Endpoint: 4 OUT (ADAPTIVE)
    Rates: 4990 - 55010 (continous)
  Altset 3
    Format: S16_LE
    Channels: 1
    Endpoint: 4 OUT (ADAPTIVE)
    Rates: 4990 - 55010 (continous)
  Altset 4
    Format: S16_LE
    Channels: 2
    Endpoint: 4 OUT (ADAPTIVE)
    Rates: 4990 - 55010 (continous)
  Altset 5
    Format: STD
    Channels: 1
    Endpoint: 4 OUT (ADAPTIVE)
    Rates: 4990 - 55010 (continous)
  Altset 6
    Format: STD
    Channels: 2
    Endpoint: 4 OUT (ADAPTIVE)
    Rates: 4990 - 55010 (continous)

Capture:
  Status: Stop
  Altset 1
    Format: U8
    Channels: 1
    Endpoint: 5 IN (ASYNC)
    Rates: 4000, 5512, 6000, 8000, 11025, 12000, 16000, 22050, 24000, 32000, 44100, 48000
  Altset 2
    Format: U8
    Channels: 2
    Endpoint: 5 IN (ASYNC)
    Rates: 4000, 5512, 6000, 8000, 11025, 12000, 16000, 22050, 24000, 32000, 44100, 48000
  Altset 3
    Format: S16_LE
    Channels: 1
    Endpoint: 5 IN (ASYNC)
    Rates: 4000, 5512, 6000, 8000, 11025, 12000, 16000, 22050, 24000, 32000, 44100, 48000
  Altset 4
    Format: S16_LE
    Channels: 2
    Endpoint: 5 IN (ASYNC)
    Rates: 4000, 5512, 6000, 8000, 11025, 12000, 16000, 22050, 24000, 32000, 44100, 48000
  Altset 5
    Format: STD
    Channels: 1
    Endpoint: 5 IN (ASYNC)
    Rates: 4000, 5512, 6000, 8000, 11025, 12000, 16000, 22050, 24000, 32000, 44100, 48000
  Altset 6
    Format: STD
    Channels: 2
    Endpoint: 5 IN (ASYNC)
    Rates: 4000, 5512, 6000, 8000, 11025, 12000, 16000, 22050, 24000, 32000, 44100, 48000

Any help much appreciated.

BTW, what does Format: STD mean? 

bye
John

-- 

Freelance DataDreamer http://www.semiosix.com
Good Things require a precise lack of control



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
