From: Sasha Khapyorsky <sashak@smlink.com>
Subject: Re: Re: au88x0 modem
Date: Thu, 15 Sep 2005 23:43:45 +0300
Message-ID: <20050915204345.GC27700@sashak.softier1.local>
References: <4325AEA3.1090602@netvigator.com> <20050913000909.GB19713@tecr>
 <20050913085552.GA2655@titan.lahn.de>
 <20050913173529.GD31269@sashak.softier1.local>
 <20050913174930.GA5816@titan.lahn.de> <4327DA14.3040205@netvigator.com>
 <20050914205608.GD14657@sashak.softier1.local>
 <20050915091158.GA7314@titan.lahn.de> <20050915092155.GA7328@titan.lahn.de>
 <20050915143533.GB23218@sashak.softier1.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <20050915143533.GB23218@sashak.softier1.local>
Content-disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
Cc: openvortex-dev@nongnu.org, alsa-devel@lists.sourceforge.net, Raymond <rayau@netvigator.com>
List-Id: alsa-devel@alsa-project.org

On 17:35 Thu 15 Sep     , Sasha Khapyorsky wrote:
> 
> I will send cleaned codec access patch separately and will look what is
> next.

Pilipp, no real patches yet, let's investigate few things:

1. Actual "secondary codec" bit in CODEC_EN register - just silly print
(apply with -p1):


--- au88x0_prev/au88x0_core.c	2005-09-14 20:51:03.000000000 +0300
+++ au88x0/au88x0_core.c	2005-09-15 22:59:05.000000000 +0300
@@ -2516,6 +2516,8 @@ static void vortex_codec_init(vortex_t *
 	msleep(2);
 	if (hwread(vortex->mmio, VORTEX_CODEC_EN)&(EN_CODEC1|EN_MODEM))
 		vortex->num_of_codecs = 2;
+	printk("vortex_codec_init: VORTEX_CODEC_EN = %08x\n",
+		hwread(vortex->mmio, VORTEX_CODEC_EN));
 }
 
 static void



2. GPIO

Probably we are lucky and au88x0 implements it in AC97 way, try to write
mc97 registers via /proc (for this you need build drivers in debug mode,
'--with-debug=detect' is ok):

('alsa-kernelDocumentation/Procfile.txt' is reference too)

 # echo 42 ffff > /proc/asound/card0/codec97#0/mc97#1-1+regs

, look if value of 0x42 register was changes (0x42 is line level control
- works in all known cases (up to know :) ), basically value should '0'
  - unmuted, 0dB), then:

 # echo 42 0 > /proc/asound/card0/codec97#0/mc97#1-1+regs

, and if ok, try to touch 0x54 - gpio status rtegister:

 # echo 54 1 > /proc/asound/card0/codec97#0/mc97#1-1+regs

, if value is changed (we are lucky then), you may connect line and
isten 'Hook-Off' clicks (when 0x54 is switched between 0 and 1) with
parallel phone.


3. DMA

After some looking in au88x0 driver I think that it is possible that
modem could use one ADB channels (predefined or programmable) for pcm
data transfers (just like regular audio), similar scheme may be found
with some other devices like ali5451.

If so we could try to find channel numbers (should be two - for playback
and capture). It is very possible that channels should be configured
somehow first.

Philipp, How looks your 'aplay -l' output?


ANYBODY knows something about modem DMA/PCM with au88x0, please advise.


BTW, I found fine au88x0 datasheet there:
http://galadriel.mat.utfsm.cl/~mjander/aureal/techdoc/techpaper.html

Thanks,
Sasha.


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
