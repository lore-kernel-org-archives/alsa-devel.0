From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: soc-core: Remove display_register()
	callback
Date: Wed, 2 Feb 2011 14:51:15 +0000
Message-ID: <20110202145115.GR12743@opensource.wolfsonmicro.com>
References: <1296642054-10485-1-git-send-email-dp@opensource.wolfsonmicro.com>
	<20110202102335.GM12743@opensource.wolfsonmicro.com>
	<AANLkTing5zryWWt4HZHGUd15-6mrxpnRwA8EEiE8DGem@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EC871103818
	for <alsa-devel@alsa-project.org>; Wed,  2 Feb 2011 15:51:16 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <AANLkTing5zryWWt4HZHGUd15-6mrxpnRwA8EEiE8DGem@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 02, 2011 at 09:50:40AM -0500, jonsmirl@gmail.com wrote:

> TI Codec devices have two problems:
> 1) large registers - up to 128 bits
> 2) sparse register maps - big gaps between valid register addresses.

The sparse register maps are already very well handled, they're quite
widespread.
