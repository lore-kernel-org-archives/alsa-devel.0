From: Christoph Hellwig <hch@infradead.org>
Subject: Re: Re: [linuxsh-dev] [PATCH] ALSA driver for Yamaa AICA on Sega Dreamcast
Date: Tue, 18 Apr 2006 12:52:24 +0100
Message-ID: <20060418115224.GA8591@infradead.org>
References: <1145232784.12804.2.camel@localhost.localdomain> <20060417012913.GA16821@linux-sh.org> <1145304037.9244.27.camel@localhost.localdomain> <1145310435.16138.83.camel@mindpipe> <20060417220512.GA16119@infradead.org> <s5hhd4r9ohh.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hhd4r9ohh.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>, Lee Revell <rlrevell@joe-job.com>, Adrian McMenamin <adrian@mcmen.demon.co.uk>, Paul Mundt <lethal@linux-sh.org>, Alsa-devel <alsa-devel@lists.sourceforge.net>, linux-sh <linuxsh-dev@lists.sourceforge.net>, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 18, 2006 at 12:17:46PM +0200, Takashi Iwai wrote:
> Heh, the suggested line is what CondingStyle suggets -- the output of
> indent program.  Yeah, but better to fix "bad programming" :)

indent only fixes indentation.  Moving the if check to a different line
as the function call changes more than indentation so indent doesn't do it.
Yes, there's more to code codingstyle than just running indent :)



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
