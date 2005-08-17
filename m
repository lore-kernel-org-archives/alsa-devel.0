From: Raymond <rayau@netvigator.com>
Subject: Re: Alsa mix in HW
Date: Wed, 17 Aug 2005 20:42:55 +0800
Message-ID: <430330CF.3090006@netvigator.com>
References: <42EBAE72.9090608@e4a.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <42EBAE72.9090608@e4a.it>
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
Cc: openvortex-dev@nongnu.org
List-Id: alsa-devel@alsa-project.org


snd_pcm_hardware_t of the sound cards will need to support

1) Hardware Mixing ( spatializing mono audio stream into 2, 4, 5.1, .. 
speakers

.channels_min  = 1
.formats =  SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_U8

2) Doppler Effect ( Frequency shift by pitch )

.rates = SNDRV_PCM_RATE_CONTINUOUS | SNDRV_PCM_RATE_8000_48000 or 
SNDRV_PCM_RATE_8000_44100

3) Recording API ( full duplex )

4) Mono/Stero Hint ( Playing stereo background music )

.channels_max >= 2

Do anyone have a list of the sound cards ( alsa driver ) which support 
the above features ?


Dino Puller wrote:

> 
> Hi all,
>    here http://dino.e4a.it/openal-alsa you can find an implementation of 
> OpenAL library that can mix sources in HW. It's based on C.J.Purnell 
> openal-alsa-emu10k1 but in this one i've replaced all code relative to 
> emu10k1 processor, with a more compatible one, so now it's should works 
> with every sound card that supports multiple sub streams. It's not based 
> on OpenAL official tree because it's play too much with conversions to a 
> canonical format of samples witch slow down any trial to mix in 
> hardware. Don't expect too much it's only a first release but it's seems 
> to works.
> 
> 
> bye,
>    Dino Puller



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
