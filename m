From: Carsten Koch <Carsten.Koch@icem.com>
Subject: Re: optical SPDIF output on Abit NF7 nforce2 main board.
Date: Mon, 01 Sep 2003 17:58:15 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F536C97.5080008@icem.com>
References: <3F532D5E.6040300@icem.com>	<s5hy8x8oefw.wl@alsa2.suse.de>	<3F534D6A.5030706@icem.com>	<s5hllt8oaye.wl@alsa2.suse.de>	<3F535A42.6020403@icem.com> <s5hekz0o7wi.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hekz0o7wi.wl@alsa2.suse.de>
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
>>The sound was playing too fast with mpg321.
>>I was using
>>    mpg321 -o alsa09  --audiodevice hw:0,1
>>It seems like mpg321 was playing my 44.1kHz mp3 in 48kHz mode.
> 
> 
> then try plughw:0,1.
> alsa-lib will convert the sample rate automatically.

Unfortunately, the sound is playing too fast with plughw:0,1 as well.

Also, I was wrong about alsaplayer playing it at the right speed.
Maybe I had left alsaplayer's speed at ~90% when I last used it.
I started it again now with a new mp3 file to load and it played
that one (and all other 44kHz files I tried from then on) too fast
(both with hw:0,1 and with plughw:0,1).

One more question: Is there a way to make hw:0,1 or plughw:0,1 the
default? Many programs do not have a --audiodevice parameter or
use the OSS emulation and I would of course still like to hear their
sound.

Carsten.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
