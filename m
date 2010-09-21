From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Remove extra rtd->dev.init_name
 assignment in soc_probe_dai_link
Date: Tue, 21 Sep 2010 18:43:08 +0100
Message-ID: <20100921174307.GA26395@rakim.wolfsonmicro.main>
References: <1285072609-22191-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D464710388F
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Sep 2010 19:43:10 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1285072609-22191-1-git-send-email-jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 21, 2010 at 03:36:49PM +0300, Jarkko Nikula wrote:
> rtd->dev.init_name is set twice in soc_probe_dai_link. I removed the first
> assignement from dai_link->stream_name since then there won't be sysfs name
> changes and usually dai_link->name seems to fit anyway better for a sysfs
> directory name.
> 
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>

Applied, thanks.
