From: David Cullen <david.cullen@teligy.com>
Subject: Re: Call to mmap in ALSA lib 1.0.13 fails in
 src/pcm/pcm_mmap.c line 367
Date: Thu, 21 Dec 2006 14:53:50 -0500
Message-ID: <458AE64E.4010405@teligy.com>
References: <45880176.3070300@teligy.com>	<s5hirg64f8b.wl%tiwai@suse.de>	<45898126.3060808@teligy.com>	<s5hejqu4dq8.wl%tiwai@suse.de>	<458AB128.20403@teligy.com>	<s5hd56dryl9.wl%tiwai@suse.de>	<458ABDCD.2060306@teligy.com>	<s5h8xh1rxlj.wl%tiwai@suse.de>	<458AC97B.5040402@teligy.com>
	<s5h4prpruxb.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5h4prpruxb.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Thu, 21 Dec 2006 12:50:51 -0500,
> David Cullen wrote:
>> 
>> Takashi Iwai wrote:
>> > At Thu, 21 Dec 2006 12:01:01 -0500,
>> > David Cullen wrote:
>> >> 
>> >> Dear Mr. Iwai,
>> >> 
>> >> Takashi Iwai wrote:
>> >> > As mentioned in the previous mail, it should be like
>> >> > 
>> >> > pcm.!default {
>> >> > 	type plug
>> >> > 	slave.pcm {
>> >> > 		type hw
>> >> > 		card 0
>> >> > 	}
>> >> > }
>> >> 
>> >> I put only those lines in my asound.conf file and I still got this
>> >> output:
>> >> 
>> >> /etc # speaker-test
>> >> 
>> >> speaker-test 1.0.13
>> >> 
>> >> Playback device is default
>> >> Stream parameters are 48000Hz, S16_BE, 1 channels
>> >> Using 16 octaves of pink noise
>> >> ALSA lib pcm_plug.c:773:(snd_pcm_plug_hw_refine_schange) Unable to
>> >> find an usable access for 'default'
>> >> Sample format not available for playback: Invalid argument
>> >> Setting of hwparams failed: Invalid argument
>> > 
>> > Does aplay work?
>> > 
>> > Takashi
>> 
>> This is what happens when I try aplay:
>> 
>> /usr/share/sounds/alsa # aplay Noise.wav
>> Playing WAVE 'Noise.wav' : Signed 16 bit Little Endian, Rate 48000
>> Hz, Mono
>> ALSA lib pcm_plug.c:773:(snd_pcm_plug_hw_refine_schange) Unable to
>> find an usable access for 'default'
>> aplay: set_params:929: Channels count non available
> 
> Hm, this looks like you don't use plug layer?
> Make sure that you have no ~/.asoundrc file.  Then try
> 
> 	% aplay -Dplughw foo.wav
> 
> "plughw" is a standard PCM name defined in /usr/share/cards/alsa.conf,
> so it should work even without /etc/asound.conf.
> 
> 
> Takashi
> 

I verified that there are no .asoundrc files in the filesystem.
However, this is the result of the aplay test:

/usr/share/sounds/alsa # aplay -Dplughw Noise.wav
ALSA lib pcm_hw.c:1358:(_snd_pcm_hw_open) Invalid value for card
aplay: main:556: audio open error: No such device

-- 
Thank you,
David Cullen
Teligy

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
