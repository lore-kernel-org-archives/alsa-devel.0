From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V5 1/5] powerpc: introduce macro
	spin_event_timeout()
Date: Tue, 26 May 2009 14:03:01 +0100
Message-ID: <20090526130301.GE8969@sirena.org.uk>
References: <20090526123235.17472.73912.stgit@terra>
	<20090526123406.17472.79948.stgit@terra>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 815F11038AA
	for <alsa-devel@alsa-project.org>;
	Tue, 26 May 2009 15:03:05 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090526123406.17472.79948.stgit@terra>
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
Cc: grant.likely@secretlab.ca, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, timur@freescale.com
List-Id: alsa-devel@alsa-project.org

On Tue, May 26, 2009 at 08:34:06AM -0400, Jon Smirl wrote:
> The macro spin_event_timeout() takes a condition and timeout value
> (in microseconds) as parameters.  It spins until either the condition is true
> or the timeout expires.  It returns the result of the condition when the loop
> was terminated.

As previously mentioned you need to submit any changes you want to make
here as incremental patches against the PowerPC tree rather than as an
entire new patch.  If you are forwarding on copies of the patch you
really ought to preserve Timur's authorship too with a From line in the
mail.
