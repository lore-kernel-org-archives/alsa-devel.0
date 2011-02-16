From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/5] ASoC: sst_platform: fix the pulseaudio
	error
Date: Tue, 15 Feb 2011 17:57:15 -0800
Message-ID: <20110216015714.GA3021@opensource.wolfsonmicro.com>
References: <1297774735-32184-1-git-send-email-vinod.koul@intel.com>
	<1297774735-32184-5-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5D6BA243EC
	for <alsa-devel@alsa-project.org>; Wed, 16 Feb 2011 02:57:04 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1297774735-32184-5-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Koul, Vinod" <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, Harsha Priya <priya.harsha@intel.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 15, 2011 at 06:28:54PM +0530, Koul, Vinod wrote:
> From: Vinod Koul <vinod.koul@intel.com>
> 
> Pulseaudio doesnt work with current driver and it was root caused to absense of
> hw_params function and malloc_pages in it.
> This patch adds this and allows pa to work fine with these drivers

For changes like this you really should provide changelogs which are
more specific about what the actual problem is - it's fine to say that
you found the problem while testing with PulseAudio but you really
should say what the problem you found was.  This is more useful for both
review and for mining the changelog as it explains the change itself
rather than the circumstances in which it was created.

Anyway, I've applied the whole series - thanks!
