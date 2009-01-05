From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [patch 2.6.28-git] ASoC: fix davinci-sffsdr buglet
Date: Mon, 5 Jan 2009 11:04:12 +0000
Message-ID: <20090105110359.GA28006@sirena.org.uk>
References: <200901050208.30918.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id A5CA61037EE
	for <alsa-devel@alsa-project.org>; Mon,  5 Jan 2009 12:04:15 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <200901050208.30918.david-b@pacbell.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Brownell <david-b@pacbell.net>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 05, 2009 at 02:08:30AM -0800, David Brownell wrote:
> From: David Brownell <dbrownell@users.sourceforge.net>

> DaVinci ASoC: fix multiboard buglet

> Minor bugfix:  now that DaVinci kernels can support multiple
> boards, board-specific ASoC components need to verify they're
> running on the right board before initializing.

Applied, thanks (note that you seem to have multiple subject lines in
there, BTW).
