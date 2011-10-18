From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC: Amplifier behind codec?
Date: Tue, 18 Oct 2011 13:43:16 +0100
Message-ID: <20111018124316.GA18713@sirena.org.uk>
References: <20111018103821.GC1922@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 7F22A24547
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Oct 2011 14:43:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20111018103821.GC1922@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 18, 2011 at 12:38:21PM +0200, Wolfram Sang wrote:

Always CC maintainers if you want replies to your mail.

> Is the above approach still the preferred way of doing this?

No, use an aux_dev.  See Speyside for an example.
