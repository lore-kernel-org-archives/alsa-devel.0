From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: uda134x: replace a macro with a
	value in	platform struct.
Date: Fri, 25 Jun 2010 12:29:59 +0100
Message-ID: <20100625112959.GB21217@opensource.wolfsonmicro.com>
References: <1277386731-31160-1-git-send-email-vzapolskiy@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8694B1039C7
	for <alsa-devel@alsa-project.org>;
	Fri, 25 Jun 2010 13:30:00 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1277386731-31160-1-git-send-email-vzapolskiy@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vladimir Zapolskiy <vzapolskiy@gmail.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 24, 2010 at 05:38:50PM +0400, Vladimir Zapolskiy wrote:
> This change wipes out a hardcoded macro, which enables codec bias
> level control. Now is_powered_on_standby value shall be used instead.
> 
> Signed-off-by: Vladimir Zapolskiy <vzapolskiy@gmail.com>

Applied both, thanks.  Like I say, the first patch really should be done
by using DAPM rather than this custom code but it's still an improvement
on the existing code.
