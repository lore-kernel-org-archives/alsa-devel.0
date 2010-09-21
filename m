From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Fix soc-cache buffer overflow bug
Date: Tue, 21 Sep 2010 14:21:40 +0100
Message-ID: <20100921132139.GB29838@rakim.wolfsonmicro.main>
References: <1285074755-8627-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9C77F10388C
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Sep 2010 15:21:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1285074755-8627-1-git-send-email-dp@opensource.wolfsonmicro.com>
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

On Tue, Sep 21, 2010 at 02:12:35PM +0100, Dimitris Papastamos wrote:
> Make sure we stay within the cache boundaries when updating the
> register cache.
> 
> Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>

OK, will wait for Liam's review before applying but as discussed
off-line please also do a version of this patch that applies to
2.6.36-rc since it's a bug fix.
