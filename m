From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [PATCH] Enable low latency EFX capture on emu10k1
Date: Wed, 14 Jul 2004 12:05:55 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1089820931.2104.4.camel@mindpipe>
References: <1089786178.3360.7.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1089786178.3360.7.camel@mindpipe>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
Cc: pzad@pobox.sk
List-Id: alsa-devel@alsa-project.org

On Wed, 2004-07-14 at 02:22, Lee Revell wrote:
> The following patch fixes EFX capture on the emu10k1.  The
> capture_period_sizes table is in bytes, but the hardware constraint was
> being set in frames.
> 
> I tested 4 channel recording with a capture period of 64 frames (64
> frames x 2 bytes/sample x 4 channels = 512, the lowest power of 2
> capture period allowed).
> 

With this patch, I can record 8 channels with a period of 64 frames.
Trying to record 16 gives the error "alsactl: set_control:966: Cannot
write control '3:0:0:EFX voices mask:0' : Invalid argument".

Lee

root@mindpipe:/home/rlrevell# jackd -vvv --realtime -d alsa --rate 48000 -p 64 -C -d hw:0,2 -S 
getting driver descriptor from /usr/local/lib/jack/jack_dummy.so
getting driver descriptor from /usr/local/lib/jack/jack_oss.so
getting driver descriptor from /usr/local/lib/jack/jack_alsa.so
jackd 0.98.1
Copyright 2001-2003 Paul Davis and others.
jackd comes with ABSOLUTELY NO WARRANTY
This is free software, and you are welcome to redistribute it
under certain conditions; see the file COPYING for details

registered builtin port type 32 bit float mono audio
loading driver ..
new client: alsa_pcm, id = 1 type 1 @ 0x8056a20 fd = -1
apparent rate = 48000
creating alsa driver ... -|hw:0,2|64|2|48000|0|0|nomon|swmeter|-|16bit
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
++ jack_rechain_graph():
client alsa_pcm: internal client, execution_order=0.
-- jack_rechain_graph()
2136 waiting for signals
load = 0.2626 max usecs: 7.000, spare = 1326.000
load = 0.3938 max usecs: 7.000, spare = 1326.000
load = 0.4595 max usecs: 7.000, spare = 1326.000
load = 0.4923 max usecs: 7.000, spare = 1326.000
load = 0.5087 max usecs: 7.000, spare = 1326.000
load = 0.5544 max usecs: 8.000, spare = 1325.000
jack main caught signal 2
stopping driver
detaching driver
unloading driver
freeing shared port segments
stopping server thread
stopping watchdog thread
freeing engine shared memory
engine deleted




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
