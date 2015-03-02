From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: wm8804: Fix small issues in
	probe error path
Date: Mon, 2 Mar 2015 18:15:56 +0000
Message-ID: <20150302181556.GD2042@opensource.wolfsonmicro.com>
References: <1425319075-10400-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20150302180351.GA21293@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3FD292605D7
 for <alsa-devel@alsa-project.org>; Mon,  2 Mar 2015 19:15:57 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20150302180351.GA21293@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, info@crazy-audio.com, lgirdwood@gmail.com, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 02, 2015 at 06:03:51PM +0000, Mark Brown wrote:
> On Mon, Mar 02, 2015 at 05:57:54PM +0000, Charles Keepax wrote:
> 
> > The regulator notifiers were not being cleared up on the error path in
> > wm8804_probe and the nothing was being cleared up if
> > snd_soc_register_codec failed. This patch fixes these issues.
> 
> Why not fix this at source by adding a devm_ notifier registration?

Oops.. yeah that is almost certainly better. I will respin for
that.

Thanks,
Charles
