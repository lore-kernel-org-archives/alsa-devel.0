From: Marcel <shizuma@magma.ca>
Subject: sbawe isa non pnp woes
Date: Tue, 2 Mar 2004 21:33:16 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040303023316.GA23931@dailyplanet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

Hello

I have a isa awe 64 card configurable on-board for pnp/non-pnp (a jumper).
I choose not to use pnp and assing (another jumper) irq 5 for DOS (heheheh)
compatability.  This card always been giving me excellent results with
DOS/Windows/OSS.

Could someone help me in getting rid of underrun conditions I have when I
"aplay bong.wav".  This is a 1 second wave file I play to indicate time:  I
play it 3 times at 3:00, 9 times at 9:00.  The computer is sollicited
sometimes when this file is played (a cron job) and I get underrun
condition.  I think it wouldn't be too hard to give high priority to aplay
for 1 second from time to time so the sound wouldn't be so distorted, but I
don't have any wee idea what to do.  Well I read somewhere to use alsaplay
-r suid root but it's worst than aplay.

Another thing, seems a bug had been replaced by another bug.  See what I
have to do in order to get snd-sbawe do load.  Took me days to figure out
this!  A nightmare.  Won't load witn any deviation to this:

v 1.0.2 compile options:
#./configure --with-cards=sbawe --with-sequencer=yes \
# --with-kernel=/usr/local/src/linux

V 0.9.8 compile options:
./configure --with-cards=sbawe --with-sequencer=yes --with-isapnp=no \
 --with-kernel=/usr/local/src/linux

V 0.9.8 modprobe options:
options snd-sbawe port=0x220 irq=5 dma8=1 dma16=5 mpu_port=0x330 \
awe_port=0x620

V 1.0.2 modprobe options:
#options snd-sbawe port=0x220 irq=5 dma8=1 dma16=5 mpu_port=0x330 \
awe_port=0x620 isapnp=0

I have PNP enabled in kernel.

Just some thoughts.
 


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
