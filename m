From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 3/6] ASoC: TWL4030: Enable all audio paths
Date: Mon, 6 Apr 2009 13:45:21 +0100
Message-ID: <20090406124520.GA14169@sirena.org.uk>
References: <1239020372-8457-1-git-send-email-peter.ujfalusi@nokia.com>
	<1239020372-8457-2-git-send-email-peter.ujfalusi@nokia.com>
	<1239020372-8457-3-git-send-email-peter.ujfalusi@nokia.com>
	<1239020372-8457-4-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 4D35124386
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Apr 2009 14:45:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1239020372-8457-4-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: sakoman@gmail.com, alsa-devel@alsa-project.org, jarkko.nikula@nokia.com
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 06, 2009 at 03:19:29PM +0300, Peter Ujfalusi wrote:

> Enable all TX and RX paths on the TWL codec.

What does this mean by "enable" - I'm guessing it's powering blocks
within the CODEC rather than connecting any audio paths?

> This is not so nice, but doing it runtime brings quite a bit
> of challenge, since for example the Digital loopback also needs
> the RX and TX paths to be enabled.

What are the problems other than loopback (which really needs digital
routing to work properly, though I've never seen much demand for it
outside of testing)?  Powering everything is probably fine, I'm just
wondering if this is due to the hardware or the core.
