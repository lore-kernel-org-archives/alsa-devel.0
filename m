From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: AC97 doesn't use regmap by default
Date: Tue, 31 Jul 2012 16:42:14 +0100
Message-ID: <20120731154214.GJ4468@opensource.wolfsonmicro.com>
References: <1343738547-24152-1-git-send-email-manuel.lauss@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7B172265D2A
 for <alsa-devel@alsa-project.org>; Tue, 31 Jul 2012 17:42:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1343738547-24152-1-git-send-email-manuel.lauss@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Manuel Lauss <manuel.lauss@gmail.com>
Cc: alsa-devel@alsa-project.org, Manuel Lauss <manuel.lauss@googlemail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 31, 2012 at 02:42:27PM +0200, Manuel Lauss wrote:
> From: Manuel Lauss <manuel.lauss@googlemail.com>
> 
> Since commit 38cbf9598feba97de9f9b43efa9153fd7c1a2ec9
> ("ASoC: core: Try to use regmap if the driver doesn't set up any I/O")
> any ASoC codec which doesn't set codec::control_data is assumed
> to use regmap.  That doesn't work with AC97 so this workaround
> sets the codec::control_data member to a random value to restore
> proper behaviour.

Applied, thanks.
