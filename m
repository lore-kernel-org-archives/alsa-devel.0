From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 1/7] ASoC: fsl: add PPC_MPC52xx
	dependency to	SND_POWERPC_SOC
Date: Wed, 19 Sep 2012 21:47:31 +0100
Message-ID: <20120919204730.GB12297@opensource.wolfsonmicro.com>
References: <1348066285-87741-1-git-send-email-emillbrandt@dekaresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B1B6926522C
 for <alsa-devel@alsa-project.org>; Wed, 19 Sep 2012 22:47:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1348066285-87741-1-git-send-email-emillbrandt@dekaresearch.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Grant Likely <grant.likely@secretlab.ca>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, Eric Millbrandt <emillbrandt@dekaresearch.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 19, 2012 at 10:51:25AM -0400,  wrote:
> From: Eric Millbrandt <emillbrandt@dekaresearch.com>
> 
> mpc52xx socs need to define SND_POWERPC_SOC to build ASoC drivers.
> 
> Signed-off-by: Eric Millbrandt <emillbrandt@dekaresearch.com>
> ---
> Changes since v1:
> Patch was "powerpc/52xx: define FSL_SOC"
> Changed from defining FSL_SOC for PPC_MPC52xx to adding PPC_MPC52xx as a
> dependency of SND_POWERPC_SOC as per Anatolij Gustschin's comment.

Patches 2 to 7 appear to have gone AWOL?
