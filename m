From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC CODEC power management on reboot
Date: Mon, 22 Jun 2009 12:32:50 +0100
Message-ID: <20090622113249.GA15884@sirena.org.uk>
References: <20090622111323.GM14476@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id B05E1243A3
	for <alsa-devel@alsa-project.org>;
	Mon, 22 Jun 2009 13:32:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090622111323.GM14476@trinity.fluff.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ben Dooks <ben-alsa@fluff.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 22, 2009 at 12:13:23PM +0100, Ben Dooks wrote:

> Should the ASoC (possibly DAPM) layer sort out powering down the CODEC
> before reboot, or should it be down to the codec or the mapping driver
> to do this?

Core.
