From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 4/4] ALSA: ASoC: Davinci: Fixed
	missing	McBSP pinmux for SFFSDR
Date: Tue, 10 Mar 2009 16:02:10 +0000
Message-ID: <20090310160207.GE12297@sirena.org.uk>
References: <1236655929-31688-1-git-send-email-hugo@hugovil.com>
	<1236655929-31688-5-git-send-email-hugo@hugovil.com>
	<20090310102921.GA12297@sirena.org.uk>
	<20090310100341.cc08cc08.hugo@hugovil.com>
	<20090310151615.GB12297@sirena.org.uk>
	<20090310114211.4ad49269.hugo@hugovil.com>
	<87hc21tlt1.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 157161037F2
	for <alsa-devel@alsa-project.org>; Tue, 10 Mar 2009 17:02:19 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <87hc21tlt1.fsf@deeprootsystems.com>
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
Cc: davinci-linux-open-source@linux.davincidsp.com, alsa-devel@alsa-project.org, Hugo Villeneuve <hugo@hugovil.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 10, 2009 at 08:55:06AM -0700, Kevin Hilman wrote:

> On a related note, sound/soc/davinci/davinci-[evm,sffsdr].c is
> actually board-level setup code and should not actually live in
> sound/asoc/.  It should live in arch/arm/mach-davinci/* and follow the
> rest of the davinci chip/board code upstream.

No, the ASoC APIs are not stable enough for this - putting this code in
arch/arm will just lead to merge pain when code from one tree goes in
without updates from the other.

Experience also suggests that audio drivers often get substantial enough
and need sufficient review to warrant keeping separate from the core
machine code.
