From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 0/3] ASoC: codecs: max98088: bug fixes and
	changes
Date: Thu, 12 May 2011 09:42:59 +0100
Message-ID: <1305189779.3369.2.camel@odin>
References: <1305179918-19317-1-git-send-email-jinyoungp@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id C44D8103994
	for <alsa-devel@alsa-project.org>;
	Thu, 12 May 2011 10:43:02 +0200 (CEST)
Received: by fxm5 with SMTP id 5so1014849fxm.38
	for <alsa-devel@alsa-project.org>; Thu, 12 May 2011 01:43:02 -0700 (PDT)
In-Reply-To: <1305179918-19317-1-git-send-email-jinyoungp@nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: jinyoungp@nvidia.com
Cc: Peter.Hsiang@maxim-ic.com, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Thu, 2011-05-12 at 14:58 +0900, jinyoungp@nvidia.com wrote:
> From: Jin Park <jinyoungp@nvidia.com>
> 
> Recently, I working on max98088 and changed something in max98088 asoc driver.
> The MAX98088 driver had some bug and needed modifies.
> The changes was confirmed by Peter Hsiang who author of max98088 driver and
> maxim engineer.
> Please review my changes.
> 
> Thanks,
> Jin Park.
> 
> Jin Park (3):
>   ASoC: codecs: max98088: Fixed invalid register definitions in mixer
>     controls
>   ASoC: codecs: max98088: Moved the EX Limiter Mode from dapm widget to
>     control
>   ASoC: codecs: max98088: Added digital mute function in DAI1 and DAI2
> 
>  sound/soc/codecs/max98088.c |   62 +++++++++++++++++++++++++++++++------------
>  sound/soc/codecs/max98088.h |   13 +++++++++
>  2 files changed, 58 insertions(+), 17 deletions(-)
> 
> 

All

Acked-by: Liam Girdwood <lrg@ti.com>
