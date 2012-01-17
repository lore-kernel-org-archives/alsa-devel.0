From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: Allow drivers to specify how
 many bits are significant on a DAI
Date: Tue, 17 Jan 2012 11:38:49 +0000
Message-ID: <20120117113848.GE2944@opensource.wolfsonmicro.com>
References: <1326739267-9678-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<4F15377B.6080108@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1E4E7245C0
	for <alsa-devel@alsa-project.org>; Tue, 17 Jan 2012 12:38:52 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4F15377B.6080108@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 17, 2012 at 09:55:23AM +0100, Peter Ujfalusi wrote:

Peter, I shouldn't need to have to remind you to delete unneeded context
from your replies.

> Should we apply the constraint only if the sample size is bigger than
> the msbit request:
> 		if (sample_sizes[i] > bits) {
> 			ret = snd_pcm_hw_constraint_msbits();
> 		}

> Might be not an issue to say that we have 24msbit on the 8bit sample,
> but it does not sound right.

It shouldn't hurt and it is potentially useful to the application to
know that things will be converted up by the hardware; unless there's a
great reason to do so I'd rather not hide the information.
