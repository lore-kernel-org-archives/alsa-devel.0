From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: submitting patch: specify destination kernel
 version(s)
Date: Fri, 2 Sep 2011 14:57:03 +0100
Message-ID: <20110902135702.GA10175@sirena.org.uk>
References: <1322a11922c.1088573675407063638.-3372964620296301533@zoho.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 8E9C724360
	for <alsa-devel@alsa-project.org>;
	Fri,  2 Sep 2011 15:57:05 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1322a11922c.1088573675407063638.-3372964620296301533@zoho.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Torsten Schenk <torsten.schenk@zoho.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 02, 2011 at 02:16:27PM +0200, Torsten Schenk wrote:

Please fix your mailer to word wrap within paragraphs.

> I'm currently preparing a patch for the kernel, I want it to be included from 3.0 on, but not in versions before. I once got a hint to put

> Cc: stable@kernel.org

> but that seems not to do the trick. How could it be achieved, that the patch only appears in 3.0 (and later)?

What's the actual patch?  Cc stable is the way to get patches picked up
for the stable kernel, if you want to limit the backports putting a note
in the changelog is probably sensible.
