From: "John S. Denker" <jsd@monmouth.com>
Subject: Re: sb16 gets wedged when doing overlapped i/o (full
 duplex)
Date: Fri, 06 Dec 2002 09:08:45 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DF0AF6D.8060405@monmouth.com>
References: <Pine.LNX.4.05.10212060748420.3576-100000@pulsar.kss-loka.si>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070606050003020803000607"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.05.10212060748420.3576-100000@pulsar.kss-loka.si>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Uros Bizjak <uros@kss-loka.si>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------070606050003020803000607
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Uros Bizjak wrote:

>   Could you put a printk() in snd_sb16_*_pointer() functions
> (sb16_main.c souce)? This printk() should print dma channel and value of
> ptr, so we can see when/if DMA channels gets stuck.

Done.  The result put 2.6 megabytes into /var/log/messages.
The head -10 and tail -50 of the relevant section is
attached below;  if anybody wants more detail the whole
shebang is available at
   http://www.av8n.net/~jsd/alsa/messages.txt

>   BTW: It looks like another sb16 hardware bug to me. On module re-load,
> drivers reset sb16 chip, that is why module reload helps.

Plausible....  But note that the cs4239 module gets i/o
errors when provoked by the same program, so there may
be driver design weaknesses involved, too.

> Perhaps you can derive a small test case from your application, which
> will help developers to stresstest soundcard and perhaps PCM layer?

My program is not super-small, but the relevant
passages are simple and easy to find.
You can help yourself at
   http://www.monmouth.com/~jsd/turbid/

Compile the thing and invoke it as
   ./turbid -F 440
or
   ./turbid -v -F 440

Note that just for you I added the --snooze <tt>
option, which will cause it to generate an
overrun every <tt> seconds (default .5) PROVIDED
<tt> is not too small.

--------------070606050003020803000607
Content-Type: text/plain;
 name="msgs.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="msgs.txt"

