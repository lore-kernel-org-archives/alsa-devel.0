From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: kernel 2.6 bug
Date: Fri, 19 Dec 2003 09:21:43 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0312190917210.25201-100000@studcom.urz.uni-halle.de>
References: <3FE21B72.8090200@esitcom.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <3FE21B72.8090200@esitcom.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Amaury Jacquot <sxpert@esitcom.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Amaury Jacquot wrote:
> I tried the 2.6 kernel today, and have a bug
>
> using snd-usb-audio with the oss emulation
>
> bad: scheduling while atomic!
> Call Trace:
>   [<c011bdea>] schedule+0x70a/0x710
> ...
>   [<c026218a>] usb_unlink_urb+0x2a/0x30
>   [<c02a7ad8>] deactivate_urbs+0xb8/0xc0
> ...

This bug has been fixes in recent ALSA versions.

In usbaudio.c, replace the line

	/* #define SND_USE_ASYNC_UNLINK */

with

	#define SND_USB_ASYNC_UNLINK


HTH
Clemens




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
