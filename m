From: =?iso-8859-1?q?Chris=20Rankin?= <rankincj@yahoo.com>
Subject: Re: EMU10K1 - CVS: nasty "click" at end of WAV files, and spurious extra modules.
Date: Fri, 31 Jan 2003 19:56:51 +0000 (GMT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030131195651.81705.qmail@web40605.mail.yahoo.com>
References: <s5hptqdshsi.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hptqdshsi.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

 --- Takashi Iwai <tiwai@suse.de> wrote:
> do you know which version (or date) the driver
> worked without clicks?
> there have been not many changes for emu10k1 or pcm
> stuffs recently.

On a hunch, I downloaded the alsa-lib-0.9.0rc6 and
alsa-util-0.9.0rc6 packages and tried those against
the current CVS version of the kernel modules. There
is no nasty clicking sound using 0.9.0rc6 userspace.

Even more interesting:

alsa-lib 0.9.0rc6 + alsa-utils CVS => CLICK!
alsa-lib CVS + alsa-utils 0.9.0rc6 => No click.

I'm guessing that the problem lies in aplay.

Chris


__________________________________________________
Do You Yahoo!?
Everything you'll ever need on one web page
from News and Sport to Email and Music Charts
http://uk.my.yahoo.com


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
