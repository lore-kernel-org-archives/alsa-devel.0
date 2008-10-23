From: Jason Harvey <softdevice@jasonline.co.uk>
Subject: Re: Backported sbxfi driver (UNTESTED!)
Date: Thu, 23 Oct 2008 16:31:56 +0100
Message-ID: <490098EC.80505@jasonline.co.uk>
References: <s5hy70xsl46.wl%tiwai@suse.de>	<48F739F4.5070303@nostalgicnetworxx.org>	<48F74344.4090509@gmail.com>
	<s5hvdvs1wig.wl%tiwai@suse.de>	<5501535d0810220824o6b8bf427qd2c806783ec1e56f@mail.gmail.com>	<s5h4p34mz0j.wl%tiwai@suse.de>	<5501535d0810220907p2102afc2t13e47ff5309c01bc@mail.gmail.com>	<5501535d0810220924w66341ac6u4d4de4ed87243a7@mail.gmail.com>	<48FF7E17.9080601@gmail.com>
	<s5h4p3350o4.wl%tiwai@suse.de>	<5501535d0810230446j52de12aes885d066ea38cb240@mail.gmail.com>	<4900659E.90809@jasonline.co.uk>
	<s5hbpxb8lfe.wl%tiwai@suse.de>	<490071DC.6070607@jasonline.co.uk>
	<s5habcv5mu0.wl%tiwai@suse.de>	<490088DC.7090205@jasonline.co.uk>
	<s5hzlkv44v7.wl%tiwai@suse.de>	<s5hwsfz44i9.wl%tiwai@suse.de>
	<s5htzb3440f.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from homer.jasonline.co.uk (78-86-168-217.zone2.bethere.co.uk
	[78.86.168.217])
	by alsa0.perex.cz (Postfix) with ESMTP id 6E1F9103881
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Oct 2008 17:32:05 +0200 (CEST)
In-Reply-To: <s5htzb3440f.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> One another thing I'm wondering is whether this happens only with
> OSS.  What happens if you do like the following to disable the sample
> rate conversion?
>
> 	# echo mplayer 0 0 direct > /proc/asound/card0/pcm0p/oss
>
>   
That works! Perfect stereo.

Playing wn.wav.
Audio file file format detected.
==========================================================================
Opening audio decoder: [pcm] Uncompressed PCM audio decoder
AUDIO: 48000 Hz, 2 ch, s16le, 1536.0 kbit/100.00% (ratio: 192000->192000)
Selected audio codec: [pcm] afm: pcm (Uncompressed PCM)
==========================================================================
AO: [pulse] Init failed: Connection refused
*** PULSEAUDIO: Unable to connect: Connection refused
*** Is your sound server running?
*** See: http://www.pulseaudio.org/wiki/Troubleshooting
[AO_ALSA] Playback open error: Connection refused
AO: [oss] 96000Hz 2ch s16le (2 bytes per sample)
Video: no video
Starting playback...
A: 101.2 (01:41.2) of 241.0 (04:01.0)  1.4%

Thanks,
Jason
