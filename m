From: Raymond <rayau@netvigator.com>
Subject: Re: au8830 - front / rear channels swapped after first play and Surround40
Date: Sun, 27 Mar 2005 00:38:11 +0800
Message-ID: <42458FF3.7050608@netvigator.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
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


 >>Using "vortex_adbdma_stopfifo()" instead of vortex_adbdma_pausefifo()"
 >>in snd_vortex_pcm_trigger() (just like the last version of au88x0 in
 >>alsa-driver before it merged into alsa-kernel) seem to fix the
 >>front/rear channels swap when playing 4 channels sound in au8830.

Manuel Jander wrote:
 >
 > Does the IRQ fifo error appear once for every sound played or a lot
 > more than that ? if it appears once for every PCM plaayback start, it
 > may be that this error is just a harmless "fifo empty" error, and as
 > such could be just ignored. An if it really signals a FIFO empty
 > error, it maybe useful to detect xruns ?

The fifo error also occur when using the pause/resume button of xmms 
1.2.10 (alsa 1.2.10 output plugin) to pause and resume of the playing of 
music.

vortex: start 0
vortex: IRQ fifo error
vortex: pause 0
vortex: resume 0
vortex: IRQ fifo error
vortex: pause 0
vortex: resume 0
vortex: pause 0
vortex: resume 0
vortex: IRQ fifo error
vortex: pause 0
vortex: resume 0
vortex: IRQ fifo error
vortex: stop 0


1) How to prove that it is just a harmless "fifo empty" error ?

The outls.wav and outrs.wav (may be too short) cannot be paused in xmms.


Raymond










-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
