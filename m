From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Many problems: no midi, jackd errors, hdspmixer
 segfault still, general speed
Date: Fri, 29 Oct 2004 09:31:09 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0410290926460.12522-100000@studcom.urz.uni-halle.de>
References: <200410290113.i9T1DrQL017748@sanctuary.aproximation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailgate.uni-halle.de (mailgate.urz.uni-halle.de [141.48.3.51])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id E878B261
	for <alsa-devel@alsa-project.org>; Fri, 29 Oct 2004 10:07:50 +0200 (MEST)
In-Reply-To: <200410290113.i9T1DrQL017748@sanctuary.aproximation.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: thewade <pdman@aproximation.org>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

thewade wrote:
> I have no rawmidi module! What do I have to enable to get my
> kernel build to include this?
> [pdman at musicbox linux]$ cat .config | grep RAWMIDI
> CONFIG_SND_RAWMIDI=y

"y" means that it's built into the kernel, i.e. there is no separate
module.

> The midi does not work with my multiface:
>
> [pdman at musicbox pdman]$ aconnect -li
> client 0: \'System\' [type=kernel]
>     0 \'Timer           \'
>     1 \'Announce        \'

Does the driver show up in /proc/asound/cards? Is there a MIDI device
in /proc/asound/devices? Does "amidi -l" say anything?


Clemens



-------------------------------------------------------
This Newsletter Sponsored by: Macrovision 
For reliable Linux application installations, use the industry's leading
setup authoring tool, InstallShield X. Learn more and evaluate 
today. http://clk.atdmt.com/MSI/go/ins0030000001msi/direct/01/
