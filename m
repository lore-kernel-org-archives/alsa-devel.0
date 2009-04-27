From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [RFC] SoC WM8940 Driver
Date: Mon, 27 Apr 2009 13:25:50 +0100
Message-ID: <20090427122550.GF1760@sirena.org.uk>
References: <49F21310.4060009@cam.ac.uk> <20090425102100.GA4394@sirena.org.uk>
	<49F345A8.1030901@cam.ac.uk> <20090425180346.GA4072@sirena.org.uk>
	<49F599BB.9050805@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id D2718103819
	for <alsa-devel@alsa-project.org>;
	Mon, 27 Apr 2009 14:25:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <49F599BB.9050805@cam.ac.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 27, 2009 at 11:40:43AM +0000, Jonathan Cameron wrote:

> As in snd_soc_dapm_add_route only mux, switch and mixer controls can take
> a control element.

You can modify the core, or if you're not keen on doing that just drop
this feature for now - it's relatively rarely used.

> Nearest I can currently come up with is to insert a mux with only one option...

It'd need to be a mixer, at least.  A mux with only one option could
never be disabled.