Dec  6 06:51:58 moat2 jsd: about to start ....
Dec  6 06:52:03 moat2 turbid: PID file "/var/run/turbid.pid" already exists, not overwriting
Dec  6 06:52:03 moat2 kernel: snd_sb16_capture_pointer  dma: 5 ptr: 8
Dec  6 06:52:03 moat2 kernel: snd_sb16_capture_pointer  dma: 5 ptr: 4110
Dec  6 06:52:03 moat2 kernel: snd_sb16_capture_pointer  dma: 5 ptr: 4894
Dec  6 06:52:03 moat2 kernel: snd_sb16_playback_pointer dma: 1 ptr: 11
Dec  6 06:52:03 moat2 kernel: snd_sb16_capture_pointer  dma: 5 ptr: 8206
Dec  6 06:52:03 moat2 kernel: snd_sb16_playback_pointer dma: 1 ptr: 2055
Dec  6 06:52:03 moat2 kernel: snd_sb16_playback_pointer dma: 1 ptr: 2239
Dec  6 06:52:03 moat2 kernel: snd_sb16_capture_pointer  dma: 5 ptr: 12302
....
Dec  6 06:57:59 moat2 kernel: snd_sb16_playback_pointer dma: 1 ptr: 4129
Dec  6 06:57:59 moat2 kernel: snd_sb16_playback_pointer dma: 1 ptr: 6151
Dec  6 06:57:59 moat2 kernel: snd_sb16_playback_pointer dma: 1 ptr: 6176
Dec  6 06:57:59 moat2 kernel: snd_sb16_playback_pointer dma: 1 ptr: 6
Dec  6 06:57:59 moat2 kernel: snd_sb16_playback_pointer dma: 1 ptr: 33
Dec  6 06:57:59 moat2 kernel: snd_sb16_playback_pointer dma: 1 ptr: 2053
Dec  6 06:57:59 moat2 kernel: snd_sb16_playback_pointer dma: 1 ptr: 2081
Dec  6 06:58:00 moat2 kernel: snd_sb16_playback_pointer dma: 1 ptr: 4103
Dec  6 06:58:00 moat2 kernel: snd_sb16_playback_pointer dma: 1 ptr: 5861
Dec  6 06:58:00 moat2 kernel: snd_sb16_playback_pointer dma: 1 ptr: 6151
Dec  6 06:58:00 moat2 kernel: snd_sb16_playback_pointer dma: 1 ptr: 6317
Dec  6 06:58:00 moat2 kernel: snd_sb16_playback_pointer dma: 1 ptr: 7
Dec  6 06:58:00 moat2 kernel: snd_sb16_playback_pointer dma: 1 ptr: 34
Dec  6 06:58:00 moat2 kernel: snd_sb16_playback_pointer dma: 1 ptr: 2055
Dec  6 06:58:00 moat2 kernel: snd_sb16_playback_pointer dma: 1 ptr: 2081
Dec  6 06:58:00 moat2 kernel: snd_sb16_playback_pointer dma: 1 ptr: 4103
Dec  6 06:58:00 moat2 kernel: snd_sb16_playback_pointer dma: 1 ptr: 4129
Dec  6 06:58:00 moat2 kernel: snd_sb16_playback_pointer dma: 1 ptr: 6151
Dec  6 06:58:00 moat2 kernel: snd_sb16_playback_pointer dma: 1 ptr: 6177
Dec  6 06:58:00 moat2 kernel: snd_sb16_playback_pointer dma: 1 ptr: 7
Dec  6 06:58:00 moat2 kernel: snd_sb16_playback_pointer dma: 1 ptr: 242
Dec  6 06:58:00 moat2 kernel: snd_sb16_playback_pointer dma: 1 ptr: 2055
Dec  6 06:58:00 moat2 kernel: snd_sb16_playback_pointer dma: 1 ptr: 2083
Dec  6 06:58:00 moat2 kernel: snd_sb16_playback_pointer dma: 1 ptr: 4103
Dec  6 06:58:00 moat2 kernel: snd_sb16_playback_pointer dma: 1 ptr: 4129
Dec  6 06:58:00 moat2 kernel: snd_sb16_capture_pointer  dma: 5 ptr: 6
Dec  6 06:58:00 moat2 kernel: snd_sb16_playback_pointer dma: 1 ptr: 6155
Dec  6 06:58:00 moat2 kernel: snd_sb16_playback_pointer dma: 1 ptr: 7893
Dec  6 06:58:00 moat2 kernel: snd_sb16_capture_pointer  dma: 5 ptr: 4210
Dec  6 06:58:00 moat2 kernel: snd_sb16_capture_pointer  dma: 5 ptr: 4386
Dec  6 06:58:10 moat2 turbid[4903]: Calout wrote 8820 got -5
Dec  6 06:58:10 moat2 kernel: snd_sb16_capture_pointer  dma: 5 ptr: 8192
Dec  6 06:58:10 moat2 kernel: snd_sb16_capture_pointer  dma: 5 ptr: 8192
Dec  6 06:58:10 moat2 kernel: snd_sb16_playback_pointer dma: 1 ptr: 0
Dec  6 06:58:10 moat2 kernel: snd_sb16_playback_pointer dma: 1 ptr: 0
Dec  6 06:58:20 moat2 kernel: snd_sb16_capture_pointer  dma: 5 ptr: 8192
Dec  6 06:58:20 moat2 turbid[4903]: Calout wrote 8820 got -5
Dec  6 06:58:20 moat2 kernel: snd_sb16_playback_pointer dma: 1 ptr: 0
Dec  6 06:58:30 moat2 turbid[4902]: Read_stuff requested 2048 got -5: Input/output error
Dec  6 06:58:30 moat2 turbid[4902]: turbid exiting, status 1
Dec  6 06:58:30 moat2 kernel: snd_sb16_playback_pointer dma: 1 ptr: 0
Dec  6 06:58:49 moat2 jsd: program has exited due to i/o error
Dec  6 06:59:10 moat2 jsd: will restart it just for fun
Dec  6 06:59:15 moat2 turbid: PID file "/var/run/turbid.pid" already exists, not overwriting
Dec  6 06:59:15 moat2 kernel: snd_sb16_capture_pointer  dma: 5 ptr: 8
Dec  6 06:59:15 moat2 kernel: snd_sb16_playback_pointer dma: 1 ptr: 11
Dec  6 06:59:25 moat2 turbid[4908]: Read_stuff requested 2048 got -5: Input/output error
Dec  6 06:59:25 moat2 turbid[4908]: turbid exiting, status 1
Dec  6 06:59:25 moat2 kernel: snd_sb16_playback_pointer dma: 1 ptr: 2048
Dec  6 06:59:29 moat2 jsd: program has exited due to i/o error

--------------070606050003020803000607--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
