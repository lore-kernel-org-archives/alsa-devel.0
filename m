From: Ricardo Neri <ricardo.neri@ti.com>
Subject: Re: [PATCH] ASoC: OMAP: HDMI: Initialize IEC-60958
 channel status word
Date: Tue, 5 Jun 2012 10:25:31 -0500
Message-ID: <4FCE24EB.6060307@ti.com>
References: <1338836836-7396-1-git-send-email-ricardo.neri@ti.com>
	<20120605102821.GO23408@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 73B0A104339
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Jun 2012 17:26:02 +0200 (CEST)
In-Reply-To: <20120605102821.GO23408@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: peter.ujfalusi@ti.com, alsa-devel@alsa-project.org, lrg@ti.com, s-guiriec@ti.com
List-Id: alsa-devel@alsa-project.org

Hi Mark,
On 06/05/2012 05:28 AM, Mark Brown wrote:
> On Mon, Jun 04, 2012 at 02:07:15PM -0500, Ricardo Neri wrote:
>> Hi Mark, Liam,
>>
>> This patch is to fix an bug that I found in K3.5-rc1. As the IEC-60958 channel
>> status word is not initialized in hw_params, the params from previous
>> calls corrupt those of the current playback.
>
> Don't send cover letters for single patches, if there's anything useful
> to say say it in the patch.

Sorry, I will resend as a single patch without the cover letter.

Ricardo
