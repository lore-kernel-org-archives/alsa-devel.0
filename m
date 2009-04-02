From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 3/5] ARM: DaVinci: ASoC: Add the
	platform	devices for ASP
Date: Thu, 2 Apr 2009 16:19:41 +0100
Message-ID: <20090402151941.GJ4527@sirena.org.uk>
References: <1238723371-27446-1-git-send-email-naresh@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id EAA2124400
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Apr 2009 17:19:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1238723371-27446-1-git-send-email-naresh@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: naresh@ti.com
Cc: davinci-linux-open-source@linux.davincidsp.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 02, 2009 at 09:49:31PM -0400, naresh@ti.com wrote:

> Registers the platform devices for ASP on dm355, dm644x and dm646x so that the
> machine driver can probe to get ASP related platform data.

Registering the platform data like this is a good change.  However, it
looks like you're using this to probe the machine driver rather than the
ASoC DAI or platform drivers.  

The structure ought to be that instead of calling snd_soc_register_dai()
in the module_init() function the McASP drivers register platform
drivers for themselves there.  Then the resources can be acquired and
snd_soc_register_dai() called in the probe function of the driver,
meaning the machine driver doesn't need to get involved in passing the
data around at all.
