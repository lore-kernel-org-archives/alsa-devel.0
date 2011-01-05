From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Fix the device references to codec and
	platform drivers
Date: Wed, 5 Jan 2011 11:29:28 +0000
Message-ID: <20110105112928.GA27706@opensource.wolfsonmicro.com>
References: <1294207491-17789-1-git-send-email-priya.harsha@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 95578103909
	for <alsa-devel@alsa-project.org>; Wed,  5 Jan 2011 12:29:12 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1294207491-17789-1-git-send-email-priya.harsha@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Harsha, Priya" <priya.harsha@intel.com>
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 05, 2011 at 11:34:51AM +0530, Harsha, Priya wrote:
> From: Harsha Priya <priya.harsha@intel.com>
> 
> The soc-core takes the platform and codec driver reference during probe. Few of
> these references are not released during remove. This cause the platform and
> codec driver module unload to fail.

Applied, thanks.
