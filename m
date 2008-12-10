From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: Warnings in wm8903.c (Re: Merged upstream to
	topic/asoc branch)
Date: Wed, 10 Dec 2008 11:25:59 +0000
Message-ID: <20081210112558.GD31542@sirena.org.uk>
References: <s5h8wqzzv8r.wl%tiwai@suse.de>
	<20081201170633.GI13758@sirena.org.uk>
	<s5h3ah7zul7.wl%tiwai@suse.de>
	<20081201172454.GJ13758@sirena.org.uk>
	<s5hvdu3yf6c.wl%tiwai@suse.de> <s5hmyffiuco.wl%tiwai@suse.de>
	<s5hy6yojxrz.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 90EF624432
	for <alsa-devel@alsa-project.org>; Wed, 10 Dec 2008 12:25:59 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hy6yojxrz.wl%tiwai@suse.de>
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

On Wed, Dec 10, 2008 at 08:26:56AM +0100, Takashi Iwai wrote:

> Hmm, I got the warnings again on a x86-64 with gcc-4.3.2 randconfig
> test build again.

> The config is attached below.

OK, I've managed to reproduce this with that .config.  I'll push a patch
later today which adds return statements to silence the warning, meaning
that any genuine issues won't be suppressed.
