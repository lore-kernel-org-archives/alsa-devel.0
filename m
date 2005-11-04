From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: getting started: USBpre support
Date: Fri, 04 Nov 2005 16:03:05 +0100
Message-ID: <1131116585.436b78293c8f2@webmail.uni-halle.de>
References: <loom.20051030T175159-949@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <loom.20051030T175159-949@post.gmane.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jim Carroll <jim@maplesong.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Jim Carroll wrote:
> I'm having trouble getting started writing an alsa driver for my Sound
> Devices USBpre microphone interface.  It is a full sound card, playing and
> recording full duplex, but it also drives my condenser microphones with
> phantom power.
>
> I've been reading the linux kernel driver book, and Takashi Iwai's
> writing-an-alsa-driver.pdf, but neither are quite applicable to my hardware.
>
> What else can I read to get started?

Linux USB documentation, USB Audio specification

> I've been looking at the generic usb alsa driver, and starting to modify it
> for my usb device...

What changes are needed?  How does the USBpre differ from class-compliant
devices?

> does anyone have a similar stand-alone kernel module project that I could use
> as a starting place?

drivers/usb/class/audio.c is somewhat similar to usbaudio.c.

> I have some windows source for reference on how to talk to the USBpre.

Can it be published somewhere?


Regards,
Clemens


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
