From: "Mihai T. Lazarescu" <mihai@email.it>
Subject: Re: Help fix driver for YMF-744B on Toshiba Tecra 8100?
Date: Fri, 20 Feb 2004 02:25:28 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0402200213190.19312@laptop.localdomain>
References: <Pine.LNX.4.58.0402181132500.19312@laptop.localdomain>
 <40350050.1040901@elf.org> <Pine.LNX.4.58.0402201128170.1173@home.aussec.com>
Reply-To: "Mihai T. Lazarescu" <mihai@email.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0402201128170.1173@home.aussec.com>
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

On Fri, 20 Feb 2004, tom burkart wrote:

> When I load the toshiba kernel module, then the alsa driver, set the mixer
> settings, then I have sound most of the time (under an old version of
> gnome).

Strange, I have the toshiba kernel module loaded at boot time
and when I start ALSA by hand I get mostly non-functional sound.

> The other option is to unload alsa and load the ymfpci module (kernel/oss)
> and there is sound (guaranteed every time).

xine playback is better with ALSA (synchronization) and OSS
is becoming obsolete in 2.6 kernels... :)

> My intention was to compare the low level code of the kernel oss driver
> with the alsa driver and see what they do differently.
> My initial guess is that the initialisation is done slightly
> differently...

I used to use ALSA 0.5 series without a glitch years ago on
RH6.2-7.2 (maybe even 7.3, until OSS ymfpci came out).

My intention is to compare 0.5 series inits with current
version, since I suspect they should be easier to compare than
OSS and ALSA... :)

> Alas, I haven't had the chance to do so... (yet).

Can't guess when I'll have a chance myself, but don't loosing
faith. ;)

Cheers,

Mihai


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
