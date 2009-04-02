From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 5/5] ARM: DaVinci: ASoC: Add machine	driver
	support for DM646x
Date: Thu, 2 Apr 2009 16:39:36 +0100
Message-ID: <20090402153935.GL4527@sirena.org.uk>
References: <1238723897-27687-1-git-send-email-naresh@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id BD47010386B
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Apr 2009 17:39:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1238723897-27687-1-git-send-email-naresh@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Naresh Medisetty <naresh@ti.com>
Cc: alsa-devel@alsa-project.org, davinci-linux-open-source@linux.davincidsp.com
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 02, 2009 at 09:58:17PM -0400, Naresh Medisetty wrote:

Aside from the issue with the passing of platform data that I mentioned
in regard to the arch/arm side of the patch I only have one very minor
issue here:

> +	{
> +		.name = "MCASP SPDIF",

Might be better to write "McASP S/PDIF"?  The string is mostly for human
consumption - the reason it's mostly all caps is that most manufacturers
use capital letters in their part numbers.  Really not important either
way.
