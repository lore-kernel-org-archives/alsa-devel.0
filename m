From: Tim Goetze <tim@quitte.de>
Subject: Re: Testers of M-Audio Delta/Audiophile cards wanted
Date: Thu, 19 Sep 2002 16:50:13 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.21.0209191647190.595-100000@summer.quitte>
References: <s5h65x2qbo7.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h65x2qbo7.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

>At Thu, 19 Sep 2002 16:35:19 +0200 (CEST),
>Tim Goetze wrote:

[ak4524_t undefined ...]

>> make: *** [ews.o] Error 1
>> make: Leaving directory
>> `/home/tim/audio/alsa-cvs/alsa-driver/pci/ice1712'
>
>could you check whether ice1712.h exists on alsa-kernel/pci/ice1712?
>also, please check whether the file with the same name exists
>somewhere in alsa-driver/include?

[~/audio/alsa-cvs/alsa-driver] find .. -name "ice1712.h"
../alsa-kernel/pci/ice1712/ice1712.h
[~/audio/alsa-cvs/alsa-driver] file alsa-kernel
alsa-kernel: symbolic link to ../alsa-kernel

tim



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
