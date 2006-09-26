From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: intel8x0-snd module fails to correctly detect
	clock when compiled in kernel
Date: Tue, 26 Sep 2006 16:25:23 +0200
Message-ID: <1159280723.451938539a56d@domainfactory-webmail.de>
References: <200609251535.45246.martin@mrvanes.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <200609251535.45246.martin@mrvanes.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Martin van Es <martin@mrvanes.com>
Cc: alsa-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Martin van Es wrote:
> Yesterday I compiled the fresh 2.6.18 kernel and to my big surprise
> I discovered my sound was a bit off speed (too slow, like 48000
> content was played at 44100 or so). Hence my immediate search for
> clock problems.
>
> A bit of searching revealed that the ac97#0-0 file (in
> /proc/asound/card0 dir) contains 2 lines referring to 441~ and 48~.
> In 2.6.18 these lines
>
> PCM front DAC    : 48000Hz
> PCM ADC          : 48000Hz
>
> Both lines alternate between 44100 and 48000 between reboots (and I
> can't find what it depends on).

These are the playback and capture sample rates used by the hardware.
The rate is that of the file last played (or currently being played).

> dmesg outputs the following 2 lines concerning audio clock:
> intel8x0_measure_ac97_clock: measured 50992 usecs
> intel8x0: clocking to 43920
>
> The 'clocking to' line is not always the same, but never 48000.

The AC'97 specification says that the AC'97 bus runs at 48 kHz.
However, there is some hardware that doesn't use this frequency, so
the driver tries to measure the actual rate.

> Don't ask me why, but at last I tried to build the intel8x0-snd
> driver as a module and surprisingly that always results in correct
> funcionality. The 2 dmesg lines now read:
> intel8x0_measure_ac97_clock: measured 50463 usecs
> intel8x0: clocking to 48000

It seems that, when compiled in the kernel, some other code runs at
the same time as the clock measuring code and interferes with it,
probably by disabling interrupts for too long.

> I tried to use ac97_clock=48000 as kernel boot parameter, but the
> doesn't help (for the in-kernel version of the module).

This option is intended to specify a value different from the
default.  Try 47999.  ;-)


HTH
Clemens


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
