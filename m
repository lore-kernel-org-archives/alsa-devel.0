From: Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: ALSA patch for 2.5.4
Date: Mon, 11 Feb 2002 19:23:02 -0500
Message-ID: <3C686066.91B06D84@mandrakesoft.com>
References: <Pine.LNX.4.31.0202111429270.500-100000@pnote.perex-int.cz> <1013472766.19794.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Received: from www.linux.org.uk (IDENT:exim@parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id BAA11381
	for <alsa-devel@alsa-project.org>; Tue, 12 Feb 2002 01:23:19 +0100
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Dan Mann <mainlylinux@attbi.com>
Cc: Jaroslav Kysela <perex@perex.cz>, ALSA development <alsa-devel@alsa-project.org>, LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@transmeta.com>
List-Id: alsa-devel@alsa-project.org

Dan Mann wrote:
> On Mon, 2002-02-11 at 09:16, Jaroslav Kysela wrote:
> >       I repeat myself but anyway. We are open to any suggestions and
> > ideas for this kernel integration patch. Unfortunately, Linus has not
> > approved this directory tree and he is not talking with us at the time.
> > It seems that BIO changes are over, but he's probably busy enough to
> > ignore our e-mails with co-operation requests.

> There are at least 2 reasons that I can see why Linus probably won't
> accept your patch:
> 
>         1. It is not an inline text attachment (it is a URL).
>         2. It is 79,000 lines long

Well, merging ALSA is going to be one big mother of a patch no matter
how you slice it :)

But I agree, it would be nice for the patch to be broken up into steps,
ie. first patch moves OSS drivers into new location, second patch adds
infrastructure, third patch adds the 1001 drivers that ALSA supports :)

Also if the ALSA guys wanted to experiment with BK, that would be a
great way to do the merge.

	Jeff



-- 
Jeff Garzik      | "I went through my candy like hot oatmeal
Building 1024    |  through an internally-buttered weasel."
MandrakeSoft     |             - goats.com

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
