From: Luca Tamburrano <ltamburrano@tiscalinet.it>
Subject: 2.4.20 + alsa + Ali 5451 possible bug
Date: 05 May 2003 10:06:27 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1052121986.1620.3.camel@ZeUs.fastwebnet.it>
Mime-Version: 1.0
Content-Type: text/plain
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

hi,
I'm using alsa driver on a HP omnibook xt6200 w/ Ali 5451 chipset.

While playing some mp3s and some flash sites w/ sound I had a strange
behavior exactly at the end of the playback. It seems like it stalls
before the trigger function. I recompiled w/ debug options and got that
for an impulsive sound of a button beep.

May  4 11:39:11 ZeUs kernel: alloc_voice: type=1 rec=0
May  4 11:39:11 ZeUs kernel: find_free_channel: for pcm
May  4 11:39:11 ZeUs kernel: alloc_pcm_channel no. 0.
May  4 11:39:11 ZeUs kernel: alloc_voice: type=1 rec=1
May  4 11:39:11 ZeUs kernel: find_free_channel: for rec
May  4 11:39:11 ZeUs kernel: alloc_pcm_channel no. 31.
May  4 11:39:11 ZeUs kernel: alloc_voice: type=1 rec=0
May  4 11:39:11 ZeUs kernel: find_free_channel: for pcm
May  4 11:39:11 ZeUs kernel: alloc_pcm_channel no. 1.
May  4 11:39:11 ZeUs kernel: playback_prepare ...
May  4 11:39:11 ZeUs kernel: playback_prepare: eso=4000h count=800h
May  4 11:39:11 ZeUs kernel: playback_prepare:
May  4 11:39:11 ZeUs kernel:     ch=0, Rate=22050
Delta=75ah,GVSEL=1h,PAN=0h,CTRL=fh
May  4 11:39:11 ZeUs kernel: trigger: what=3h whati=2h
May  4 11:39:11 ZeUs kernel: playback pointer returned cso=9h.
May  4 11:39:11 ZeUs kernel: playback pointer returned cso=10h.
May  4 11:39:11 ZeUs kernel: playback pointer returned cso=16h.
May  4 11:39:11 ZeUs kernel: playback pointer returned cso=8fbh.
May  4 11:39:11 ZeUs kernel: playback pointer returned cso=906h.
May  4 11:39:11 ZeUs kernel: playback pointer returned cso=90dh.
May  4 11:39:11 ZeUs kernel: playback pointer returned cso=9c6h.
May  4 11:39:11 ZeUs kernel: playback pointer returned cso=9d1h.
May  4 11:39:11 ZeUs kernel: playback pointer returned cso=9d8h.
May  4 11:39:11 ZeUs kernel: playback pointer returned cso=fdch.
May  4 11:39:11 ZeUs kernel: playback pointer returned cso=febh.
May  4 11:39:11 ZeUs kernel: playback pointer returned cso=ff1h.
May  4 11:39:11 ZeUs kernel: playback pointer returned cso=17ceh.
May  4 11:39:11 ZeUs kernel: playback pointer returned cso=17d9h.
May  4 11:39:11 ZeUs kernel: playback pointer returned cso=17dfh.
May  4 11:39:22 ZeUs kernel: playback pointer returned cso=1096h.
May  4 11:39:22 ZeUs kernel: trigger: what=3h whati=2h
May  4 11:39:22 ZeUs kernel: free_voice: channel=1
May  4 11:39:22 ZeUs kernel: stop_voice: channel=1
May  4 11:39:22 ZeUs kernel: disable_voice_irq channel=1
May  4 11:39:22 ZeUs kernel: free_channel_pcm channel=1
May  4 11:39:22 ZeUs kernel: free_voice: channel=0
May  4 11:39:22 ZeUs kernel: stop_voice: channel=0
May  4 11:39:22 ZeUs kernel: disable_voice_irq channel=0
May  4 11:39:22 ZeUs kernel: free_channel_pcm channel=0
May  4 11:39:22 ZeUs kernel: free_voice: channel=31
May  4 11:39:22 ZeUs kernel: stop_voice: channel=31
May  4 11:39:22 ZeUs kernel: disable_voice_irq channel=31
May  4 11:39:22 ZeUs kernel: free_channel_pcm channel=31


saw that?

May  4 11:39:11 ZeUs kernel: playback pointer returned cso=17dfh.
May  4 11:39:22 ZeUs kernel: playback pointer returned cso=1096h.

in those 11 sec I have the repetition of the sound in loop.

wht could it be?

btw the driver works well to me but that.

Luca Tamburrano


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
