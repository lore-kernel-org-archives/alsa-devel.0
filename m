From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: usb quattro
Date: Thu, 05 Sep 2002 00:26:37 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D76262D.7050801@boosthardware.com>
References: <3D761979.5050707@boosthardware.com>	<s5hn0qx6clp.wl@alsa2.suse.de>	<3D761DED.2020108@boosthardware.com> <s5hlm6h6byu.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

I changed it to this (very small change).

> 
> well, just write a few codes...
> 
> #include <alsa/asoundlib.h>
> 
> int main()
> {
> 	snd_pcm_t *pcm;
> 	int err;
> 	snd_pcm_hw_params_t hw; <<<<----
> 
> 	err = snd_pcm_open(&pcm, "hw:2,1", SND_PCM_STREAM_PLAYBACK, 0);
> 	snd_pcm_hw_params_alloca(&hw);
> 	err = snd_pcm_hw_params_any(pcm, hw);
> 	err = snd_pcm_hw_params_set_access(pcm, hw, SND_PCM_ACCESS_RW_INTERLEAVED);
> 	err = snd_pcm_hw_params_set_format(pcm, hw, SND_PCM_FORMAT_S16_LE);
> 	err = snd_pcm_hw_params_set_rate(pcm, hw, 48000, 0);
> 	err = snd_pcm_hw_params_set_channels(pcm, hw, 2);
> 	err = snd_pcm_hw_params_set_period_size(pcm, hw, 512, 0);
> 	err = snd_pcm_hw_params_set_buffer_size(pcm, hw, 1024, 0); <<<<----
> 	err = snd_pcm_hw_params(pcm, hw);
> 	return err;
> }
> 
> 
> (not tested at all ;)
> 
> 
> Takashi
> 
> 

It doesn't quite compile.

----
#gcc -c -o qinit qinit.c
qinit.c: In function `main':
qinit.c:7: storage size of `hw' isn't known
qinit.c:17: too many arguments to function 
`snd_pcm_hw_params_set_buffer_size'
----

-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.boosthardware.com/LAU/guide/
========================================

"Um...symbol_get and symbol_put... They're
kindof like does anyone remember like get_symbol
and put_symbol I think we used to have..."
- Rusty Russell in his talk on the module subsystem



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
