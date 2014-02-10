From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH 0/7] Audio support for Armada 370 DB
Date: Mon, 10 Feb 2014 16:04:32 +0100
Message-ID: <20140210160432.27281741@skate>
References: <1391102051-5319-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140210152141.1391fb67@skate>
 <20140210145729.GP1757@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.free-electrons.com (top.free-electrons.com [176.31.233.9])
 by alsa0.perex.cz (Postfix) with ESMTP id 24967261A91
 for <alsa-devel@alsa-project.org>; Mon, 10 Feb 2014 16:04:35 +0100 (CET)
In-Reply-To: <20140210145729.GP1757@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>, alsa-devel@alsa-project.org, Jason Cooper <jason@lakedaemon.net>, Liam Girdwood <lgirdwood@gmail.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: alsa-devel@alsa-project.org

Mark,

On Mon, 10 Feb 2014 14:57:29 +0000, Mark Brown wrote:

> > Any comments on the patch series? I'd like these to be included in
> > 3.15, and so far I've only received one simple comment from Jason
> > Cooper regarding the defconfig changes, but no other comments.
> 
> Don't send contentless pings, they're more noise in the inbox.  In this
> case the fact that you didn't use subject lines matching the subsystem
> means that they tend to get pushed down my list (or more exactly don't
> come up when I search for patches for the subsystems I maintain).  If
> your subject lines stand out in git shortlog output for the area you're
> working on that's generally an issue, for example with ASoC you're
> looking for an "ASoC: ".

Sure, sorry. The patches that are of interest to you are prefixed by
"sound: codec" (for the patch touching sound/soc/codecs) and "sound:
soc" (for the patches touching sound/soc/kirkwood).

If you want, I can resend with subject lines containing 'ASoC:',
however maybe it's better if some other comments are made before, to
avoid additional noise.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
