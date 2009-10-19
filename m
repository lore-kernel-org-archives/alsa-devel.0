From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/14] sound/soc: Move dereference after
	NULL test
Date: Mon, 19 Oct 2009 16:12:52 +0100
Message-ID: <20091019151251.GB29796@sirena.org.uk>
References: <Pine.LNX.4.64.0910170832300.9213@ask.diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 6E283243CF
	for <alsa-devel@alsa-project.org>;
	Mon, 19 Oct 2009 17:12:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0910170832300.9213@ask.diku.dk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Julia Lawall <julia@diku.dk>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Sat, Oct 17, 2009 at 08:32:56AM +0200, Julia Lawall wrote:
> From: Julia Lawall <julia@diku.dk>
> 
> If the NULL test on jack is needed, then the derefernce should be after the
> NULL test.

Applied, thanks.
