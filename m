From: Tim Goetze <tim@quitte.de>
Subject: Re: rc2 - snd-via82xx - really sounds bad - distorted,
 resampled, phasey
Date: Mon, 8 Dec 2003 00:39:39 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0312080024270.519@autumn>
References: <1070820195.3841.42.camel@Wizard.knechthome.com>
 <3FD3716A.9010009@boosthardware.com> <1070833482.2913.82.camel@Wizard.knechthome.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1070833482.2913.82.camel@Wizard.knechthome.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Mark Knecht <markknecht@comcast.net>
Cc: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Mark Knecht wrote:

>   Hi. Ok, since you suggested it I set up this Via 8235 sound chip on
>my system as the primary sound chip. However, it's sounding amazingly
>bad! It's terribly distorted and even at the best of times sounds very,
>very,phasey. I can pretty much hear what sound like terrible resampling
>noise, maybe like it's going from 44.1K up to 48K or something.

have you played around with the via82xx 'dxs_support' module parameter
yet? your modules.conf suggests you haven't. the driver didn't guess
the value right on this box fwiw, i had to set it manually.

add 'options snd-via82xx dxs_support=X' to modules.conf where 0 < X <= 4.
there's some comments at the head of alsa-kernel/pci/via82xx.c that
shed some more light on the issue.

hth,

tim


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
