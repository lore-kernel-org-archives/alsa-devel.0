From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Re: [Alsa-user] Audigy multichannel and line-in
	did not work in	Linux 2.6.7
Date: Tue, 14 Sep 2004 23:13:50 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1095218029.2406.132.camel@krustophenia.net>
References: <200409070718.i877IHol013713@www3.pobox.sk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200409070718.i877IHol013713@www3.pobox.sk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Peter Zubaj <pzad@pobox.sk>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

On Tue, 2004-09-07 at 03:18, Peter Zubaj wrote:
> Hi,
> 
> There is check for channel count (1,2,4,8).
> Attached patch will add suppor for 16,32,64.
> 
> Could you test this ??? I tryed 32 and 64 channels an looks like it
> works. I can not test (no time to do this) if recorded data are good.
> Maybe if you remove this check completly hardware will work with 10
> channels too, who know.

OK, it works (output from jackd):

registered builtin port type 32 bit float mono audio
loading driver ..
new client: alsa_pcm, id = 1 type 1 @ 0x8056858 fd = -1
creating alsa driver ... hw:0,0|hw:0,2|64|2|48000|0|0|nomon|swmeter|-|16bit
control device hw:0
configuring for 48000Hz, period = 64 frames, buffer = 2 periods
new buffer size 64
registered port alsa_pcm:capture_1, offset = 256
registered port alsa_pcm:capture_2, offset = 512
registered port alsa_pcm:capture_3, offset = 768
registered port alsa_pcm:capture_4, offset = 1024
registered port alsa_pcm:capture_5, offset = 1280
registered port alsa_pcm:capture_6, offset = 1536
registered port alsa_pcm:capture_7, offset = 1792
registered port alsa_pcm:capture_8, offset = 2048
registered port alsa_pcm:capture_9, offset = 2304
registered port alsa_pcm:capture_10, offset = 2560
registered port alsa_pcm:capture_11, offset = 2816
registered port alsa_pcm:capture_12, offset = 3072
registered port alsa_pcm:capture_13, offset = 3328
registered port alsa_pcm:capture_14, offset = 3584
registered port alsa_pcm:capture_15, offset = 3840
registered port alsa_pcm:capture_16, offset = 4096
registered port alsa_pcm:playback_1, offset = 0
registered port alsa_pcm:playback_2, offset = 0

It does not work unless the number of channels is a power of two. 
Here's what happens with 15 channels:

registered builtin port type 32 bit float mono audio
loading driver ..
new client: alsa_pcm, id = 1 type 1 @ 0x8056858 fd = -1
creating alsa driver ... hw:0,0|hw:0,2|64|2|48000|0|0|nomon|swmeter|-|16bit
control device hw:0
configuring for 48000Hz, period = 64 frames, buffer = 2 periods
ALSA: no playback configurations available (Invalid argument)
ALSA: cannot configure capture channel
cannot load driver module alsa

Since the allowed capture buffer sizes are fixed, this is the behavior I
would expect; seems like it makes the hardware design much easier.  kX
ASIO seems to use 16, probably because this works on both Audigy and
SBLive and gives you some playback voices left over for the wave devices
and MIDI synth.  It is also the smallest power of two that is guaranteed
to be more than the number of physical inputs or outputs.

Takashi-san, please apply Peter's patch to CVS.

Lee




-------------------------------------------------------
This SF.Net email is sponsored by: thawte's Crypto Challenge Vl
Crack the code and win a Sony DCRHC40 MiniDV Digital Handycam
Camcorder. More prizes in the weekly Lunch Hour Challenge.
Sign up NOW http://ad.doubleclick.net/clk;10740251;10262165;m
