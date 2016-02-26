From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH RESEND] ASoC: pxa: remove unused variable
Date: Fri, 26 Feb 2016 14:46:20 +0100
Message-ID: <2759692.ZNT2pvbZBk@wuerfel>
References: <1456437736-732609-1-git-send-email-arnd@arndb.de>
 <20160226011827.GA18327@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 by alsa0.perex.cz (Postfix) with ESMTP id 760642606C7
 for <alsa-devel@alsa-project.org>; Fri, 26 Feb 2016 14:46:31 +0100 (CET)
In-Reply-To: <20160226011827.GA18327@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-arm-kernel@lists.infradead.org
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org

On Friday 26 February 2016 10:18:27 Mark Brown wrote:
> On Thu, Feb 25, 2016 at 11:02:04PM +0100, Arnd Bergmann wrote:
> 
> > Submitted originally on Nov 23 2015, this apparently got lost,
> > resending it now.
> 
> You didn't really submit it, you pasted it into the middle of a reply to
> a message on an existing thread for a patch that was already applied:
> 
> https://lkml.org/lkml/2015/11/23/88
> 
> That's not really submitting a patch as far as I'm concerned, something
> that won't just apply with git am without special faffing isn't helping
> and things in the middle of threads aren't good either (it gets
> difficult to follow and there's every chance they'll never even get seen
> if they're buried in the middle of a reply where you don't expect to see
> a patch).

I see your point about the patch being in the middle of the thread.

Regarding the 'git am' compatibility, I thought I'd done it right,
but see now that I used incorrect scissors, apparently 'git mailinfo'
expects at least six '-' characters as the separator, while I used
just three.

	Arnd
