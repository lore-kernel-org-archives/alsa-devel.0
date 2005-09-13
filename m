From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Problems with Hercules DJ Console and the usb-audio
 driver
Date: Tue, 13 Sep 2005 17:58:07 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0509131756100.3875-100000@studcom.urz.uni-halle.de>
References: <20050913140934.GA24953@nittionio.nu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050913140934.GA24953@nittionio.nu>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Daniel Svensson <nano@nittionio.nu>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Daniel Svensson wrote:
> Here is the output of "amixer scontents":
> ...
> Which doesn't match alsamixer controls very well (in count and names).

What is the output of "amixer contents"?

> Ok, so some progress. The device accepts S16, 6 channels, 48kHz.
> Still no output, fails with kernel message:
>
> ALSA /hom.../usbaudio.c:807: cannot submit datapipe for urb 5, err = -28

28 = ENOSPC.  Please disable bandwidth checking in the kernel
configuration.  (This is a bug of your distribution unless you
compiled the kernel yourself.)


HTH
Clemens



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
