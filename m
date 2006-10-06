From: Daniel Yek <dyek@real.com>
Subject: 5.1 surround sound playback XRUN / snd_pcm_writei()
 didn't unblock immediately / small 114 msec buffer
Date: Fri, 06 Oct 2006 01:52:41 -0700
Message-ID: <6.2.1.2.2.20061006012016.30ac5ee8@mailone.real.com>
References: <6.2.1.2.2.20060928013552.16a4b928@mailone.real.com>
	<s5hhcys2kr2.wl%tiwai@suse.de>
	<6.2.1.2.2.20060928125136.20c38030@mailone.real.com>
	<s5hhcyq52do.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hhcyq52do.wl%tiwai@suse.de>
References: <6.2.1.2.2.20060928013552.16a4b928@mailone.real.com>
	<s5hhcys2kr2.wl%tiwai@suse.de>
	<6.2.1.2.2.20060928125136.20c38030@mailone.real.com>
	<s5hhcyq52do.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Alsa Developement <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi,

I opened "surround51" PCM device and set the sampling rate to 48000, S16_LE 
format. I requested 500000 usec (0.5 sec) of buffer time, but I got back 
only 113770 usec. (equals to 65532 bytes.) Is there a way I can get a 
bigger buffer size? Does it depend on the driver or ALSA can typically 
provide more?

I used snd_pcm_writei() in blocking mode, transferring 28800 bytes (2400 
frames) at a time. After two writes (buffer about full), the third write 
blocked for 95 msec. Soon after, the function blocked for 128 msec, caused 
XRUN. Is snd_pcm_writei() in blocking mode suitable for 5.1 channels 
playback without XRUNs? Why snd_pcm_writei() didn't unblock immediately 
when snd_pcm_avail_update() returned 5044 frames (105 msec.) available?

I'm going to try a non-blocking snd_pcm_writei() solution. Do you think it 
is the answer to the XRUN problem?

Thank you very much.


-- 
Daniel Yek


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
