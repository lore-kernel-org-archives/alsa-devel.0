From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Change of cold reset and ac97 register
	cache
Date: Sat, 19 Jan 2008 11:49:48 +0000
Message-ID: <20080119114947.GA22336@sirena.org.uk>
References: <87k5m91k93.fsf@polgara.paysbobval>
	<20080117132827.GA1248@rakim.wolfsonmicro.main>
	<87d4s0kurn.fsf@polgara.paysbobval>
	<20080118115122.GA22933@rakim.wolfsonmicro.main>
	<87y7amewvh.fsf@polgara.paysbobval>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 502B524538
	for <alsa-devel@alsa-project.org>; Sat, 19 Jan 2008 12:49:53 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <87y7amewvh.fsf@polgara.paysbobval>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Robert Jarzmik <rjarzmik@free.fr>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 18, 2008 at 08:50:42PM +0100, Robert Jarzmik wrote:

> As we said, I'll implement a machine dependent solution, assuming there'll be in
> the future a mecanism in ASoC v2 allowing hook inscription for the reset phase.
> I'll synchronize the cache in this specific function, and will wait ASoC to
> catch up or propose a patch.

For the benefit of the archives: the root issue here is that AC97 reset
has problems working as documented with the SoC CPU being used here so
it is normally done using a GPIO line on the CPU.  Robert is working on
a consumer device for which he doesn't have hardware documentation so is
unable to generate a working reset to the chip.
