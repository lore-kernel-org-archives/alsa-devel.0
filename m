From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/9] ARM: DaVinci: ASoC: Adds ASoC
	driver	support for TI DM646X EVM platform
Date: Thu, 19 Mar 2009 19:19:35 +0000
Message-ID: <20090319191935.GB8966@sirena.org.uk>
References: <1237204945-30039-1-git-send-email-naresh@ti.com>
	<200903161038.05404.david-b@pacbell.net>
	<87r60tl8nt.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 4A99E24418
	for <alsa-devel@alsa-project.org>; Thu, 19 Mar 2009 20:19:44 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <87r60tl8nt.fsf@deeprootsystems.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: David Brownell <david-b@pacbell.net>, davinci-linux-open-source@linux.davincidsp.com, Naresh Medisetty <naresh@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 19, 2009 at 10:33:26AM -0700, Kevin Hilman wrote:

> That being said, some effort should be made to split out the
> chip/board specific settings into platform data which can be managed
> by chip/board specific code.

That is the current design: the chip drivers should all be completely
generic and work on any board using that chip.  For SoC side drivers
this includes things like the platform resources for the device (this is
why I was pushing back on the platform data in the machine driver).  The
board specific drivers should just configure the interconnections
between the codec and SoC drivers, including things like the clocking.
