From: yan hang fai <hfyan0@ie.cuhk.edu.hk>
Subject: Newbie compile problem
Date: Fri, 4 Oct 2002 10:41:34 +0800 (HKT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.10.10210041040540.12173-100000@iesun57>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello
     I am a newbie in alsa development, so please bear with me :)
     I would like to write a simple audio player using the ALSA library.
     Currently I have got the three ALSA packages (driver, lib, util)
  installed. I can use ALSA to output sound, like when i'm using xmms or
  playing quake 2. However what I want to do is not just to use the ALSA
  drivers, but to write a simple audio player using its library. I cannot
  even compile the demo program supplied by the alsa how-to.   I have
  included <alsa/asoundlib.h> , but compiler said it could not be found. I
  searched through my linux system and found the .h file in
  sys/asoundlib.h, so i included that and tried again. Now that asoundlib
  could be found but i got
  mplay.c: In function `int main(int, char **)':
  mplay.c:14: `snd_pcm_hw_params_t' undeclared (first use this function)
  mplay.c:14: (Each undeclared identifier is reported only once
      mplay.c:14: for each function it appears in.)
  mplay.c:14: `hw_params' undeclared (first use this function)
  mplay.c:16: `SND_PCM_STREAM_PLAYBACK' undeclared (first use this
function)
  mplay.c:16: passing `char *' to argument 2 of `snd_pcm_open(snd_pcm_t
**, int, int, int)' lacks a cast
  mplay.c:23: implicit declaration of function `int
snd_pcm_hw_params_malloc(...)'
  mplay.c:29: implicit declaration of function `int
snd_pcm_hw_params_any(...)'
  mplay.c:35: `SND_PCM_ACCESS_RW_INTERLEAVED' undeclared (first use this
function)
  mplay.c:35: implicit declaration of function `int
snd_pcm_hw_params_set_access(...)'
  mplay.c:41: `SND_PCM_FORMAT_S16_LE' undeclared (first use this function)
  mplay.c:41: implicit declaration of function `int
snd_pcm_hw_params_set_format(...)'
  mplay.c:47: implicit declaration of function `int
snd_pcm_hw_params_set_rate_near(...)'
  mplay.c:53: implicit declaration of function `int
snd_pcm_hw_params_set_channels(...)'
  mplay.c:59: implicit declaration of function `int
snd_pcm_hw_params(...)'
  mplay.c:65: implicit declaration of function `int
snd_pcm_hw_params_free(...)'
  mplay.c:67: implicit declaration of function `int snd_pcm_prepare(...)'
  mplay.c:74: implicit declaration of function `int snd_pcm_writei(...)'
  make: *** [mplay] Error 1


  Could anyone tell me what's missing?  Thank You Very Much
  PS: i've put -lasound but still get the same result





-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
