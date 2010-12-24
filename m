From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 0/9] ASoC: codecs: Fix register cache
	incoherencies
Date: Fri, 24 Dec 2010 16:38:41 +0100
Message-ID: <4D14BE81.6000907@metafoo.de>
References: <1293198484-1902-1-git-send-email-lars@metafoo.de>
	<20101224145706.GA16614@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
	(mailhost.informatik.uni-hamburg.de [134.100.9.70])
	by alsa0.perex.cz (Postfix) with ESMTP id 1D42C246E4
	for <alsa-devel@alsa-project.org>; Fri, 24 Dec 2010 16:39:01 +0100 (CET)
In-Reply-To: <20101224145706.GA16614@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On 12/24/2010 03:57 PM, Mark Brown wrote:
> > On Fri, Dec 24, 2010 at 02:47:55PM +0100, Lars-Peter Clausen wrote:
>> >> The multi-component patch(commit f0fba2ad1) introduced a generic register cache
>> >> framework. Most of the drivers where converted to use this new framework. But
> >
> > No it didn't - soc-cache.c has been present since the middle of 2009.
Hm. Ok, you are right, I've should have checked more closely. Only the allocation of
the register cache was moved from the drivers to the core.

So the commit messages should have been along the lines of:
	The multi-component patch(commit f0fba2ad1) moved the alloction of the
	register cache from drivers to the ASoC core. While most of the drivers were
	converted to respect this change, some still maintain their own register
	cache besides the one used and allocated by the core.
	Thus the device ends up with two from each other incoherent caches, which
	can lead to undefined behaviour.

If there are no other issues with this series, I'll resend it with adjusted commit
messages in a few days.

- Lars
