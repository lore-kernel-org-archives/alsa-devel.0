From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Return -1 instead of -EINVAL to
 ensure consistency
Date: Wed, 22 Sep 2010 16:49:05 +0100
Message-ID: <20100922154905.GJ26395@rakim.wolfsonmicro.main>
References: <1285085047-31508-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A304810390B
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Sep 2010 17:49:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1285085047-31508-1-git-send-email-dp@opensource.wolfsonmicro.com>
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

On Tue, Sep 21, 2010 at 05:04:07PM +0100, Dimitris Papastamos wrote:
> The code can't really cope with I/O errors, so it would be better
> to be consistent throughout all cache functions and return -1 instead
> of -EINVAL.
> 
> The return value of snd_soc_read(...) is mostly checked in the probe
> function and nowhere else.

Applied, thanks.
