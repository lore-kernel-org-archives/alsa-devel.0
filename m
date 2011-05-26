From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH] ASoC: Fix dapm_is_shared_kcontrol so
 everything isn't shared
Date: Thu, 26 May 2011 21:02:47 +0300
Message-ID: <20110526210247.5cd4265b.jhnikula@gmail.com>
References: <1306425453-20753-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 2DD1E10384A
	for <alsa-devel@alsa-project.org>;
	Thu, 26 May 2011 20:02:50 +0200 (CEST)
Received: by eyg5 with SMTP id 5so406166eyg.38
	for <alsa-devel@alsa-project.org>; Thu, 26 May 2011 11:02:49 -0700 (PDT)
In-Reply-To: <1306425453-20753-1-git-send-email-swarren@nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Thu, 26 May 2011 09:57:33 -0600
Stephen Warren <swarren@nvidia.com> wrote:

> Commit af46800 ("ASoC: Implement mux control sharing") introduced
> function dapm_is_shared_kcontrol.
> 
> When this function returns true, the naming of DAPM controls is derived
> from the kcontrol_new. Otherwise, the name comes from the widget (and
> possibly a widget's naming prefix).
> 
> A bug in the implementation of dapm_is_shared_kcontrol made it return 1
> in all cases. Hence, that commit caused a change in control naming for
> all controls instead of just shared controls.
> 
> Specifically, a control is always considered shared because it is always
> compared against itself. Solve this by never comparing against the widget
> containing the control being created.
> 
> Equally, controls should never be shared between DAPM contexts; when the
> same codec is instantiated multiple times, the same kcontrol_new will be
> used. However, the control should no be shared between the multiple
> instances.
> 
> I tested that with the Tegra WM8903 driver:
> * Shared is now mostly 0 as expected, and sometimes 1.
> * The expected controls are still generated after this change.
> 
> However, I don't have any systems that have a widget/control naming
> prefix, so I can't test that aspect.
> 
> Thanks for Jarkko Nikula for pointing out how to fix this.
> 
> v2:
> * Don't share across DAPM contexts.
> * Changed to Tested-by tag below for Jarkko.
> 
> Reported-by: Liam Girdwood <lrg@ti.com>
> Tested-by: Jarkko Nikula <jhnikula@gmail.com>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
>  sound/soc/soc-dapm.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
> 
Tested-by confirmation :-)

-- 
Jarkko
