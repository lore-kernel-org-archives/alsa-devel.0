From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC updates for 2.6.38
Date: Tue, 22 Feb 2011 04:49:10 +0000
Message-ID: <20110222044910.GE18299@sirena.org.uk>
References: <20110218041933.GB6069@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id DF040244FB
	for <alsa-devel@alsa-project.org>; Tue, 22 Feb 2011 05:49:12 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20110218041933.GB6069@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 17, 2011 at 08:19:34PM -0800, Mark Brown wrote:
> The following changes since commit 6ed8f1485fc82d44ac464bc84a7dcdddd1fa096f:
> 
>   ASoC: Improve WM8994 digital power sequencing (2011-02-03 20:17:13 +0000)
> 
> are available in the git repository at:
>   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.38

Any updates on this?  Some of these fixes are fairly urgent.

> These are all driver specific with the exception of the two commits from
> me.  These are both small and focused changes which fix obvious issues
> for some systems, both being things that the framework should clearly
> have been doing but had omitted to do.

Ping?

> Dimitris Papastamos (2):
>       ASoC: WM8994: Improve robustness in some use cases
>       ASoC: WM8994: Improve playback robustness
> 
> Janusz Krzysztofik (1):
>       ASoC: CX20442: fix wrong reg_cache_default content
> 
> Mark Brown (2):
>       ASoC: Sync initial widget state with hardware
>       ASoC: Ensure supplies are maintained for force enabled widgets
> 
> Stephen Warren (2):
>       ASoC: WM8903: Fix mic detection register definitions
>       ASoC: WM8903: Fix mic detection enable logic
> 
>  include/sound/wm8903.h     |   10 +--
>  sound/soc/codecs/cx20442.c |    2 +-
>  sound/soc/codecs/wm8903.c  |    2 +-
>  sound/soc/codecs/wm8994.c  |  197 ++++++++++++++++++++++++++++++++++++++++---
>  sound/soc/soc-dapm.c       |   23 +++++-
>  5 files changed, 210 insertions(+), 24 deletions(-)
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 

-- 
"You grabbed my hand and we fell into it, like a daydream - or a fever."
