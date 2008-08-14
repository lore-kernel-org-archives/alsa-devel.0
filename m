From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: ASoC machine driver: use more than one at91 ssc
Date: Thu, 14 Aug 2008 10:10:12 +0100
Message-ID: <20080814091009.GC23994@sirena.org.uk>
References: <loom.20080812T193653-308@post.gmane.org>
	<loom.20080813T060220-577@post.gmane.org>
	<20080813094706.GB30710@sirena.org.uk>
	<loom.20080813T163128-717@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 23952103892
	for <alsa-devel@alsa-project.org>;
	Thu, 14 Aug 2008 11:10:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <loom.20080813T163128-717@post.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Simon Tremblay <bidou@videotron.qc.ca>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 13, 2008 at 04:49:37PM +0000, Simon Tremblay wrote:

> But just for to test, I activated only SSC1 and I got a weird problem. When my
> machine driver module is loaded, I hear something from my headphone like it
> "synced" with console serial output (I hear noise when characters are
> transmitted to console serial output). But I don't know if there is something
> about not activating SSC0 that could cause that...

That might be better addressed to an Atmel related list but (aside from
hardware problems) one thing to check is if there are any multi-function
pins they are all configured in the correct fashion.
