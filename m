From: Olivier Blin <olivierblin@club-internet.fr>
Subject: Re: kernel oops with snd-intel8x0 driver and Sis7012
 chipset
Date: Sun, 14 Sep 2003 19:52:43 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030914195243.33cf44da.olivierblin@club-internet.fr>
References: <20030912025815.5ce81395.olivierblin@club-internet.fr>
	<s5hekymcrsp.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hekymcrsp.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

> please check whether the compiler is correct (the exactly same
> compiler which is used for the kernel), and check the compile option
> whether -fomit-frame-pointer is NOT set.
> also, trying cvs version is recommended in such a case, since i'm
> working only on the latest version, too.

I now use alsa compiled without  -fomit-frame-pointer and it works
a lot better, thanks for your help.

aplay still segfaults with some files (without kernel oops), I'll try
to track it.

-- 
Olivier Blin


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
