From: Wilfried Weissmann <Wilfried.Weissmann@gmx.at>
Subject: au8830+via & alsa 0.9.7c
Date: Mon, 20 Oct 2003 22:37:41 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F944795.20205@gmx.at>
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
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>, openvortex-dev@nongnu.org
List-Id: alsa-devel@alsa-project.org

hi,

last weekend i grabbed my old aureal vortex 2 card and replaced my 
current (lowcost) card with it. and after installing the brand new 
alsa-0.9.7c i got a fully functional soundcard with full duplex and 
hardware mixing. whoooho! i was in heaven... for about 30 seconds. then 
my via kt133 chipset got me an instant ticket to the ground level. 
"welcome aboard ladies and gentlemen to flight kt133. our current 
crusing altitute is 0 feet above ground level." :/
but the goods news is that only the playback stopped. no kernel crash, 
no freezes, only inconveniet "Vortex: vortex_fifo_setadbctrl fail" in my 
  /var/log/messages. but as an old internet surfer i knew that the truth 
is somewhere out there. at google! so i looked up the pci register fix 
put the line "install snd-au8830 /sbin/setpci -d '12eb:*' 40.B=ff ; 
insmod snd-au8830" in my modules.conf and everything worked fine. at the 
openvortex list i read that there is also another fix that tunes the via 
agp-bridge. i have not tried this one yet, but i guess that would work 
too (although in the example from the mail they set a register in the 
au88x0 instead of the bus-bridge). but i thought that the fix was 
already in the driver. afterwards i had a look at the sources and could 
not find code that would do this. is there another workaround in the 
driver (apart from the loop with a counter around the 
vortex_fifo_setadbctrl() that stopps the kernel from freezing) or is it 
just not in there?

there is also somewhere a bug in recording (unless this is caused by 
still running on the 0.9.6 libs. i will upgrade that soon.). i 
discovered it when i used speakfreely with alsa support. in one second 
intervals there was some loud noise that sounded like garbage data. when 
i compiled speakfreely with oss support and linear audio then the 
distortion was gone. with "arecord -f MU_LAW -r 16000 -t au x.au" i can 
reproduce something similar. this time there is 1 second of normal 
audio. for few milliseconds there appears some short sample from the 
previous second again. then 1 second of normal playback and a sample 
from that is also played again....
it feels like that the buffer does not have the right size. if you 
choose higher sampling rates, 16-bit samples and stereo then the samples 
that are played twice are getting shorter and finally the problem 
disappears. any ideas?

i am using kernel 2.4.22 tainted by NVidia.o(tm) on a athlon k7 800MHz 
box with a via kt133 chipset. the distribution is debian-sarge 
(testing). no alsa plugins are used.

bye,
wilfried



-------------------------------------------------------
This SF.net email is sponsored by OSDN developer relations
Here's your chance to show off your extensive product knowledge
We want to know what you know. Tell us and you have a chance to win $100
http://www.zoomerang.com/survey.zgi?HRPT1X3RYQNC5V4MLNSV3E54
