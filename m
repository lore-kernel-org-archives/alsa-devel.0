From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] ASoC: Convert DAPM pop time configuration
	to debugfs
Date: Thu, 28 Aug 2008 14:14:27 +0100
Message-ID: <20080828131425.GE11132@sirena.org.uk>
References: <1219923984-5267-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<s5hzlmx8f0f.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id EEBB924617
	for <alsa-devel@alsa-project.org>;
	Thu, 28 Aug 2008 15:14:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hzlmx8f0f.wl%tiwai@suse.de>
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

On Thu, Aug 28, 2008 at 03:07:12PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > It would be nice to apply this to 2.6.27 since the sysfs file was only
> > added in the 2.6.27 cycle but it's not critical either way.

> I prefer pushing this for 2.6.28 as this is no "bug fix". 

Yeah, it's a bit dubious either way - like you say, it's not a bug fix
but if it's not merged for 2.6.27 then we add a new sysfs interface for
a single kernel release.  But then it's unlikely that anything in user
space is going to get upset when it vanishes.
