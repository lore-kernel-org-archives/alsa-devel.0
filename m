From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/3] mfd: wm5102: Mark additional registers
	as volatile
Date: Fri, 6 Jun 2014 14:07:36 +0100
Message-ID: <20140606130736.GD19857@opensource.wolfsonmicro.com>
References: <1402058000-5357-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1402058000-5357-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F2598265172
 for <alsa-devel@alsa-project.org>; Fri,  6 Jun 2014 15:07:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1402058000-5357-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: lgirdwood@gmail.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lee.jones@linaro.org, sameo@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 06, 2014 at 01:33:19PM +0100, Charles Keepax wrote:
> @@ -1878,6 +1875,9 @@ static bool wm5102_volatile_register(struct device *dev, unsigned int reg)
>  	switch (reg) {
>  	case ARIZONA_SOFTWARE_RESET:
>  	case ARIZONA_DEVICE_REVISION:
> +	case ARIZONA_WRITE_SEQUENCER_CTRL_0:
> +	case ARIZONA_WRITE_SEQUENCER_CTRL_1:
> +	case ARIZONA_WRITE_SEQUENCER_CTRL_2:
>  	case ARIZONA_OUTPUT_STATUS_1:

Just noticed that we are missing WRITE_SEQUENCER_CTRL_3 here, I
might hold off with this patch until:

mfd: wm5102: Mark register write sequencer control 3 readable

Has made it to a public MFD branch I can rebase onto, then I can
add that in too.

Thanks,
Charles
