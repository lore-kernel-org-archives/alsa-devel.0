From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Allow 32bits registers
Date: Mon, 8 Jun 2009 10:50:32 +0100
Message-ID: <20090608095031.GB7858@sirena.org.uk>
References: <1244353751.9532.5.camel@brutus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id C8D9410380F
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Jun 2009 11:50:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1244353751.9532.5.camel@brutus>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Ribeiro <drwyrm@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, openezx-devel <openezx-devel@lists.openezx.org>
List-Id: alsa-devel@alsa-project.org

On Sun, Jun 07, 2009 at 02:49:11AM -0300, Daniel Ribeiro wrote:
> Replace the remaining unsigned shorts with unsigned ints.
> Tested with pcap2 codec (25 bits registers).
> 
> Signed-off-by: Daniel Ribeiro <drwyrm@gmail.com>

Thanks, I've applied this.  Given that the merge window is *very* close
and this is a fairly high risk change (in that it could affect a lot of
drivers) I've created a for-2.6.32 branch and applied it there.  I think
the change is perfectly safe but I'd rather be cautious.

BTW, there was one unrelated coding style change in there.
