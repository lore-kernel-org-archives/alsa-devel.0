From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V2 0/9] mpc5200 audio rework for AC97
Date: Sun, 24 May 2009 12:08:54 +0100
Message-ID: <20090524110854.GB4933@sirena.org.uk>
References: <20090523231148.17919.46103.stgit@terra>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 658D324349
	for <alsa-devel@alsa-project.org>;
	Sun, 24 May 2009 13:09:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090523231148.17919.46103.stgit@terra>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: grant.likely@secretlab.ca, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, May 23, 2009 at 07:12:55PM -0400, Jon Smirl wrote:

[Jon, could you please fix the word wrapping in your MUA, there's none
at all which makes it more difficult than it needs to be to respond to
your e-mail.]

> Mark is not enthused about soc-of-simple.c so rather than extend it
> for AC97 I altered the drivers to not use it. Instead they use the old
> way of manually binding everything. Mark would like to see OF binding
> more closely integrated to the core. Once a proper solution for OF

I really don't feel that this reflects the issues I had with the code
well.  There are two basic issues here:

 - You had been trying to represent the AC97 CODEC drivers as platform
   devices which is not a good approach, largely since AC97 is a real
   bus and should be represented as such.

 - soc-of-simple really should be merged into the core now, there's no
   need to have to add changes to individual drivers any more since
   drivers are already regstering with the core.

These two points are basically unrelated except in that your motiviation
for doing the platform device thing was trying to fit your machine
drivers into the existing soc-of-simple framework.  It's the changes to
the cross-platform AC97 drivers that were causing real problems,
soc-of-simple is only an issue in that using it motivates these other
changes.

> binding is agreed upon it is easy to convert the existing drivers. A
> first step would be converting the existing codec drivers so that they
> can be dynamically loaded.

I'm not aware of any CODEC drivers which can't currently be built and
used as modules.  If you mean "load via the normal device model" then
yes, that'd be very good (and is in progress) but it's another issue and
as I explained last time AC97 poses particular problems there.
