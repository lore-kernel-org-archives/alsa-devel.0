From: Andreas Mohr <andim2@users.sourceforge.net>
Subject: Re: [PATCH] AZT3328 driver update (#2)
Date: Sat, 17 Sep 2005 12:42:48 +0200
Message-ID: <20050917104248.GA12380@rhlx01.fht-esslingen.de>
References: <20050916234828.GA23429@rhlx01.fht-esslingen.de> <1126918534.4986.110.camel@mindpipe>
Reply-To: andi@lisas.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <1126918534.4986.110.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: andi@lisas.de, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

On Fri, Sep 16, 2005 at 08:55:34PM -0400, Lee Revell wrote:
> On Sat, 2005-09-17 at 01:48 +0200, Andreas Mohr wrote:
> > - FOUND the 1us DirectX timer area (yay!), made the code respect it properly
> 
> You should add support for the ALSA timer API if possible, it's actually
> quite simple.  This will allow the ALSA sequencer to use it.  See
> sound/pci/emu10k1/timer.c for an example.

Hah! I DID research it a bit (driver API docu, some drivers, ...),
but the result didn't make me believe ALSA would find this timer very useful.
I didn't even bother to ask about it any more since I was certain that there's
no support API.
Thanks a lot for mentioning it, against all odds!

I will add that support ASAP, however that shouldn't prevent anyone from
committing my current patch if wanted.

Thanks again,

Andreas Mohr


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
