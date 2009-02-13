From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH]: ARM DaVinci ASoC: Fix module unload error
Date: Fri, 13 Feb 2009 20:31:09 +0000
Message-ID: <20090213203109.GB6410@sirena.org.uk>
References: <1234508979-13522-1-git-send-email-chaithrika@ti.com>
	<20090213133057.GC31085@sirena.org.uk>
	<87fxiijfi2.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 280FC24355
	for <alsa-devel@alsa-project.org>; Fri, 13 Feb 2009 21:31:52 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <87fxiijfi2.fsf@deeprootsystems.com>
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
Cc: chaithrika@ti.com, alsa-devel@alsa-project.org, davinci-linux-open-source@linux.davincidsp.com
List-Id: alsa-devel@alsa-project.org

On Fri, Feb 13, 2009 at 11:36:37AM -0800, Kevin Hilman wrote:

> This patch is against DaVinci git[1], which still has some differences
> compared to the upstream trees.

> Below is a version of this patch against Linus' tree, with the SFFSDR
> board changes from Hugo included.

Applied, thanks.  Is there any plan in place for bringing the DaVinci
tree into sync with mainline here?  It'd help avoid issues like this in
future.
