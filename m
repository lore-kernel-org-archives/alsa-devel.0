From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: usb quattro
Date: Thu, 05 Sep 2002 01:35:39 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D76365B.3080003@boosthardware.com>
References: <3D761979.5050707@boosthardware.com>	<s5hn0qx6clp.wl@alsa2.suse.de>	<3D761DED.2020108@boosthardware.com>	<s5hlm6h6byu.wl@alsa2.suse.de>	<3D76262D.7050801@boosthardware.com> <s5hk7m169jt.wl@alsa2.suse.de>
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

Sorry if this is stupid, I'm not a trained programmer. I get this now.

Do you know how to fix it?

# gcc qinit.c
/tmp/cco2X9S0.o: In function `main':
/tmp/cco2X9S0.o(.text+0x17): undefined reference to `snd_pcm_open'
/tmp/cco2X9S0.o(.text+0x22): undefined reference to 
`snd_pcm_hw_params_sizeof'
/tmp/cco2X9S0.o(.text+0x3d): undefined reference to 
`snd_pcm_hw_params_sizeof'
/tmp/cco2X9S0.o(.text+0x5c): undefined reference to `snd_pcm_hw_params_any'
/tmp/cco2X9S0.o(.text+0x72): undefined reference to 
`snd_pcm_hw_params_set_access'
/tmp/cco2X9S0.o(.text+0x88): undefined reference to 
`snd_pcm_hw_params_set_format'
/tmp/cco2X9S0.o(.text+0xa0): undefined reference to 
`snd_pcm_hw_params_set_rate'
/tmp/cco2X9S0.o(.text+0xb6): undefined reference to 
`snd_pcm_hw_params_set_channels'
/tmp/cco2X9S0.o(.text+0xce): undefined reference to 
`snd_pcm_hw_params_set_period_size'
/tmp/cco2X9S0.o(.text+0xe7): undefined reference to 
`snd_pcm_hw_params_set_buffer_size'
/tmp/cco2X9S0.o(.text+0xfb): undefined reference to `snd_pcm_hw_params'
collect2: ld returned 1 exit status


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
