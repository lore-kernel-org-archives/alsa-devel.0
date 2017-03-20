From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [RFC PATCH 0/2] ASoC: wm8994: master clock issues
Date: Mon, 20 Mar 2017 14:11:37 +0000
Message-ID: <20170320141137.GR6986@localhost.localdomain>
References: <1489682483-13051-1-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 6527B266D9D
 for <alsa-devel@alsa-project.org>; Mon, 20 Mar 2017 15:10:36 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1489682483-13051-1-git-send-email-olivier.moysan@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: olivier moysan <olivier.moysan@st.com>
Cc: alsa-devel@alsa-project.org, alexandre.torgue@st.com, arnaud.pouliquen@st.com, tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org, mcoquelin.stm32@gmail.com
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 16, 2017 at 05:41:21PM +0100, olivier moysan wrote:
> Hello,
> 
> I face two issues using wm8994 codec driver.
> Below is a description of the use cases rising the problem.
> I added the patches which allow to fix these issues.
> These minimalist patches can be seen as a starting point for a discussion on the best
> way to handle the use cases exposed.
> 
> 
> - ASoC: wm8994: default master clock selection
> 
> Use case:
> CPU DAI and codec are managed through simple card.
> Wolson codec wm8994 is set as slave of CPU DAI and CPU DAI feeds codec with master clock.
> Master clock is derived from mclk-fs property and provided to CPU DAI and codec 
> through snd_soc_dai_set_sysclk API. 
> 
> Analysis:
> The simple card assumes id 0 for master clock.
> However wm8994 codec exposes master clock ids from 1 to 4. (MCLK1, MCLK2 ..)
> 
> The proposal in this patch is to define a default selection regarding master clock
> when id 0 is provided.
> 
> 
> - ASoC: wm8994: delay aifxclk activation
> 
> Use case:
> Wolson codec wm8994 is set as slave of CPU DAI and CPU DAI feeds codec with master clock.
> CPU DAI generates master clock when enabled in trigger callback.
> So master clock is available only at runtime. 
> Master clock is not available when configuring codec through alsa controls.
> 
> Analysis:
> When we configure aifx clock while master clock is not active, related registers are not updated in wm8894 codec.
> A way to go around this problem, is to delay aifxclk activation until SND_SOC_DAPM_POST_PMU DAPM stage.
> The purpose of patch here is to illustrate this workaround. 
> 
> What I cannot clearly figure out, is  how this may impact other uses of wm8894 codec.
> I try to know if it's worth investigating further in this direction or if it will not be applicable.
> If not applicable, what maybe the other options ?
> 
> regards
> olivier

Would be good to CC patches@opensource.wolfsonmicro.com on the
next version of these patches as well, higher chance someone here
will notice and have a look over them.

Thanks,
Charles
