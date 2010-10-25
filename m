From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/4] ASoC: soc-cache: Add support for LZO
 based register caching
Date: Mon, 25 Oct 2010 11:13:03 -0700
Message-ID: <20101025181302.GD16246@opensource.wolfsonmicro.com>
References: <1287757702-9573-5-git-send-email-dp@opensource.wolfsonmicro.com>
	<20101022161850.GF16521@opensource.wolfsonmicro.com>
	<1287858481.9010.11.camel@dplaptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 883D110390C
	for <alsa-devel@alsa-project.org>;
	Mon, 25 Oct 2010 20:12:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1287858481.9010.11.camel@dplaptop>
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

On Sat, Oct 23, 2010 at 07:28:01PM +0100, Dimitris Papastamos wrote:

> The function naming is wrong.  This function is a helper function for
> the LZO compression type.  I've prefixed this function with LZO to avoid
> misunderstanding.  Ideally this would live in a separate file.

Go ahead and split out if it seems useful.
