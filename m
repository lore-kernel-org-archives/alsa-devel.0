From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Compulab sound device
Date: Mon, 15 Aug 2005 13:32:27 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0508151323470.21757-100000@studcom.urz.uni-halle.de>
References: <20050815083943.89306.qmail@web54607.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050815083943.89306.qmail@web54607.mail.yahoo.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Chow Raymond <usher_raymond82@yahoo.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Chow Raymond wrote:
> --- Clemens Ladisch <clemens@ladisch.de> wrote:
> > An AC'97 codec is always connected to an AC'97
> > controller.  It's the
> > controller that would be supported (or not) by ALSA.
>
> Umm..so is the ac97 controller supported by ALSA?

Yes.  The Compulab website says it's using a PXA255 chip,
and the "AC97 driver for the Intel PXA2xx chip" should
support it.

> I select that driver during kernel configuration (Sound
> -> ALSA -> ALSA Arm Devices). However, when i flash
> the kernel into the Compulab Armcore, it could not
> detect any sound devices.
>
> [root@ARMCore root]$ cat /proc/asound/version
> Advanced Linux Sound Architecture Driver Version 1.0.4

I don't think you were able to select the PXA driver
with that ALSA version.

Get the CVS version of ALSA, and try to copy the
contents of the alsa-kernel/arm/ directory into your
kernel's sound/arm/ directory.


HTH
Clemens



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
