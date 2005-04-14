From: Raymond <rayau@netvigator.com>
Subject: Re: au88x0_synth
Date: Thu, 14 Apr 2005 23:31:17 +0800
Message-ID: <425E8CC5.3030601@netvigator.com>
References: <424A5D7D.2070400@netvigator.com> <Pine.HPX.4.33n.0503301007400.20197-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0503301007400.20197-100000@studcom.urz.uni-halle.de>
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

Takashi Iwai wrote:
> Raymond wrote:
>>1) Is the Trident Wavetable working ?
>
>
> Very limited.  It's no proper "MIDI" wavetable implementation.
> IIRC, only a module player worked with trident driver.
>

# aplaymidi -l
  Port    Client name                      Port name
  64:0    MPU-401 MIDI 0-0                 MPU-401 MIDI 0-0
  65:0    au8830 WaveTable                 au8830 Port 0
  65:1    au8830 WaveTable                 au8830 Port 1
  65:2    au8830 WaveTable                 au8830 Port 2
  65:3    au8830 WaveTable                 au8830 Port 3

# ls /proc/asound/au8830
codec97#0  midi0  midi2  midi4  pcm0p  pcm2p  wavetableD1
id         midi1  midi3  pcm0c  pcm1p  pcm3p


# more /proc/asound/au8830/wavetableD1
Device: au8830
Ports: 4
Addresses: 65:0 65:1 65:2 65:3
Use Counter: 0
Max Voices: 64
Allocated Voices: 0
Memory Size: 16777216
Memory Available: 16777216
Allocated Blocks: 0
SoundFonts: 0
Instruments: 0
Samples: 0
Locked Instruments: 0
Locked Samples: 0

# more /proc/asound/hwdep
00-02: au8830 WaveTable


1) What value of memsize will need to pass into snd_util_memhdr_new(int
memsize) if au30gm.arl is about 5 Mb ?

2) Do au88x0 DMA (scatter-gather) has any alignment requirement or
maximum size of the samples ?

3) Is it correct to implement functions snd_soundfont_load_arlpatch(),
load_arlpatch() in soundfont.c to load arl ?








-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
