From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] OPL4 support
Date: Mon, 24 Mar 2003 10:33:12 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0303241031280.23754-100000@studcom.urz.uni-halle.de>
References: <Pine.LNX.4.44.0303241022570.1189-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <Pine.LNX.4.44.0303241022570.1189-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> On Mon, 24 Mar 2003, Clemens Ladisch wrote:
> > This adds support for the mixer and wavetable synthesizer of OPL4 chips.
> >
> > The OPL4 can be used with OPTi 82C928/Mozart, 82C929 and 82C924 cards
> > (82C925 and 82C93x have an integrated OPL3 and don't support an external
> > OPLx chip).
>
> Is there any reason why this code is in isa/opl4? The code looks generic,
> so we can put it to drivers/opl4 as well.

The OPL4 has never been used except with the above ISA cards AFAIK.
Anyway, either directory is fine with me.


Regards,
Clemens




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
