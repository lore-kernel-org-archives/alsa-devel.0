From: Carsten Koch <Carsten.Koch@icem.com>
Subject: Re: optical SPDIF output on Abit NF7 nforce2 main board.
Date: Mon, 01 Sep 2003 21:13:02 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F539A3E.3030508@icem.com>
References: <3F532D5E.6040300@icem.com>	<s5hy8x8oefw.wl@alsa2.suse.de>	<3F534D6A.5030706@icem.com>	<s5hllt8oaye.wl@alsa2.suse.de>	<3F535A42.6020403@icem.com>	<s5hekz0o7wi.wl@alsa2.suse.de>	<3F536C97.5080008@icem.com>	<s5hbru4o444.wl@alsa2.suse.de>	<3F538893.1010801@icem.com> <s5h7k4snyhl.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h7k4snyhl.wl@alsa2.suse.de>
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
> ok, then apparently it looks like working correctly.

Look: yes, sound: no. ;-)


> can you play mp3 on normal analog output correctly?

Yes. It looks like this:

vdr:~ #  head /proc/asound/card?/pcm?p/sub?/hw_params
==> /proc/asound/card0/pcm0p/sub0/hw_params <==
access: RW_INTERLEAVED
format: S16_LE
subformat: STD
channels: 2
rate: 44100 (44100/1)
period_size: 1024
buffer_size: 8192
tick_time: 10000

==> /proc/asound/card0/pcm1p/sub0/hw_params <==
closed

and it sounds OK.


Carsten.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
