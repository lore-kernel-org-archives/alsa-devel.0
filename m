From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: EMU10K1 and the extra voice
Date: Sun, 6 Jun 2004 12:38:22 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0406061234350.1780@pnote.perex-int.cz>
References: <20040605125936.GA3478@lost.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040605125936.GA3478@lost.org.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Chris Purnell <cjp@lost.org.uk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sat, 5 Jun 2004, Chris Purnell wrote:

> For PCM playback the EMU10K1 driver is allocating an extra voice.
> This is somewhat wastefull and I kind of need all 64 voices.
> Is appears to be using it to generate the period interrupts.
> Does anyone know what it would take to rewrite the driver to
> not need this extra voice?

I'm not sure, if it's possible in a simple way. The extra voice is
required to do the proper interrupt acknowledge. If I remember correctly,
the interrupts are going faster than voice position otherwise.

Anyway, it wouldn't be a big problem to update driver and create a new 
(ONE!) PCM device with multiple mixed channels (up to 63).

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
