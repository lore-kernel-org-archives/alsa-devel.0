From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: snd_trident in 2.6.5 doesn't work after suspending
 to disk.
Date: Fri, 9 Apr 2004 13:18:42 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0404091318200.3733@pnote.perex-int.cz>
References: <20040409094649.GA19170@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040409094649.GA19170@localhost>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jakob Lell <jlell@jakoblell.de>
Cc: Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, 9 Apr 2004, Jakob Lell wrote:

> Hi,
> I'm using Linux 2.6.5 and the driver snd_trident. When I suspend to
> disk (echo -n 4 > /proc/acpi/sleep) and resume again, the sound driver
> won't work any more. It will work again after running rmmod
> snd_trident;modprobe snd_trident. However, to do so I have to kill all
> programs using sound (i.e. artsd, mplayer,...). Is there any way to
> make sound work again after suspending without terminating all
> this programs?

The trident driver does not have suspend/resume code yet.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
