From: Daniel Svensson <nano@nittionio.nu>
Subject: Re: Problems with Hercules DJ Console and the usb-audio driver
Date: Wed, 14 Sep 2005 15:23:46 +0200
Message-ID: <20050914132346.GA18354@nittionio.nu>
References: <20050913140934.GA24953@nittionio.nu> <Pine.HPX.4.33n.0509131756100.3875-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.HPX.4.33n.0509131756100.3875-100000@studcom.urz.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 13, 2005 at 05:58:07PM +0200, Clemens Ladisch wrote:
> What is the output of "amixer contents"?
See the first mail in this thread.

> 28 = ENOSPC.  Please disable bandwidth checking in the kernel
> configuration.  (This is a bug of your distribution unless you
> compiled the kernel yourself.)

I use kernel 2.6.12-1-686, supplied by Debian. I'll forward your mail to
the maintainer. Disabling CONFIG_USB_BANDWIDTH did the trick. I have
sound working now (all channels tested).

So a resume of changes to minimal support for this device. 

1. Classify the MIDI interface as standard MIDI interface.
2. Ignore mixer errors.
http://sourceforge.net/mailarchive/message.php?msg_id=12931847

3. Disable CONFIG_USB_BANDWIDTH

However, as Takashi Iwai said, ignoring mixer elements is not very nice
(Delay Control brings errors if not ignored), and the MIDI patch needs 
some love too. 

And the names of the mixer elements are not correct

Here's a summary of the alsamixer elements vs real names

1 (multi)
 1.1 - Front Left
 1.2 - Front Right

2 (multi)
 2.1 - Rear Right
 2.2 - Front Center

3 (single) - Rear Left

4 (single) - Woofer

Is it perhaps possible to have Rear Left/Right on the same element?
Currently they're all named 'PCM', Front, Rear, Center, Woofer would be
good names. 

This probably sums up what has to be done to get support for this device
into ALSA. Does Capture need to be working before support enters ALSA or
that can wait? 

-- 
Daniel Svensson <nano@nittionio.nu>


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
