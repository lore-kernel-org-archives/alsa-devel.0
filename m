From: Clemens Lang <clemens.lang@bmw-carit.de>
Subject: Re: Possible GPL-licensed header included in alsa-lib
Date: Thu, 11 Dec 2014 09:55:43 +0100
Message-ID: <20141211085543.GI22300@ulm-bmuc496424.bmw-carit.de>
References: <20141209174917.GC22300@ulm-bmuc496424.bmw-carit.de>
 <54874207.5030609@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bmw-carit.de (mail.bmw-carit.de [62.245.222.98])
 by alsa0.perex.cz (Postfix) with ESMTP id 98C652606CC
 for <alsa-devel@alsa-project.org>; Thu, 11 Dec 2014 09:55:50 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <54874207.5030609@perex.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 09, 2014 at 07:40:07PM +0100, Jaroslav Kysela wrote:
> > Two questions:
> >  1. Have the copyright holders of the code in question agreed to
> >     re-license under a different, LGPL-preserving license and, if yes,
> > 	is there some documentation about that?
> 
> I don't think so.. Not sure how difficult would be to gather the
> original authors from the 2.4 code.

>From what I can see the file appeared in 2.1.45. I haven't had enough
time to do so yet, but I will try looking into the lkml archives --
maybe I can find the patch that created it.

> >  2. If the header is indeed covered by GPL-2.0, would you accept patches
> >     to replace it with a different implementation, e.g. Rusty Russell's
> > 	MIT-licensed list from ccan[2]?
> 
> It could be solution, but the current code seems a bit less complicated.

I'm sure I could simplify the implementation and remove the features not
needed by alsa.


> Could you try to obtain list of original authors from linux 2.4 ? I
> think I can ask about the licence change.

I'm working on it and will get back to you once I have some results (or
given up).

Best regards,
Clemens
