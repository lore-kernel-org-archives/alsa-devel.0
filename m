From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Debugged improper setting of PLL fields in
	WM8580	driver
Date: Tue, 1 Sep 2009 11:47:37 +0100
Message-ID: <20090901104737.GC18651@sirena.org.uk>
References: <1b68c6790908311935l190e5912k974894974ed65a70@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id A80342443E
	for <alsa-devel@alsa-project.org>;
	Tue,  1 Sep 2009 12:47:37 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1b68c6790908311935l190e5912k974894974ed65a70@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: jassi brar <jassisinghbrar@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 01, 2009 at 11:35:08AM +0900, jassi brar wrote:

>    Bug was caught while trying to use WM8580 as I2S master on SMDK.
>    Symptoms were lesser LRCLK read by CRO(41.02 instead of 44.1 KHz)
>    Solved by referring to WM8580A manual and setting mask value correctly
>    and making the code to not touch 'reserved' bits of PLL4 register.

>    Signed-off-by: Jassi <jassi.brar@samsung.com>

I've applied this, thanks.  However, I had to hand hack the patch to
apply it since it was broken in several ways - your MUA had word wrapped
it and there was a missing line at the end of the patch.  Please try to
avoid these issues, hand fixups are time consuming and only possible for
very small patches.  Also, it looks like you used the output of git show
for the patch - doing that corrupts the commit message by indenting it,
you should use git format-patch for e-mail.

I'd suggest looking into using git format-patch and git send-email to
send patches, they will get most things right for you.  The GMail web
interface definately doesn't work for this, if that is all you have
access to due to firewall restrictions you'll need to use an attachment
rather than sending the patch in the body of the e-mail as normal.  If
your firewall is a bit more open then GMail supports sending via SMTP
which allows you to use git send-email to avoid the word wrapping.
