From: Olivier Blin <olivierblin@club-internet.fr>
Subject: Re: kernel oops with snd-intel8x0 driver and Sis7012
 chipset
Date: Fri, 12 Sep 2003 12:46:37 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030912124637.66bf2f0e.olivierblin@club-internet.fr>
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

On Fri, 12 Sep 2003 10:52:22 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> are you sure aplay segfaults with the same oops?

Sorry, I haven't checked, I'll tell you in a few hours.

> the oops in resample_expand() was known in the ealier 2.6.0-test
> kernels when it's build without frame pointer.  but it appears only on
> OSS emulation.
> also, in the recent version, at least 0.9.6, it no longer appears.

It is fixed in 2.6.0-test kernels (at least no problem with kernel >=
test4), but not in 2.4.22 pre kernels.

> anyway the oops you've seen is not the problem of intel8x0 driver but
> in the somewhere core part.
> 
> please check whether the compiler is correct (the exactly same
> compiler which is used for the kernel), and check the compile option
> whether -fomit-frame-pointer is NOT set.

I'll check all this

> also, trying cvs version is recommended in such a case, since i'm
> working only on the latest version, too.

ok, i'll stick to cvs from now


-- 
Olivier Blin


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
