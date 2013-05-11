From: Marc Dietrich <marvin24@gmx.de>
Subject: Re: [PATCH 5/5] tegraalc5632: add UCM config fromUbuntu
Date: Sat, 11 May 2013 16:15:49 +0200
Message-ID: <1786278.dYWLQAQjL2@ax5200p>
References: <1368190270-29647-1-git-send-email-marcin@juszkiewicz.com.pl>
 <518D1EE3.10205@wwwdotorg.org> <20130510205330.GT3200@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 by alsa0.perex.cz (Postfix) with ESMTP id 4307B261A44
 for <alsa-devel@alsa-project.org>; Sat, 11 May 2013 16:16:36 +0200 (CEST)
Received: from mailout-de.gmx.net ([10.1.76.34]) by mrigmx.server.lan
 (mrigmx002) with ESMTP (Nemesis) id 0MB0os-1UiuNL440q-00A2AJ for
 <alsa-devel@alsa-project.org>; Sat, 11 May 2013 16:16:35 +0200
In-Reply-To: <20130510205330.GT3200@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Stephen Warren <swarren@wwwdotorg.org>, Marcin Juszkiewicz <marcin@juszkiewicz.com.pl>, Liam Girgwood <liam.r.girdwood@linux.intel.com>, Luke Yelavich <themuso@ubuntu.com>, Mark Brown <broonie@kernel.org>, Peter Robinson <pbrobinson@gmail.com>, Andrey Danin <danindrey@mail.ru>, Leon Romanovsky <leon@leon.nu>, Jordi Mallach <jordi@debian.org>
List-Id: alsa-devel@alsa-project.org

Hi,

On Friday 10 May 2013 21:53:30 Mark Brown wrote:
> On Fri, May 10, 2013 at 10:22:59AM -0600, Stephen Warren wrote:
> > "alc5632" is the name of the audio CODEC, which could be used in a
> > variety of different boards, each of which might require a different UCM
> > configuration. Shouldn't the file be named based on the board name. At
> 
> Yes, it should.

I like to help out, but I'm also unfamiliar with UCM profiles. This 
configuation belong to the AC100 netboot (board name paz00) and a single hifi 
use case would be sufficient for now. http://www.alsa-
project.org/main/index.php/Use_Case_Manager doesn't give much info. Andrey, 
Leon, any idea?

Marc

> 
> > I also notice that this file doesn't define any use-cases/verbs/...
> > Presumably a Linux-based OS would expect a certain set of them to exist,
> > and they'd be implemented/named consistently across all UCM configs?
> 
> I'd expect them to at least fall back to assuming some default thing is
> available - having a model that is more "do I need to do something
> special for this mode".  Being able to give at least some basic
> functionality from a minimal starting point seems sensible.
