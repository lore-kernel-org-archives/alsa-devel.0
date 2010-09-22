From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2.6.36] ASoC: Fix soc-cache buffer overflow
	bug
Date: Wed, 22 Sep 2010 12:02:34 +0100
Message-ID: <20100922110234.GA23058@opensource.wolfsonmicro.com>
References: <1285077806-29415-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B6DDB1038CC
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Sep 2010 13:02:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1285077806-29415-1-git-send-email-dp@opensource.wolfsonmicro.com>
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

On Tue, Sep 21, 2010 at 03:03:26PM +0100, Dimitris Papastamos wrote:
> Make sure we stay within the cache boundaries when updating the
> register cache.
> 
> Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>

Applied, thanks.
