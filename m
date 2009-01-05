From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC updates
Date: Mon, 5 Jan 2009 21:09:18 +0000
Message-ID: <20090105210918.GA21839@opensource.wolfsonmicro.com>
References: <20090105175633.GA24696@rakim.wolfsonmicro.main>
	<s5hocylpj9a.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E6C02103835
	for <alsa-devel@alsa-project.org>; Mon,  5 Jan 2009 22:09:18 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hocylpj9a.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 05, 2009 at 09:53:21PM +0100, Takashi Iwai wrote:

> Are all these 2.6.30 material or for 2.6.29?

They're a bit on the edge, I'd expect them to be safe for 2.6.29 but the
conservative thing would be to punt to 2.6.30.  None of them are
critical.

> For 2.6.30, I'll create another branch.  It won't be included in
> linux-next, too, until rc1 is reached (Stephen requested so), but we
> can keep it in our main branch, of course.

How about branching off a fixes branch for 2.6.29 rather than a -next
branch?  That way we can keep using the same branch for further fixes
through the -rc series.  Doesn't make much difference either way,
though.
