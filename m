From: Carsten Koch <Carsten.Koch@icem.com>
Subject: Re: optical SPDIF output on Abit NF7 nforce2 main board.
Date: Mon, 01 Sep 2003 16:40:02 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F535A42.6020403@icem.com>
References: <3F532D5E.6040300@icem.com>	<s5hy8x8oefw.wl@alsa2.suse.de>	<3F534D6A.5030706@icem.com> <s5hllt8oaye.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hllt8oaye.wl@alsa2.suse.de>
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

Takashi Iwai wrote:
...
> no.  for ALSA native apps, you can (should be able to) select a PCM
> device for use.
> 
> it's not supported in the OSS emulation over kernel modules, though.
> so, it won't work on mpg123.
> 
> you can try alternatively mpg321, which is based on libao.

I did and it worked!
Many thanks!

The sound was playing too fast with mpg321.
I was using
    mpg321 -o alsa09  --audiodevice hw:0,1
It seems like mpg321 was playing my 44.1kHz mp3 in 48kHz mode.

Next, I tried
    alsaplayer -d hw:0,1
which worked correctly right away.
Thanks again!

I will now update to the latest cvs version and see if I can get
loop-through of my DVB card's SPDIF out to work.

Carsten.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
