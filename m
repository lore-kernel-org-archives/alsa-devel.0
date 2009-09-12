From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 8/8,
	retry] sound/soc: introduce missing kfree
Date: Sat, 12 Sep 2009 13:42:29 +0100
Message-ID: <20090912124229.GB4633@sirena.org.uk>
References: <Pine.LNX.4.64.0909121424420.8557@pc-004.diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id DBD291037FC
	for <alsa-devel@alsa-project.org>;
	Sat, 12 Sep 2009 14:42:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0909121424420.8557@pc-004.diku.dk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Julia Lawall <julia@diku.dk>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Sat, Sep 12, 2009 at 02:25:35PM +0200, Julia Lawall wrote:
> From: Julia Lawall <julia@diku.dk>
> 
> Error handling code following a kzalloc should free the allocated data.
> Error handling code following an ioremap should iounmap the allocated data.

Applied after manually fixing paths (the patch had a bunch of prefixes
in the directory name).  Thanks!
