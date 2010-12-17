From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: soc-dapm: Introduce the new
 snd_soc_dapm_virt_mux type
Date: Fri, 17 Dec 2010 17:37:12 +0000
Message-ID: <20101217173712.GA30235@rakim.wolfsonmicro.main>
References: <1292514819-4254-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 71C331037FC
	for <alsa-devel@alsa-project.org>; Fri, 17 Dec 2010 18:37:15 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1292514819-4254-1-git-send-email-dp@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 16, 2010 at 03:53:39PM +0000, Dimitris Papastamos wrote:
> This new type is a virtual version of snd_soc_dapm_mux.  It is used
> when a backing register value is not necessary for deciding which
> input path to connect.  A simple virtual enumeration control e.g.
> SOC_DAPM_ENUM_VIRT() can be exposed to userspace which will be used
> to choose which path to connect.

Applied, thanks.
