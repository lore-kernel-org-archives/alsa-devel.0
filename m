From: Raymond <rayau@netvigator.com>
Subject: Re: au88x0_synth
Date: Tue, 19 Apr 2005 16:39:01 +0800
Message-ID: <4264C3A5.50105@netvigator.com>
References: <424A5D7D.2070400@netvigator.com>	<Pine.HPX.4.33n.0503301007400.20197-100000@studcom.urz.uni-halle.de>	<425E8CC5.3030601@netvigator.com> <s5hy8bkchnd.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hy8bkchnd.wl@alsa2.suse.de>
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
> 
> I don't know of arl format, but if it's not compatible with
> soundfonts, stciking with the current soundfont handler doesn't make
> sense, IMO.
> 
> 
"Another new feature in 2.048 drivers is the possibility to upload SF2
sound banks, but it's still very limitedbecause only 2MB, 4MB and 8MB
SF2 2.0 banks can be uploaded. In fact, it's a long-awaited option
because basically Aureal ARL format is plainly the SF2 2.0 but with its
own addressing system."

Quoted from
http://www.xbitlabs.com/articles/multimedia/display/sq2500.html


1) Why samplerate is missing in soundfont_sample_info_t ?

The samples in au30gm.arl have different samplerates.

2) How can I create a stream_t for each voice in snd-au8830-synth and
use those vortex_adbdma_**** functions in snd-au8830 modules (using
ADB instead of WT) ?

3) Refer to
http://www.mail-archive.com/alsa-devel@lists.sourceforge.net/msg11719.html

Is it possible to use adb to play the sample loop using scatter gatter
DMA ? ( by adding a flag in stream_t to indicate the sample has a loop )


4) Can those snd_vortex_synth_alloc(), snd_vortex_synth_free(),
snd_vortex_synth_bzero() replaced by kmalloc(), kfree(), ... instead of
implementing a Memory blocks Management system with those fuctions in
util_mem.c ?

























-------------------------------------------------------
This SF.Net email is sponsored by: New Crystal Reports XI.
Version 11 adds new functionality designed to reduce time involved in
creating, integrating, and deploying reporting solutions. Free runtime info,
new features, or free trial, at: http://www.businessobjects.com/devxi/728
